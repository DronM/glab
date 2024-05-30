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

type AutoToGlassMatchHead struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата"`
	User_id fields.ValInt `json:"user_id" alias:"Пользователь"`
}

func (o *AutoToGlassMatchHead) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.User_id.SetNull()
}

func NewModelMD_AutoToGlassMatchHead() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoToGlassMatchHead{})),
		ID: "AutoToGlassMatchHead_Model",
		Relation: "auto_to_glass_match_heads",
	}
}
//for insert
type AutoToGlassMatchHead_argv struct {
	Argv *AutoToGlassMatchHead `json:"argv"`	
}

//Keys for delete/get object
type AutoToGlassMatchHead_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoToGlassMatchHead_keys_argv struct {
	Argv *AutoToGlassMatchHead_keys `json:"argv"`	
}

//old keys for update
type AutoToGlassMatchHead_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата"`
	User_id fields.ValInt `json:"user_id" alias:"Пользователь"`
}

type AutoToGlassMatchHead_old_keys_argv struct {
	Argv *AutoToGlassMatchHead_old_keys `json:"argv"`	
}

