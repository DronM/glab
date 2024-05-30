package controllers

/**
 * Andrey Mikhalevich 15/12/21
 *
 * Controller implimentation file
 *
 */

import (
	"fmt"
	"reflect"
	"context"
	"strings"
	"strconv"
	"time"
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"	
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/srv/httpSrv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/response"
	
	cpt "github.com/dronm/gobizap/repo/captcha"
	
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

const (
	PWD_LEN = 6
	DEF_PASSWORD = "123456"
	
	RESP_ER_AUTH_CODE = 1000
	RESP_ER_AUTH_DESCR = "Неверное имя пользователя или пароль"
	RESP_ER_BANNED_CODE = 1001
	RESP_ER_BANNED_DESCR = "Доступ запрещен"
	
	RESP_ER_EMAIL = 1002
	RESP_ER_EMAIL_DESCR = "Ошибка отправки email"

	RESP_ER_AUTH_TOKEN_CODE = 1003
	RESP_ER_AUTH_TOKEN_DESCR = "Неверный токен"
	
	ER_USER_NOT_DEFIND_DESCR = "Пользователь не определен";
	ER_USER_NOT_DEFIND_CODE = 1004
	
	RESP_ER_BANNED_DEV_CODE = 1005
	RESP_ER_BANNED_DEV_DESCR = "Доступ с устройства запрещен"

	RESP_ER_OTHER_USER_DATA_CODE = 1006
	RESP_ER_OTHER_USER_DATA_DESCR = "Запрещено изменять чужие данные"
	
	RESP_ER_NO_EMAIL_CODE = 1007
	RESP_ER_NO_EMAIL_DESCR = "Адрес электронной почты не найден"
	
	RESP_ER_CAPTCHA_CODE = 1008
	RESP_ER_CAPTCHA_DESCR = "Неверный код"

	SESS_VAR_NAME = "USER_NAME"
	SESS_VAR_DESCR = "USER_DESCR"
	SESS_VAR_ID = "USER_ID"
	SESS_VAR_WIDTH_TYPE = "WIDTH_TYPE"
	SESS_VAR_LOGIN_ID = "USER_LOGIN_ID"
	SESS_VAR_LOGGED = "LOGGED"
	SESS_VAR_POP_COMPLETE_COUNT = "POP_COMPLETE_COUNT" //popularity
	
	USER_PWD_RECOVERY_CAPTCHA = "pwd_recovery"
	CAPTCHA_WIDTH = 240
	CAPTCHA_HEIGHT = 80
	CAPTCHA_LEN = 6
	
)

//Method implemenation
func (pm *User_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["UserDialog"], &models.UserDialog{}, sock.GetPresetFilter("UserDialog"))
}


//User_Controller_insert
func (pm *User_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.User)

	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn	
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	
	
	//photo upload
	http_sock, ok := sock.(*httpSrv.HTTPSocket)
	if !ok {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "User_Controller_update: not HTTPSocket type")
	}	
	data, _, err := http_sock.GetUploadedFileData("photo[]")
	if err == nil {
		args.Photo.SetValue(data)
	}	
	
	//2) custom
	pwd := DEF_PASSWORD//genUniqID(PWD_LEN)
	hash := GetMd5(pwd)
	args.Pwd.SetValue(hash)
	
	field_ids, field_args, field_values := gobizap.ArgsToInsertParams(rfltArgs, nil, "")		
	
	//1) begin transaction
	_, err = conn.Exec(context.Background(), "BEGIN")
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_insert BEGIN: %v",err))
	}
			
	q := fmt.Sprintf("INSERT INTO users (%s) VALUES (%s) RETURNING id", field_ids, field_args)
	row := &models.User_keys{}
	if err := conn.QueryRow(context.Background(), q, field_values...).Scan(&row.Id); err != nil {
		conn.Exec(context.Background(), "ROLLBACK")
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("pgx.Conn.QueryRow.Scan(&row.Id): %v",err))
	}
	resp.AddModel(model.New_InsertedKey_Model(row))
	
	if err := sendEmailNewPwd(conn, row.Id.GetValue(), pwd); err != nil {
		conn.Exec(context.Background(), "ROLLBACK")
		return gobizap.NewPublicMethodError(RESP_ER_EMAIL, fmt.Sprintf("sendEmailNewPwd(): %v",err))
	}
	
	//events
	params := make(map[string]interface{})
	params["emitterId"] = sock.GetToken()
	app.PublishPublicMethodEvents(pm, params)
	
	//3) action
	keys := make(map[string]interface{})
	keys["id"] = row.Id.GetValue()
	if err := addAction(conn, sock, app.GetMD().Models["User"], "insert", keys); err != nil {
		conn.Exec(context.Background(), "ROLLBACK")
		return err
	}

	//4) commit
	_, err = conn.Exec(context.Background(), "COMMIT")
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_insert COMMIT: %v",err))
	}
	
	return nil
}

