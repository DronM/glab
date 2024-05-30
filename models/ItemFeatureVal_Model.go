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

type ItemFeatureVal struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_feature_id fields.ValInt `json:"item_feature_id" required:"true" alias:"Харктеристика"`
	Item_id fields.ValInt `json:"item_id" required:"true" alias:"Номенклатура"`
	Val fields.ValText `json:"val" required:"true" alias:"Значение"`
	Date_time fields.ValDateTimeTZ `json:"date_time" required:"true" alias:"Дата обновения"`
}

func (o *ItemFeatureVal) SetNull() {
	o.Id.SetNull()
	o.Item_feature_id.SetNull()
	o.Item_id.SetNull()
	o.Val.SetNull()
	o.Date_time.SetNull()
}

func NewModelMD_ItemFeatureVal() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemFeatureVal{})),
		ID: "ItemFeatureVal_Model",
		Relation: "item_feature_vals",
	}
}
//for insert
type ItemFeatureVal_argv struct {
	Argv *ItemFeatureVal `json:"argv"`	
}

//Keys for delete/get object
type ItemFeatureVal_keys struct {
	Id fields.ValInt `json:"id"`
}
type ItemFeatureVal_keys_argv struct {
	Argv *ItemFeatureVal_keys `json:"argv"`	
}

//old keys for update
type ItemFeatureVal_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Item_feature_id fields.ValInt `json:"item_feature_id" alias:"Харктеристика"`
	Item_id fields.ValInt `json:"item_id" alias:"Номенклатура"`
	Val fields.ValText `json:"val" alias:"Значение"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата обновения"`
}

type ItemFeatureVal_old_keys_argv struct {
	Argv *ItemFeatureVal_old_keys `json:"argv"`	
}

