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

type BankAccount struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Parent_data_type enums.ValEnum_data_types `json:"parent_data_type" required:"true" alias:"Тип родителя"`
	Parent_id fields.ValInt `json:"parent_id" alias:"ИД родителя"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Bank_acc fields.ValText `json:"bank_acc" alias:"Расчетный счет"`
	Bank_bik fields.ValText `json:"bank_bik" alias:"БИК банка"`
}

func (o *BankAccount) SetNull() {
	o.Id.SetNull()
	o.Parent_data_type.SetNull()
	o.Parent_id.SetNull()
	o.Name.SetNull()
	o.Bank_acc.SetNull()
	o.Bank_bik.SetNull()
}

func NewModelMD_BankAccount() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(BankAccount{})),
		ID: "BankAccount_Model",
		Relation: "bank_accounts",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type BankAccount_argv struct {
	Argv *BankAccount `json:"argv"`	
}

//Keys for delete/get object
type BankAccount_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type BankAccount_keys_argv struct {
	Argv *BankAccount_keys `json:"argv"`	
}

//old keys for update
type BankAccount_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Parent_data_type enums.ValEnum_data_types `json:"parent_data_type" alias:"Тип родителя"`
	Parent_id fields.ValInt `json:"parent_id" alias:"ИД родителя"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Bank_acc fields.ValText `json:"bank_acc" alias:"Расчетный счет"`
	Bank_bik fields.ValText `json:"bank_bik" alias:"БИК банка"`
}

type BankAccount_old_keys_argv struct {
	Argv *BankAccount_old_keys `json:"argv"`	
}

