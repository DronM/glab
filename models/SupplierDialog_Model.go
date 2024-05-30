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

type SupplierDialog struct {
	Id fields.ValInt `json:"id" primaryKey:"true" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

func (o *SupplierDialog) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_SupplierDialog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierDialog{})),
		ID: "SupplierDialog_Model",
		Relation: "suppliers_dialog",
	}
}
