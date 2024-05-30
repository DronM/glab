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

type AutoModel_complete_for_make struct {
	Name fields.ValText `json:"name"`
	Make_id fields.ValInt `json:"make_id" required:"true"`
	Ic fields.ValInt `json:"ic"`
	Mid fields.ValInt `json:"mid"`
	Count fields.ValInt `json:"count"`
	Ord_directs fields.ValText `json:"ord_directs"`
}
type AutoModel_complete_for_make_argv struct {
	Argv *AutoModel_complete_for_make `json:"argv"`	
}

