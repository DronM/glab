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

type BankFlowIn_apply_rules struct {
	Operation_id fields.ValText `json:"operation_id" required:"true"`
}

type BankFlowIn_apply_rules_argv struct {
	Argv *BankFlowIn_apply_rules `json:"argv"`	
}

