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

type ValEnum_quality_levels struct {
	fields.ValText
}

func (e *ValEnum_quality_levels) GetValues() []string {
	return []string{ "econom", "standart", "premium" }
}

//func (e *ValEnum_quality_levels) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "econom", "standart", "premium" }
//}

