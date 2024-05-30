package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 28/12/2022
 *
 * This is AutoBodyType controller implimentation file.
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
func (pm *AutoBodyType_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoBodyType"], &models.AutoBodyType_keys{}, sock.GetPresetFilter("AutoBodyType"))	
}

//Method implemenation delete
func (pm *AutoBodyType_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoBodyType"], sock.GetPresetFilter("AutoBodyType"))	
}

//Method implemenation get_object
func (pm *AutoBodyType_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoBodyType"], &models.AutoBodyType{}, sock.GetPresetFilter("AutoBodyType"))	
}

//Method implemenation get_list
func (pm *AutoBodyType_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoBodyType"], &models.AutoBodyType{}, sock.GetPresetFilter("AutoBodyType"))	
}

//Method implemenation update
func (pm *AutoBodyType_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoBodyType"], sock.GetPresetFilter("AutoBodyType"))	
}


