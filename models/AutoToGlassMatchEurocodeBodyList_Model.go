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

type AutoToGlassMatchEurocodeBodyList struct {
	Auto_to_glass_match_head_id fields.ValInt `json:"auto_to_glass_match_head_id"`
	Eurocode_local fields.ValText `json:"eurocode_local" primaryKey:"true" alias:"Полный код"`
	Doors fields.ValText `json:"doors" alias:"Кузов тип дверй"`
	Type fields.ValText `json:"type" alias:"Кузов тип"`
	Model fields.ValText `json:"model" alias:"Кузов модель"`
}

func (o *AutoToGlassMatchEurocodeBodyList) SetNull() {
	o.Auto_to_glass_match_head_id.SetNull()
	o.Eurocode_local.SetNull()
	o.Doors.SetNull()
	o.Type.SetNull()
	o.Model.SetNull()
}

func NewModelMD_AutoToGlassMatchEurocodeBodyList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoToGlassMatchEurocodeBodyList{})),
		ID: "AutoToGlassMatchEurocodeBodyList_Model",
		Relation: "auto_to_glass_match_eurocode_bodies_list",
	}
}
