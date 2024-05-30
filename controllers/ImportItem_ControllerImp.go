package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 21/02/2023
 *
 * This is ImportItem controller implimentation file.
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
func (pm *ImportItem_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ImportItem"], &models.ImportItem_keys{}, sock.GetPresetFilter("ImportItem"))	
}

//Method implemenation delete
func (pm *ImportItem_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ImportItem"], sock.GetPresetFilter("ImportItem"))	
}

//Method implemenation get_object
func (pm *ImportItem_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ImportItemList"], &models.ImportItemList{}, sock.GetPresetFilter("ImportItemList"))	
}

//Method implemenation get_list
func (pm *ImportItem_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["ImportItemList"], &models.ImportItemList{}, sock.GetPresetFilter("ImportItemList"))	
}

//Method implemenation update
func (pm *ImportItem_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["ImportItem"], sock.GetPresetFilter("ImportItem"))	
}


