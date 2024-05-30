package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 25/04/2024
 *
 * This is BankAccount controller implimentation file.
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
func (pm *BankAccount_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankAccount"], &models.BankAccount_keys{}, sock.GetPresetFilter("BankAccount"))	
}

//Method implemenation delete
func (pm *BankAccount_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankAccount"], sock.GetPresetFilter("BankAccount"))	
}

//Method implemenation get_object
func (pm *BankAccount_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["BankAccountList"], &models.BankAccountList{}, sock.GetPresetFilter("BankAccountList"))	
}

//Method implemenation get_list
func (pm *BankAccount_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["BankAccountList"], &models.BankAccountList{}, sock.GetPresetFilter("BankAccountList"))	
}

//Method implemenation update
func (pm *BankAccount_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankAccount"], sock.GetPresetFilter("BankAccount"))	
}


