package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 02/06/2023
 *
 * This is AutoToGlassMatchHead controller implimentation file.
 *
 */

import (
	"reflect"	
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	"github.com/jackc/pgx/v5/pgxpool"
)

//Method implemenation insert
func (pm *AutoToGlassMatchHead_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.AutoToGlassMatchHead)
	sess := sock.GetSession()
	args.User_id.SetValue(sess.GetInt(SESS_VAR_ID))
	
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchHead"], &models.AutoToGlassMatchHead_keys{}, sock.GetPresetFilter("AutoToGlassMatchHead"))	
}

//Method implemenation delete
func (pm *AutoToGlassMatchHead_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchHead"], sock.GetPresetFilter("AutoToGlassMatchHead"))	
}

//Method implemenation get_object
func (pm *AutoToGlassMatchHead_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	model_struct := &models.AutoToGlassMatchHeadList{}
	
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := d_store.GetSecondary(gobizap.GetModelLsnValue(model_struct))
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()


	if err := gobizap.GetObjectOnArgsWithConn(conn, app, resp, rfltArgs, app.GetMD().Models["AutoToGlassMatchHeadList"], model_struct, sock.GetPresetFilter("AutoToGlassMatchHeadList")); err != nil {
		return err
	}
	
	//item priority
	prior_model_md := app.GetMD().Models["ItemPriority"]
	prior_query, prior_query_tot, prior_where_params, _, _, err := gobizap.GetListQuery(conn, rfltArgs, prior_model_md, sock.GetPresetFilter("ItemPriority"), app.GetEncryptKey())
	if err != nil {
		return err
	}
	if err := gobizap.AddQueryResult(resp, prior_model_md, &models.ItemPriority{}, prior_query, prior_query_tot, prior_where_params, conn, false); err != nil {
		return err
	}
	
	return nil
}

//Method implemenation get_list
func (pm *AutoToGlassMatchHead_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoToGlassMatchHeadList"], &models.AutoToGlassMatchHeadList{}, sock.GetPresetFilter("AutoToGlassMatchHeadList"))	
}

//Method implemenation update
func (pm *AutoToGlassMatchHead_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.AutoToGlassMatchHead)
	
	user_id := args.User_id.GetValue()
	if user_id > 0 {
		sess := sock.GetSession()
		role := sess.GetString(gobizap.SESS_ROLE)		
		if role != "admin" {
			args.User_id.SetValue(sess.GetInt(SESS_VAR_ID))
		}	
	}	

	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchHead"], sock.GetPresetFilter("AutoToGlassMatchHead"))	
}


