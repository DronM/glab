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

type ContactList struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Name fields.ValText `json:"name"`
	Posts_ref fields.ValJSON `json:"posts_ref"`
	Email fields.ValText `json:"email"`
	Tel fields.ValText `json:"tel"`
	Tel_ext fields.ValText `json:"tel_ext"`
	Descr fields.ValText `json:"descr" defOrder:"ASC"`
	Comment_text fields.ValText `json:"comment_text"`
	Tm_photo fields.ValText `json:"tm_photo"`
	Tm_first_name fields.ValText `json:"tm_first_name"`
	Tm_exists fields.ValBool `json:"tm_exists"`
	Tm_activated fields.ValBool `json:"tm_activated"`
	Ext_id fields.ValInt `json:"ext_id"`
}

func (o *ContactList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Posts_ref.SetNull()
	o.Email.SetNull()
	o.Tel.SetNull()
	o.Tel_ext.SetNull()
	o.Descr.SetNull()
	o.Comment_text.SetNull()
	o.Tm_photo.SetNull()
	o.Tm_first_name.SetNull()
	o.Tm_exists.SetNull()
	o.Tm_activated.SetNull()
	o.Ext_id.SetNull()
}

func NewModelMD_ContactList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ContactList{})),
		ID: "ContactList_Model",
		Relation: "contacts_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
		LimitConstant: "doc_per_page_count",
	}
}
//for insert
type ContactList_argv struct {
	Argv *ContactList `json:"argv"`	
}

//Keys for delete/get object
type ContactList_keys struct {
	Id fields.ValInt `json:"id"`
}
type ContactList_keys_argv struct {
	Argv *ContactList_keys `json:"argv"`	
}

//old keys for update
type ContactList_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
	Posts_ref fields.ValJSON `json:"posts_ref"`
	Email fields.ValText `json:"email"`
	Tel fields.ValText `json:"tel"`
	Tel_ext fields.ValText `json:"tel_ext"`
	Descr fields.ValText `json:"descr"`
	Comment_text fields.ValText `json:"comment_text"`
	Tm_photo fields.ValText `json:"tm_photo"`
	Tm_first_name fields.ValText `json:"tm_first_name"`
	Tm_exists fields.ValBool `json:"tm_exists"`
	Tm_activated fields.ValBool `json:"tm_activated"`
	Ext_id fields.ValInt `json:"ext_id"`
}

type ContactList_old_keys_argv struct {
	Argv *ContactList_old_keys `json:"argv"`	
}

