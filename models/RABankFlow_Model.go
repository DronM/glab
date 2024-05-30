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
	"glab/enums"	
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

type RABankFlow struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" required:"true" alias:"Период" defOrder:"ASC"`
	Deb fields.ValBool `json:"deb" alias:"Дебет"`
	Doc_type enums.ValEnum_doc_types `json:"doc_type" required:"true" alias:"Вид документа"`
	Doc_id fields.ValInt `json:"doc_id"`
	Bank_account_id fields.ValInt `json:"bank_account_id" required:"true"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

func (o *RABankFlow) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Deb.SetNull()
	o.Doc_type.SetNull()
	o.Doc_id.SetNull()
	o.Bank_account_id.SetNull()
	o.Total.SetNull()
}

func NewModelMD_RABankFlow() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(RABankFlow{})),
		ID: "RABankFlow_Model",
		Relation: "ra_bank_flow",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type RABankFlow_argv struct {
	Argv *RABankFlow `json:"argv"`	
}

//Keys for delete/get object
type RABankFlow_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type RABankFlow_keys_argv struct {
	Argv *RABankFlow_keys `json:"argv"`	
}

//old keys for update
type RABankFlow_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"Код"`
	Id fields.ValInt `json:"id" alias:"Код"`
	Date_time fields.ValDateTime `json:"date_time" alias:"Период"`
	Deb fields.ValBool `json:"deb" alias:"Дебет"`
	Doc_type enums.ValEnum_doc_types `json:"doc_type" alias:"Вид документа"`
	Doc_id fields.ValInt `json:"doc_id"`
	Bank_account_id fields.ValInt `json:"bank_account_id"`
	Total fields.ValFloat `json:"total" alias:"Сумма"`
}

type RABankFlow_old_keys_argv struct {
	Argv *RABankFlow_old_keys `json:"argv"`	
}

