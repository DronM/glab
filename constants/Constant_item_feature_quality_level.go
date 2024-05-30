package constants

/**
 * Andrey Mikhalevich 20/12/21
 * This file is part of the OSBE framework
 * 
 * This file is generated from the template build/templates/constant.go.tmpl
 * All direct modification will be lost with the next build.
 * Edit template instead.
*/

import (
	"github.com/dronm/gobizap"
)

type Constant_item_feature_quality_level struct {
	gobizap.ConstantJSON
}

func New_Constant_item_feature_quality_level() *Constant_item_feature_quality_level {
	return &Constant_item_feature_quality_level{ gobizap.ConstantJSON{ID: "item_feature_quality_level", Autoload: false }}
}

