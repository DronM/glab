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

type AutoToGlassMatchHeadList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата"`
	User_id fields.ValInt `json:"user_id" sysCol:"true"`
	Users_ref fields.ValJSON `json:"users_ref" alias:"Пользователь"`
	User_code_list fields.ValText `json:"user_code_list" alias:"Коды пользователя"`
	Auto_bodies_list fields.ValJSON `json:"auto_bodies_list" alias:"Коды пользователя"`
}

func (o *AutoToGlassMatchHeadList) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.User_id.SetNull()
	o.Users_ref.SetNull()
	o.User_code_list.SetNull()
	o.Auto_bodies_list.SetNull()
}

func NewModelMD_AutoToGlassMatchHeadList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoToGlassMatchHeadList{})),
		ID: "AutoToGlassMatchHeadList_Model",
		Relation: "auto_to_glass_match_heads_list",
	}
}
