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

type RGCashFlow struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" required:"true" alias:"Период" defOrder:"ASC"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

func (o *RGCashFlow) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Cash_location_id.SetNull()
	o.Total.SetNull()
}

func NewModelMD_RGCashFlow() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(RGCashFlow{})),
		ID: "RGCashFlow_Model",
		Relation: "rg_cash_flow",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type RGCashFlow_argv struct {
	Argv *RGCashFlow `json:"argv"`	
}

//Keys for delete/get object
type RGCashFlow_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type RGCashFlow_keys_argv struct {
	Argv *RGCashFlow_keys `json:"argv"`	
}

//old keys for update
type RGCashFlow_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"Код"`
	Id fields.ValInt `json:"id" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" alias:"Период"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

type RGCashFlow_old_keys_argv struct {
	Argv *RGCashFlow_old_keys `json:"argv"`	
}

