package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 20/12/2022
 *
 * This is Login controller implimentation file.
 *
 */

import (
	"reflect"	
	"encoding/json"
	"fmt"
	
	"glab/models"
	
	//"github.com/dronm/ds/pgds"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/evnt"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	"github.com/dronm/gobizap/model"
	
	//"github.com/jackc/pgx/v5"
)



//Method implemenation get_object
func (pm *Login_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["LoginList"], &models.LoginList{}, sock.GetPresetFilter("LoginList"))	
}

//Method implemenation get_list
func (pm *Login_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["LoginList"], &models.LoginList{}, sock.GetPresetFilter("LoginList"))	
}

//Method implemenation
func (pm *Login_Controller_logout) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*evnt.Event)
	
	session_id_i, ok := args.Params["session_id"]
	if !ok {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "Login_Controller_logout session_id parameter is missing")
	}
	session_id, ok := session_id_i.(string)
	if !ok {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "Login_Controller_logout session_id parameter is not a string")
	}
	
	//find socket on public key	
	ws_srv := app.GetServer("ws")
	if ws_srv == nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "Login_Controller_logout Application server with ID 'ws' not found")
	}

	//response with event model
	sock_resp := response.NewResponse("", app.GetMD().Version.Value)
	sock_resp.AddModelFromStruct(model.ModelID("Event"), evnt.Event{Id: "User.logout"})
	resp_b, err := json.Marshal(sock_resp)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("Login_Controller_logout json.marhsal(): %v", err))
	}

	sockets := ws_srv.GetClientSockets()
	for sock_item := range sockets.Iter() {			
		if session_id == sock_item.GetToken() {
			if err := ws_srv.SendToClient(sock_item, resp_b); err != nil {
				app.GetLogger().Errorf("Login_Controller_logout ws_srv.SendToClient(): %v", err)
			}
			conn := sock_item.GetConn()
			if conn != nil {
				conn.Close()
			}
		}
	}
	
	return nil
}


