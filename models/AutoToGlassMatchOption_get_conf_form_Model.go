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

type AutoToGlassMatchOption_get_conf_form struct {
	Auto_to_glass_match_head_id fields.ValInt `json:"auto_to_glass_match_head_id" required:"true"`
}

type AutoToGlassMatchOption_get_conf_form_argv struct {
	Argv *AutoToGlassMatchOption_get_conf_form `json:"argv"`	
}

