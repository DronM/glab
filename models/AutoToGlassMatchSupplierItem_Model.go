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
	"glab/enums"	
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type AutoToGlassMatchSupplierItem struct {
	Auto_to_glass_match_option_id fields.ValInt `json:"auto_to_glass_match_option_id" primaryKey:"true" alias:"Строка опций"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id" primaryKey:"true" alias:"Номенклатура"`
	Auto_body_id fields.ValInt `json:"auto_body_id" primaryKey:"true" alias:"Кузов"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Поколение"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Модель"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Марка"`
	Feature_list fields.ValJSON `json:"feature_list" alias:"Список опций"`
	Quality_level enums.ValEnum_quality_levels `json:"quality_level" required:"true" alias:"Уровень качества"`
	Item_priority_id fields.ValInt `json:"item_priority_id" alias:"Приоритет"`
}

func (o *AutoToGlassMatchSupplierItem) SetNull() {
	o.Auto_to_glass_match_option_id.SetNull()
	o.Supplier_item_id.SetNull()
	o.Auto_body_id.SetNull()
	o.Auto_model_generation_id.SetNull()
	o.Auto_model_id.SetNull()
	o.Auto_make_id.SetNull()
	o.Feature_list.SetNull()
	o.Quality_level.SetNull()
	o.Item_priority_id.SetNull()
}

func NewModelMD_AutoToGlassMatchSupplierItem() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoToGlassMatchSupplierItem{})),
		ID: "AutoToGlassMatchSupplierItem_Model",
		Relation: "auto_to_glass_match_supplier_items",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type AutoToGlassMatchSupplierItem_argv struct {
	Argv *AutoToGlassMatchSupplierItem `json:"argv"`	
}

//Keys for delete/get object
type AutoToGlassMatchSupplierItem_keys struct {
	Auto_to_glass_match_option_id fields.ValInt `json:"auto_to_glass_match_option_id"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id"`
	Auto_body_id fields.ValInt `json:"auto_body_id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoToGlassMatchSupplierItem_keys_argv struct {
	Argv *AutoToGlassMatchSupplierItem_keys `json:"argv"`	
}

//old keys for update
type AutoToGlassMatchSupplierItem_old_keys struct {
	Old_auto_to_glass_match_option_id fields.ValInt `json:"old_auto_to_glass_match_option_id" alias:"Строка опций"`
	Auto_to_glass_match_option_id fields.ValInt `json:"auto_to_glass_match_option_id" alias:"Строка опций"`
	Old_supplier_item_id fields.ValInt `json:"old_supplier_item_id" alias:"Номенклатура"`
	Supplier_item_id fields.ValInt `json:"supplier_item_id" alias:"Номенклатура"`
	Old_auto_body_id fields.ValInt `json:"old_auto_body_id" alias:"Кузов"`
	Auto_body_id fields.ValInt `json:"auto_body_id" alias:"Кузов"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Поколение"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Модель"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Марка"`
	Feature_list fields.ValJSON `json:"feature_list" alias:"Список опций"`
	Quality_level enums.ValEnum_quality_levels `json:"quality_level" alias:"Уровень качества"`
	Item_priority_id fields.ValInt `json:"item_priority_id" alias:"Приоритет"`
}

type AutoToGlassMatchSupplierItem_old_keys_argv struct {
	Argv *AutoToGlassMatchSupplierItem_old_keys `json:"argv"`	
}

