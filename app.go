package main

import (
	"errors"
	"fmt"
	"net"
	"os"
	"strings"
	"time"
	"context"

	"glab/controllers"
	"glab/glab_config"

	"github.com/dronm/ds"
	"github.com/dronm/ds/pgds"

	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/evnt"
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/permission"
	_ "github.com/dronm/gobizap/permission/pg"	
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/srv/httpSrv"
	"github.com/dronm/gobizap/srv/wsSrv"
	"github.com/dronm/gobizap/view"
	"github.com/dronm/gobizap/xslt"

	"github.com/dronm/session"
	_ "github.com/dronm/session/redis"

	"github.com/labstack/gommon/log"
	
	_ "github.com/dronm/gobizap/view/excel"
	_ "github.com/dronm/gobizap/view/html"
	_ "github.com/dronm/gobizap/view/json"
	_ "github.com/dronm/gobizap/view/xml"	
)

const (
	PAGE_TITLE        = "Лаборатория автостекла"
	PAGE_AUTHOR       = "Andrey Mikhalevich"
	PAGE_KEYWORS      = ""
	PAGE_DESCRIPTION  = ""
	DEF_COLOR_PALETTE = "blue-400"
)

type glabVariables struct {
	httpSrv.ServerVars
	Role_id               string `json:"role_id"`
	User_id               int64  `json:"user_id"`
	User_name             string `json:"user_name"`
	App_port              string `json:"app_port"`
	App_ports             string `json:"app_ports"`
	App_id                string `json:"app_id"`
	Token                 string `json:"token"`
	TokenExpires          string `json:"tokenExpires"`
	DefColorPalette       string `json:"defColorPalette"`
	PopBasedCompleteCount int64  `json:"popBasedCompleteCount"` //popularity base complete count
}

type GLabApp struct {
	httpSrv.HTTPApplication
	//
	cancel context.CancelFunc		
	ctx context.Context
}

