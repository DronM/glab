package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 26/04/2024
 *
 * This is BankFlowIn controller implimentation file.
 *
 */

import (
	"context"
	"errors"
	"fmt"
	"io"
	"mime/multipart"
	"reflect"

	"github.com/dronm/clbnk"
	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/repo/userOperation"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/sql"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/srv/httpSrv"
	"github.com/jackc/pgx/v5"

	"glab/models"
)

const (
	IMPORT_BANK_OPERATION_ID  = "import_from_bank"
	ER_UNSUPPORTED_MIME_CODE  = 1000
	ER_UNSUPPORTED_MIME_DESCR = "Данное расширение файла не поддерживается"
)

// Method implemenation insert
func (pm *BankFlowIn_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankFlowIn"], &models.BankFlowIn_keys{}, sock.GetPresetFilter("BankFlowIn"))
}

// Method implemenation delete
func (pm *BankFlowIn_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankFlowIn"], sock.GetPresetFilter("BankFlowIn"))
}

// Method implemenation get_object
func (pm *BankFlowIn_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["BankFlowInList"], &models.BankFlowInList{}, sock.GetPresetFilter("BankFlowInList"))
}

// Method implemenation get_list
func (pm *BankFlowIn_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["BankFlowInList"], &models.BankFlowInList{}, sock.GetPresetFilter("BankFlowInList"))
}

// Method implemenation update
func (pm *BankFlowIn_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["BankFlowIn"], sock.GetPresetFilter("BankFlowIn"))
}

// Method implemenation import_from_bank
func (pm *BankFlowIn_Controller_import_from_bank) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	var file multipart.File
	var file_h *multipart.FileHeader

	http_sock, ok := sock.(*httpSrv.HTTPSocket)
	if !ok {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, "BankFlowIn_Controller_import_from_bank Not HTTPSocket type")
	}

	//check uploaded file mime: txt
	var err error
	file, file_h, err = http_sock.Request.FormFile("bank_file[]")
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_import_from_bank Request.FormFile(): %v", err))
	}

	mimes := []httpSrv.MIME_TYPE{httpSrv.MIME_TYPE_txt}
	if !FileHeaderContainsMimes(file_h, mimes) {
		return gobizap.NewPublicMethodError(ER_UNSUPPORTED_MIME_CODE, ER_UNSUPPORTED_MIME_DESCR)
	}

	sess := sock.GetSession()
	user_id := sess.GetInt(SESS_VAR_ID)
	args := rfltArgs.Interface().(*models.BankFlowIn_import_from_bank)

	//async bank load
	go importFromBank(app, file, user_id, args.Operation_id.GetValue())

	return nil
}

