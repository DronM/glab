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

type AutoBodyList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование кузова"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Модель"`
	Auto_models_ref fields.ValJSON `json:"auto_models_ref" alias:"Модель"`
	Auto_body_type_id fields.ValInt `json:"auto_body_type_id" alias:"Тип кузова идентификатор"`
	Auto_body_types_ref fields.ValJSON `json:"auto_body_types_ref" alias:"Тип кузова"`
	Auto_body_doors_ref fields.ValJSON `json:"auto_body_doors_ref" alias:"Тип дверей кузова"`
	Year_from fields.ValInt `json:"year_from" alias:"Начало производтва"`
	Year_to fields.ValInt `json:"year_to" alias:"Окончание производтва"`
	Model fields.ValText `json:"model" alias:"Модель"`
	Auto_price_categories_ref fields.ValJSON `json:"auto_price_categories_ref" alias:"Категория цены"`
	Auto_body_size fields.ValText `json:"auto_body_size" alias:"Размер кузова"`
	Complexity_film_body fields.ValInt `json:"complexity_film_body" alias:"Класс сложности пленка кузов"`
	Complexity_film_front fields.ValInt `json:"complexity_film_front" alias:"Класс сложности пленка перед"`
	Complexity_film_back fields.ValInt `json:"complexity_film_back" alias:"Класс сложности пленка зад"`
	Complexity_glass fields.ValInt `json:"complexity_glass" alias:"Класс сложности замена стекла"`
}

func (o *AutoBodyList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Auto_model_id.SetNull()
	o.Auto_models_ref.SetNull()
	o.Auto_body_type_id.SetNull()
	o.Auto_body_types_ref.SetNull()
	o.Auto_body_doors_ref.SetNull()
	o.Year_from.SetNull()
	o.Year_to.SetNull()
	o.Model.SetNull()
	o.Auto_price_categories_ref.SetNull()
	o.Auto_body_size.SetNull()
	o.Complexity_film_body.SetNull()
	o.Complexity_film_front.SetNull()
	o.Complexity_film_back.SetNull()
	o.Complexity_glass.SetNull()
}

func NewModelMD_AutoBodyList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoBodyList{})),
		ID: "AutoBodyList_Model",
		Relation: "auto_bodies_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
