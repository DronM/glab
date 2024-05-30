package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 16/08/2023
 *
 * This is AutoBody controller implimentation file.
 *
 */

import (
	"reflect"	
	
	"glab/models"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	//"github.com/jackc/pgx/v5"
)

var auto_body_list_fields string

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

//Method implemenation complete_for_model
func (pm *AutoBody_Controller_complete_for_model) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
/*
	scan_model := &models.AutoBodyList{}
	scan_model_md := app.GetMD().Models["AutoBodyList"]
	
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary(gobizap.GetModelLsnValue(scan_model))
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
		
	if auto_body_list_fields == "" {
		var sb strings.Builder
		for i, fld := range strings.Split(scan_model_md.GetFieldList(""), ",") {
			if i > 0 {
				sb.WriteString(",")
			}
			sb.WriteString("t." + fld)
		}
		auto_body_list_fields = sb.String()
	}
	
	args := rfltArgs.Interface().(*models.AutoBody_complete_for_model)
	cond_vals := make([]interface{}, 3)
	cond_vals[0] = args.Make_id.GetValue()
	cond_vals[1] = args.Name.GetValue()
	
	if args.Count.GetIsSet() {
		cond_vals[2] = args.Count.GetValue()
	}else{
		cond_vals[2] = 500 //max value
	}	
	
	query := `SELECT ` +
		auto_body_list_fields +
		` FROM auto_bodies_list AS t
		WHERE ($1 = 0 OR t.auto_model_id = $1) AND (t.name ILIKE '%'||$2||'%' OR t.name_variants ILIKE '%'||$2||'%')
		ORDER BY
			CASE WHEN p.code > 0 THEN 0 ELSE 1 END,
			name		
		LIMIT $3`		
fmt.Println("CompleteOnArgsWithConn query=",query, cond_vals[0])		

	return gobizap.AddQueryResult(resp, scan_model_md, scan_model, query, "", cond_vals, conn, false)
*/
	return nil	
}

