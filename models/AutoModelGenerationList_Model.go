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

type AutoModelGenerationList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Марка"`
	Auto_makes_ref fields.ValJSON `json:"auto_makes_ref"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Модель"`
	Auto_models_ref fields.ValJSON `json:"auto_models_ref"`
	Generation_num fields.ValText `json:"generation_num" alias:"Номер поколения"`
	Prod_index fields.ValText `json:"prod_index" alias:"Заводской индекс модели"`
	Year_from fields.ValInt `json:"year_from" alias:"Начало производтва"`
	Year_to fields.ValInt `json:"year_to" alias:"Окончание производтва"`
	Model fields.ValText `json:"model" alias:"Модификация"`
	Series fields.ValText `json:"series" alias:"Серия"`
	Name fields.ValText `json:"name" alias:"Название"`
	Body_count fields.ValInt `json:"body_count" alias:"Количество кузовов"`
}

func (o *AutoModelGenerationList) SetNull() {
	o.Id.SetNull()
	o.Auto_make_id.SetNull()
	o.Auto_makes_ref.SetNull()
	o.Auto_model_id.SetNull()
	o.Auto_models_ref.SetNull()
	o.Generation_num.SetNull()
	o.Prod_index.SetNull()
	o.Year_from.SetNull()
	o.Year_to.SetNull()
	o.Model.SetNull()
	o.Series.SetNull()
	o.Name.SetNull()
	o.Body_count.SetNull()
}

func NewModelMD_AutoModelGenerationList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoModelGenerationList{})),
		ID: "AutoModelGenerationList_Model",
		Relation: "auto_model_generations_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
