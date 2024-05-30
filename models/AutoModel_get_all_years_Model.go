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

type AutoModel_get_all_years struct {
	Model_id fields.ValInt `json:"model_id" required:"true"`
	Model_generation_id fields.ValInt `json:"model_generation_id"`
}
type AutoModel_get_all_years_argv struct {
	Argv *AutoModel_get_all_years `json:"argv"`	
}

