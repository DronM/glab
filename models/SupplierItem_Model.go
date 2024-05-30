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

type SupplierItem struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Item_id fields.ValInt `json:"item_id" alias:"Базовый товар"`
	Supplier_id fields.ValInt `json:"supplier_id" alias:"Поставщик"`
	Supplier_item_id fields.ValText `json:"supplier_item_id" alias:"ID поставщика"`
	Cost fields.ValFloat `json:"cost" alias:"Цена поставщика"`
	Sale_price fields.ValFloat `json:"sale_price" alias:"Рекомендованная розничная цена"`
	Artikul fields.ValText `json:"artikul" alias:"Артикул (код поставщика)"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий текст"`
	Comment_note fields.ValText `json:"comment_note" alias:"Комментарий примечание"`
	Modified_dt fields.ValDateTimeTZ `json:"modified_dt" alias:"Дата модификации"`
}

func (o *SupplierItem) SetNull() {
	o.Id.SetNull()
	o.Item_id.SetNull()
	o.Supplier_id.SetNull()
	o.Supplier_item_id.SetNull()
	o.Cost.SetNull()
	o.Sale_price.SetNull()
	o.Artikul.SetNull()
	o.Comment_text.SetNull()
	o.Comment_note.SetNull()
	o.Modified_dt.SetNull()
}

func NewModelMD_SupplierItem() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(SupplierItem{})),
		ID: "SupplierItem_Model",
		Relation: "supplier_items",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type SupplierItem_argv struct {
	Argv *SupplierItem `json:"argv"`	
}

//Keys for delete/get object
type SupplierItem_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type SupplierItem_keys_argv struct {
	Argv *SupplierItem_keys `json:"argv"`	
}

//old keys for update
type SupplierItem_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Item_id fields.ValInt `json:"item_id" alias:"Базовый товар"`
	Supplier_id fields.ValInt `json:"supplier_id" alias:"Поставщик"`
	Supplier_item_id fields.ValText `json:"supplier_item_id" alias:"ID поставщика"`
	Cost fields.ValFloat `json:"cost" alias:"Цена поставщика"`
	Sale_price fields.ValFloat `json:"sale_price" alias:"Рекомендованная розничная цена"`
	Artikul fields.ValText `json:"artikul" alias:"Артикул (код поставщика)"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий текст"`
	Comment_note fields.ValText `json:"comment_note" alias:"Комментарий примечание"`
	Modified_dt fields.ValDateTimeTZ `json:"modified_dt" alias:"Дата модификации"`
}

type SupplierItem_old_keys_argv struct {
	Argv *SupplierItem_old_keys `json:"argv"`	
}

