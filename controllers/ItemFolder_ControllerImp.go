package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 28/12/2022
 *
 * This is ItemFolder controller implimentation file.
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
func (pm *ItemFolder_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFolder"], &models.ItemFolder_keys{}, sock.GetPresetFilter("ItemFolder"))	
}

//Method implemenation delete
func (pm *ItemFolder_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFolder"], sock.GetPresetFilter("ItemFolder"))	
}

//Method implemenation get_object
func (pm *ItemFolder_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFolderList"], &models.ItemFolderList{}, sock.GetPresetFilter("ItemFolderList"))	
}

//Method implemenation get_list
func (pm *ItemFolder_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	modelStruct := &models.ItemFolderList{}
	modelMD := app.GetMD().Models["ItemFolderList"]
	encryptKey := app.GetEncryptKey()
	extraConds := sock.GetPresetFilter("ItemFolderList")
	
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary(gobizap.GetModelLsnValue(modelStruct))
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
//	
	f_sep := gobizap.ArgsFieldSep(rfltArgs)
	orderby_sql := gobizap.GetSQLOrderByFromArgsOrDefault(rfltArgs, f_sep, modelMD, encryptKey)	
	where_sql, cond_params, err := gobizap.GetSQLWhereFromArgs(rfltArgs, f_sep, modelMD, extraConds)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("%v",err))
	}

	relation := modelMD.Relation
	query := fmt.Sprintf("SELECT %s FROM %s", modelMD.GetFieldList(encryptKey), relation)	
	if where_sql != "" {
		query += " "+where_sql
	}else{
		//no params!
		query += " WHERE parent_item_folder_id IS NULL"
	}
	if orderby_sql != "" {
		query += " "+orderby_sql
	}		
	query += " LIMIT 5000"
	m, err := gobizap.QueryResultToModel(modelMD, modelStruct, query, "", cond_params, conn, false)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("%v",err))
	}
	resp.AddModel(m)
	return nil	
}

//Method implemenation update
func (pm *ItemFolder_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFolder"], sock.GetPresetFilter("ItemFolder"))	
}

//Method implemenation complete
func (pm *ItemFolder_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFolderList"], &models.ItemFolderList{}, nil)
}

