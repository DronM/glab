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

type PersonDocument struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Employee_id fields.ValInt `json:"employee_id"`
	Person_document_type_id fields.ValInt `json:"person_document_type_id"`
}

func (o *PersonDocument) SetNull() {
	o.Id.SetNull()
	o.Employee_id.SetNull()
	o.Person_document_type_id.SetNull()
}

func NewModelMD_PersonDocument() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(PersonDocument{})),
		ID: "PersonDocument_Model",
		Relation: "person_documents",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type PersonDocument_argv struct {
	Argv *PersonDocument `json:"argv"`	
}

//Keys for delete/get object
type PersonDocument_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type PersonDocument_keys_argv struct {
	Argv *PersonDocument_keys `json:"argv"`	
}

//old keys for update
type PersonDocument_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Employee_id fields.ValInt `json:"employee_id"`
	Person_document_type_id fields.ValInt `json:"person_document_type_id"`
}

type PersonDocument_old_keys_argv struct {
	Argv *PersonDocument_old_keys `json:"argv"`	
}