func (a *GLabApp) init(conf *glab_config.GLabConfig) {
		var err error
	
	a.Config = conf
	l := log.New("-")
	l.SetHeader("${time_rfc3339_nano} ${short_file}:${line} ${level} -${message}")
	l.SetLevel(a.GetLogLevel(conf.GetLogLevel()))
	a.Logger = l 
	
	//context
	a.ctx, a.cancel = context.WithCancel(context.Background())		
	
	//
	a.OnReloadConfig = func(){
		a.init(a.Config.(*glab_config.GLabConfig))
	}
	
	//metadata
	a.MD = NewMD(a.GetAppVersion())
	initMD(a.MD)
	
	//default per page count
	gobizap.DocPerPageCountConstantID = "doc_per_page_count"
	
	//HTTPDir or current
	http_dir := conf.HTTPDir
	if http_dir == "" {
		http_dir, err = os.Getwd()//current working dir
		if err != nil {
			panic(fmt.Sprintf("os.Getwd(): %v", err))
		}
	}	
	a.UserTmplDir = http_dir+"/tmpl"
	a.UserTmplExtension = "html"

	a.setJavaScript(conf.JsDebug);	
	a.setCSS();
		
	//Event server
	local_events := []string{"Permission.change",
			"Login.destroy_session",
			"Attachment.clear_cache",
	}		
	evnt_srv := evnt.NewEvntSrv(a.Logger, a.HandleEvent, local_events)	
	a.OnPublishEvent = evnt_srv.PublishEvent
	a.MD.Controllers["Event"].(*evnt.Event_Controller).EvntServer = evnt_srv
	a.EvntServer = evnt_srv
	
	//Db support
	db_conf := a.Config.GetDb()
	a.DataStorage, err = ds.NewProvider("pg", db_conf.Primary, evnt_srv.OnNotification, db_conf.Secondaries)
	if err != nil {
		panic(err)
	}
	d_store,ok := a.DataStorage.(*pgds.PgProvider)
	if !ok {
		panic(errors.New("a.DataStorage is not of type *pgds.PgProvider"))
	}

	err = d_store.Primary.Connect()
	if err != nil {
		panic(err)
	}

	//peprmission support
	a.PermisManager, err = permission.NewManager("pg", d_store.Primary.Pool)
	if err != nil {
		panic(err)
	}
		
	//session support
	sess_conf := a.Config.GetSession()
	a.SessManager, err = session.NewManager("redis", sess_conf.MaxLifeTime, sess_conf.MaxIdleTime, sess_conf.DestroyAllTime, conf.Redis.Connect, conf.Redis.Namespace)
	if err != nil {
		panic(fmt.Sprintf("session.NewManager: %v", err))
	}
	
	lv := conf.GetLogLevel()
	var sess_lv session.LogLevel
	switch lv {
	case "debug": sess_lv = session.LOG_LEVEL_DEBUG
	case "warn": sess_lv = session.LOG_LEVEL_WARN
	default: sess_lv = session.LOG_LEVEL_ERROR
	}
	a.SessManager.StartGC(l.Output(), sess_lv)
	
	//Db connection to event server
	evnt_srv.DbPool = d_store.Primary.Pool
	
	//http server
	server := &httpSrv.HTTPServer{}
	server.Address = conf.HttpServer
	server.AppID = conf.AppID
	server.Logger = a.Logger
	server.HTTPDir = http_dir
	server.AddURLShortcut("/mgateway", "Mgateway", "callback", "ViewXML", nil)//
	
	//!!!Event custom socket
	server.OnConstructSocket = (func(srv *evnt.EvntSrv) srv.OnConstructSocketProto {
		//id string, id, 
		return func(conn net.Conn, token string, tokenExp time.Time) socket.ClientSocketer {
			sock := evnt.NewClientSocket(conn, token, tokenExp, srv)
			return sock
		}
	})(evnt_srv)
	
	server.OnHandleRequest = a.HandleRequest	
	server.OnHandleSession = a.HandleSession
	server.OnHandleServerError = a.HandleServerError		
	
	//corresponding content types
	server.AddViewContentType("ViewXML", httpSrv.MIME_TYPE_xml, httpSrv.CHARSET_UTF8)
	server.AddViewContentType("ViewJSON", httpSrv.MIME_TYPE_json, httpSrv.CHARSET_UTF8)
	server.AddViewContentType("ViewHTML", httpSrv.MIME_TYPE_html, httpSrv.CHARSET_UTF8)
	server.AddViewContentType("ViewPDF", httpSrv.MIME_TYPE_pdf, "")
	server.AddViewContentType("ViewExcel", httpSrv.MIME_TYPE_xls, "")
	server.AddViewContentType("ViewText", httpSrv.MIME_TYPE_txt, httpSrv.CHARSET_UTF8)
	server.AddViewContentType("ViewCSV", httpSrv.MIME_TYPE_txt, httpSrv.CHARSET_UTF8)
	server.AllowedExtensions = []string{"ico","css","js","gif","png","mp3","woff","woff2","ttf","jpg"}
	server.Headers = map[string]string{
		"Pragma": "no-cache",
		"Cache-Control": "no-cache, no-store, max-age=0, must-revalidate",
		"Expires": "0",	
	}	
	a.AddServer("http", server)
	
	//views
	view.Init("ViewXML", map[string]interface{}{"BeforeRender": a.OnBeforeRenderXML,
			"DebugDir": http_dir + "/CACHE",
			})
	view.Init("ViewJSON", nil)
	view.Init("ViewHTML",
		map[string]interface{}{"SrvTemplateDir": conf.TemplateDir,
			"UserViewDir": http_dir + "/views",
			"TemplateExtension": "html.xsl",
			"TemplateTransform": xslt.XSLTransform,
			"BeforeRender": a.onBeforeRenderHTML,
			"DebugDir": http_dir + "/CACHE",
			"XMLDebug": false,
			"HTMLDebug": false,			
			})
	view.Init("ViewExcel",
		map[string]interface{}{"SrvTemplateDir": conf.TemplateDir,
			"UserViewDir": http_dir + "/views",
			"TemplateTransform": xslt.XSLTransform,			
			})
	/*view.Init("ViewPDF",
		map[string]interface{}{"SrvTemplateDir": conf.TemplateDir,
			"UserViewDir": http_dir + "/views",
			"TemplateTransform": xslt.XSLToPDFTransform,
			"Fop": conf.Fop,
			"ConfFile": conf.FopConf,
			"DebugDir": http_dir + "/CACHE",
			"Debug": false,
		})
	*/
	
	//web socket server
	ws_srv := &wsSrv.WSServer{BaseServer: srv.BaseServer{Address: conf.GetWSServer(),
		TlsAddress: conf.GetTLSWSServer(),
		TlsCert: conf.TLSCert,
		TlsKey: conf.TLSKey,
		Logger: a.Logger,
		AppID: conf.AppID,
		OnHandleJSONRequest: a.HandleJSONRequest,
		OnHandleSession: a.HandleSession,
		OnDestroySession: a.DestroySession,
		OnHandleServerError: a.HandleServerError,
		OnConstructSocket: server.OnConstructSocket,		
	}}//a.OnCloseSocket
	a.AddServer("ws", ws_srv)
	
	//notifier
	//controllers.InitNotifier(conf.NotifierParams.Host, conf.NotifierParams.AppName, conf.NotifierParams.Pwd)
	
	//client search
	//clientSearch.DadataKey = conf.DadataKey	
}

