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

type FinExpenseTypeItemList struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Parent1_id fields.ValInt `json:"parent1_id" alias:"Родитель 1 ID"`
	Parent2_id fields.ValInt `json:"parent2_id" alias:"Родитель 2 ID"`
	Parents1_ref fields.ValJSON `json:"parents1_ref" alias:"Родитель 1"`
	Parents2_ref fields.ValJSON `json:"parents2_ref" alias:"Родитель 2"`
	Name fields.ValText `json:"name" alias:"Наименование" defOrder:"ASC"`
}

func (o *FinExpenseTypeItemList) SetNull() {
	o.Id.SetNull()
	o.Parent1_id.SetNull()
	o.Parent2_id.SetNull()
	o.Parents1_ref.SetNull()
	o.Parents2_ref.SetNull()
	o.Name.SetNull()
}

func NewModelMD_FinExpenseTypeItemList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(FinExpenseTypeItemList{})),
		ID: "FinExpenseTypeItemList_Model",
		Relation: "fin_expense_types_items_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
