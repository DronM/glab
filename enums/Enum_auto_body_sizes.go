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

type ValEnum_auto_body_sizes struct {
	fields.ValText
}

func (e *ValEnum_auto_body_sizes) GetValues() []string {
	return []string{ "small", "middle", "large", "extra_large" }
}

//func (e *ValEnum_auto_body_sizes) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "small", "middle", "large", "extra_large" }
//}

