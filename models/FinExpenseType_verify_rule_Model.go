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

type FinExpenseType_verify_rule struct {
	Rule fields.ValText `json:"rule" required:"true"`
}

type FinExpenseType_verify_rule_argv struct {
	Argv *FinExpenseType_verify_rule `json:"argv"`	
}

