package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 04/04/2023
 *
 * This is SupplierStoreValue controller implimentation file.
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

//Method implemenation insert
func (pm *SupplierStoreValue_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierStoreValue"], &models.SupplierStoreValue_keys{}, sock.GetPresetFilter("SupplierStoreValue"))	
}

//Method implemenation delete
func (pm *SupplierStoreValue_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierStoreValue"], sock.GetPresetFilter("SupplierStoreValue"))	
}

//Method implemenation get_object
func (pm *SupplierStoreValue_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierStoreValueList"], &models.SupplierStoreValueList{}, sock.GetPresetFilter("SupplierStoreValueList"))	
}

//Method implemenation get_list
func (pm *SupplierStoreValue_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierStoreValueList"], &models.SupplierStoreValueList{}, sock.GetPresetFilter("SupplierStoreValueList"))	
}

//Method implemenation update
func (pm *SupplierStoreValue_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierStoreValue"], sock.GetPresetFilter("SupplierStoreValue"))	
}


