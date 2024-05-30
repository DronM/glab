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

type SupplierItemFeatureVal struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_feature_id fields.ValInt `json:"item_feature_id" required:"true" alias:"Харктеристика"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id" required:"true" alias:"Номенклатура"`
	Val fields.ValText `json:"val" required:"true" alias:"Значение"`
	Date_time fields.ValDateTimeTZ `json:"date_time" required:"true" alias:"Дата обновения"`
}

func (o *SupplierItemFeatureVal) SetNull() {
	o.Id.SetNull()
	o.Item_feature_id.SetNull()
	o.Supplier_item_id.SetNull()
	o.Val.SetNull()
	o.Date_time.SetNull()
}

func NewModelMD_SupplierItemFeatureVal() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierItemFeatureVal{})),
		ID: "SupplierItemFeatureVal_Model",
		Relation: "supplier_item_feature_vals",
	}
}
//for insert
type SupplierItemFeatureVal_argv struct {
	Argv *SupplierItemFeatureVal `json:"argv"`	
}

//Keys for delete/get object
type SupplierItemFeatureVal_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type SupplierItemFeatureVal_keys_argv struct {
	Argv *SupplierItemFeatureVal_keys `json:"argv"`	
}

//old keys for update
type SupplierItemFeatureVal_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Item_feature_id fields.ValInt `json:"item_feature_id" alias:"Харктеристика"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id" alias:"Номенклатура"`
	Val fields.ValText `json:"val" alias:"Значение"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата обновения"`
}

type SupplierItemFeatureVal_old_keys_argv struct {
	Argv *SupplierItemFeatureVal_old_keys `json:"argv"`	
}

