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

type ItemFolderList struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Parent_item_folder_id fields.ValInt `json:"parent_item_folder_id" alias:"Родитель"`
	Code fields.ValInt `json:"code" required:"true" alias:"Код"`
	Item_feature_groups_list fields.ValJSON `json:"item_feature_groups_list"`
	Supplier_item_feature_groups_list fields.ValJSON `json:"supplier_item_feature_groups_list"`
	Vehicle_types_ref fields.ValJSON `json:"vehicle_types_ref"`
	Item_priorities_ref fields.ValJSON `json:"item_priorities_ref"`
}

func (o *ItemFolderList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Parent_item_folder_id.SetNull()
	o.Code.SetNull()
	o.Item_feature_groups_list.SetNull()
	o.Supplier_item_feature_groups_list.SetNull()
	o.Vehicle_types_ref.SetNull()
	o.Item_priorities_ref.SetNull()
}

func NewModelMD_ItemFolderList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFolderList{})),
		ID: "ItemFolderList_Model",
		Relation: "item_folders_list",
	}
}
