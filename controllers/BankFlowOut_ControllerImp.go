package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 26/04/2024
 *
 * This is BankFlowOut controller implimentation file.
 *
 */

import (
	"reflect"

	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv"

	"glab/models"
)

// Method implemenation insert
func (pm *BankFlowOut_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankFlowOut"], &models.BankFlowOut_keys{}, sock.GetPresetFilter("BankFlowOut"))
}

// Method implemenation delete
func (pm *BankFlowOut_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankFlowOut"], sock.GetPresetFilter("BankFlowOut"))
}

// Method implemenation get_object
func (pm *BankFlowOut_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["BankFlowOutDialog"], &models.BankFlowOutDialog{}, sock.GetPresetFilter("BankFlowOutDialog"))
}

// Method implemenation get_list
func (pm *BankFlowOut_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["BankFlowOutList"], &models.BankFlowOutList{}, sock.GetPresetFilter("BankFlowOutList"))
}

// Method implemenation update
func (pm *BankFlowOut_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankFlowOut"], sock.GetPresetFilter("BankFlowOut"))
}
