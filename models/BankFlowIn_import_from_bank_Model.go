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

type BankFlowIn_import_from_bank struct {
	Bank_file fields.ValText `json:"bank_file"`
	Operation_id fields.ValText `json:"operation_id" required:"true"`
}

type BankFlowIn_import_from_bank_argv struct {
	Argv *BankFlowIn_import_from_bank `json:"argv"`	
}

