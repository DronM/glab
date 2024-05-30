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

type FinExpenseTypeList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Parent_id fields.ValInt `json:"parent_id" alias:"Родитель"`
	Name fields.ValText `json:"name" alias:"Наименование" defOrder:"ASC"`
	For_cash fields.ValBool `json:"for_cash" alias:"Для кассы"`
	For_bank fields.ValBool `json:"for_bank" alias:"Для банка"`
	Deleted fields.ValBool `json:"deleted" alias:"Удален, отображать не всем"`
}

func (o *FinExpenseTypeList) SetNull() {
	o.Id.SetNull()
	o.Parent_id.SetNull()
	o.Name.SetNull()
	o.For_cash.SetNull()
	o.For_bank.SetNull()
	o.Deleted.SetNull()
}

func NewModelMD_FinExpenseTypeList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(FinExpenseTypeList{})),
		ID: "FinExpenseTypeList_Model",
		Relation: "fin_expense_types_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
