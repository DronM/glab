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

type Department struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"Код"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

func (o *Department) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_Department() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(Department{})),
		ID: "Department_Model",
		Relation: "departments",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type Department_argv struct {
	Argv *Department `json:"argv"`	
}

//Keys for delete/get object
type Department_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type Department_keys_argv struct {
	Argv *Department_keys `json:"argv"`	
}

//old keys for update
type Department_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"Код"`
	Id fields.ValInt `json:"id" alias:"Код"`
	Name fields.ValText `json:"name" alias:"Наименование"`
}

type Department_old_keys_argv struct {
	Argv *Department_old_keys `json:"argv"`	
}