//User_Controller_delete Method implemenation
func (pm *User_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	//modified
	return DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["User"], sock.GetPresetFilter("User"))
}

//Method implemenation
func (pm *User_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["UserList"], &models.UserList{}, sock.GetPresetFilter("UserList"))
}

//Method implemenation
func (pm *User_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	
	args := rfltArgs.Interface().(*models.User_old_keys)
	
	//photo upload
	http_sock, ok := sock.(*httpSrv.HTTPSocket)
	if !ok {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "User_Controller_update: not HTTPSocket type")
	}	

	//uploaded file
	data, _, err := http_sock.GetUploadedFileData("photo[]")
	if err == nil {		
		args.Photo.SetValue(data)
	}
		
	return UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["User"], sock.GetPresetFilter("User"))
}

//Method implemenation
func (pm *User_Controller_reset_pwd) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
		
	//custom
	pwd := genUniqID(PWD_LEN)
	hash := GetMd5(pwd)
	if hash == "" {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "Ошибка генерации пароля")
	}	
	args := rfltArgs.Interface().(*models.User_reset_pwd)
	
	if _, err := conn.Prepare(context.Background(),
		USER_RESET_PWD_Q,
		"UPDATE users SET pwd = $1 WHERE id = $2"); err != nil {
				
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_reset_pwd USER_RESET_PWD_Q pgx.Conn.Prepare(): %v",err))
	}
	
	if _, err := conn.Exec(context.Background(), "BEGIN"); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_reset_pwd BEGIN: %v",err))
	}
		
	if _, err := conn.Exec(context.Background(), USER_RESET_PWD_Q, hash, args.User_id); err != nil {
		conn.Exec(context.Background(), "ROLLBACK")
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_reset_pwd USER_RESET_PWD_Q pgx.Conn.Exec(): %v",err))
	}
	
	if err := sendEmailResetPwd(conn, args.User_id.GetValue(), pwd); err != nil {
		conn.Exec(context.Background(), "ROLLBACK")
		return gobizap.NewPublicMethodError(RESP_ER_EMAIL, fmt.Sprintf("User_Controller_reset_pwd sendEmailResetPwd(): %v",err))
	}
	
	if _, err := conn.Exec(context.Background(), "COMMIT"); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_reset_pwd COMMIT: %v",err))
	}
	
	return nil
}

//Method implemenation
func (pm *User_Controller_login) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
				
	user_row := models.UserLogin{}
	user_fields, user_ids, err := gobizap.MakeStructRowFields(&user_row, "")
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_login users_login gobizap.MakeStructRowFields(): %v",err))
	}
	if _, err := conn.Prepare(context.Background(),
			USER_LOGIN_Q,
			fmt.Sprintf("SELECT %s FROM users_login WHERE name = $1 AND pwd = md5($2)", user_ids) ); err != nil {
			
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_login USER_LOGIN_Q conn.Prepare(): %v",err))	
	}
	
	args := rfltArgs.Interface().(*models.User_login)
	
	err = conn.QueryRow(context.Background(), USER_LOGIN_Q, args.Name.GetValue(), args.Pwd.GetValue()).Scan(user_fields...)	
	if err == pgx.ErrNoRows {
		return gobizap.NewPublicMethodError(RESP_ER_AUTH_CODE, RESP_ER_AUTH_DESCR)	
		
	}else if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_login USER_LOGIN_Q conn.QueryRow(): %v",err))	
	}
	
	pub_key, err := doLoginUser(app, sock, conn, &user_row, args.Width_type.GetValue())
	if err != nil {
		return err
	}
		
	//return auth
	/*token := fmt.Sprintf("%s:%s", pub_key, GetMd5(pub_key + sess_id))
	token_r:= fmt.Sprintf("%s:%s", pub_key, GetMd5(pub_key + user_row.Pwd + strconv.FormatInt(user_row.Id.GetValue(), 10))) 
	resp.AddModel(models.NewAuth_Model(token, token_r, sock.GetTokenExpires()))
	*/
	addAuthModel(resp, pub_key, sock.GetSession().SessionID(), user_row.Pwd.GetValue(), user_row.Id.GetValue(), sock.GetTokenExpires())
	
	return nil
}

