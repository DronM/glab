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

type AutoModelGenerationBodyList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" sysCol:"true"`
	Auto_bodies_ref fields.ValJSON `json:"auto_bodies_ref" alias:"Кузов"`
	Eurocode fields.ValText `json:"eurocode" alias:"Еврокод"`
	Local_id fields.ValText `json:"local_id" alias:"Внутренний код ID"`
}

func (o *AutoModelGenerationBodyList) SetNull() {
	o.Id.SetNull()
	o.Auto_model_generation_id.SetNull()
	o.Auto_bodies_ref.SetNull()
	o.Eurocode.SetNull()
	o.Local_id.SetNull()
}

func NewModelMD_AutoModelGenerationBodyList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoModelGenerationBodyList{})),
		ID: "AutoModelGenerationBodyList_Model",
		Relation: "auto_model_generation_bodies_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
