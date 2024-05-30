package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 17/01/2023
 *
 * This is ItemFeatureGroupItem controller implimentation file.
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
func (pm *ItemFeatureGroupItem_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFeatureGroupItem"], &models.ItemFeatureGroupItem_keys{}, sock.GetPresetFilter("ItemFeatureGroupItem"))	
}

//Method implemenation delete
func (pm *ItemFeatureGroupItem_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFeatureGroupItem"], sock.GetPresetFilter("ItemFeatureGroupItem"))	
}

//Method implemenation get_object
func (pm *ItemFeatureGroupItem_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFeatureGroupItemList"], &models.ItemFeatureGroupItemList{}, sock.GetPresetFilter("ItemFeatureGroupItemList"))	
}

//Method implemenation get_list
func (pm *ItemFeatureGroupItem_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFeatureGroupItemList"], &models.ItemFeatureGroupItemList{}, sock.GetPresetFilter("ItemFeatureGroupItemList"))	
}

//Method implemenation update
func (pm *ItemFeatureGroupItem_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFeatureGroupItem"], sock.GetPresetFilter("ItemFeatureGroupItem"))	
}


