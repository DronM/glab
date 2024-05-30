package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 19/04/2024
 *
 * This is FinExpenseType controller implimentation file.
 *
 */

import (
	"context"
	"fmt"
	"reflect"
	"strings"

	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv"
	"github.com/jackc/pgx/v5"

	"glab/bnkImpParser"
	"glab/models"
)

const (
	ER_RULE_VERIF_CODE  = 1000
	ER_RULE_VERIF_DESCR = "Неизвестный литерал: %s"
)

// Method implemenation insert
func (pm *FinExpenseType_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary("")
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_verify_rule d_store.GetPrimary() failed: %v", err))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	args := rfltArgs.Interface().(*models.FinExpenseType)
	rule, err := MakeRuleCondition(args.Bank_match_rule.GetValue())
	if err != nil {
		return gobizap.NewPublicMethodError(ER_RULE_VERIF_CODE, err.Error())
	}
	if err := VerifyExpenseRule(rule, conn); err != nil {
		return gobizap.NewPublicMethodError(ER_RULE_VERIF_CODE, err.Error())
	}
	args.Bank_match_rule_cond.SetValue(rule)
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["FinExpenseType"], &models.FinExpenseType_keys{}, sock.GetPresetFilter("FinExpenseType"))
}

// Method implemenation delete
func (pm *FinExpenseType_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["FinExpenseType"], sock.GetPresetFilter("FinExpenseType"))
}

// Method implemenation get_object
func (pm *FinExpenseType_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["FinExpenseTypeDialog"], &models.FinExpenseTypeDialog{}, sock.GetPresetFilter("FinExpenseTypeDialog"))
}

// Method implemenation get_list
func (pm *FinExpenseType_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	// args := rfltArgs.Interface().(*model.Cond_Model)
	// cond := args.Cond_fields.GetValue()
	// if cond == "" {
	// 	//add parent_id is null
	// 	args.Cond_fields.SetValue("parent_id")
	// 	args.Cond_vals.SetValue("null")
	// 	args.Cond_sgns.SetValue("i")
	// }
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["FinExpenseTypeList"], &models.FinExpenseTypeList{}, sock.GetPresetFilter("FinExpenseTypeList"))
}

// Method implemenation update
func (pm *FinExpenseType_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.FinExpenseType_old_keys)
	if args.Bank_match_rule.GetIsSet() {
		d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
		pool_conn, conn_id, err := d_store.GetSecondary("")
		if err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_verify_rule d_store.GetPrimary() failed: %v", err))
		}
		defer d_store.Release(pool_conn, conn_id)
		conn := pool_conn.Conn()

		rule, err := MakeRuleCondition(args.Bank_match_rule.GetValue())
		if err != nil {
			return gobizap.NewPublicMethodError(ER_RULE_VERIF_CODE, err.Error())
		}
		if err := VerifyExpenseRule(rule, conn); err != nil {
			return gobizap.NewPublicMethodError(ER_RULE_VERIF_CODE, err.Error())
		}
		args.Bank_match_rule_cond.SetValue(rule)
	}
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["FinExpenseType"], sock.GetPresetFilter("FinExpenseType"))
}

// Method implemenation complete
func (pm *FinExpenseType_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["FinExpenseTypeList"], &models.FinExpenseTypeList{}, sock.GetPresetFilter("FinExpenseTypeList"))
}

func (pm *FinExpenseType_Controller_verify_rule) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.FinExpenseType_verify_rule)

	d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary("")
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("BankFlowIn_Controller_verify_rule d_store.GetPrimary() failed: %v", err))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	input := args.Rule.GetValue()
	rule, err := MakeRuleCondition(input)
	if err != nil {
		return gobizap.NewPublicMethodError(ER_RULE_VERIF_CODE, err.Error())
	}
	return VerifyExpenseRule(rule, conn)
}

func VerifyExpenseRule(rule string, conn *pgx.Conn) error {
	var res bool
	if err := conn.QueryRow(context.Background(),
		fmt.Sprintf("SELECT %s", rule),
	).Scan(&res); err != nil {
		return gobizap.NewPublicMethodError(ER_RULE_VERIF_CODE, fmt.Sprintf("Ошибка разбора выражения: %v", err))
	}

	return nil
}

func MakeRuleCondition(input string) (string, error) {
	var rule strings.Builder
	var err_t strings.Builder
	l := bnkImpParser.NewLexer(input)
	for {
		tok := l.NextToken()
		if tok.Type == bnkImpParser.TK_EOF {
			break
		}

		if tok.Type == bnkImpParser.TK_ILLEGAL {
			if err_t.Len() > 0 {
				err_t.WriteString(", ")
			}
			err_t.WriteString(fmt.Sprintf(ER_RULE_VERIF_DESCR, tok.Literal))
			continue
		}

		if rule.Len() > 0 {
			rule.WriteString(" ")
		}

		switch tok.Type {
		case bnkImpParser.TK_STRING:
			rule.WriteString(fmt.Sprintf(`'%s'`, tok.Literal))

		case bnkImpParser.TK_LPAREN:
			rule.WriteString("(")

		case bnkImpParser.TK_RPAREN:
			rule.WriteString(")")

		case bnkImpParser.TK_NOT:
			rule.WriteString("NOT")

		case bnkImpParser.TK_LIKE:
			rule.WriteString("LIKE")

		case bnkImpParser.TK_LOWER_CASE:
			rule.WriteString("LOWER")

		case bnkImpParser.TK_UPPER_CASE:
			rule.WriteString("UPPER")

		case bnkImpParser.TK_AND:
			rule.WriteString("AND")

		case bnkImpParser.TK_OR:
			rule.WriteString("OR")
		}
	}
	if err_t.Len() > 0 {
		return "", gobizap.NewPublicMethodError(ER_RULE_VERIF_CODE, err_t.String())
	}

	return rule.String(), nil
}
