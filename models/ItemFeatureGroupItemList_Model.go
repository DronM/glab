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

type ItemFeatureGroupItemList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_feature_group_id fields.ValInt `json:"item_feature_group_id" alias:"Группа"`
	Item_feature_id fields.ValInt `json:"item_feature_id" alias:"Харктеристика"`
	Item_features_ref fields.ValJSON `json:"item_features_ref" alias:"Харктеристика"`
	Code fields.ValInt `json:"code" alias:"Код сортировки" defOrder:"ASC"`
	Filter_option_type fields.ValText `json:"filter_option_type" alias:"Тип фильтра"`
	For_config fields.ValBool `json:"for_config" alias:"Используется для конфигуратора"`
}

func (o *ItemFeatureGroupItemList) SetNull() {
	o.Id.SetNull()
	o.Item_feature_group_id.SetNull()
	o.Item_feature_id.SetNull()
	o.Item_features_ref.SetNull()
	o.Code.SetNull()
	o.Filter_option_type.SetNull()
	o.For_config.SetNull()
}

func NewModelMD_ItemFeatureGroupItemList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFeatureGroupItemList{})),
		ID: "ItemFeatureGroupItemList_Model",
		Relation: "item_feature_group_items_list",
	}
}
