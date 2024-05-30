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

type AutoModel struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Марка"`
	Name fields.ValText `json:"name" required:"true"`
	Name_variants fields.ValText `json:"name_variants" alias:"Варианты наименования"`
	Popularity_type_id fields.ValInt `json:"popularity_type_id" alias:"Популярность"`
	Vehicle_type_id fields.ValInt `json:"vehicle_type_id" alias:"Тип ТС"`
}

func (o *AutoModel) SetNull() {
	o.Id.SetNull()
	o.Auto_make_id.SetNull()
	o.Name.SetNull()
	o.Name_variants.SetNull()
	o.Popularity_type_id.SetNull()
	o.Vehicle_type_id.SetNull()
}

func NewModelMD_AutoModel() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoModel{})),
		ID: "AutoModel_Model",
		Relation: "auto_models",
	}
}
//for insert
type AutoModel_argv struct {
	Argv *AutoModel `json:"argv"`	
}

//Keys for delete/get object
type AutoModel_keys struct {
	Id fields.ValInt `json:"id"`
}
type AutoModel_keys_argv struct {
	Argv *AutoModel_keys `json:"argv"`	
}

//old keys for update
type AutoModel_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Марка"`
	Name fields.ValText `json:"name"`
	Name_variants fields.ValText `json:"name_variants" alias:"Варианты наименования"`
	Popularity_type_id fields.ValInt `json:"popularity_type_id" alias:"Популярность"`
	Vehicle_type_id fields.ValInt `json:"vehicle_type_id" alias:"Тип ТС"`
}

type AutoModel_old_keys_argv struct {
	Argv *AutoModel_old_keys `json:"argv"`	
}

