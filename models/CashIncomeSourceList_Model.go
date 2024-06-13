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

type CashIncomeSourceList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Cash_locations_ref fields.ValJSON `json:"cash_locations_ref"`
}

func (o *CashIncomeSourceList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Cash_locations_ref.SetNull()
}

func NewModelMD_CashIncomeSourceList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashIncomeSourceList{})),
		ID: "CashIncomeSourceList_Model",
		Relation: "cash_income_sources_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type CashIncomeSourceList_argv struct {
	Argv *CashIncomeSourceList `json:"argv"`	
}

//Keys for delete/get object
type CashIncomeSourceList_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type CashIncomeSourceList_keys_argv struct {
	Argv *CashIncomeSourceList_keys `json:"argv"`	
}

//old keys for update
type CashIncomeSourceList_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Cash_locations_ref fields.ValJSON `json:"cash_locations_ref"`
}

type CashIncomeSourceList_old_keys_argv struct {
	Argv *CashIncomeSourceList_old_keys `json:"argv"`	
}

