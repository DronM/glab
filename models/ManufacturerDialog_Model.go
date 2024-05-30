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

type ManufacturerDialog struct {
	Id fields.ValInt `json:"id" primaryKey:"true" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

func (o *ManufacturerDialog) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_ManufacturerDialog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ManufacturerDialog{})),
		ID: "ManufacturerDialog_Model",
		Relation: "manufacturers_dialog",
	}
}
