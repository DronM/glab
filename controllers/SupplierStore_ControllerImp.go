package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 04/04/2023
 *
 * This is SupplierStore controller implimentation file.
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
	
	//"github.com/jackc/pgx/v5"
)

//Method implemenation insert
func (pm *SupplierStore_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierStore"], &models.SupplierStore_keys{}, sock.GetPresetFilter("SupplierStore"))	
}

//Method implemenation delete
func (pm *SupplierStore_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierStore"], sock.GetPresetFilter("SupplierStore"))	
}

//Method implemenation get_object
func (pm *SupplierStore_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierStoreList"], &models.SupplierStoreList{}, sock.GetPresetFilter("SupplierStoreList"))	
}

//Method implemenation get_list
func (pm *SupplierStore_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierStoreList"], &models.SupplierStoreList{}, sock.GetPresetFilter("SupplierStoreList"))	
}

//Method implemenation update
func (pm *SupplierStore_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierStore"], sock.GetPresetFilter("SupplierStore"))	
}

//Method implemenation complete_for_supplier
func (pm *SupplierStore_Controller_complete_for_supplier) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	scan_model := &models.SupplierStoreList{}
	scan_model_md := app.GetMD().Models["SupplierStoreList"]
	
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
	
	args := rfltArgs.Interface().(*models.SupplierStore_complete_for_supplier)
	cond_vals := make([]interface{}, 2)
	cond_vals[0] = args.Supplier_id.GetValue()
	cond_vals[1] = args.Name.GetValue()
	query := `SELECT ` + 
		scan_model_md.GetFieldList("") +
		` FROM supplier_stores_list
		WHERE ($1 = 0 OR supplier_id = $1) AND name ILIKE '%'||$2::text||'%'
		` + orderby_sql + " " + limit_sql
//fmt.Println("CompleteOnArgsWithConn query=",query, cond_vals[0], cond_vals[1])		
	return gobizap.AddQueryResult(resp, scan_model_md, scan_model, query, "", cond_vals, conn, false)
}

