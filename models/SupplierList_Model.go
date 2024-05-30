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

type SupplierList struct {
	Id fields.ValInt `json:"id" autoInc:"true" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование" defOrder:"ASC"`
}

func (o *SupplierList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_SupplierList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierList{})),
		ID: "SupplierList_Model",
		Relation: "suppliers_list",
	}
}
