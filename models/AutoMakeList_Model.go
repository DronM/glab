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

type AutoMakeList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование" defOrder:"ASC"`
	Name_variants fields.ValText `json:"name_variants" alias:"Варианты наименования"`
	Logo fields.ValJSON `json:"logo"`
	Popularity_types_ref fields.ValJSON `json:"popularity_types_ref" alias:"Популярность брэнда"`
	Popularity_type_id fields.ValInt `json:"popularity_type_id" sysCol:"true"`
	Model_count fields.ValInt `json:"model_count" alias:"Количество моделей"`
}

func (o *AutoMakeList) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Name_variants.SetNull()
	o.Logo.SetNull()
	o.Popularity_types_ref.SetNull()
	o.Popularity_type_id.SetNull()
	o.Model_count.SetNull()
}

func NewModelMD_AutoMakeList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(AutoMakeList{})),
		ID: "AutoMakeList_Model",
		Relation: "auto_makes_list",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type AutoMakeList_argv struct {
	Argv *AutoMakeList `json:"argv"`	
}

//Keys for delete/get object
type AutoMakeList_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type AutoMakeList_keys_argv struct {
	Argv *AutoMakeList_keys `json:"argv"`	
}

//old keys for update
type AutoMakeList_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Name_variants fields.ValText `json:"name_variants" alias:"Варианты наименования"`
	Logo fields.ValJSON `json:"logo"`
	Popularity_types_ref fields.ValJSON `json:"popularity_types_ref" alias:"Популярность брэнда"`
	Popularity_type_id fields.ValInt `json:"popularity_type_id"`
	Model_count fields.ValInt `json:"model_count" alias:"Количество моделей"`
}

type AutoMakeList_old_keys_argv struct {
	Argv *AutoMakeList_old_keys `json:"argv"`	
}

