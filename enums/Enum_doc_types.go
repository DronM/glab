package enums

/**
 * Andrey Mikhalevich 16/12/21
 * This file is part of the OSBE framework
 * 
 * This file is generated from the template build/templates/enum.go.tmpl
 * All direct modification will be lost with the next build.
 * Edit template instead.
*/

import (
	"github.com/dronm/gobizap/fields"
)

type ValEnum_doc_types struct {
	fields.ValText
}

func (e *ValEnum_doc_types) GetValues() []string {
	return []string{ "cash_flow_in", "cash_flow_out", "cash_flow_transfers", "bank_flow_in", "bank_flow_out" }
}

//func (e *ValEnum_doc_types) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "cash_flow_in", "cash_flow_out", "cash_flow_transfers", "bank_flow_in", "bank_flow_out" }
//}

