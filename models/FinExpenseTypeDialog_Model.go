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

type FinExpenseTypeDialog struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Parents_ref fields.ValJSON `json:"parents_ref" alias:"Родитель"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Lev fields.ValInt `json:"lev" alias:"Уровень"`
	For_cash fields.ValBool `json:"for_cash" alias:"Для кассы"`
	For_bank fields.ValBool `json:"for_bank" alias:"Для банка"`
	Bank_match_rule fields.ValText `json:"bank_match_rule" alias:"Правило поиска соответствия для банка"`
	Deleted fields.ValBool `json:"deleted" alias:"Удален, отображать не всем"`
}

func (o *FinExpenseTypeDialog) SetNull() {
	o.Id.SetNull()
	o.Parents_ref.SetNull()
	o.Name.SetNull()
	o.Lev.SetNull()
	o.For_cash.SetNull()
	o.For_bank.SetNull()
	o.Bank_match_rule.SetNull()
	o.Deleted.SetNull()
}

func NewModelMD_FinExpenseTypeDialog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(FinExpenseTypeDialog{})),
		ID: "FinExpenseTypeDialog_Model",
		Relation: "fin_expense_types_dialog",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
