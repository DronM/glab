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

type ItemSearchResult struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Name fields.ValText `json:"name"`
	Auto_makes_ref fields.ValJSON `json:"auto_makes_ref"`
	Auto_models_ref fields.ValJSON `json:"auto_models_ref"`
	Auto_model_generations_ref fields.ValJSON `json:"auto_model_generations_ref"`
	Auto_bodies_ref fields.ValJSON `json:"auto_bodies_ref"`
	Item_folders_ref fields.ValJSON `json:"item_folders_ref"`
	Item_priorities_ref fields.ValJSON `json:"item_priorities_ref"`
	Features_list fields.ValJSON `json:"features_list"`
	Suppliers_ref fields.ValJSON `json:"suppliers_ref" alias:"Поставщик"`
	Supplier_item_id fields.ValText `json:"supplier_item_id" alias:"ID поставщика"`
	Cost fields.ValFloat `json:"cost" alias:"Цена поставщика"`
	Sale_price fields.ValFloat `json:"sale_price" alias:"Рекомендованная розничная цена"`
	Artikul fields.ValText `json:"artikul" alias:"Артикул (код поставщика)"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий текст"`
	Comment_note fields.ValText `json:"comment_note" alias:"Комментарий примечание"`
	Stores_list fields.ValJSON `json:"stores_list"`
}

func (o *ItemSearchResult) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Auto_makes_ref.SetNull()
	o.Auto_models_ref.SetNull()
	o.Auto_model_generations_ref.SetNull()
	o.Auto_bodies_ref.SetNull()
	o.Item_folders_ref.SetNull()
	o.Item_priorities_ref.SetNull()
	o.Features_list.SetNull()
	o.Suppliers_ref.SetNull()
	o.Supplier_item_id.SetNull()
	o.Cost.SetNull()
	o.Sale_price.SetNull()
	o.Artikul.SetNull()
	o.Comment_text.SetNull()
	o.Comment_note.SetNull()
	o.Stores_list.SetNull()
}

func NewModelMD_ItemSearchResult() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemSearchResult{})),
		ID: "ItemSearchResult_Model",
		Relation: "",
	}
}
