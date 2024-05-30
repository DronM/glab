package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 20/01/2023
 *
 * This is ItemFolderFeatureGroup controller implimentation file.
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
func (pm *ItemFolderFeatureGroup_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFolderFeatureGroup"], &models.ItemFolderFeatureGroup_keys{}, sock.GetPresetFilter("ItemFolderFeatureGroup"))	
}

//Method implemenation delete
func (pm *ItemFolderFeatureGroup_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFolderFeatureGroup"], sock.GetPresetFilter("ItemFolderFeatureGroup"))	
}

//Method implemenation get_object
func (pm *ItemFolderFeatureGroup_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFolderFeatureGroupList"], &models.ItemFolderFeatureGroupList{}, sock.GetPresetFilter("ItemFolderFeatureGroupList"))	
}

//Method implemenation get_list
func (pm *ItemFolderFeatureGroup_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFolderFeatureGroupList"], &models.ItemFolderFeatureGroupList{}, sock.GetPresetFilter("ItemFolderFeatureGroupList"))	
}

//Method implemenation update
func (pm *ItemFolderFeatureGroup_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFolderFeatureGroup"], sock.GetPresetFilter("ItemFolderFeatureGroup"))	
}


