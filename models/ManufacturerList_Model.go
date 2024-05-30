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

type ManufacturerList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование" defOrder:"ASC"`
	Brand_list fields.ValJSON `json:"brand_list" alias:"Список брэндов"`
}

func (o *ManufacturerList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Brand_list.SetNull()
}

func NewModelMD_ManufacturerList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ManufacturerList{})),
		ID: "ManufacturerList_Model",
		Relation: "manufacturers_list",
	}
}