//Method implemenation
func (pm *User_Controller_logout) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {

	sess := sock.GetSession()	
	login_id := sess.GetInt("USER_LOGIN_ID")
	if login_id == 0 {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "login_id=0")
	}
	man := app.GetSessManager()
	man.SessionDestroy(sess.SessionID())

	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	if _, err := conn.Prepare(context.Background(),
		USER_LOGIN_CLOSE_Q,
		`UPDATE logins
		SET date_time_out = now()
		WHERE id=$1`); err != nil {
		
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("USER_LOGIN_CLOSE_Q pgx.Prepare(): %v",err))	
	}


	if _, err = conn.Exec(context.Background(), USER_LOGIN_CLOSE_Q, login_id); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("USER_LOGIN_CLOSE_Q pgx.Exec(): %v",err))	
	}		
	return nil
}


func sendEmailNewPwd(conn *pgx.Conn, id int64, pwd string) error {
	//_, err := conn.Exec(context.Background(), "SELECT email_user_new_account($1, $2)", id, pwd)
	//return err
	return nil
}

func sendEmailResetPwd(conn *pgx.Conn, userID int64, newPwd string) error {
	return RegisterMailFromSQL(conn, "mail_password_recover", nil, []interface{}{userID, newPwd})
}

func sendEmailEmailConf(conn *pgx.Conn, id int64, key string) error {
	//_, err := conn.Exec(context.Background(), "SELECT email_user_email_conf($1, $2)", id, key)
	//return err
	return nil
}

//Method implemenation
func (pm *User_Controller_login_token) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.User_login_token)
	token := args.Token.GetValue()
	pub_key_p := strings.Index(token, ":")
	if pub_key_p < 0 {
		return gobizap.NewPublicMethodError(RESP_ER_AUTH_TOKEN_CODE, RESP_ER_AUTH_TOKEN_DESCR)
	}
	
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := d_store.GetSecondary("")
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	pub_key := token[:pub_key_p]

	session_id := ""
	pwd_hash := ""
	user_id := 0
	user_row := &models.UserDialog{}
	if _, err := conn.Prepare(context.Background(),
		USER_LOGIN_TOKEN_Q,
			`SELECT
				trim(l.session_id) AS session_id,
				u.pwd,
				u.id,
				ud.id,
				ud.name,
				ud.role_id,
				ud.banned,
				ud.locale_id,
				ud.time_zone_locales_ref
				
			FROM logins l
			LEFT JOIN users_dialog AS ud ON ud.id = l.user_id
			LEFT JOIN users AS u ON u.id = l.user_id
			WHERE l.date_time_out IS NULL AND l.pub_key=$1`); err != nil {
			
		return gobizap.NewPublicMethodError(RESP_ER_AUTH_TOKEN_CODE, fmt.Sprintf("USER_LOGIN_TOKEN_Q pgx.Conn.Prepare(): %v", err))
	}
	
	err = conn.QueryRow(context.Background(), USER_LOGIN_TOKEN_Q, pub_key).Scan(&session_id,
				&pwd_hash, &user_id,
				&user_row.Id,
				&user_row.Name,
				&user_row.Role_id,
				&user_row.Banned,
				&user_row.Locale_id,
				&user_row.Time_zone_locales_ref)
			
	if err == pgx.ErrNoRows {
		return gobizap.NewPublicMethodError(RESP_ER_AUTH_TOKEN_CODE, RESP_ER_AUTH_TOKEN_DESCR)
	
	}else if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("USER_LOGIN_TOKEN_Q pgx.Rows.Scan(): %v",err))	
	}
	
	if token[pub_key_p+1:] != GetMd5(pub_key + session_id) {
		return gobizap.NewPublicMethodError(RESP_ER_AUTH_TOKEN_CODE, RESP_ER_AUTH_TOKEN_DESCR)
	}
	
	sess := sock.GetSession()
	man := app.GetSessManager()
	man.SessionDestroy(sess.SessionID())
	man.SessionStart(session_id)
	
	//return user profile
	m := &model.Model{ID: "UserDialog"}
	m.Rows = make([]model.ModelRow, 1)		
	m.Rows[0] = user_row
	resp.AddModel(m)
	
	//return auth
	token_r:= fmt.Sprintf("%s:%s", pub_key, GetMd5(pub_key + pwd_hash + strconv.Itoa(user_id)) ) 
	resp.AddModel(model.NewAuth_Model(pub_key+":"+token[pub_key_p+1:], token_r, sock.GetTokenExpires()))
	
	return nil
}