func (a *GLabApp) onBeforeRenderHTML(sock *httpSrv.HTTPSocket, resp *response.Response) error {

	if err := a.BeforeRenderHTML(sock, resp); err != nil {
		return err
	}

	//+custom variables
	conf := a.GetConfig()
	cl_vars := &glabVariables{ServerVars: httpSrv.ServerVars{Title: PAGE_TITLE,
		Author:      PAGE_AUTHOR,
		Keywords:    PAGE_KEYWORS,
		Description: PAGE_DESCRIPTION,
		Version:     a.MD.Version.Value,
	}}
	if conf.(*glab_config.GLabConfig).JsDebug {
		cl_vars.Debug = 1
	} else {
		cl_vars.Debug = 0
	}
	cl_vars.App_id = conf.GetAppID()
	cl_vars.DefColorPalette = DEF_COLOR_PALETTE

	sess := sock.GetSession()
	cl_vars.Role_id = sess.GetString(gobizap.SESS_ROLE)

	if sess.GetBool(controllers.SESS_VAR_LOGGED) {
		cl_vars.User_id = sess.GetInt(controllers.SESS_VAR_ID)
		cl_vars.Token = sock.Token
		cl_vars.TokenExpires = sock.TokenExpires.Format(fields.FORMAT_DATE_TIME_TZ1)

		cl_vars.User_name = sess.GetString(controllers.SESS_VAR_NAME)

		ws_srv := conf.GetWSServer()
		ws_port_p := strings.Index(ws_srv, ":")
		if ws_port_p >= 0 {
			cl_vars.App_port = ws_srv[ws_port_p+1:]
		}
		wss_srv := conf.GetTLSWSServer()
		if wss_srv != "" {
			ws_port_p := strings.Index(wss_srv, ":")
			if ws_port_p >= 0 {
				cl_vars.App_ports = wss_srv[ws_port_p+1:]
			}
		}

		cl_vars.PopBasedCompleteCount = sess.GetInt(controllers.SESS_VAR_POP_COMPLETE_COUNT)
	}

	locale := sess.GetString(gobizap.SESS_LOCALE)
	if locale == "" {
		locale = conf.GetDefaultLocale()
	}

	cl_vars.CurDate = time.Now().Unix()
	if cl_vars.Debug == 1 {
		cl_vars.ScriptId = gobizap.GenUniqID(12)
	} else {
		cl_vars.ScriptId = cl_vars.Version
	}
	cl_vars.Locale_id = locale

	resp.AddModel(httpSrv.NewServerVarsModel(cl_vars))
	//fmt.Println("Login_id=",sess.GetInt("USER_LOGIN_ID"), "UserName=", sess.GetString("USER_NAME"))
	return nil
}

func (a *GLabApp) GetLogLevel(logLevel string) log.Lvl {
	var lvl log.Lvl

	switch logLevel {
	case "debug":
		lvl = log.DEBUG
		break
	case "info":
		lvl = log.INFO
		break
	case "warn":
		lvl = log.WARN
		break
	case "error":
		lvl = log.ERROR
		break
	default:
		lvl = log.INFO
	}
	return lvl
}

//cleanup before socket close
/*
func (a *GLabApp) OnCloseSocket(sock socket.ClientSocketer){
	sess := sock.GetSession()
	if sess == nil {
		return
	}
	user_id := sess.GetInt(controllers.SESS_VAR_ID)
	if user_id == 0 {
		return
	}
	go func(app *GLabApp){
		d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
		var conn_id pgds.ServerID
		var pool_conn *pgxpool.Conn
		pool_conn, conn_id, err_с := d_store.GetPrimary()
		if err_с != nil {
			app.GetLogger().Errorf("OnCloseSocket GetPrimary(): %v", err_с)
			return
		}
		defer d_store.Release(pool_conn, conn_id)
		conn := pool_conn.Conn()

		if _, err := conn.Exec(context.Background(),
			`DELETE FROM user_operations WHERE user_id = $1 AND status='end'`,
			user_id,
		); err != nil {
			app.GetLogger().Errorf("OnCloseSocket DELETE conn.Exec(): %v", err)
		}
	}(a)
}
*/
