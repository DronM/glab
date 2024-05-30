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

type AutoToGlassMatchEurocodeList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_to_glass_match_head_id fields.ValInt `json:"auto_to_glass_match_head_id"`
	User_code fields.ValText `json:"user_code" alias:"Код, введенный пользователем"`
	Auto_bodies_list fields.ValJSON `json:"auto_bodies_list" alias:"Кузовы"`
}

func (o *AutoToGlassMatchEurocodeList) SetNull() {
	o.Id.SetNull()
	o.Auto_to_glass_match_head_id.SetNull()
	o.User_code.SetNull()
	o.Auto_bodies_list.SetNull()
}

func NewModelMD_AutoToGlassMatchEurocodeList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoToGlassMatchEurocodeList{})),
		ID: "AutoToGlassMatchEurocodeList_Model",
		Relation: "auto_to_glass_match_eurocodes_list",
	}
}
