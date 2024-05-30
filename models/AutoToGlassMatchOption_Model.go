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

type AutoToGlassMatchOption struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_to_glass_match_head_id fields.ValInt `json:"auto_to_glass_match_head_id" alias:"Master"`
	Item_priority_id fields.ValInt `json:"item_priority_id" alias:"Группа стекол"`
	Line_num fields.ValInt `json:"line_num" alias:"Номер строки"`
	Eurocode_list fields.ValArray `json:"eurocode_list" alias:"Список еврокодов с отметками"`
	Eurocode_view fields.ValText `json:"eurocode_view" alias:"Список еврокодов с отметками (для просмотра)"`
	Body_door_list fields.ValJSON `json:"body_door_list" alias:"Список дверей кузовов с отметками"`
	Body_door_view fields.ValText `json:"body_door_view" alias:"Список дверей кузовов с отметками (для просмотра)"`
	Body_type_list fields.ValJSON `json:"body_type_list" alias:"Список типов кузовов с отметками"`
	Body_type_view fields.ValText `json:"body_type_view" alias:"Список типов кузовов с отметками (для просмотра)"`
	Body_model_list fields.ValArray `json:"body_model_list" alias:"Список моделей кузовов с отметками"`
	Body_model_view fields.ValText `json:"body_model_view" alias:"Список моделей кузовов с отметками (для просмотра)"`
	Option_list fields.ValJSON `json:"option_list" alias:"Список опций со значениями"`
	Quant_econom fields.ValInt `json:"quant_econom" alias:"Минимальный складской остаток эконом"`
	Quant_standart fields.ValInt `json:"quant_standart" alias:"Минимальный складской остаток стандарт"`
	Quant_premium fields.ValInt `json:"quant_premium" alias:"Минимальный складской остаток премиум"`
}

func (o *AutoToGlassMatchOption) SetNull() {
	o.Id.SetNull()
	o.Auto_to_glass_match_head_id.SetNull()
	o.Item_priority_id.SetNull()
	o.Line_num.SetNull()
	o.Eurocode_list.SetNull()
	o.Eurocode_view.SetNull()
	o.Body_door_list.SetNull()
	o.Body_door_view.SetNull()
	o.Body_type_list.SetNull()
	o.Body_type_view.SetNull()
	o.Body_model_list.SetNull()
	o.Body_model_view.SetNull()
	o.Option_list.SetNull()
	o.Quant_econom.SetNull()
	o.Quant_standart.SetNull()
	o.Quant_premium.SetNull()
}

func NewModelMD_AutoToGlassMatchOption() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoToGlassMatchOption{})),
		ID: "AutoToGlassMatchOption_Model",
		Relation: "auto_to_glass_match_options",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type AutoToGlassMatchOption_argv struct {
	Argv *AutoToGlassMatchOption `json:"argv"`	
}

//Keys for delete/get object
type AutoToGlassMatchOption_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoToGlassMatchOption_keys_argv struct {
	Argv *AutoToGlassMatchOption_keys `json:"argv"`	
}

//old keys for update
type AutoToGlassMatchOption_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Auto_to_glass_match_head_id fields.ValInt `json:"auto_to_glass_match_head_id" alias:"Master"`
	Item_priority_id fields.ValInt `json:"item_priority_id" alias:"Группа стекол"`
	Line_num fields.ValInt `json:"line_num" alias:"Номер строки"`
	Eurocode_list fields.ValArray `json:"eurocode_list" alias:"Список еврокодов с отметками"`
	Eurocode_view fields.ValText `json:"eurocode_view" alias:"Список еврокодов с отметками (для просмотра)"`
	Body_door_list fields.ValJSON `json:"body_door_list" alias:"Список дверей кузовов с отметками"`
	Body_door_view fields.ValText `json:"body_door_view" alias:"Список дверей кузовов с отметками (для просмотра)"`
	Body_type_list fields.ValJSON `json:"body_type_list" alias:"Список типов кузовов с отметками"`
	Body_type_view fields.ValText `json:"body_type_view" alias:"Список типов кузовов с отметками (для просмотра)"`
	Body_model_list fields.ValArray `json:"body_model_list" alias:"Список моделей кузовов с отметками"`
	Body_model_view fields.ValText `json:"body_model_view" alias:"Список моделей кузовов с отметками (для просмотра)"`
	Option_list fields.ValJSON `json:"option_list" alias:"Список опций со значениями"`
	Quant_econom fields.ValInt `json:"quant_econom" alias:"Минимальный складской остаток эконом"`
	Quant_standart fields.ValInt `json:"quant_standart" alias:"Минимальный складской остаток стандарт"`
	Quant_premium fields.ValInt `json:"quant_premium" alias:"Минимальный складской остаток премиум"`
}

type AutoToGlassMatchOption_old_keys_argv struct {
	Argv *AutoToGlassMatchOption_old_keys `json:"argv"`	
}

