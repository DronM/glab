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

type BankAccountList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Parent_data_type enums.ValEnum_data_types `json:"parent_data_type" required:"true" alias:"Тип родителя"`
	Parent_id fields.ValInt `json:"parent_id" alias:"ИД родителя"`
	Parents_ref fields.ValJSON `json:"parents_ref" alias:"Родитель"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Bank_acc fields.ValText `json:"bank_acc" alias:"Расчетный счет"`
	Banks_ref fields.ValJSON `json:"banks_ref"`
}

func (o *BankAccountList) SetNull() {
	o.Id.SetNull()
	o.Parent_data_type.SetNull()
	o.Parent_id.SetNull()
	o.Parents_ref.SetNull()
	o.Name.SetNull()
	o.Bank_acc.SetNull()
	o.Banks_ref.SetNull()
}

func NewModelMD_BankAccountList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(BankAccountList{})),
		ID: "BankAccountList_Model",
		Relation: "bank_accounts_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
