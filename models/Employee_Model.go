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

type Employee struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" required:"true"`
	Birth_date fields.ValDate `json:"birth_date"`
	Department_id fields.ValInt `json:"department_id"`
	Qualification fields.ValInt `json:"qualification"`
	Driving_lic_cat fields.ValJSON `json:"driving_lic_cat" alias:"Категории вод.удост."`
	Expirience fields.ValJSON `json:"expirience" alias:"Стаж"`
	Staff fields.ValBool `json:"staff" alias:"Штатный сотрудник"`
	Card_bank_id fields.ValInt `json:"card_bank_id"`
	Children fields.ValJSON `json:"children" alias:"Дети"`
	Alimony fields.ValBool `json:"alimony" alias:"Алименты"`
	Cloth fields.ValJSON `json:"cloth" alias:"Одежда"`
	Contact_id fields.ValInt `json:"contact_id"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	Sort_index fields.ValInt `json:"sort_index" alias:"Индекс сортировки"`
}

func (o *Employee) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Birth_date.SetNull()
	o.Department_id.SetNull()
	o.Qualification.SetNull()
	o.Driving_lic_cat.SetNull()
	o.Expirience.SetNull()
	o.Staff.SetNull()
	o.Card_bank_id.SetNull()
	o.Children.SetNull()
	o.Alimony.SetNull()
	o.Cloth.SetNull()
	o.Contact_id.SetNull()
	o.Comment_text.SetNull()
	o.Sort_index.SetNull()
}

func NewModelMD_Employee() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(Employee{})),
		ID: "Employee_Model",
		Relation: "employees",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type Employee_argv struct {
	Argv *Employee `json:"argv"`	
}

//Keys for delete/get object
type Employee_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type Employee_keys_argv struct {
	Argv *Employee_keys `json:"argv"`	
}

//old keys for update
type Employee_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Name fields.ValText `json:"name"`
	Birth_date fields.ValDate `json:"birth_date"`
	Department_id fields.ValInt `json:"department_id"`
	Qualification fields.ValInt `json:"qualification"`
	Driving_lic_cat fields.ValJSON `json:"driving_lic_cat" alias:"Категории вод.удост."`
	Expirience fields.ValJSON `json:"expirience" alias:"Стаж"`
	Staff fields.ValBool `json:"staff" alias:"Штатный сотрудник"`
	Card_bank_id fields.ValInt `json:"card_bank_id"`
	Children fields.ValJSON `json:"children" alias:"Дети"`
	Alimony fields.ValBool `json:"alimony" alias:"Алименты"`
	Cloth fields.ValJSON `json:"cloth" alias:"Одежда"`
	Contact_id fields.ValInt `json:"contact_id"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	Sort_index fields.ValInt `json:"sort_index" alias:"Индекс сортировки"`
}

type Employee_old_keys_argv struct {
	Argv *Employee_old_keys `json:"argv"`	
}

