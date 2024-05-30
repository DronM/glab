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

type SupplierStore_complete_for_supplier struct {
	Name fields.ValText `json:"name"`
	Supplier_id fields.ValInt `json:"supplier_id" required:"true"`
	Ic fields.ValInt `json:"ic"`
	Mid fields.ValInt `json:"mid"`
	Count fields.ValInt `json:"count"`
	Ord_directs fields.ValText `json:"ord_directs"`
}

type SupplierStore_complete_for_supplier_argv struct {
	Argv *SupplierStore_complete_for_supplier `json:"argv"`	
}

