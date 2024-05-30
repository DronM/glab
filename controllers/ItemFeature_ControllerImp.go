package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 30/12/2022
 *
 * This is ItemFeature controller implimentation file.
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
func (pm *ItemFeature_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFeature"], &models.ItemFeature_keys{}, sock.GetPresetFilter("ItemFeature"))	
}

//Method implemenation delete
func (pm *ItemFeature_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFeature"], sock.GetPresetFilter("ItemFeature"))	
}

//Method implemenation get_object
func (pm *ItemFeature_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFeature"], &models.ItemFeature{}, sock.GetPresetFilter("ItemFeature"))	
}

//Method implemenation get_list
func (pm *ItemFeature_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFeatureList"], &models.ItemFeatureList{}, sock.GetPresetFilter("ItemFeatureList"))	
}

//Method implemenation update
func (pm *ItemFeature_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ItemFeature"], sock.GetPresetFilter("ItemFeature"))	
}

//Method implemenation complete
func (pm *ItemFeature_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemFeatureList"], &models.ItemFeatureList{}, nil)
}

