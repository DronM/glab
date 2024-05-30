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

type  struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование" defOrder:"ASC"`
	Name_lat fields.ValText `json:"name_lat" alias:"Наименование латиницей для API"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
}

func (o *) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Name_lat.SetNull()
	o.Comment_text.SetNull()
}

func NewModelMD_() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf({})),
		ID: "_Model",
		Relation: "item_features_list",
	}
}
