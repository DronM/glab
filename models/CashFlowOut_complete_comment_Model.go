package models

/**
 * Andrey Mikhalevich 16/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/models/Model.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

//Controller method model
import (
		
	"github.com/dronm/gobizap/fields"
)

type CashFlowOut_complete_comment struct {
	Comment_text fields.ValText `json:"comment_text"`
	Fin_expense_type2_id fields.ValInt `json:"fin_expense_type2_id"`
	Ic fields.ValInt `json:"ic"`
	Mid fields.ValInt `json:"mid"`
	Count fields.ValInt `json:"count"`
	Ord_directs fields.ValText `json:"ord_directs"`
}

type CashFlowOut_complete_comment_argv struct {
	Argv *CashFlowOut_complete_comment `json:"argv"`	
}

