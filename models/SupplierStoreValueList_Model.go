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

type SupplierStoreValueList struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Supplier_store_id fields.ValInt `json:"supplier_store_id"`
	Supplier_stores_ref fields.ValJSON `json:"supplier_stores_ref"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id"`
	Supplier_items_ref fields.ValJSON `json:"supplier_items_ref"`
	Val fields.ValText `json:"val" alias:"Остаток"`
}

func (o *SupplierStoreValueList) SetNull() {
	o.Id.SetNull()
	o.Supplier_store_id.SetNull()
	o.Supplier_stores_ref.SetNull()
	o.Supplier_item_id.SetNull()
	o.Supplier_items_ref.SetNull()
	o.Val.SetNull()
}

func NewModelMD_SupplierStoreValueList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierStoreValueList{})),
		ID: "SupplierStoreValueList_Model",
		Relation: "supplier_store_values_list",
	}
}
