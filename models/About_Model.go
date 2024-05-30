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

type About struct {
	Author fields.ValText `json:"author"`
	Tech_mail fields.ValText `json:"tech_mail"`
	App_name fields.ValText `json:"app_name"`
	Fw_version fields.ValText `json:"fw_version"`
	App_version fields.ValText `json:"app_version"`
	Db_name fields.ValText `json:"db_name"`
}

func (o *About) SetNull() {
	o.Author.SetNull()
	o.Tech_mail.SetNull()
	o.App_name.SetNull()
	o.Fw_version.SetNull()
	o.App_version.SetNull()
	o.Db_name.SetNull()
}

func NewModelMD_About() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(About{})),
		ID: "About_Model",
		Relation: "",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
		LimitConstant: "doc_per_page_count",
	}
}
