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
	"glab/enums"	
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type CashFlowIn struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Cash_flow_income_type enums.ValEnum_cash_flow_income_types `json:"cash_flow_income_type" required:"true" alias:"Тип родителя"`
	Cash_income_source_id fields.ValInt `json:"cash_income_source_id" alias:"Источник прихода"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	User_id fields.ValInt `json:"user_id"`
	Total fields.ValFloat `json:"total"`
}

func (o *CashFlowIn) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Cash_location_id.SetNull()
	o.Cash_flow_income_type.SetNull()
	o.Cash_income_source_id.SetNull()
	o.Comment_text.SetNull()
	o.User_id.SetNull()
	o.Total.SetNull()
}

func NewModelMD_CashFlowIn() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowIn{})),
		ID: "CashFlowIn_Model",
		Relation: "cash_flow_in",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type CashFlowIn_argv struct {
	Argv *CashFlowIn `json:"argv"`	
}

//Keys for delete/get object
type CashFlowIn_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type CashFlowIn_keys_argv struct {
	Argv *CashFlowIn_keys `json:"argv"`	
}

//old keys for update
type CashFlowIn_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Date_time fields.ValDateTimeTZ `json:"date_time"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Cash_flow_income_type enums.ValEnum_cash_flow_income_types `json:"cash_flow_income_type" alias:"Тип родителя"`
	Cash_income_source_id fields.ValInt `json:"cash_income_source_id" alias:"Источник прихода"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	User_id fields.ValInt `json:"user_id"`
	Total fields.ValFloat `json:"total"`
}

type CashFlowIn_old_keys_argv struct {
	Argv *CashFlowIn_old_keys `json:"argv"`	
}

