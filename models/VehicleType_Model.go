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

type VehicleType struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
	Code fields.ValInt `json:"code" required:"true" alias:"Код для сортировки" defOrder:"ASC"`
}

func (o *VehicleType) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Code.SetNull()
}

func NewModelMD_VehicleType() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(VehicleType{})),
		ID: "VehicleType_Model",
		Relation: "vehicle_types",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type VehicleType_argv struct {
	Argv *VehicleType `json:"argv"`	
}

//Keys for delete/get object
type VehicleType_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type VehicleType_keys_argv struct {
	Argv *VehicleType_keys `json:"argv"`	
}

//old keys for update
type VehicleType_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Code fields.ValInt `json:"code" alias:"Код для сортировки"`
}

type VehicleType_old_keys_argv struct {
	Argv *VehicleType_old_keys `json:"argv"`	
}

