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

type CashFlowOut struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Fin_expense_type1_id fields.ValInt `json:"fin_expense_type1_id" required:"true"`
	Fin_expense_type2_id fields.ValInt `json:"fin_expense_type2_id" required:"true"`
	Fin_expense_type3_id fields.ValInt `json:"fin_expense_type3_id"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	User_id fields.ValInt `json:"user_id"`
	Total fields.ValFloat `json:"total"`
}

func (o *CashFlowOut) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Cash_location_id.SetNull()
	o.Fin_expense_type1_id.SetNull()
	o.Fin_expense_type2_id.SetNull()
	o.Fin_expense_type3_id.SetNull()
	o.Comment_text.SetNull()
	o.User_id.SetNull()
	o.Total.SetNull()
}

func NewModelMD_CashFlowOut() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowOut{})),
		ID: "CashFlowOut_Model",
		Relation: "cash_flow_out",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type CashFlowOut_argv struct {
	Argv *CashFlowOut `json:"argv"`	
}

//Keys for delete/get object
type CashFlowOut_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type CashFlowOut_keys_argv struct {
	Argv *CashFlowOut_keys `json:"argv"`	
}

//old keys for update
type CashFlowOut_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Date_time fields.ValDateTimeTZ `json:"date_time"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Fin_expense_type1_id fields.ValInt `json:"fin_expense_type1_id"`
	Fin_expense_type2_id fields.ValInt `json:"fin_expense_type2_id"`
	Fin_expense_type3_id fields.ValInt `json:"fin_expense_type3_id"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	User_id fields.ValInt `json:"user_id"`
	Total fields.ValFloat `json:"total"`
}

type CashFlowOut_old_keys_argv struct {
	Argv *CashFlowOut_old_keys `json:"argv"`	
}

