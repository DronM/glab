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

type CashFlowInOutList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" defOrder:"DESC"`
	Cash_location_id fields.ValInt `json:"cash_location_id"`
	Cash_location_descr fields.ValText `json:"cash_location_descr" defOrder:"DESC"`
	Fin_expense_types1_descr fields.ValText `json:"fin_expense_types1_descr"`
	Fin_expense_types2_descr fields.ValText `json:"fin_expense_types2_descr"`
	Fin_expense_types3_descr fields.ValText `json:"fin_expense_types3_descr"`
	Total_bal_start fields.ValFloat `json:"total_bal_start"`
	Total_in fields.ValFloat `json:"total_in"`
	Total_out fields.ValFloat `json:"total_out"`
	Total_transfer fields.ValFloat `json:"total_transfer"`
	Total_bal_end fields.ValFloat `json:"total_bal_end"`
}

func (o *CashFlowInOutList) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Cash_location_id.SetNull()
	o.Cash_location_descr.SetNull()
	o.Fin_expense_types1_descr.SetNull()
	o.Fin_expense_types2_descr.SetNull()
	o.Fin_expense_types3_descr.SetNull()
	o.Total_bal_start.SetNull()
	o.Total_in.SetNull()
	o.Total_out.SetNull()
	o.Total_transfer.SetNull()
	o.Total_bal_end.SetNull()
}

func NewModelMD_CashFlowInOutList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowInOutList{})),
		ID: "CashFlowInOutList_Model",
		Relation: "cash_flow_in_out_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
