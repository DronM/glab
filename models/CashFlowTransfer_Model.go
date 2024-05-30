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

type CashFlowTransfer struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time"`
	From_cash_location_id fields.ValInt `json:"from_cash_location_id"`
	To_cash_location_id fields.ValInt `json:"to_cash_location_id"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	User_id fields.ValInt `json:"user_id"`
	Total fields.ValFloat `json:"total"`
}

func (o *CashFlowTransfer) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.From_cash_location_id.SetNull()
	o.To_cash_location_id.SetNull()
	o.Comment_text.SetNull()
	o.User_id.SetNull()
	o.Total.SetNull()
}

func NewModelMD_CashFlowTransfer() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowTransfer{})),
		ID: "CashFlowTransfer_Model",
		Relation: "cash_flow_transfers",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type CashFlowTransfer_argv struct {
	Argv *CashFlowTransfer `json:"argv"`	
}

//Keys for delete/get object
type CashFlowTransfer_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type CashFlowTransfer_keys_argv struct {
	Argv *CashFlowTransfer_keys `json:"argv"`	
}

//old keys for update
type CashFlowTransfer_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Date_time fields.ValDateTimeTZ `json:"date_time"`
	From_cash_location_id fields.ValInt `json:"from_cash_location_id"`
	To_cash_location_id fields.ValInt `json:"to_cash_location_id"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	User_id fields.ValInt `json:"user_id"`
	Total fields.ValFloat `json:"total"`
}

type CashFlowTransfer_old_keys_argv struct {
	Argv *CashFlowTransfer_old_keys `json:"argv"`	
}

