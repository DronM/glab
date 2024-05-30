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

type BankFlowIn_get_report struct {
	Templ fields.ValText `json:"templ"`
	Inline fields.ValInt `json:"inline"`
}

type BankFlowIn_get_report_argv struct {
	Argv *BankFlowIn_get_report `json:"argv"`	
}

