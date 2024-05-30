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

type RGBankFlow struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" required:"true" alias:"Период" defOrder:"ASC"`
	Bank_account_id fields.ValInt `json:"bank_account_id"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

func (o *RGBankFlow) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Bank_account_id.SetNull()
	o.Total.SetNull()
}

func NewModelMD_RGBankFlow() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(RGBankFlow{})),
		ID: "RGBankFlow_Model",
		Relation: "rg_bank_flow",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type RGBankFlow_argv struct {
	Argv *RGBankFlow `json:"argv"`	
}

//Keys for delete/get object
type RGBankFlow_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type RGBankFlow_keys_argv struct {
	Argv *RGBankFlow_keys `json:"argv"`	
}

//old keys for update
type RGBankFlow_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"Код"`
	Id fields.ValInt `json:"id" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" alias:"Период"`
	Bank_account_id fields.ValInt `json:"bank_account_id"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

type RGBankFlow_old_keys_argv struct {
	Argv *RGBankFlow_old_keys `json:"argv"`	
}