// importFromBank loads data from import file asynchronously
func importFromBank(app gobizap.Applicationer, file io.ReadCloser, userID int64, userOperationID string) {
	defer file.Close()

	d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err_с := d_store.GetPrimary()
	if err_с != nil {
		app.GetLogger().Errorf("importFromBank d_store.GetPrimary() failed: %v", err_с)
		//no way to end user operation with error
		return
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	userOperation.StartUserOperation(conn, IMPORT_BANK_OPERATION_ID, userID, userOperationID)

	b_imp := clbnk.NewBankImport()
	b_imp.EncodingType = clbnk.ENCODING_TYPE_WIN

	f_cont, err := io.ReadAll(file)
	if err != nil {
		userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, fmt.Errorf("importFromBank: io.ReadAll() failed: %v", err))
		return
	}

	if err := b_imp.Unmarshal(f_cont); err != nil {
		userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, fmt.Errorf("importFromBank: bncl.Umnarshal() failed: %v", err))
		return
	}
	if len(b_imp.AccSection) == 0 {
		userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, fmt.Errorf("importFromBank: AccSection has 0 values"))
		return
	}
	fmt.Printf("Document count=%d\n", len(b_imp.Documents))

	//find bank account
	var acc_id int
	if err := conn.QueryRow(context.Background(),
		"SELECT id FROM bank_accounts WHERE bank_acc = $1",
		b_imp.AccSection[0].Account,
	).Scan(&acc_id); err != nil {
		var e error
		if errors.Is(err, pgx.ErrNoRows) {
			e = fmt.Errorf("Банковский счет %s не найден", b_imp.AccSection[0].Account)
		} else {
			e = fmt.Errorf("importFromBank: Scan() for bank_accounts failed: %v", err)
		}
		userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, e)
		return
	}

	type expense_type struct {
		id        int
		rule      string
		parent_id *int
	}
	var expense_rules []expense_type

	//find expense types
	// var exp_types map[int]string
	// if err := conn.QueryRow(context.Background(),
	// 	"SELECT FROM bank_accounts WHERE bank_acc = $1",
	// 	b_imp.AccSection[0].Account,
	// ).Scan(&acc_id); err != nil {
	// 	var e error
	// 	if errors.Is(err, pgx.ErrNoRows) {
	// 		e = fmt.Errorf("Банковский счет %s не найден", b_imp.AccSection[0].Account)
	// 	} else {
	// 		e = fmt.Errorf("Scan() failed: %v", err)
	// 	}
	// 	userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, e)
	// 	return
	// }
	rows, err := conn.Query(context.Background(),
		`SELECT
		    id,
		    bank_match_rule,
	        parent_id,
	        count(*)
		FROM fin_expense_types
		WHERE coalesce(bank_match_rule,'') <> ''
		GROUP BY
		    id,
		    bank_match_rule,
	        parent_id
		`,
	)
	if err != nil {
		userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, fmt.Errorf("importFromBank: conn.Query() failed: %v", err))
		return
	}
	defer rows.Close()

	ind := 0
	for rows.Next() {
		var expense expense_type
		var cnt int
		if err := rows.Scan(&expense.id,
			&expense.rule,
			&expense.parent_id,
			&cnt,
		); err != nil {
			userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, fmt.Errorf("importFromBank: conn.Scan() for fin_expense_types failed: %v", err))
			return
		}
		if ind == 0 {
			expense_rules = make([]expense_type, cnt)
		}
		expense_rules[ind] = expense
	}
	// Check for errors after iterating
	if rows.Err() != nil {
		userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, fmt.Errorf("importFromBank: after conn.Next() failed: %v", err))
		return
	}
	//iterate documents
	for _, doc := range b_imp.Documents {
		doc_pp, ok := doc.(*clbnk.PPDocument)
		if !ok { // import pp only
			continue
		}
		var q string
		var params []interface{}
		if doc_pp.PayerAccount == b_imp.AccSection[0].Account {
			//out
			q = `WITH 
				sel AS (
				    SELECT
						id,
						parent_id
			        FROM bank_flow_out_find_expense_type($5)
				)
				INSERT INTO bank_flow_out
				(bank_account_id, pp_num, date_time, uploaded_date_time, client_descr, pay_comment, total,
				fin_expense_type1_id, fin_expense_type2_id, fin_expense_type3_id)
				SELECT 
					$1, $2, $3, now(), $4, $5, $6, 
					(SELECT parent_id FROM sel),
			        (SELECT id FROM sel),
			        NULL 
				ON CONFLICT (bank_account_id, date_time, pp_num, client_descr) DO UPDATE SET 
					uploaded_date_time = now(),
					pay_comment = excluded.pay_comment,
					total = excluded.total,
					fin_expense_type1_id = excluded.fin_expense_type1_id,
			        fin_expense_type2_id = excluded.fin_expense_type2_id,
			        fin_expense_type3_id = excluded.fin_expense_type3_id
			`
			params = []interface{}{acc_id, fmt.Sprintf("%d", doc_pp.Num), doc_pp.Date, doc_pp.PayerName, doc_pp.PayComment, doc_pp.Sum}
		} else {
			//in
			q = `INSERT INTO bank_flow_in
			(bank_account_id, pp_num, date_time, uploaded_date_time, client_descr, pay_comment, total)
			VALUES (
			             $1, $2, $3, now(), $4, $5, $6
			)
			ON CONFLICT (bank_account_id, date_time, pp_num, client_descr) DO UPDATE SET 
			    uploaded_date_time = now(),
			    pay_comment = excluded.pay_comment,
			    total = excluded.total
			`
			params = []interface{}{acc_id, fmt.Sprintf("%d", doc_pp.Num), doc_pp.Date, doc_pp.PayerName, doc_pp.PayComment, doc_pp.Sum}

		}
		if _, err := conn.Exec(context.Background(), q, params...); err != nil {
			userOperation.EndUserOperationWithError(app.GetLogger(), conn, userID, userOperationID, fmt.Errorf("Exec() failed: %v", err))
			return
		}
	}

	//end user (fl) operation
	userOperation.EndUserOperation(app.GetLogger(), conn, userID, userOperationID)
}

