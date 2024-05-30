package models

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/models/Model.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

import (
	"reflect"	
		
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type AutoPriceCategory struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Price_from fields.ValFloat `json:"price_from" alias:"Цена от" defOrder:"ASC"`
	Price_to fields.ValFloat `json:"price_to" alias:"Цена до"`
}

func (o *AutoPriceCategory) SetNull() {
	o.Id.SetNull()
	o.Price_from.SetNull()
	o.Price_to.SetNull()
}

func NewModelMD_AutoPriceCategory() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoPriceCategory{})),
		ID: "AutoPriceCategory_Model",
		Relation: "auto_price_categories",
	}
}
//for insert
type AutoPriceCategory_argv struct {
	Argv *AutoPriceCategory `json:"argv"`	
}

//Keys for delete/get object
type AutoPriceCategory_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoPriceCategory_keys_argv struct {
	Argv *AutoPriceCategory_keys `json:"argv"`	
}

//old keys for update
type AutoPriceCategory_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Price_from fields.ValFloat `json:"price_from" alias:"Цена от"`
	Price_to fields.ValFloat `json:"price_to" alias:"Цена до"`
}

type AutoPriceCategory_old_keys_argv struct {
	Argv *AutoPriceCategory_old_keys `json:"argv"`	
}

