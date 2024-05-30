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

type AutoModelGeneration struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Марка"`
	Generation_num fields.ValText `json:"generation_num" alias:"Номер поколения"`
	Prod_index fields.ValText `json:"prod_index" alias:"Заводской индекс модели"`
	Year_from fields.ValInt `json:"year_from" alias:"Начало производтва"`
	Year_to fields.ValInt `json:"year_to" alias:"Окончание производтва"`
	Model fields.ValText `json:"model" alias:"Модификация"`
	Series fields.ValText `json:"series" alias:"Серия"`
}

func (o *AutoModelGeneration) SetNull() {
	o.Id.SetNull()
	o.Auto_model_id.SetNull()
	o.Generation_num.SetNull()
	o.Prod_index.SetNull()
	o.Year_from.SetNull()
	o.Year_to.SetNull()
	o.Model.SetNull()
	o.Series.SetNull()
}

func NewModelMD_AutoModelGeneration() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoModelGeneration{})),
		ID: "AutoModelGeneration_Model",
		Relation: "auto_model_generations",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type AutoModelGeneration_argv struct {
	Argv *AutoModelGeneration `json:"argv"`	
}

//Keys for delete/get object
type AutoModelGeneration_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoModelGeneration_keys_argv struct {
	Argv *AutoModelGeneration_keys `json:"argv"`	
}

//old keys for update
type AutoModelGeneration_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Марка"`
	Generation_num fields.ValText `json:"generation_num" alias:"Номер поколения"`
	Prod_index fields.ValText `json:"prod_index" alias:"Заводской индекс модели"`
	Year_from fields.ValInt `json:"year_from" alias:"Начало производтва"`
	Year_to fields.ValInt `json:"year_to" alias:"Окончание производтва"`
	Model fields.ValText `json:"model" alias:"Модификация"`
	Series fields.ValText `json:"series" alias:"Серия"`
}

type AutoModelGeneration_old_keys_argv struct {
	Argv *AutoModelGeneration_old_keys `json:"argv"`	
}

