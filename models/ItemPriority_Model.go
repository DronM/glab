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

type ItemPriority struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Code fields.ValInt `json:"code" required:"true" alias:"Код для сортировки"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
}

func (o *ItemPriority) SetNull() {
	o.Id.SetNull()
	o.Code.SetNull()
	o.Name.SetNull()
}

func NewModelMD_ItemPriority() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemPriority{})),
		ID: "ItemPriority_Model",
		Relation: "item_priorities",
	}
}
//for insert
type ItemPriority_argv struct {
	Argv *ItemPriority `json:"argv"`	
}

//Keys for delete/get object
type ItemPriority_keys struct {
	Id fields.ValInt `json:"id"`
}
type ItemPriority_keys_argv struct {
	Argv *ItemPriority_keys `json:"argv"`	
}

//old keys for update
type ItemPriority_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Code fields.ValInt `json:"code" alias:"Код для сортировки"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

type ItemPriority_old_keys_argv struct {
	Argv *ItemPriority_old_keys `json:"argv"`	
}

