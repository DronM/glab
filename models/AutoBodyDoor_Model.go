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

type AutoBodyDoor struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true" defOrder:"ASC"`
	Name_full fields.ValText `json:"name_full"`
}

func (o *AutoBodyDoor) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Name_full.SetNull()
}

func NewModelMD_AutoBodyDoor() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoBodyDoor{})),
		ID: "AutoBodyDoor_Model",
		Relation: "auto_body_doors",
	}
}
//for insert
type AutoBodyDoor_argv struct {
	Argv *AutoBodyDoor `json:"argv"`	
}

//Keys for delete/get object
type AutoBodyDoor_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoBodyDoor_keys_argv struct {
	Argv *AutoBodyDoor_keys `json:"argv"`	
}

//old keys for update
type AutoBodyDoor_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
	Name_full fields.ValText `json:"name_full"`
}

type AutoBodyDoor_old_keys_argv struct {
	Argv *AutoBodyDoor_old_keys `json:"argv"`	
}

