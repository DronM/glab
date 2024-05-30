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

type AutoModelList struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Auto_make_id fields.ValInt `json:"auto_make_id"`
	Auto_makes_ref fields.ValJSON `json:"auto_makes_ref"`
	Name fields.ValText `json:"name"`
	Name_variants fields.ValText `json:"name_variants"`
	Popularity_type_id fields.ValInt `json:"popularity_type_id" sysCol:"true"`
	Vehicle_type_id fields.ValInt `json:"vehicle_type_id" sysCol:"true"`
	Popularity_types_ref fields.ValJSON `json:"popularity_types_ref" alias:"Популярность"`
	Vehicle_types_ref fields.ValJSON `json:"vehicle_types_ref" alias:"Тип ТС"`
	Model_generation_count fields.ValInt `json:"model_generation_count" alias:"Количество поколений"`
	Body_count fields.ValInt `json:"body_count" alias:"Количество кузовов"`
}

func (o *AutoModelList) SetNull() {
	o.Id.SetNull()
	o.Auto_make_id.SetNull()
	o.Auto_makes_ref.SetNull()
	o.Name.SetNull()
	o.Name_variants.SetNull()
	o.Popularity_type_id.SetNull()
	o.Vehicle_type_id.SetNull()
	o.Popularity_types_ref.SetNull()
	o.Vehicle_types_ref.SetNull()
	o.Model_generation_count.SetNull()
	o.Body_count.SetNull()
}

func NewModelMD_AutoModelList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoModelList{})),
		ID: "AutoModelList_Model",
		Relation: "auto_models_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
