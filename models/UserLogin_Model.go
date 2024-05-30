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

type UserLogin struct {
	Id fields.ValInt `json:"id" primaryKey:"true" alias:"Код"`
	Name fields.ValText `json:"name" alias:"Имя"`
	Role_id fields.ValText `json:"role_id"`
	Create_dt fields.ValDateTimeTZ `json:"create_dt"`
	Banned fields.ValBool `json:"banned"`
	Time_zone_locales_ref fields.ValJSON `json:"time_zone_locales_ref"`
	Locale_id fields.ValText `json:"locale_id"`
	Pwd fields.ValText `json:"pwd"`
	Ban_hash fields.ValText `json:"ban_hash"`
}

func (o *UserLogin) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Role_id.SetNull()
	o.Create_dt.SetNull()
	o.Banned.SetNull()
	o.Time_zone_locales_ref.SetNull()
	o.Locale_id.SetNull()
	o.Pwd.SetNull()
	o.Ban_hash.SetNull()
}

func NewModelMD_UserLogin() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(UserLogin{})),
		ID: "UserLogin_Model",
		Relation: "users_login",
	}
}
