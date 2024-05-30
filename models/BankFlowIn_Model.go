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

type BankFlowIn struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Bank_account_id fields.ValInt `json:"bank_account_id" required:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" required:"true" alias:"Период"`
	Uploaded_date_time fields.ValDateTimeTZ `json:"uploaded_date_time" alias:"Дата загрузки"`
	Client_descr fields.ValText `json:"client_descr" alias:"Корреспондент"`
	Pay_comment fields.ValText `json:"pay_comment" alias:"Назначение платежа"`
	Pp_num fields.ValText `json:"pp_num" alias:"Номер платежносго поручения"`
	Total fields.ValFloat `json:"total"`
}

func (o *BankFlowIn) SetNull() {
	o.Id.SetNull()
	o.Bank_account_id.SetNull()
	o.Date_time.SetNull()
	o.Uploaded_date_time.SetNull()
	o.Client_descr.SetNull()
	o.Pay_comment.SetNull()
	o.Pp_num.SetNull()
	o.Total.SetNull()
}

func NewModelMD_BankFlowIn() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(BankFlowIn{})),
		ID: "BankFlowIn_Model",
		Relation: "bank_flow_in",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type BankFlowIn_argv struct {
	Argv *BankFlowIn `json:"argv"`	
}

//Keys for delete/get object
type BankFlowIn_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type BankFlowIn_keys_argv struct {
	Argv *BankFlowIn_keys `json:"argv"`	
}

//old keys for update
type BankFlowIn_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Bank_account_id fields.ValInt `json:"bank_account_id"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Период"`
	Uploaded_date_time fields.ValDateTimeTZ `json:"uploaded_date_time" alias:"Дата загрузки"`
	Client_descr fields.ValText `json:"client_descr" alias:"Корреспондент"`
	Pay_comment fields.ValText `json:"pay_comment" alias:"Назначение платежа"`
	Pp_num fields.ValText `json:"pp_num" alias:"Номер платежносго поручения"`
	Total fields.ValFloat `json:"total"`
}

type BankFlowIn_old_keys_argv struct {
	Argv *BankFlowIn_old_keys `json:"argv"`	
}

