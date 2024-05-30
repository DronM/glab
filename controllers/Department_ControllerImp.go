package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 20/02/2024
 *
 * This is Department controller implimentation file.
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
func (pm *Department_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Department"], &models.Department_keys{}, sock.GetPresetFilter("Department"))	
}

//Method implemenation delete
func (pm *Department_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Department"], sock.GetPresetFilter("Department"))	
}

//Method implemenation get_object
func (pm *Department_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["Department"], &models.Department{}, sock.GetPresetFilter("Department"))	
}

//Method implemenation get_list
func (pm *Department_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["Department"], &models.Department{}, sock.GetPresetFilter("Department"))	
}

//Method implemenation update
func (pm *Department_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Department"], sock.GetPresetFilter("Department"))	
}

//Method implemenation complete
func (pm *Department_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["Department"], &models.Department{}, sock.GetPresetFilter("Department"))	
}

