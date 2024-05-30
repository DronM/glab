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

type ItemFolder struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
	Parent_item_folder_id fields.ValInt `json:"parent_item_folder_id" alias:"Родитель"`
	Code fields.ValInt `json:"code" required:"true" alias:"Код" defOrder:"ASC"`
	Item_priority_id fields.ValInt `json:"item_priority_id" alias:"Приоритет вывода"`
	Vehicle_type_id fields.ValInt `json:"vehicle_type_id" alias:"Тип транпорта"`
}

func (o *ItemFolder) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Parent_item_folder_id.SetNull()
	o.Code.SetNull()
	o.Item_priority_id.SetNull()
	o.Vehicle_type_id.SetNull()
}

func NewModelMD_ItemFolder() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFolder{})),
		ID: "ItemFolder_Model",
		Relation: "item_folders",
	}
}
//for insert
type ItemFolder_argv struct {
	Argv *ItemFolder `json:"argv"`	
}

//Keys for delete/get object
type ItemFolder_keys struct {
	Id fields.ValInt `json:"id"`
}
type ItemFolder_keys_argv struct {
	Argv *ItemFolder_keys `json:"argv"`	
}

//old keys for update
type ItemFolder_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Parent_item_folder_id fields.ValInt `json:"parent_item_folder_id" alias:"Родитель"`
	Code fields.ValInt `json:"code" alias:"Код"`
	Item_priority_id fields.ValInt `json:"item_priority_id" alias:"Приоритет вывода"`
	Vehicle_type_id fields.ValInt `json:"vehicle_type_id" alias:"Тип транпорта"`
}

type ItemFolder_old_keys_argv struct {
	Argv *ItemFolder_old_keys `json:"argv"`	
}

