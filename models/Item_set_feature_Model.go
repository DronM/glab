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

type Item_set_feature struct {
	Feature_id fields.ValInt `json:"feature_id" required:"true"`
	Item_id fields.ValInt `json:"item_id" required:"true"`
	Val fields.ValText `json:"val"`
}
type Item_set_feature_argv struct {
	Argv *Item_set_feature `json:"argv"`	
}

