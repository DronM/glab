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

type CashFlowTransferList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" defOrder:"DESC"`
	From_cash_location_id fields.ValInt `json:"from_cash_location_id"`
	From_cash_locations_ref fields.ValJSON `json:"from_cash_locations_ref"`
	To_cash_location_id fields.ValInt `json:"to_cash_location_id"`
	To_cash_locations_ref fields.ValJSON `json:"to_cash_locations_ref"`
	Comment_text fields.ValText `json:"comment_text" alias:"Комментарий"`
	Users_ref fields.ValJSON `json:"users_ref"`
	Total fields.ValFloat `json:"total"`
}

func (o *CashFlowTransferList) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.From_cash_location_id.SetNull()
	o.From_cash_locations_ref.SetNull()
	o.To_cash_location_id.SetNull()
	o.To_cash_locations_ref.SetNull()
	o.Comment_text.SetNull()
	o.Users_ref.SetNull()
	o.Total.SetNull()
}

func NewModelMD_CashFlowTransferList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowTransferList{})),
		ID: "CashFlowTransferList_Model",
		Relation: "cash_flow_transfer_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "total_total", Expr: "sum(total)"},
&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
