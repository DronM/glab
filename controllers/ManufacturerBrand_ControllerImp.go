package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 16/02/2023
 *
 * This is ManufacturerBrand controller implimentation file.
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
func (pm *ManufacturerBrand_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ManufacturerBrand"], &models.ManufacturerBrand_keys{}, sock.GetPresetFilter("ManufacturerBrand"))	
}

//Method implemenation delete
func (pm *ManufacturerBrand_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ManufacturerBrand"], sock.GetPresetFilter("ManufacturerBrand"))	
}

//Method implemenation get_object
func (pm *ManufacturerBrand_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ManufacturerBrandList"], &models.ManufacturerBrandList{}, sock.GetPresetFilter("ManufacturerBrandList"))	
}

//Method implemenation get_list
func (pm *ManufacturerBrand_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["ManufacturerBrandList"], &models.ManufacturerBrandList{}, sock.GetPresetFilter("ManufacturerBrandList"))	
}

//Method implemenation update
func (pm *ManufacturerBrand_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ManufacturerBrand"], sock.GetPresetFilter("ManufacturerBrand"))	
}

//Method implemenation complete
func (pm *ManufacturerBrand_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["ManufacturerBrandList"], &models.ManufacturerBrandList{}, sock.GetPresetFilter("ManufacturerBrandList"))	
}

