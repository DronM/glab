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

type ValEnum_object_mod_actions struct {
	fields.ValText
}

func (e *ValEnum_object_mod_actions) GetValues() []string {
	return []string{ "insert", "update", "delete" }
}

//func (e *ValEnum_object_mod_actions) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "insert", "update", "delete" }
//}

