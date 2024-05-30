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

type ItemFeatureValueList struct {
	Code fields.ValInt `json:"code" primaryKey:"true"`
	Name fields.ValText `json:"name"`
	Descr fields.ValText `json:"descr"`
}

func (o *ItemFeatureValueList) SetNull() {
	o.Code.SetNull()
	o.Name.SetNull()
	o.Descr.SetNull()
}

func NewModelMD_ItemFeatureValueList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFeatureValueList{})),
		ID: "ItemFeatureValueList_Model",
		Relation: "",
	}
}
