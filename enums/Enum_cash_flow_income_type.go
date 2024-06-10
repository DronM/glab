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

type ValEnum_cash_flow_income_type struct {
	fields.ValText
}

func (e *ValEnum_cash_flow_income_type) GetValues() []string {
	return []string{ "cash", "bank" }
}

//func (e *ValEnum_cash_flow_income_type) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "cash", "bank" }
//}

