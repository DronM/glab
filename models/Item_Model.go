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

type Item struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Item_folder_id fields.ValInt `json:"item_folder_id" alias:"Группа товаров"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Для какой марки"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Для какой модели"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Для какого поколения модели"`
	Auto_body_id fields.ValInt `json:"auto_body_id" alias:"Для какого кузова"`
	Manufacturer_brand_id fields.ValInt `json:"manufacturer_brand_id" alias:"Производитель"`
	Feature_vals fields.ValText `json:"feature_vals" alias:"Значение фильтруемых свойств"`
	Modified_dt fields.ValDateTimeTZ `json:"modified_dt" alias:"Дата модификации"`
}

func (o *Item) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Item_folder_id.SetNull()
	o.Auto_make_id.SetNull()
	o.Auto_model_id.SetNull()
	o.Auto_model_generation_id.SetNull()
	o.Auto_body_id.SetNull()
	o.Manufacturer_brand_id.SetNull()
	o.Feature_vals.SetNull()
	o.Modified_dt.SetNull()
}

func NewModelMD_Item() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(Item{})),
		ID: "Item_Model",
		Relation: "items",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type Item_argv struct {
	Argv *Item `json:"argv"`	
}

//Keys for delete/get object
type Item_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type Item_keys_argv struct {
	Argv *Item_keys `json:"argv"`	
}

//old keys for update
type Item_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Item_folder_id fields.ValInt `json:"item_folder_id" alias:"Группа товаров"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Для какой марки"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Для какой модели"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Для какого поколения модели"`
	Auto_body_id fields.ValInt `json:"auto_body_id" alias:"Для какого кузова"`
	Manufacturer_brand_id fields.ValInt `json:"manufacturer_brand_id" alias:"Производитель"`
	Feature_vals fields.ValText `json:"feature_vals" alias:"Значение фильтруемых свойств"`
	Modified_dt fields.ValDateTimeTZ `json:"modified_dt" alias:"Дата модификации"`
}

type Item_old_keys_argv struct {
	Argv *Item_old_keys `json:"argv"`	
}

