package models

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/models/Model.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

import (
	"reflect"	
		
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type BankFlowOutDialog struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Bank_accounts_ref fields.ValJSON `json:"bank_accounts_ref"`
	Fin_expense_types1_ref fields.ValJSON `json:"fin_expense_types1_ref"`
	Fin_expense_types2_ref fields.ValJSON `json:"fin_expense_types2_ref"`
	Fin_expense_types3_ref fields.ValJSON `json:"fin_expense_types3_ref"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Период"`
	Uploaded_date_time fields.ValDateTimeTZ `json:"uploaded_date_time" alias:"Дата загрузки"`
	Client_descr fields.ValText `json:"client_descr" alias:"Корреспондент"`
	Pay_comment fields.ValText `json:"pay_comment" alias:"Назначение платежа"`
	Total fields.ValFloat `json:"total"`
	Pp_num fields.ValText `json:"pp_num" alias:"Номер платежного поручения"`
}

func (o *BankFlowOutDialog) SetNull() {
	o.Id.SetNull()
	o.Bank_accounts_ref.SetNull()
	o.Fin_expense_types1_ref.SetNull()
	o.Fin_expense_types2_ref.SetNull()
	o.Fin_expense_types3_ref.SetNull()
	o.Date_time.SetNull()
	o.Uploaded_date_time.SetNull()
	o.Client_descr.SetNull()
	o.Pay_comment.SetNull()
	o.Total.SetNull()
	o.Pp_num.SetNull()
}

func NewModelMD_BankFlowOutDialog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(BankFlowOutDialog{})),
		ID: "BankFlowOutDialog_Model",
		Relation: "bank_flow_out_dialog",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
