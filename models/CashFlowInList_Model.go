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

type CashFlowInList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата" defOrder:"DESC"`
	Cash_location_id fields.ValInt `json:"cash_location_id" sysCol:"true"`
	Cash_locations_ref fields.ValJSON `json:"cash_locations_ref" alias:"Касса"`
	Cash_flow_income_type fields.ValText `json:"cash_flow_income_type" alias:"Тип"`
	Cash_income_sources_ref fields.ValJSON `json:"cash_income_sources_ref" alias:"Источник прихода" sysCol:"true"`
	Cash_income_sources_descr fields.ValText `json:"cash_income_sources_descr" alias:"Источник прихода"`
	Cash_income_source_id fields.ValInt `json:"cash_income_source_id" alias:"Источник прихода" sysCol:"true"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	Users_ref fields.ValJSON `json:"users_ref" alias:"Пользователь"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

func (o *CashFlowInList) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Cash_location_id.SetNull()
	o.Cash_locations_ref.SetNull()
	o.Cash_flow_income_type.SetNull()
	o.Cash_income_sources_ref.SetNull()
	o.Cash_income_sources_descr.SetNull()
	o.Cash_income_source_id.SetNull()
	o.Comment_text.SetNull()
	o.Users_ref.SetNull()
	o.Total.SetNull()
}

func NewModelMD_CashFlowInList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowInList{})),
		ID: "CashFlowInList_Model",
		Relation: "cash_flow_in_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "total_total", Expr: "sum(total)"},
&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
