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

type ValEnum_screen_width_types struct {
	fields.ValText
}

func (e *ValEnum_screen_width_types) GetValues() []string {
	return []string{ "sm", "md", "lg" }
}

//func (e *ValEnum_screen_width_types) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "sm", "md", "lg" }
//}

