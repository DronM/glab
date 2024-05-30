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

type AutoModelGeneration_gen_next_id struct {
	Model_id fields.ValInt `json:"model_id"`
	Eurocode fields.ValText `json:"eurocode"`
}

type AutoModelGeneration_gen_next_id_argv struct {
	Argv *AutoModelGeneration_gen_next_id `json:"argv"`	
}

