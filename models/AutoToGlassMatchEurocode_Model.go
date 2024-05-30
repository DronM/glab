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

type AutoToGlassMatchEurocode struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Auto_to_glass_match_head_id fields.ValInt `json:"auto_to_glass_match_head_id"`
	Auto_bodies_list fields.ValArray `json:"auto_bodies_list" alias:"Кузовы"`
	User_code fields.ValText `json:"user_code" required:"true" alias:"Код, введенный пользователем"`
}

func (o *AutoToGlassMatchEurocode) SetNull() {
	o.Id.SetNull()
	o.Auto_to_glass_match_head_id.SetNull()
	o.Auto_bodies_list.SetNull()
	o.User_code.SetNull()
}

func NewModelMD_AutoToGlassMatchEurocode() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoToGlassMatchEurocode{})),
		ID: "AutoToGlassMatchEurocode_Model",
		Relation: "auto_to_glass_match_eurocodes",
	}
}
//for insert
type AutoToGlassMatchEurocode_argv struct {
	Argv *AutoToGlassMatchEurocode `json:"argv"`	
}

//Keys for delete/get object
type AutoToGlassMatchEurocode_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoToGlassMatchEurocode_keys_argv struct {
	Argv *AutoToGlassMatchEurocode_keys `json:"argv"`	
}

//old keys for update
type AutoToGlassMatchEurocode_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Auto_to_glass_match_head_id fields.ValInt `json:"auto_to_glass_match_head_id"`
	Auto_bodies_list fields.ValArray `json:"auto_bodies_list" alias:"Кузовы"`
	User_code fields.ValText `json:"user_code" alias:"Код, введенный пользователем"`
}

type AutoToGlassMatchEurocode_old_keys_argv struct {
	Argv *AutoToGlassMatchEurocode_old_keys `json:"argv"`	
}

