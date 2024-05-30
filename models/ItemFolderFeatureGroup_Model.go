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

type ItemFolderFeatureGroup struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_folder_id fields.ValInt `json:"item_folder_id" alias:"Папка"`
	Item_feature_group_id fields.ValInt `json:"item_feature_group_id" alias:"Характеристика"`
}

func (o *ItemFolderFeatureGroup) SetNull() {
	o.Id.SetNull()
	o.Item_folder_id.SetNull()
	o.Item_feature_group_id.SetNull()
}

func NewModelMD_ItemFolderFeatureGroup() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFolderFeatureGroup{})),
		ID: "ItemFolderFeatureGroup_Model",
		Relation: "item_folder_feature_groups",
	}
}
//for insert
type ItemFolderFeatureGroup_argv struct {
	Argv *ItemFolderFeatureGroup `json:"argv"`	
}

//Keys for delete/get object
type ItemFolderFeatureGroup_keys struct {
	Id fields.ValInt `json:"id"`
}
type ItemFolderFeatureGroup_keys_argv struct {
	Argv *ItemFolderFeatureGroup_keys `json:"argv"`	
}

//old keys for update
type ItemFolderFeatureGroup_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Item_folder_id fields.ValInt `json:"item_folder_id" alias:"Папка"`
	Item_feature_group_id fields.ValInt `json:"item_feature_group_id" alias:"Характеристика"`
}

type ItemFolderFeatureGroup_old_keys_argv struct {
	Argv *ItemFolderFeatureGroup_old_keys `json:"argv"`	
}

