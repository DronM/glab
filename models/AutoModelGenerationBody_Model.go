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

type AutoModelGenerationBody struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Поколение"`
	Auto_body_id fields.ValInt `json:"auto_body_id" alias:"Кузов"`
	Eurocode fields.ValText `json:"eurocode" alias:"Еврокод"`
	Local_id fields.ValText `json:"local_id" alias:"Внутренний код ID"`
}

func (o *AutoModelGenerationBody) SetNull() {
	o.Id.SetNull()
	o.Auto_model_generation_id.SetNull()
	o.Auto_body_id.SetNull()
	o.Eurocode.SetNull()
	o.Local_id.SetNull()
}

func NewModelMD_AutoModelGenerationBody() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoModelGenerationBody{})),
		ID: "AutoModelGenerationBody_Model",
		Relation: "auto_model_generation_bodies",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type AutoModelGenerationBody_argv struct {
	Argv *AutoModelGenerationBody `json:"argv"`	
}

//Keys for delete/get object
type AutoModelGenerationBody_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoModelGenerationBody_keys_argv struct {
	Argv *AutoModelGenerationBody_keys `json:"argv"`	
}

//old keys for update
type AutoModelGenerationBody_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Поколение"`
	Auto_body_id fields.ValInt `json:"auto_body_id" alias:"Кузов"`
	Eurocode fields.ValText `json:"eurocode" alias:"Еврокод"`
	Local_id fields.ValText `json:"local_id" alias:"Внутренний код ID"`
}

type AutoModelGenerationBody_old_keys_argv struct {
	Argv *AutoModelGenerationBody_old_keys `json:"argv"`	
}

