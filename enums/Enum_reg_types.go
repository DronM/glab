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

type ValEnum_reg_types struct {
	fields.ValText
}

func (e *ValEnum_reg_types) GetValues() []string {
	return []string{ "cash_flow", "bank_flow" }
}

//func (e *ValEnum_reg_types) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "cash_flow", "bank_flow" }
//}

