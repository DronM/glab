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

type SupplierItemFolderFeatureGroupList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_folder_id fields.ValInt `json:"item_folder_id" alias:"Папка"`
	Item_feature_group_id fields.ValInt `json:"item_feature_group_id" alias:"Группа характеристик ID"`
	Item_feature_groups_ref fields.ValJSON `json:"item_feature_groups_ref" alias:"Группа характеристик"`
}

func (o *SupplierItemFolderFeatureGroupList) SetNull() {
	o.Id.SetNull()
	o.Item_folder_id.SetNull()
	o.Item_feature_group_id.SetNull()
	o.Item_feature_groups_ref.SetNull()
}

func NewModelMD_SupplierItemFolderFeatureGroupList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierItemFolderFeatureGroupList{})),
		ID: "SupplierItemFolderFeatureGroupList_Model",
		Relation: "supplier_item_folder_feature_groups_list",
	}
}
