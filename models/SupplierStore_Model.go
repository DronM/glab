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

type SupplierStore struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Supplier_id fields.ValInt `json:"supplier_id" alias:"Поставщик"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Name_api fields.ValText `json:"name_api" alias:"Наименование API"`
}

func (o *SupplierStore) SetNull() {
	o.Id.SetNull()
	o.Supplier_id.SetNull()
	o.Name.SetNull()
	o.Name_api.SetNull()
}

func NewModelMD_SupplierStore() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierStore{})),
		ID: "SupplierStore_Model",
		Relation: "supplier_stores",
	}
}
//for insert
type SupplierStore_argv struct {
	Argv *SupplierStore `json:"argv"`	
}

//Keys for delete/get object
type SupplierStore_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type SupplierStore_keys_argv struct {
	Argv *SupplierStore_keys `json:"argv"`	
}

//old keys for update
type SupplierStore_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Supplier_id fields.ValInt `json:"supplier_id" alias:"Поставщик"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Name_api fields.ValText `json:"name_api" alias:"Наименование API"`
}

type SupplierStore_old_keys_argv struct {
	Argv *SupplierStore_old_keys `json:"argv"`	
}

