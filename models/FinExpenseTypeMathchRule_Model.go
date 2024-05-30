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

type FinExpenseTypeMathchRule struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Fin_expense_type_id fields.ValInt `json:"fin_expense_type_id" required:"true"`
	Rule fields.ValText `json:"rule" alias:"Условие"`
}

func (o *FinExpenseTypeMathchRule) SetNull() {
	o.Id.SetNull()
	o.Fin_expense_type_id.SetNull()
	o.Rule.SetNull()
}

func NewModelMD_FinExpenseTypeMathchRule() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(FinExpenseTypeMathchRule{})),
		ID: "FinExpenseTypeMathchRule_Model",
		Relation: "fin_expense_type_match_rules",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type FinExpenseTypeMathchRule_argv struct {
	Argv *FinExpenseTypeMathchRule `json:"argv"`	
}

//Keys for delete/get object
type FinExpenseTypeMathchRule_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type FinExpenseTypeMathchRule_keys_argv struct {
	Argv *FinExpenseTypeMathchRule_keys `json:"argv"`	
}

//old keys for update
type FinExpenseTypeMathchRule_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Fin_expense_type_id fields.ValInt `json:"fin_expense_type_id"`
	Rule fields.ValText `json:"rule" alias:"Условие"`
}

type FinExpenseTypeMathchRule_old_keys_argv struct {
	Argv *FinExpenseTypeMathchRule_old_keys `json:"argv"`	
}

