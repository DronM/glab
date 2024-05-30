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

type BankCard struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true"`
}

func (o *BankCard) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_BankCard() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(BankCard{})),
		ID: "BankCard_Model",
		Relation: "card_banks",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type BankCard_argv struct {
	Argv *BankCard `json:"argv"`	
}

//Keys for delete/get object
type BankCard_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type BankCard_keys_argv struct {
	Argv *BankCard_keys `json:"argv"`	
}

//old keys for update
type BankCard_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
}

type BankCard_old_keys_argv struct {
	Argv *BankCard_old_keys `json:"argv"`	
}

