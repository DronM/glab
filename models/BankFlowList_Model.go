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

type BankFlowList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Bank_account_id fields.ValInt `json:"bank_account_id"`
	Bank_accounts_ref fields.ValJSON `json:"bank_accounts_ref"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Период" defOrder:"DESC"`
	Uploaded_date_time fields.ValDateTimeTZ `json:"uploaded_date_time" alias:"Дата загрузки"`
	Client_descr fields.ValText `json:"client_descr" alias:"Корреспондент"`
	Pay_comment fields.ValText `json:"pay_comment" alias:"Назначение платежа"`
	Total_in fields.ValFloat `json:"total_in"`
	Total_out fields.ValFloat `json:"total_out"`
}

func (o *BankFlowList) SetNull() {
	o.Id.SetNull()
	o.Bank_account_id.SetNull()
	o.Bank_accounts_ref.SetNull()
	o.Date_time.SetNull()
	o.Uploaded_date_time.SetNull()
	o.Client_descr.SetNull()
	o.Pay_comment.SetNull()
	o.Total_in.SetNull()
	o.Total_out.SetNull()
}

func NewModelMD_BankFlowList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(BankFlowList{})),
		ID: "BankFlowList_Model",
		Relation: "bank_flow_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "total_total_in", Expr: "sum(total_in)"},
&model.AggFunction{Alias: "total_total_out", Expr: "sum(total_out)"},
&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
