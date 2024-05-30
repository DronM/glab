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

type SupplierItemList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_id fields.ValInt `json:"item_id" sysCol:"true"`
	Items_ref fields.ValJSON `json:"items_ref" alias:"Базовый товар"`
	Item_folders_ref fields.ValJSON `json:"item_folders_ref" alias:"Группа товаров"`
	Supplier_id fields.ValInt `json:"supplier_id" sysCol:"true"`
	Suppliers_ref fields.ValJSON `json:"suppliers_ref" alias:"Поставщик"`
	Supplier_item_id fields.ValJSON `json:"supplier_item_id" alias:"ID поставщика"`
	Cost fields.ValFloat `json:"cost" alias:"Цена поставщика"`
	Sale_price fields.ValFloat `json:"sale_price" alias:"Рекомендованная розничная цена"`
	Artikul fields.ValText `json:"artikul" alias:"Артикул (код поставщика)"`
}

func (o *SupplierItemList) SetNull() {
	o.Id.SetNull()
	o.Item_id.SetNull()
	o.Items_ref.SetNull()
	o.Item_folders_ref.SetNull()
	o.Supplier_id.SetNull()
	o.Suppliers_ref.SetNull()
	o.Supplier_item_id.SetNull()
	o.Cost.SetNull()
	o.Sale_price.SetNull()
	o.Artikul.SetNull()
}

func NewModelMD_SupplierItemList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierItemList{})),
		ID: "SupplierItemList_Model",
		Relation: "supplier_items_list",
	}
}
