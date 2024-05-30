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

type ItemList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Item_folder_id fields.ValInt `json:"item_folder_id" sysCol:"true"`
	Item_folders_ref fields.ValJSON `json:"item_folders_ref" alias:"Группа товаров"`
	Manufacturer_brand_id fields.ValInt `json:"manufacturer_brand_id" sysCol:"true"`
	Manufacturer_brands_ref fields.ValJSON `json:"manufacturer_brands_ref" alias:"Производитель"`
	Item_features_list fields.ValJSON `json:"item_features_list" alias:"Опции"`
}

func (o *ItemList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Item_folder_id.SetNull()
	o.Item_folders_ref.SetNull()
	o.Manufacturer_brand_id.SetNull()
	o.Manufacturer_brands_ref.SetNull()
	o.Item_features_list.SetNull()
}

func NewModelMD_ItemList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemList{})),
		ID: "ItemList_Model",
		Relation: "items_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
