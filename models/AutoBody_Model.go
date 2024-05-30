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

type AutoBody struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Принадлежность к модели"`
	Name fields.ValText `json:"name" required:"true"`
	Year_from fields.ValInt `json:"year_from" alias:"Начало производтва"`
	Year_to fields.ValInt `json:"year_to" alias:"Окончание производтва"`
	Model fields.ValText `json:"model" alias:"Модификация"`
	Auto_body_door_id fields.ValInt `json:"auto_body_door_id" alias:"Двери"`
	Auto_body_type_id fields.ValInt `json:"auto_body_type_id" alias:"Тип"`
	Auto_price_category_id fields.ValInt `json:"auto_price_category_id" alias:"Категория цены"`
	Auto_body_size enums.ValEnum_auto_body_sizes `json:"auto_body_size" alias:"Размер кузова"`
	Complexity_film_body fields.ValInt `json:"complexity_film_body" alias:"Класс сложности пленка кузов"`
	Complexity_film_front fields.ValInt `json:"complexity_film_front" alias:"Класс сложности пленка перед"`
	Complexity_film_back fields.ValInt `json:"complexity_film_back" alias:"Класс сложности пленка зад"`
	Complexity_glass fields.ValInt `json:"complexity_glass" alias:"Класс сложности замена стекла"`
}

func (o *AutoBody) SetNull() {
	o.Id.SetNull()
	o.Auto_model_id.SetNull()
	o.Name.SetNull()
	o.Year_from.SetNull()
	o.Year_to.SetNull()
	o.Model.SetNull()
	o.Auto_body_door_id.SetNull()
	o.Auto_body_type_id.SetNull()
	o.Auto_price_category_id.SetNull()
	o.Auto_body_size.SetNull()
	o.Complexity_film_body.SetNull()
	o.Complexity_film_front.SetNull()
	o.Complexity_film_back.SetNull()
	o.Complexity_glass.SetNull()
}

func NewModelMD_AutoBody() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoBody{})),
		ID: "AutoBody_Model",
		Relation: "auto_bodies",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type AutoBody_argv struct {
	Argv *AutoBody `json:"argv"`	
}

//Keys for delete/get object
type AutoBody_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoBody_keys_argv struct {
	Argv *AutoBody_keys `json:"argv"`	
}

//old keys for update
type AutoBody_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Принадлежность к модели"`
	Name fields.ValText `json:"name"`
	Year_from fields.ValInt `json:"year_from" alias:"Начало производтва"`
	Year_to fields.ValInt `json:"year_to" alias:"Окончание производтва"`
	Model fields.ValText `json:"model" alias:"Модификация"`
	Auto_body_door_id fields.ValInt `json:"auto_body_door_id" alias:"Двери"`
	Auto_body_type_id fields.ValInt `json:"auto_body_type_id" alias:"Тип"`
	Auto_price_category_id fields.ValInt `json:"auto_price_category_id" alias:"Категория цены"`
	Auto_body_size enums.ValEnum_auto_body_sizes `json:"auto_body_size" alias:"Размер кузова"`
	Complexity_film_body fields.ValInt `json:"complexity_film_body" alias:"Класс сложности пленка кузов"`
	Complexity_film_front fields.ValInt `json:"complexity_film_front" alias:"Класс сложности пленка перед"`
	Complexity_film_back fields.ValInt `json:"complexity_film_back" alias:"Класс сложности пленка зад"`
	Complexity_glass fields.ValInt `json:"complexity_glass" alias:"Класс сложности замена стекла"`
}

type AutoBody_old_keys_argv struct {
	Argv *AutoBody_old_keys `json:"argv"`	
}

