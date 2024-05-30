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

type AutoBodyType struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true" defOrder:"ASC"`
	Name_full fields.ValText `json:"name_full"`
}

func (o *AutoBodyType) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Name_full.SetNull()
}

func NewModelMD_AutoBodyType() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoBodyType{})),
		ID: "AutoBodyType_Model",
		Relation: "auto_body_types",
	}
}
//for insert
type AutoBodyType_argv struct {
	Argv *AutoBodyType `json:"argv"`	
}

//Keys for delete/get object
type AutoBodyType_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoBodyType_keys_argv struct {
	Argv *AutoBodyType_keys `json:"argv"`	
}

//old keys for update
type AutoBodyType_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
	Name_full fields.ValText `json:"name_full"`
}

type AutoBodyType_old_keys_argv struct {
	Argv *AutoBodyType_old_keys `json:"argv"`	
}

