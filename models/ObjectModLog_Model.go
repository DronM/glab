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

type ObjectModLog struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Object_type enums.ValEnum_data_types `json:"object_type" required:"true" alias:"Вид объекта"`
	Object_id fields.ValInt `json:"object_id" required:"true" alias:"Идентификатор объекта"`
	Object_descr fields.ValText `json:"object_descr" required:"true" alias:"Представление объекта"`
	User_descr fields.ValText `json:"user_descr" alias:"Пользователь"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата" defOrder:"DESC"`
	Action enums.ValEnum_object_mod_actions `json:"action" alias:"Действие"`
	Details fields.ValText `json:"details" alias:"Подробности"`
}

func (o *ObjectModLog) SetNull() {
	o.Id.SetNull()
	o.Object_type.SetNull()
	o.Object_id.SetNull()
	o.Object_descr.SetNull()
	o.User_descr.SetNull()
	o.Date_time.SetNull()
	o.Action.SetNull()
	o.Details.SetNull()
}

func NewModelMD_ObjectModLog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ObjectModLog{})),
		ID: "ObjectModLog_Model",
		Relation: "object_mod_log",
		AggFunctions: []*model.AggFunction{
			&model.AggFunction{Alias: "totalCount", Expr: "count(*)"},
		},
	}
}
//for insert
type ObjectModLog_argv struct {
	Argv *ObjectModLog `json:"argv"`	
}

//Keys for delete/get object
type ObjectModLog_keys struct {
	Id fields.ValInt `json:"id"`
	Mode string `json:"mode" openMode:"true"` //open mode insert|copy|edit
}
type ObjectModLog_keys_argv struct {
	Argv *ObjectModLog_keys `json:"argv"`	
}

//old keys for update
type ObjectModLog_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Object_type enums.ValEnum_data_types `json:"object_type" alias:"Вид объекта"`
	Object_id fields.ValInt `json:"object_id" alias:"Идентификатор объекта"`
	Object_descr fields.ValText `json:"object_descr" alias:"Представление объекта"`
	User_descr fields.ValText `json:"user_descr" alias:"Пользователь"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата"`
	Action enums.ValEnum_object_mod_actions `json:"action" alias:"Действие"`
	Details fields.ValText `json:"details" alias:"Подробности"`
}

type ObjectModLog_old_keys_argv struct {
	Argv *ObjectModLog_old_keys `json:"argv"`	
}

