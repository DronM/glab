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

type Item_complete_item struct {
	Make_id fields.ValInt `json:"make_id"`
	Model_id fields.ValInt `json:"model_id"`
	Model_generation_id fields.ValInt `json:"model_generation_id"`
	Body_id fields.ValInt `json:"body_id"`
	Item_folder_id fields.ValInt `json:"item_folder_id"`
	Descr fields.ValText `json:"descr"`
	Ic fields.ValInt `json:"ic"`
	Mid fields.ValInt `json:"mid"`
	Count fields.ValInt `json:"count"`
	Ord_directs fields.ValText `json:"ord_directs"`
}
type Item_complete_item_argv struct {
	Argv *Item_complete_item `json:"argv"`	
}

