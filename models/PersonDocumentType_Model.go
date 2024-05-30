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

type PersonDocumentType struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true"`
}

func (o *PersonDocumentType) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
}

func NewModelMD_PersonDocumentType() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(PersonDocumentType{})),
		ID: "PersonDocumentType_Model",
		Relation: "person_document_types",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type PersonDocumentType_argv struct {
	Argv *PersonDocumentType `json:"argv"`	
}

//Keys for delete/get object
type PersonDocumentType_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type PersonDocumentType_keys_argv struct {
	Argv *PersonDocumentType_keys `json:"argv"`	
}

//old keys for update
type PersonDocumentType_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
}

type PersonDocumentType_old_keys_argv struct {
	Argv *PersonDocumentType_old_keys `json:"argv"`	
}

