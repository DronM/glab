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

type CashFlowOutList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" defOrder:"DESC"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Cash_locations_ref fields.ValJSON `json:"cash_locations_ref"`
	Fin_expense_types1_ref fields.ValJSON `json:"fin_expense_types1_ref"`
	Fin_expense_types2_ref fields.ValJSON `json:"fin_expense_types2_ref"`
	Fin_expense_types3_ref fields.ValJSON `json:"fin_expense_types3_ref"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	Comment_text2 fields.ValText `json:"comment_text2" alias:"Комментарий"`
	Users_ref fields.ValJSON `json:"users_ref"`
	Total fields.ValFloat `json:"total"`
}

func (o *CashFlowOutList) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Cash_location_id.SetNull()
	o.Cash_locations_ref.SetNull()
	o.Fin_expense_types1_ref.SetNull()
	o.Fin_expense_types2_ref.SetNull()
	o.Fin_expense_types3_ref.SetNull()
	o.Comment_text.SetNull()
	o.Comment_text2.SetNull()
	o.Users_ref.SetNull()
	o.Total.SetNull()
}

func NewModelMD_CashFlowOutList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowOutList{})),
		ID: "CashFlowOutList_Model",
		Relation: "cash_flow_out_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "total_total", Expr: "sum(total)"},
&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
