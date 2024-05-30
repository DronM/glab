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
	"glab/enums"	
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type ItemFeatureGroupItem struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_feature_group_id fields.ValInt `json:"item_feature_group_id" required:"true" alias:"Группа"`
	Item_feature_id fields.ValInt `json:"item_feature_id" required:"true" alias:"Харктеристика"`
	Code fields.ValInt `json:"code" required:"true" alias:"Код сортировки"`
	Filter_option_type enums.ValEnum_item_feature_filter_option_types `json:"filter_option_type" alias:"Тип фильтра"`
	For_config fields.ValBool `json:"for_config" alias:"Используется для конфигуратора"`
}

func (o *ItemFeatureGroupItem) SetNull() {
	o.Id.SetNull()
	o.Item_feature_group_id.SetNull()
	o.Item_feature_id.SetNull()
	o.Code.SetNull()
	o.Filter_option_type.SetNull()
	o.For_config.SetNull()
}

func NewModelMD_ItemFeatureGroupItem() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFeatureGroupItem{})),
		ID: "ItemFeatureGroupItem_Model",
		Relation: "item_feature_group_items",
	}
}
//for insert
type ItemFeatureGroupItem_argv struct {
	Argv *ItemFeatureGroupItem `json:"argv"`	
}

//Keys for delete/get object
type ItemFeatureGroupItem_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type ItemFeatureGroupItem_keys_argv struct {
	Argv *ItemFeatureGroupItem_keys `json:"argv"`	
}

//old keys for update
type ItemFeatureGroupItem_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Item_feature_group_id fields.ValInt `json:"item_feature_group_id" alias:"Группа"`
	Item_feature_id fields.ValInt `json:"item_feature_id" alias:"Харктеристика"`
	Code fields.ValInt `json:"code" alias:"Код сортировки"`
	Filter_option_type enums.ValEnum_item_feature_filter_option_types `json:"filter_option_type" alias:"Тип фильтра"`
	For_config fields.ValBool `json:"for_config" alias:"Используется для конфигуратора"`
}

type ItemFeatureGroupItem_old_keys_argv struct {
	Argv *ItemFeatureGroupItem_old_keys `json:"argv"`	
}

