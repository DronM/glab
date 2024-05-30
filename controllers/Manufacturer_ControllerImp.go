package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 04/02/2023
 *
 * This is Manufacturer controller implimentation file.
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
func (pm *Manufacturer_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Manufacturer"], &models.Manufacturer_keys{}, sock.GetPresetFilter("Manufacturer"))	
}

//Method implemenation delete
func (pm *Manufacturer_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Manufacturer"], sock.GetPresetFilter("Manufacturer"))	
}

//Method implemenation get_object
func (pm *Manufacturer_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ManufacturerDialog"], &models.ManufacturerDialog{}, sock.GetPresetFilter("ManufacturerDialog"))	
}

//Method implemenation get_list
func (pm *Manufacturer_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["ManufacturerList"], &models.ManufacturerList{}, sock.GetPresetFilter("ManufacturerList"))	
}

//Method implemenation update
func (pm *Manufacturer_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Manufacturer"], sock.GetPresetFilter("Manufacturer"))	
}

//Method implemenation complete
func (pm *Manufacturer_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["ManufacturerList"], &models.ManufacturerList{}, sock.GetPresetFilter("ManufacturerList"))	
}

