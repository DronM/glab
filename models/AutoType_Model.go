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

type AutoType struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true"`
}

func (o *AutoType) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_AutoType() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoType{})),
		ID: "AutoType_Model",
		Relation: "auto_types",
	}
}
//for insert
type AutoType_argv struct {
	Argv *AutoType `json:"argv"`	
}

//Keys for delete/get object
type AutoType_keys struct {
	Id fields.ValInt `json:"id"`
}
type AutoType_keys_argv struct {
	Argv *AutoType_keys `json:"argv"`	
}

//old keys for update
type AutoType_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
}

type AutoType_old_keys_argv struct {
	Argv *AutoType_old_keys `json:"argv"`	
}

