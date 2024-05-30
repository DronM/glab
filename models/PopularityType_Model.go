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

type PopularityType struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true" alias:"ID"`
	Code fields.ValInt `json:"code" required:"true" alias:"Код для сортировки" defOrder:"DESC"`
	Name fields.ValText `json:"name" required:"true" alias:"Наименование"`
	Item_count fields.ValInt `json:"item_count" alias:"Количество позиций вывода"`
	Screen_width_type enums.ValEnum_screen_width_types `json:"screen_width_type" alias:"Тип экрана"`
}

func (o *PopularityType) SetNull() {
	o.Id.SetNull()
	o.Code.SetNull()
	o.Name.SetNull()
	o.Item_count.SetNull()
	o.Screen_width_type.SetNull()
}

func NewModelMD_PopularityType() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(PopularityType{})),
		ID: "PopularityType_Model",
		Relation: "popularity_types",
	}
}
//for insert
type PopularityType_argv struct {
	Argv *PopularityType `json:"argv"`	
}

//Keys for delete/get object
type PopularityType_keys struct {
	Id fields.ValInt `json:"id"`
}
type PopularityType_keys_argv struct {
	Argv *PopularityType_keys `json:"argv"`	
}

//old keys for update
type PopularityType_old_keys struct {
	Old_id fields.ValInt `json:"old_id" alias:"ID"`
	Id fields.ValInt `json:"id" alias:"ID"`
	Code fields.ValInt `json:"code" alias:"Код для сортировки"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Item_count fields.ValInt `json:"item_count" alias:"Количество позиций вывода"`
	Screen_width_type enums.ValEnum_screen_width_types `json:"screen_width_type" alias:"Тип экрана"`
}

type PopularityType_old_keys_argv struct {
	Argv *PopularityType_old_keys `json:"argv"`	
}

