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

type ContactDialog struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Name fields.ValText `json:"name"`
	Posts_ref fields.ValJSON `json:"posts_ref"`
	Email fields.ValText `json:"email"`
	Tel fields.ValText `json:"tel"`
	Tel_ext fields.ValText `json:"tel_ext"`
	Comment_text fields.ValText `json:"comment_text"`
	Tm_exists fields.ValBool `json:"tm_exists"`
	Tm_activated fields.ValBool `json:"tm_activated"`
	Tm_photo fields.ValText `json:"tm_photo"`
	Ext_id fields.ValInt `json:"ext_id"`
	Tm_first_name fields.ValText `json:"tm_first_name"`
}

func (o *ContactDialog) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Posts_ref.SetNull()
	o.Email.SetNull()
	o.Tel.SetNull()
	o.Tel_ext.SetNull()
	o.Comment_text.SetNull()
	o.Tm_exists.SetNull()
	o.Tm_activated.SetNull()
	o.Tm_photo.SetNull()
	o.Ext_id.SetNull()
	o.Tm_first_name.SetNull()
}

func NewModelMD_ContactDialog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ContactDialog{})),
		ID: "ContactDialog_Model",
		Relation: "contacts_dialog",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
		LimitConstant: "doc_per_page_count",
	}
}
//for insert
type ContactDialog_argv struct {
	Argv *ContactDialog `json:"argv"`	
}

//Keys for delete/get object
type ContactDialog_keys struct {
	Id fields.ValInt `json:"id"`
}
type ContactDialog_keys_argv struct {
	Argv *ContactDialog_keys `json:"argv"`	
}

//old keys for update
type ContactDialog_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
	Posts_ref fields.ValJSON `json:"posts_ref"`
	Email fields.ValText `json:"email"`
	Tel fields.ValText `json:"tel"`
	Tel_ext fields.ValText `json:"tel_ext"`
	Comment_text fields.ValText `json:"comment_text"`
	Tm_exists fields.ValBool `json:"tm_exists"`
	Tm_activated fields.ValBool `json:"tm_activated"`
	Tm_photo fields.ValText `json:"tm_photo"`
	Ext_id fields.ValInt `json:"ext_id"`
	Tm_first_name fields.ValText `json:"tm_first_name"`
}

type ContactDialog_old_keys_argv struct {
	Argv *ContactDialog_old_keys `json:"argv"`	
}

