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

type RACashFlow struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" required:"true" alias:"Период" defOrder:"ASC"`
	Deb fields.ValBool `json:"deb" alias:"Дебет"`
	Doc_type enums.ValEnum_doc_types `json:"doc_type" required:"true" alias:"Вид документа"`
	Doc_id fields.ValInt `json:"doc_id"`
	Cash_location_id fields.ValInt `json:"cash_location_id" required:"true"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

func (o *RACashFlow) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Deb.SetNull()
	o.Doc_type.SetNull()
	o.Doc_id.SetNull()
	o.Cash_location_id.SetNull()
	o.Total.SetNull()
}

func NewModelMD_RACashFlow() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(RACashFlow{})),
		ID: "RACashFlow_Model",
		Relation: "ra_cash_flow",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type RACashFlow_argv struct {
	Argv *RACashFlow `json:"argv"`	
}

//Keys for delete/get object
type RACashFlow_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type RACashFlow_keys_argv struct {
	Argv *RACashFlow_keys `json:"argv"`	
}

//old keys for update
type RACashFlow_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"Код"`
	Id fields.ValInt `json:"id" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" alias:"Период"`
	Deb fields.ValBool `json:"deb" alias:"Дебет"`
	Doc_type enums.ValEnum_doc_types `json:"doc_type" alias:"Вид документа"`
	Doc_id fields.ValInt `json:"doc_id"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

type RACashFlow_old_keys_argv struct {
	Argv *RACashFlow_old_keys `json:"argv"`	
}

