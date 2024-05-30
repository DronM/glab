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

type SupplierItemDialog struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_name fields.ValText `json:"item_name" alias:"Наименование товара"`
	Items_ref fields.ValJSON `json:"items_ref" alias:"Базовый товар"`
	Item_folders_ref fields.ValJSON `json:"item_folders_ref" alias:"Группа товаров"`
	Suppliers_ref fields.ValJSON `json:"suppliers_ref" alias:"Поставщик"`
	Supplier_item_id fields.ValJSON `json:"supplier_item_id" alias:"ID поставщика"`
	Item_manufacturers_ref fields.ValJSON `json:"item_manufacturers_ref" alias:"Производитель"`
	Cost fields.ValFloat `json:"cost" alias:"Цена поставщика"`
	Sale_price fields.ValFloat `json:"sale_price" alias:"Рекомендованная розничная цена"`
	Artikul fields.ValText `json:"artikul" alias:"Артикул (код поставщика)"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий текст"`
	Comment_note fields.ValText `json:"comment_note" alias:"Комментарий примечание"`
	Pictures fields.ValJSON `json:"pictures"`
	Supplier_features_list fields.ValJSON `json:"supplier_features_list" alias:"Характеристики"`
}

func (o *SupplierItemDialog) SetNull() {
	o.Id.SetNull()
	o.Item_name.SetNull()
	o.Items_ref.SetNull()
	o.Item_folders_ref.SetNull()
	o.Suppliers_ref.SetNull()
	o.Supplier_item_id.SetNull()
	o.Item_manufacturers_ref.SetNull()
	o.Cost.SetNull()
	o.Sale_price.SetNull()
	o.Artikul.SetNull()
	o.Comment_text.SetNull()
	o.Comment_note.SetNull()
	o.Pictures.SetNull()
	o.Supplier_features_list.SetNull()
}

func NewModelMD_SupplierItemDialog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierItemDialog{})),
		ID: "SupplierItemDialog_Model",
		Relation: "supplier_items_dialog",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
