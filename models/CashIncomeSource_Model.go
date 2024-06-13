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

type CashIncomeSource struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
}

func (o *CashIncomeSource) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Cash_location_id.SetNull()
}

func NewModelMD_CashIncomeSource() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashIncomeSource{})),
		ID: "CashIncomeSource_Model",
		Relation: "cash_income_sources",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type CashIncomeSource_argv struct {
	Argv *CashIncomeSource `json:"argv"`	
}

//Keys for delete/get object
type CashIncomeSource_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type CashIncomeSource_keys_argv struct {
	Argv *CashIncomeSource_keys `json:"argv"`	
}

//old keys for update
type CashIncomeSource_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
}

type CashIncomeSource_old_keys_argv struct {
	Argv *CashIncomeSource_old_keys `json:"argv"`	
}

