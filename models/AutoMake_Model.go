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

type AutoMake struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
	Name_variants fields.ValText `json:"name_variants" alias:"Варианты наименования"`
	Popularity_type_id fields.ValInt `json:"popularity_type_id" alias:"Популярность"`
}

func (o *AutoMake) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Name_variants.SetNull()
	o.Popularity_type_id.SetNull()
}

func NewModelMD_AutoMake() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoMake{})),
		ID: "AutoMake_Model",
		Relation: "auto_makes",
	}
}
//for insert
type AutoMake_argv struct {
	Argv *AutoMake `json:"argv"`	
}

//Keys for delete/get object
type AutoMake_keys struct {
	Id fields.ValInt `json:"id"`
}
type AutoMake_keys_argv struct {
	Argv *AutoMake_keys `json:"argv"`	
}

//old keys for update
type AutoMake_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Name_variants fields.ValText `json:"name_variants" alias:"Варианты наименования"`
	Popularity_type_id fields.ValInt `json:"popularity_type_id" alias:"Популярность"`
}

type AutoMake_old_keys_argv struct {
	Argv *AutoMake_old_keys `json:"argv"`	
}

