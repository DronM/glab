package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 20/12/2022
 *
 * This is AutoMake controller implimentation file.
 *
 */

import (
	"reflect"	
//	"fmt"
	"strings"
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	//"github.com/jackc/pgx/v5"
)

var auto_make_list_fields string

//Method implemenation insert
func (pm *AutoMake_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoMake"], &models.AutoMake_keys{}, sock.GetPresetFilter("AutoMake"))	
}

//Method implemenation delete
func (pm *AutoMake_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoMake"], sock.GetPresetFilter("AutoMake"))	
}

//Method implemenation get_object
func (pm *AutoMake_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoMakeList"], &models.AutoMakeList{}, sock.GetPresetFilter("AutoMakeList"))	
}

//Method implemenation get_list
func (pm *AutoMake_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoMakeList"], &models.AutoMakeList{}, sock.GetPresetFilter("AutoMakeList"))	
}

//Method implemenation update
func (pm *AutoMake_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoMake"], sock.GetPresetFilter("AutoMake"))	
}

//Method implemenation complete
func (pm *AutoMake_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	scan_model := &models.AutoMakeList{}
	scan_model_md := app.GetMD().Models["AutoMakeList"]
	
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary(gobizap.GetModelLsnValue(scan_model))
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
		
	//Count based on device width_type
	args := rfltArgs.Interface().(*models.AutoMake_complete)
	cond_vals := make([]interface{}, 2)
	cond_vals[0] = args.Name.GetValue()
	
	if args.Count.GetIsSet() {
		cond_vals[1] = args.Count.GetValue()
	}else{
		cond_vals[1] = 500 //max value
	}	
	
	if auto_make_list_fields == "" {
		var sb strings.Builder
		for i, fld := range strings.Split(scan_model_md.GetFieldList(""), ",") {
			if i > 0 {
				sb.WriteString(",")
			}
			sb.WriteString("t." + fld)
		}
		auto_make_list_fields = sb.String()		
	}
	
	query := `SELECT ` +
		auto_make_list_fields +
		` FROM auto_makes_list AS t
		LEFT JOIN popularity_types AS p ON p.id = t.popularity_type_id
		WHERE t.name ILIKE '%'||$1||'%' OR t.name_variants ILIKE '%'||$1||'%'		
		ORDER BY
			CASE WHEN p.code > 0 THEN 0 ELSE 1 END,
			name
		LIMIT $2`
//fmt.Println("CompleteOnArgsWithConn query=",query, cond_vals[0], cond_vals[1])		
	return gobizap.AddQueryResult(resp, scan_model_md, scan_model, query, "", cond_vals, conn, false)
}