//Method implemenation
func (pm *User_Controller_get_profile) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	//current logged user
	sess := sock.GetSession()
	if !sess.GetBool("LOGGED") {
		return gobizap.NewPublicMethodError(RESP_ER_AUTH_CODE, RESP_ER_AUTH_DESCR)	
	}
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := d_store.GetSecondary("")
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
		
	cond := make([]interface{}, 1)
	cond[0] = sess.GetInt("USER_ID")
	f_list := app.GetMD().Models["UserProfile"].GetFieldList("")
	return gobizap.AddQueryResult(resp,  app.GetMD().Models["UserProfile"], &models.UserProfile{}, fmt.Sprintf("SELECT %s FROM users_profile WHERE id=$1",f_list), "", cond, conn, false)
}

//Method implemenation
func (pm *User_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["UserList"], &models.UserList{}, sock.GetPresetFilter("UserList"))
}

//Method implemenation
func (pm *User_Controller_delete_photo) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.User_delete_photo)

	sess := sock.GetSession()
	role := sess.GetString(gobizap.SESS_ROLE)
	user_id := sess.GetInt(SESS_VAR_ID)
	if role != "admin" && user_id != args.User_id.GetValue() {
		//only self data is allowed!
		return gobizap.NewPublicMethodError(RESP_ER_OTHER_USER_DATA_CODE, RESP_ER_OTHER_USER_DATA_DESCR)
	}

	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn	
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	if _, err := conn.Exec(context.Background(),
		`UPDATE users
		SET photo = null
		WHERE id = $1`, args.User_id); err != nil {
		
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_delete_photo pgx.Conn.Exec(): %v",err))
	}
	return nil
}

//Method implemenation
func (pm *User_Controller_password_recover) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.User_password_recover)

	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn	
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	var ret_error error
	defer (func(){
		if ret_error != nil {
			cpt.AddNewCaptcha(sock.GetSession(), app.GetLogger(), resp, USER_PWD_RECOVERY_CAPTCHA, CAPTCHA_WIDTH, CAPTCHA_HEIGHT, CAPTCHA_LEN)
		}
	})()

	//captcha check
	if ok, err := cpt.CaptchaVerify(sock.GetSession(), app.GetLogger(), []byte(args.Captcha_key.GetValue()), USER_PWD_RECOVERY_CAPTCHA); !ok || err != nil {
		if err != nil {
			ret_error = gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_password_recover CaptchaVerify(): %v",err))
		}else{
			ret_error = gobizap.NewPublicMethodError(RESP_ER_CAPTCHA_CODE, RESP_ER_CAPTCHA_DESCR)
		}
		return ret_error
	}
	
	var user_id int64
	err = conn.QueryRow(context.Background(),
		`SELECT id FROM users WHERE name = $1`,
		args.Email.GetValue(),
		).Scan(&user_id)
		
	if err != nil && err == pgx.ErrNoRows {
		//email does not exist
		
		ret_error = gobizap.NewPublicMethodError(RESP_ER_NO_EMAIL_CODE, RESP_ER_NO_EMAIL_DESCR)
		return ret_error
	
	}else if err != nil {
		ret_error = gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_password_recover pgx.Conn.QueryRow(): %v",err))
		return ret_error
	}
	
	new_pwd := DEF_PASSWORD
	
	if _, err := conn.Exec(context.Background(), "BEGIN"); err != nil {
		ret_error = gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_password_recover BEGIN: %v",err))
		return ret_error
	}
	
	if _, err := conn.Exec(context.Background(),
		"UPDATE users SET pwd = $1 WHERE id = $2",
		GetMd5(new_pwd), user_id); err != nil {
		
		ret_error = gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_password_recover UPDATE users: %v",err))
		return ret_error
	}	
	
	if err := RegisterMailFromSQL(conn, "mail_password_recover", nil, []interface{}{user_id, new_pwd}); err != nil {
		if _, err := conn.Exec(context.Background(), "ROLLBACK"); err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_password_recover ROLLBACK: %v",err))
		}
	
		ret_error = gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_password_recover RegisterMail(): %v",err))
		return ret_error
	}
	
	if _, err := conn.Exec(context.Background(), "COMMIT"); err != nil {
		ret_error = gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_password_recover COMMIT: %v",err))
		return ret_error
	}
	
	return nil
}

func addAuthModel(resp *response.Response, pubKey, sessID, pwdHash string, userId int64, exp time.Time) {
	resp.AddModel(model.NewAuth_Model(sessID, sessID, exp))
}


