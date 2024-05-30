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

type SupplierStoreValue struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Supplier_store_id fields.ValInt `json:"supplier_store_id" alias:"Место хранения поставщика"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id" alias:"Номенлатура поставщика"`
	Val fields.ValText `json:"val" alias:"Остаток"`
}

func (o *SupplierStoreValue) SetNull() {
	o.Id.SetNull()
	o.Supplier_store_id.SetNull()
	o.Supplier_item_id.SetNull()
	o.Val.SetNull()
}

func NewModelMD_SupplierStoreValue() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierStoreValue{})),
		ID: "SupplierStoreValue_Model",
		Relation: "supplier_store_values",
	}
}
//for insert
type SupplierStoreValue_argv struct {
	Argv *SupplierStoreValue `json:"argv"`	
}

//Keys for delete/get object
type SupplierStoreValue_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type SupplierStoreValue_keys_argv struct {
	Argv *SupplierStoreValue_keys `json:"argv"`	
}

//old keys for update
type SupplierStoreValue_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Supplier_store_id fields.ValInt `json:"supplier_store_id" alias:"Место хранения поставщика"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id" alias:"Номенлатура поставщика"`
	Val fields.ValText `json:"val" alias:"Остаток"`
}

type SupplierStoreValue_old_keys_argv struct {
	Argv *SupplierStoreValue_old_keys `json:"argv"`	
}

