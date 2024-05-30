package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 24/01/2023
 *
 * This is SupplierItemFolderFeatureGroup controller implimentation file.
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
func (pm *SupplierItemFolderFeatureGroup_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierItemFolderFeatureGroup"], &models.SupplierItemFolderFeatureGroup_keys{}, sock.GetPresetFilter("SupplierItemFolderFeatureGroup"))	
}

//Method implemenation delete
func (pm *SupplierItemFolderFeatureGroup_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierItemFolderFeatureGroup"], sock.GetPresetFilter("SupplierItemFolderFeatureGroup"))	
}

//Method implemenation get_object
func (pm *SupplierItemFolderFeatureGroup_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierItemFolderFeatureGroupList"], &models.SupplierItemFolderFeatureGroupList{}, sock.GetPresetFilter("SupplierItemFolderFeatureGroupList"))	
}

//Method implemenation get_list
func (pm *SupplierItemFolderFeatureGroup_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierItemFolderFeatureGroupList"], &models.SupplierItemFolderFeatureGroupList{}, sock.GetPresetFilter("SupplierItemFolderFeatureGroupList"))	
}

//Method implemenation update
func (pm *SupplierItemFolderFeatureGroup_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierItemFolderFeatureGroup"], sock.GetPresetFilter("SupplierItemFolderFeatureGroup"))	
}


