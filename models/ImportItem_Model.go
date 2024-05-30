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

type ImportItem struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата импорта"`
	Import_comment fields.ValText `json:"import_comment" alias:"Комментарий импорта"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Make fields.ValText `json:"make" alias:"Марка"`
	Model fields.ValText `json:"model" alias:"Модель"`
	Model_generation fields.ValText `json:"model_generation" alias:"Поколнение"`
	Body fields.ValText `json:"body" alias:"Кузов"`
	Supplier fields.ValText `json:"supplier" alias:"Поставщик"`
	Item_folder_id fields.ValInt `json:"item_folder_id" alias:"Группа товаров"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Для какой марки"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Для какой модели"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Для какого поколения модели"`
	Auto_body_id fields.ValInt `json:"auto_body_id" alias:"Для какого кузова"`
	Supplier_id fields.ValInt `json:"supplier_id" alias:"Для какого поствщика"`
	Options fields.ValJSON `json:"options" alias:"Опции"`
}

func (o *ImportItem) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Import_comment.SetNull()
	o.Name.SetNull()
	o.Make.SetNull()
	o.Model.SetNull()
	o.Model_generation.SetNull()
	o.Body.SetNull()
	o.Supplier.SetNull()
	o.Item_folder_id.SetNull()
	o.Auto_make_id.SetNull()
	o.Auto_model_id.SetNull()
	o.Auto_model_generation_id.SetNull()
	o.Auto_body_id.SetNull()
	o.Supplier_id.SetNull()
	o.Options.SetNull()
}

func NewModelMD_ImportItem() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ImportItem{})),
		ID: "ImportItem_Model",
		Relation: "import_items",
	}
}
//for insert
type ImportItem_argv struct {
	Argv *ImportItem `json:"argv"`	
}

//Keys for delete/get object
type ImportItem_keys struct {
	Id fields.ValInt `json:"id"`
}
type ImportItem_keys_argv struct {
	Argv *ImportItem_keys `json:"argv"`	
}

//old keys for update
type ImportItem_old_keys struct {
	Old_id fields.ValInt `json:"old_id"`
	Id fields.ValInt `json:"id"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата импорта"`
	Import_comment fields.ValText `json:"import_comment" alias:"Комментарий импорта"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Make fields.ValText `json:"make" alias:"Марка"`
	Model fields.ValText `json:"model" alias:"Модель"`
	Model_generation fields.ValText `json:"model_generation" alias:"Поколнение"`
	Body fields.ValText `json:"body" alias:"Кузов"`
	Supplier fields.ValText `json:"supplier" alias:"Поставщик"`
	Item_folder_id fields.ValInt `json:"item_folder_id" alias:"Группа товаров"`
	Auto_make_id fields.ValInt `json:"auto_make_id" alias:"Для какой марки"`
	Auto_model_id fields.ValInt `json:"auto_model_id" alias:"Для какой модели"`
	Auto_model_generation_id fields.ValInt `json:"auto_model_generation_id" alias:"Для какого поколения модели"`
	Auto_body_id fields.ValInt `json:"auto_body_id" alias:"Для какого кузова"`
	Supplier_id fields.ValInt `json:"supplier_id" alias:"Для какого поствщика"`
	Options fields.ValJSON `json:"options" alias:"Опции"`
}

type ImportItem_old_keys_argv struct {
	Argv *ImportItem_old_keys `json:"argv"`	
}

