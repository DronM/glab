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

type EmployeeStatus struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Employee_id fields.ValInt `json:"employee_id" required:"true"`
	Status_type enums.ValEnum_employee_status_types `json:"status_type" required:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" required:"true"`
}

func (o *EmployeeStatus) SetNull() {
	o.Id.SetNull()
	o.Employee_id.SetNull()
	o.Status_type.SetNull()
	o.Date_time.SetNull()
}

func NewModelMD_EmployeeStatus() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(EmployeeStatus{})),
		ID: "EmployeeStatus_Model",
		Relation: "employee_statuses",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type EmployeeStatus_argv struct {
	Argv *EmployeeStatus `json:"argv"`	
}

//Keys for delete/get object
type EmployeeStatus_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type EmployeeStatus_keys_argv struct {
	Argv *EmployeeStatus_keys `json:"argv"`	
}

//old keys for update
type EmployeeStatus_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Employee_id fields.ValInt `json:"employee_id"`
	Status_type enums.ValEnum_employee_status_types `json:"status_type"`
	Date_time fields.ValDateTimeTZ `json:"date_time"`
}

type EmployeeStatus_old_keys_argv struct {
	Argv *EmployeeStatus_old_keys `json:"argv"`	
}

