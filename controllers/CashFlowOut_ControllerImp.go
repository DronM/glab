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
	"fmt"
	"reflect"

	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv"

	"glab/models"
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

// Method implemenation complete_comment
func (pm *CashFlowOut_Controller_complete_comment) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	// return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowOut"], sock.GetPresetFilter("CashFlowOut"))
	scan_model := &models.CashFlowOutCommentList{}
	scan_model_md := app.GetMD().Models["CashFlowOutCommentList"]

	d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary(gobizap.GetModelLsnValue(scan_model))
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	args := rfltArgs.Interface().(*models.CashFlowOut_complete_comment)
	cond_vals := make([]interface{}, 3)
	cond_vals[0] = args.Comment_text.GetValue()
	cond_vals[1] = args.Fin_expense_type2_id.GetValue()

	if args.Count.GetIsSet() {
		cond_vals[2] = args.Count.GetValue()
	} else {
		cond_vals[2] = 500 //max value
	}

	query := `SELECT DISTINCT t.comment_text
		FROM cash_flow_out AS t
		WHERE (t.comment_text ILIKE '%'||$1||'%') AND t.fin_expense_type2_id = $2
		ORDER BY
	       t.comment_text
		LIMIT $3`
	fmt.Println("CompleteOnArgsWithConn query=", query, cond_vals[0])

	return gobizap.AddQueryResult(resp, scan_model_md, scan_model, query, "", cond_vals, conn, false)
}
