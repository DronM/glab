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

type ItemFeature struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование" defOrder:"ASC"`
	Name_lat fields.ValText `json:"name_lat" required:"true" alias:"Наименование литиницей для API"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	Value_attrs fields.ValJSON `json:"value_attrs" alias:"Реквизиты значения: тип данных, длина, точность, значения списка"`
}

func (o *ItemFeature) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Name_lat.SetNull()
	o.Comment_text.SetNull()
	o.Value_attrs.SetNull()
}

func NewModelMD_ItemFeature() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFeature{})),
		ID: "ItemFeature_Model",
		Relation: "item_features",
	}
}
//for insert
type ItemFeature_argv struct {
	Argv *ItemFeature `json:"argv"`	
}

//Keys for delete/get object
type ItemFeature_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type ItemFeature_keys_argv struct {
	Argv *ItemFeature_keys `json:"argv"`	
}

//old keys for update
type ItemFeature_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Name_lat fields.ValText `json:"name_lat" alias:"Наименование литиницей для API"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	Value_attrs fields.ValJSON `json:"value_attrs" alias:"Реквизиты значения: тип данных, длина, точность, значения списка"`
}

type ItemFeature_old_keys_argv struct {
	Argv *ItemFeature_old_keys `json:"argv"`	
}

