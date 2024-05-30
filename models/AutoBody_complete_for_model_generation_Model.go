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

type AutoBody_complete_for_model_generation struct {
	Model_id fields.ValInt `json:"model_id"`
	Model_generation_id fields.ValInt `json:"model_generation_id"`
	Descr fields.ValText `json:"descr"`
	Ic fields.ValInt `json:"ic"`
	Mid fields.ValInt `json:"mid"`
	Count fields.ValInt `json:"count"`
	Ord_directs fields.ValText `json:"ord_directs"`
}
type AutoBody_complete_for_model_generation_argv struct {
	Argv *AutoBody_complete_for_model_generation `json:"argv"`	
}

