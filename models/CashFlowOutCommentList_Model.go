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

type CashFlowOutCommentList struct {
	Comment_text fields.ValText `json:"comment_text" primaryKey:"true"`
}

func (o *CashFlowOutCommentList) SetNull() {
	o.Comment_text.SetNull()
}

func NewModelMD_CashFlowOutCommentList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(CashFlowOutCommentList{})),
		ID: "CashFlowOutCommentList_Model",
		Relation: "cash_flow_out_comment_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
