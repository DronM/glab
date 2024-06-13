package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 13/06/2024
 *
 * This is CashIncomeSource controller implimentation file.
 *
 */

import (
	"reflect"	
	
	"glab/models"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	//"github.com/jackc/pgx/v4"
)

//Method implemenation insert
func (pm *CashIncomeSource_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashIncomeSource"], &models.CashIncomeSource_keys{}, sock.GetPresetFilter("CashIncomeSource"))	
}

//Method implemenation delete
func (pm *CashIncomeSource_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashIncomeSource"], sock.GetPresetFilter("CashIncomeSource"))	
}

//Method implemenation get_object
func (pm *CashIncomeSource_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashIncomeSourceList"], &models.CashIncomeSourceList{}, sock.GetPresetFilter("CashIncomeSourceList"))	
}

//Method implemenation get_list
func (pm *CashIncomeSource_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashIncomeSourceList"], &models.CashIncomeSourceList{}, sock.GetPresetFilter("CashIncomeSourceList"))	
}

//Method implemenation update
func (pm *CashIncomeSource_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashIncomeSource"], sock.GetPresetFilter("CashIncomeSource"))	
}


