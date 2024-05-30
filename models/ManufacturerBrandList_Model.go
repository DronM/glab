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

type ManufacturerBrandList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование" defOrder:"ASC"`
	Quality_level fields.ValText `json:"quality_level" alias:"Уровень качества"`
	Manufacturers_ref fields.ValJSON `json:"manufacturers_ref" alias:"Производитель брэнда"`
	Manufacturer_id fields.ValInt `json:"manufacturer_id" sysCol:"true"`
}

func (o *ManufacturerBrandList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Quality_level.SetNull()
	o.Manufacturers_ref.SetNull()
	o.Manufacturer_id.SetNull()
}

func NewModelMD_ManufacturerBrandList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ManufacturerBrandList{})),
		ID: "ManufacturerBrandList_Model",
		Relation: "manufacturer_brands_list",
	}
}
