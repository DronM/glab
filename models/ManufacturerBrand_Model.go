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
	"glab/enums"	
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type ManufacturerBrand struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Manufacturer_id fields.ValInt `json:"manufacturer_id" required:"true" alias:"Производитель"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
	Quality_level enums.ValEnum_quality_levels `json:"quality_level" required:"true" alias:"Уровень качества"`
}

func (o *ManufacturerBrand) SetNull() {
	o.Id.SetNull()
	o.Manufacturer_id.SetNull()
	o.Name.SetNull()
	o.Quality_level.SetNull()
}

func NewModelMD_ManufacturerBrand() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ManufacturerBrand{})),
		ID: "ManufacturerBrand_Model",
		Relation: "manufacturer_brands",
	}
}
//for insert
type ManufacturerBrand_argv struct {
	Argv *ManufacturerBrand `json:"argv"`	
}

//Keys for delete/get object
type ManufacturerBrand_keys struct {
	Id fields.ValInt `json:"id"`
}
type ManufacturerBrand_keys_argv struct {
	Argv *ManufacturerBrand_keys `json:"argv"`	
}

//old keys for update
type ManufacturerBrand_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Manufacturer_id fields.ValInt `json:"manufacturer_id" alias:"Производитель"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Quality_level enums.ValEnum_quality_levels `json:"quality_level" alias:"Уровень качества"`
}

type ManufacturerBrand_old_keys_argv struct {
	Argv *ManufacturerBrand_old_keys `json:"argv"`	
}

