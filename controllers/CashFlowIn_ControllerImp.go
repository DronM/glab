package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 19/04/2024
 *
 * This is CashFlowIn controller implimentation file.
 *
 */

import (
	"context"
	"fmt"
	"reflect"

	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/sql"
	"github.com/dronm/gobizap/srv"

	"glab/models"
)

// Method implemenation insert
func (pm *CashFlowIn_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	sess := sock.GetSession()
	user_id := sess.GetInt(SESS_VAR_ID)
	args := rfltArgs.Interface().(*models.CashFlowIn)
	args.User_id.SetValue(user_id)
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowIn"], &models.CashFlowIn_keys{}, sock.GetPresetFilter("CashFlowIn"))
}

// Method implemenation delete
func (pm *CashFlowIn_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowIn"], sock.GetPresetFilter("CashFlowIn"))
}

// Method implemenation get_object
func (pm *CashFlowIn_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashFlowInList"], &models.CashFlowInList{}, sock.GetPresetFilter("CashFlowInList"))
}

// Method implemenation get_list
func (pm *CashFlowIn_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["CashFlowInList"], &models.CashFlowInList{}, sock.GetPresetFilter("CashFlowInList"))
}

// Method implemenation update
func (pm *CashFlowIn_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["CashFlowIn"], sock.GetPresetFilter("CashFlowIn"))
}

// Method implemenation get_report
func (pm *CashFlowIn_Controller_get_report) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	type rep_bal_row struct {
		Cash_location_id   int     `json:"cash_location_id"`
		Cash_location_name string  `json:"cash_location_name"`
		Balance_start      float64 `json:"balance_start"`
		Total_in           float64 `json:"total_in"`
		Total_transfer_in  float64 `json:"Total_transfer_in"`
		Total_out          float64 `json:"total_out"`
		Total_transfer_out float64 `json:"total_transfer_out"`
		Balance_end        float64 `json:"balance_end"`
	}

	type rep_head_row struct {
		Period_descr string `json:"period_descr"`
	}

	d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary("")
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	//firm_id, bank_account_id, date_time, date_time
	f_sep := gobizap.ArgsFieldSep(rfltArgs)

	arg_conds, err := gobizap.ParseSQLWhereFromArgs(rfltArgs, f_sep, app.GetMD().Models["CashFlowInList"].GetFields())
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report: %v", err))
	}

	// fmt.Printf("%+v\n", arg_conds)
	date_from, err := arg_conds.FieldValue("date_time", sql.SGN_SQL_GE)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report: %v", err))
	}
	date_to, err := arg_conds.FieldValue("date_time", sql.SGN_SQL_LE)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report: %v", err))
	}
	cash_location_id, err := arg_conds.FieldValue("cash_location_id", sql.SGN_SQL_E)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report: %v", err))
	}
	q_params := []interface{}{cash_location_id, date_from, date_to}

	query := `SELECT format_period_rus($1::date, $2::date, NULL)`
	mh := &model.Model{ID: model.ModelID("RepHead"),
		Rows: make([]model.ModelRow, 0),
	}
	row := rep_head_row{}
	if err := conn.QueryRow(context.Background(), query, q_params[1], q_params[2]).Scan(&row.Period_descr); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report head conn.Query():  %v", err))
	}
	mh.Rows = append(mh.Rows, &row)
	resp.AddModel(mh)

	query = `SELECT 
			cash_location_id,
			cash_location_name,
			balance_start,
			total_in,
			total_transfer_in,
			total_out,
			total_transfer_out,
			balance_end
		FROM cash_flow_location_balance_list($1, $2, $3)`

	m := &model.Model{ID: model.ModelID("RepBalanceList"),
		Rows: make([]model.ModelRow, 0),
	}
	rows, err := conn.Query(context.Background(), query, q_params...)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report cash_flow_account_balance_list conn.Query():  %v", err))
	}
	for rows.Next() {
		row := rep_bal_row{}
		if err := rows.Scan(&row.Cash_location_id,
			&row.Cash_location_name,
			&row.Balance_start,
			&row.Total_in,
			&row.Total_transfer_in,
			&row.Total_out,
			&row.Total_transfer_out,
			&row.Balance_end,
		); err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report cash_flow_account_balance_list trows.Scan(): %v", err))
		}
		m.Rows = append(m.Rows, &row)
	}
	if err := rows.Err(); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("CashFlowIn_Controller_get_report cash_flow_account_balance_list rows.Err(): %v", err))
	}
	rows.Close()

	resp.AddModel(m)

	return nil
}
