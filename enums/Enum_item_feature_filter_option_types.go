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

type ValEnum_item_feature_filter_option_types struct {
	fields.ValText
}

func (e *ValEnum_item_feature_filter_option_types) GetValues() []string {
	return []string{ "main", "additional", "distinctive" }
}

//func (e *ValEnum_item_feature_filter_option_types) GetDescriptions() map[string]map[string]string {
//	return make(map[string]{ "main", "additional", "distinctive" }
//}

