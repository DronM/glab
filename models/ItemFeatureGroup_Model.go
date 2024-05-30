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

type ItemFeatureGroup struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование" defOrder:"ASC"`
}

func (o *ItemFeatureGroup) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_ItemFeatureGroup() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFeatureGroup{})),
		ID: "ItemFeatureGroup_Model",
		Relation: "item_feature_groups",
	}
}
//for insert
type ItemFeatureGroup_argv struct {
	Argv *ItemFeatureGroup `json:"argv"`	
}

//Keys for delete/get object
type ItemFeatureGroup_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type ItemFeatureGroup_keys_argv struct {
	Argv *ItemFeatureGroup_keys `json:"argv"`	
}

//old keys for update
type ItemFeatureGroup_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

type ItemFeatureGroup_old_keys_argv struct {
	Argv *ItemFeatureGroup_old_keys `json:"argv"`	
}

