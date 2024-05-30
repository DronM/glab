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

type BankFlowOut struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Bank_account_id fields.ValInt `json:"bank_account_id" required:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" required:"true" alias:"Период"`
	Uploaded_date_time fields.ValDateTimeTZ `json:"uploaded_date_time" alias:"Дата загрузки"`
	Client_descr fields.ValText `json:"client_descr" alias:"Корреспондент"`
	Pay_comment fields.ValText `json:"pay_comment" alias:"Назначение платежа"`
	Pp_num fields.ValText `json:"pp_num" alias:"Номер платежного поручения"`
	Total fields.ValFloat `json:"total"`
	Fin_expense_type1_id fields.ValInt `json:"fin_expense_type1_id" required:"true"`
	Fin_expense_type2_id fields.ValInt `json:"fin_expense_type2_id" required:"true"`
	Fin_expense_type3_id fields.ValInt `json:"fin_expense_type3_id"`
}

func (o *BankFlowOut) SetNull() {
	o.Id.SetNull()
	o.Bank_account_id.SetNull()
	o.Date_time.SetNull()
	o.Uploaded_date_time.SetNull()
	o.Client_descr.SetNull()
	o.Pay_comment.SetNull()
	o.Pp_num.SetNull()
	o.Total.SetNull()
	o.Fin_expense_type1_id.SetNull()
	o.Fin_expense_type2_id.SetNull()
	o.Fin_expense_type3_id.SetNull()
}

func NewModelMD_BankFlowOut() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(BankFlowOut{})),
		ID: "BankFlowOut_Model",
		Relation: "bank_flow_out",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type BankFlowOut_argv struct {
	Argv *BankFlowOut `json:"argv"`	
}

//Keys for delete/get object
type BankFlowOut_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type BankFlowOut_keys_argv struct {
	Argv *BankFlowOut_keys `json:"argv"`	
}

//old keys for update
type BankFlowOut_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Bank_account_id fields.ValInt `json:"bank_account_id"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Период"`
	Uploaded_date_time fields.ValDateTimeTZ `json:"uploaded_date_time" alias:"Дата загрузки"`
	Client_descr fields.ValText `json:"client_descr" alias:"Корреспондент"`
	Pay_comment fields.ValText `json:"pay_comment" alias:"Назначение платежа"`
	Pp_num fields.ValText `json:"pp_num" alias:"Номер платежного поручения"`
	Total fields.ValFloat `json:"total"`
	Fin_expense_type1_id fields.ValInt `json:"fin_expense_type1_id"`
	Fin_expense_type2_id fields.ValInt `json:"fin_expense_type2_id"`
	Fin_expense_type3_id fields.ValInt `json:"fin_expense_type3_id"`
}

type BankFlowOut_old_keys_argv struct {
	Argv *BankFlowOut_old_keys `json:"argv"`	
}

