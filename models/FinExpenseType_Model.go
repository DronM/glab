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

type FinExpenseType struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Parent_id fields.ValInt `json:"parent_id" alias:"Родитель"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	For_cash fields.ValBool `json:"for_cash" alias:"Для кассы"`
	For_bank fields.ValBool `json:"for_bank" alias:"Для банка"`
	Deleted fields.ValBool `json:"deleted" alias:"Удален, отображать не всем"`
	Bank_match_rule fields.ValText `json:"bank_match_rule" alias:"Правило поиска соответствия для банка"`
	Bank_match_rule_cond fields.ValText `json:"bank_match_rule_cond"`
}

func (o *FinExpenseType) SetNull() {
	o.Id.SetNull()
	o.Parent_id.SetNull()
	o.Name.SetNull()
	o.For_cash.SetNull()
	o.For_bank.SetNull()
	o.Deleted.SetNull()
	o.Bank_match_rule.SetNull()
	o.Bank_match_rule_cond.SetNull()
}

func NewModelMD_FinExpenseType() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(FinExpenseType{})),
		ID: "FinExpenseType_Model",
		Relation: "fin_expense_types",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type FinExpenseType_argv struct {
	Argv *FinExpenseType `json:"argv"`	
}

//Keys for delete/get object
type FinExpenseType_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type FinExpenseType_keys_argv struct {
	Argv *FinExpenseType_keys `json:"argv"`	
}

//old keys for update
type FinExpenseType_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Parent_id fields.ValInt `json:"parent_id" alias:"Родитель"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	For_cash fields.ValBool `json:"for_cash" alias:"Для кассы"`
	For_bank fields.ValBool `json:"for_bank" alias:"Для банка"`
	Deleted fields.ValBool `json:"deleted" alias:"Удален, отображать не всем"`
	Bank_match_rule fields.ValText `json:"bank_match_rule" alias:"Правило поиска соответствия для банка"`
	Bank_match_rule_cond fields.ValText `json:"bank_match_rule_cond"`
}

type FinExpenseType_old_keys_argv struct {
	Argv *FinExpenseType_old_keys `json:"argv"`	
}

