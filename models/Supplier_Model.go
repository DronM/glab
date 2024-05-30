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
	"glab/enums"	
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type Supplier struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
	Quality_level enums.ValEnum_quality_levels `json:"quality_level" required:"true" alias:"Уровень качества"`
}

func (o *Supplier) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Quality_level.SetNull()
}

func NewModelMD_Supplier() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(Supplier{})),
		ID: "Supplier_Model",
		Relation: "suppliers",
	}
}
//for insert
type Supplier_argv struct {
	Argv *Supplier `json:"argv"`	
}

//Keys for delete/get object
type Supplier_keys struct {
	Id fields.ValInt `json:"id"`
}
type Supplier_keys_argv struct {
	Argv *Supplier_keys `json:"argv"`	
}

//old keys for update
type Supplier_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Quality_level enums.ValEnum_quality_levels `json:"quality_level" alias:"Уровень качества"`
}

type Supplier_old_keys_argv struct {
	Argv *Supplier_old_keys `json:"argv"`	
}

