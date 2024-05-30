package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 19/04/2024
 *
 * This is CashFlowOut controller implimentation file.
 *
 */

import (
	"glab/models"
	"reflect"

	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv"
	//"github.com/jackc/pgx/v4"
)

// Method implemenation insert
func (pm *CashFlowOut_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	sess := sock.GetSession()
	user_id := sess.GetInt(SESS_VAR_ID)
	args := rfltArgs.Interface().(*models.CashFlowOut)
	args.User_id.SetValue(user_id)
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowOut"], &models.CashFlowOut_keys{}, sock.GetPresetFilter("CashFlowOut"))
}

// Method implemenation delete
func (pm *CashFlowOut_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowOut"], sock.GetPresetFilter("CashFlowOut"))
}

// Method implemenation get_object
func (pm *CashFlowOut_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashFlowOutList"], &models.CashFlowOutList{}, sock.GetPresetFilter("CashFlowOutList"))
}

// Method implemenation get_list
func (pm *CashFlowOut_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashFlowOutList"], &models.CashFlowOutList{}, sock.GetPresetFilter("CashFlowOutList"))
}

// Method implemenation update
func (pm *CashFlowOut_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowOut"], sock.GetPresetFilter("CashFlowOut"))
}
