package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 28/12/2022
 *
 * This is AutoBody controller implimentation file.
 *
 */

import (
	"reflect"	
	"fmt"
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	//"github.com/jackc/pgx/v5"
)

//Method implemenation insert
func (pm *AutoBody_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoBody"], &models.AutoBody_keys{}, sock.GetPresetFilter("AutoBody"))	
}

//Method implemenation delete
func (pm *AutoBody_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoBody"], sock.GetPresetFilter("AutoBody"))	
}

//Method implemenation get_object
func (pm *AutoBody_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoBodyList"], &models.AutoBodyList{}, sock.GetPresetFilter("AutoBodyList"))	
}

//Method implemenation get_list
func (pm *AutoBody_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoBodyList"], &models.AutoBodyList{}, sock.GetPresetFilter("AutoBodyList"))	
}

//Method implemenation update
func (pm *AutoBody_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoBody"], sock.GetPresetFilter("AutoBody"))	
}

//Method implemenation complete
func (pm *AutoBody_Controller_complete_for_model_generation) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	scan_model := &models.AutoBodyList{}
	scan_model_md := app.GetMD().Models["AutoBodyList"]
	
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary(gobizap.GetModelLsnValue(scan_model))
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
		
	f_sep := gobizap.ArgsFieldSep(rfltArgs)
	orderby_sql := gobizap.GetSQLOrderByFromArgsOrDefault(rfltArgs, f_sep, scan_model_md, app.GetEncryptKey())	
	limit_sql, _, _, err := gobizap.GetSQLLimitFromArgs(rfltArgs, scan_model_md, conn, gobizap.METH_COMPLETE_DEF_COUNT)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, err.Error())
	}
	
	args := rfltArgs.Interface().(*models.AutoBody_complete_for_model_generation)
	cond_vals := make([]interface{}, 3)
	cond_vals[0] = args.Model_generation_id.GetValue()
	cond_vals[1] = args.Model_id.GetValue()
	cond_vals[2] = args.Descr.GetValue()
	
	query := `SELECT ` + 
		scan_model_md.GetFieldList("") +
		` FROM auto_bodies_list
		WHERE ($1 = 0 OR auto_model_generation_id = $1) AND ($2 = 0 OR auto_model_id = $2)
			AND (
				auto_body_types_ref->>'descr' ILIKE '%'||$3::text||'%'
				OR restyle_years ILIKE '%'||$3::text||'%'
				OR ind ILIKE '%'||$3::text||'%'
				OR year_from::text ILIKE '%'||$3::text||'%'
				OR year_to::text ILIKE '%'||$3::text||'%'
			) ` + orderby_sql + " " + limit_sql
fmt.Println("CompleteOnArgsWithConn query=",query, cond_vals[0], cond_vals[1])		
	return gobizap.AddQueryResult(resp, scan_model_md, scan_model, query, "", cond_vals, conn, false)
}

