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

type CashLocation struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

func (o *CashLocation) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_CashLocation() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashLocation{})),
		ID: "CashLocation_Model",
		Relation: "cash_locations",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type CashLocation_argv struct {
	Argv *CashLocation `json:"argv"`	
}

//Keys for delete/get object
type CashLocation_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type CashLocation_keys_argv struct {
	Argv *CashLocation_keys `json:"argv"`	
}

//old keys for update
type CashLocation_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

type CashLocation_old_keys_argv struct {
	Argv *CashLocation_old_keys `json:"argv"`	
}