// Method implemenation get_report
func (pm *BankFlowIn_Controller_get_report) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	type rep_bal_row struct {
		Firm_id           int     `json:"firm_id"`
		Firm_name         string  `json:"firm_name"`
		Bank_account_id   int     `json:"bank_account_id"`
		Bank_account_num  string  `json:"bank_account_num"`
		Bank_account_name string  `json:"bank_account_name"`
		Bank_name         string  `json:"bank_name"`
		Balance_start     float64 `json:"balance_start"`
		Total_in          float64 `json:"total_in"`
		Total_out         float64 `json:"total_out"`
		Balance_end       float64 `json:"balance_end"`
	}
	type rep_out_row struct {
		Bank_account_id         int     `json:"bank_account_id"`
		Fin_expense_type1_id    int     `json:"fin_expense_type1_id"`
		Fin_expense_type1_descr string  `json:"fin_expense_type1_descr"`
		Total_out               float64 `json:"total_out"`
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

	arg_conds, err := gobizap.ParseSQLWhereFromArgs(rfltArgs, f_sep, app.GetMD().Models["BankFlowInList"].GetFields())
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report: %v", err))
	}

	// fmt.Printf("%+v\n", arg_conds)
	date_from, err := arg_conds.FieldValue("date_time", sql.SGN_SQL_GE)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report: %v", err))
	}
	date_to, err := arg_conds.FieldValue("date_time", sql.SGN_SQL_LE)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report: %v", err))
	}
	firm_id, err := arg_conds.FieldValue("firm_id", sql.SGN_SQL_E)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report: %v", err))
	}
	acc_id, err := arg_conds.FieldValue("bank_account_id", sql.SGN_SQL_E)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report: %v", err))
	}
	q_params := []interface{}{firm_id, acc_id, date_from, date_to}

	query := `SELECT format_period_rus($1::date, $2::date, NULL)`
	mh := &model.Model{ID: model.ModelID("RepHead"),
		Rows: make([]model.ModelRow, 0),
	}
	row := rep_head_row{}
	if err := conn.QueryRow(context.Background(), query, q_params[2], q_params[3]).Scan(&row.Period_descr); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report head conn.Query():  %v", err))
	}
	mh.Rows = append(mh.Rows, &row)
	resp.AddModel(mh)

	query = `SELECT 
			firm_id,
			firm_name,
			bank_account_id,
			bank_account_num,
			bank_account_name,
			bank_name,
			balance_start,
			total_in,
			total_out,
			balance_end
		FROM bank_flow_account_balance_list($1, $2, $3, $4)`

	m := &model.Model{ID: model.ModelID("RepBalanceList"),
		Rows: make([]model.ModelRow, 0),
	}
	rows, err := conn.Query(context.Background(), query, q_params...)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report bank_flow_account_balance_list conn.Query():  %v", err))
	}
	for rows.Next() {
		row := rep_bal_row{}
		if err := rows.Scan(&row.Firm_id,
			&row.Firm_name,
			&row.Bank_account_id,
			&row.Bank_account_num,
			&row.Bank_account_name,
			&row.Bank_name,
			&row.Balance_start,
			&row.Total_in,
			&row.Total_out,
			&row.Balance_end,
		); err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report bank_flow_account_balance_list trows.Scan(): %v", err))
		}
		m.Rows = append(m.Rows, &row)
	}
	if err := rows.Err(); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report bank_flow_account_balance_list rows.Err(): %v", err))
	}
	rows.Close()

	resp.AddModel(m)

	//out with expense types
	query = `SELECT 
		bank_account_id,
		fin_expense_type1_id,
		fin_expense_type1_descr,
		total_out
		FROM bank_flow_account_out_list($1, $2, $3, $4)`

	m2 := &model.Model{ID: model.ModelID("RepOutList"),
		Rows: make([]model.ModelRow, 0),
	}
	rows, err = conn.Query(context.Background(), query, q_params...)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report bank_flow_account_out_list conn.Query(): %v", err))
	}
	for rows.Next() {
		row := rep_out_row{}
		if err := rows.Scan(&row.Bank_account_id,
			&row.Fin_expense_type1_id,
			&row.Fin_expense_type1_descr,
			&row.Total_out,
		); err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report bank_flow_account_out_list rows.Scan(): %v", err))
		}
		m2.Rows = append(m2.Rows, &row)
	}
	if err := rows.Err(); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_get_report bank_flow_account_out_list rows.Err(): %v", err))
	}
	rows.Close()

	resp.AddModel(m2)

	return nil
}
