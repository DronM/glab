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

type ConstantList struct {
	Id fields.ValText `json:"id" primaryKey:"true"`
	Name fields.ValText `json:"name" defOrder:"ASC"`
	Descr fields.ValText `json:"descr"`
	Val fields.ValText `json:"val"`
	Val_type fields.ValText `json:"val_type"`
	Ctrl_class fields.ValText `json:"ctrl_class"`
	Ctrl_options fields.ValJSON `json:"ctrl_options"`
	View_class fields.ValText `json:"view_class"`
	View_options fields.ValJSON `json:"view_options"`
}

func (o *ConstantList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Descr.SetNull()
	o.Val.SetNull()
	o.Val_type.SetNull()
	o.Ctrl_class.SetNull()
	o.Ctrl_options.SetNull()
	o.View_class.SetNull()
	o.View_options.SetNull()
}

func NewModelMD_ConstantList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ConstantList{})),
		ID: "ConstantList_Model",
		Relation: "constants_list_view",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
		LimitConstant: "doc_per_page_count",
	}
}
