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

type Manufacturer struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
}

func (o *Manufacturer) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_Manufacturer() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(Manufacturer{})),
		ID: "Manufacturer_Model",
		Relation: "manufacturers",
	}
}
//for insert
type Manufacturer_argv struct {
	Argv *Manufacturer `json:"argv"`	
}

//Keys for delete/get object
type Manufacturer_keys struct {
	Id fields.ValInt `json:"id"`
}
type Manufacturer_keys_argv struct {
	Argv *Manufacturer_keys `json:"argv"`	
}

//old keys for update
type Manufacturer_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

type Manufacturer_old_keys_argv struct {
	Argv *Manufacturer_old_keys `json:"argv"`	
}

