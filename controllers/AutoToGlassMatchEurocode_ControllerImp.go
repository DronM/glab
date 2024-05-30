package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 02/06/2023
 *
 * This is AutoToGlassMatchEurocode controller implimentation file.
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
func (pm *AutoToGlassMatchEurocode_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchEurocode"], &models.AutoToGlassMatchEurocode_keys{}, sock.GetPresetFilter("AutoToGlassMatchEurocode"))	
}

//Method implemenation delete
func (pm *AutoToGlassMatchEurocode_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchEurocode"], sock.GetPresetFilter("AutoToGlassMatchEurocode"))	
}

//Method implemenation get_object
func (pm *AutoToGlassMatchEurocode_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoToGlassMatchEurocodeList"], &models.AutoToGlassMatchEurocodeList{}, sock.GetPresetFilter("AutoToGlassMatchEurocodeList"))	
}

//Method implemenation get_list
func (pm *AutoToGlassMatchEurocode_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoToGlassMatchEurocodeList"], &models.AutoToGlassMatchEurocodeList{}, sock.GetPresetFilter("AutoToGlassMatchEurocodeList"))	
}

//Method implemenation update
func (pm *AutoToGlassMatchEurocode_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchEurocode"], sock.GetPresetFilter("AutoToGlassMatchEurocode"))	
}

//Method implemenation get_body_list
func (pm *AutoToGlassMatchEurocode_Controller_get_body_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoToGlassMatchEurocodeBodyList"], &models.AutoToGlassMatchEurocodeBodyList{}, sock.GetPresetFilter("AutoToGlassMatchEurocodeBodyList"))	
}

