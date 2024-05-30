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

type EmployeeList struct {
	Id fields.ValInt `json:"id" primaryKey:"true"`
	Name fields.ValText `json:"name"`
	Birth_date fields.ValDate `json:"birth_date"`
	Departments_ref fields.ValJSON `json:"departments_ref"`
	Posts_ref fields.ValJSON `json:"posts_ref"`
	Qualification fields.ValInt `json:"qualification"`
	Driving_lic_cat fields.ValJSON `json:"driving_lic_cat" alias:"Категории вод.удост."`
	Expirience fields.ValJSON `json:"expirience" alias:"Стаж"`
	Staff fields.ValBool `json:"staff" alias:"Штатный сотрудник"`
	Card_banks_ref fields.ValJSON `json:"card_banks_ref"`
	Children fields.ValJSON `json:"children" alias:"Дети"`
	Alimony fields.ValBool `json:"alimony" alias:"Алименты"`
	Cloth fields.ValJSON `json:"cloth" alias:"Одежда"`
	Contacts_ref fields.ValJSON `json:"contacts_ref"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
}

func (o *EmployeeList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Birth_date.SetNull()
	o.Departments_ref.SetNull()
	o.Posts_ref.SetNull()
	o.Qualification.SetNull()
	o.Driving_lic_cat.SetNull()
	o.Expirience.SetNull()
	o.Staff.SetNull()
	o.Card_banks_ref.SetNull()
	o.Children.SetNull()
	o.Alimony.SetNull()
	o.Cloth.SetNull()
	o.Contacts_ref.SetNull()
	o.Comment_text.SetNull()
}

func NewModelMD_EmployeeList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(EmployeeList{})),
		ID: "EmployeeList_Model",
		Relation: "employees_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
