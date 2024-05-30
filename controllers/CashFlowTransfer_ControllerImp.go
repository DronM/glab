package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 24/04/2024
 *
 * This is CashFlowTransfer controller implimentation file.
 *
 */

import (
	"reflect"

	"glab/models"

	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv"
	//"github.com/jackc/pgx/v4"
)

// Method implemenation insert
func (pm *CashFlowTransfer_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	sess := sock.GetSession()
	user_id := sess.GetInt(SESS_VAR_ID)
	args := rfltArgs.Interface().(*models.CashFlowTransfer)
	args.User_id.SetValue(user_id)
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowTransfer"], &models.CashFlowTransfer_keys{}, sock.GetPresetFilter("CashFlowTransfer"))
}

// Method implemenation delete
func (pm *CashFlowTransfer_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowTransfer"], sock.GetPresetFilter("CashFlowTransfer"))
}

// Method implemenation get_object
func (pm *CashFlowTransfer_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashFlowTransferList"], &models.CashFlowTransferList{}, sock.GetPresetFilter("CashFlowTransferList"))
}

// Method implemenation get_list
func (pm *CashFlowTransfer_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashFlowTransferList"], &models.CashFlowTransferList{}, sock.GetPresetFilter("CashFlowTransferList"))
}

// Method implemenation update
func (pm *CashFlowTransfer_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowTransfer"], sock.GetPresetFilter("CashFlowTransfer"))
}
