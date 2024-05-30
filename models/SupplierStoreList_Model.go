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

type SupplierStoreList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Supplier_id fields.ValInt `json:"supplier_id" sysCol:"true"`
	Supplier_name fields.ValText `json:"supplier_name" alias:"Поставщик" defOrder:"ASC"`
	Suppliers_ref fields.ValJSON `json:"suppliers_ref"`
	Name fields.ValText `json:"name" alias:"Наименование" defOrder:"ASC"`
	Name_api fields.ValText `json:"name_api" alias:"Наименование API"`
}

func (o *SupplierStoreList) SetNull() {
	o.Id.SetNull()
	o.Supplier_id.SetNull()
	o.Supplier_name.SetNull()
	o.Suppliers_ref.SetNull()
	o.Name.SetNull()
	o.Name_api.SetNull()
}

func NewModelMD_SupplierStoreList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierStoreList{})),
		ID: "SupplierStoreList_Model",
		Relation: "supplier_stores_list",
	}
}
