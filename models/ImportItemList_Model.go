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

type ImportItemList struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Date_time fields.ValDateTimeTZ `json:"date_time" alias:"Дата импорта"`
	Import_comment fields.ValText `json:"import_comment" alias:"Комментарий импорта"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Make fields.ValText `json:"make" alias:"Марка"`
	Model fields.ValText `json:"model" alias:"Модель"`
	Model_generation fields.ValText `json:"model_generation" alias:"Поколнение"`
	Body fields.ValText `json:"body" alias:"Кузов"`
	Supplier fields.ValText `json:"supplier" alias:"Поставщик"`
	Item_folders_ref fields.ValJSON `json:"item_folders_ref" alias:"Группа товаров"`
	Auto_makes_ref fields.ValJSON `json:"auto_makes_ref" alias:"Для какой марки"`
	Auto_models_ref fields.ValJSON `json:"auto_models_ref" alias:"Для какой модели"`
	Auto_model_generations_ref fields.ValJSON `json:"auto_model_generations_ref" alias:"Для какого поколения модели"`
	Auto_bodies_ref fields.ValJSON `json:"auto_bodies_ref" alias:"Для какого кузова"`
	Suppliers_ref fields.ValJSON `json:"suppliers_ref" alias:"Для какого поствщика"`
	Options fields.ValJSON `json:"options" alias:"Опции"`
}

func (o *ImportItemList) SetNull() {
	o.Id.SetNull()
	o.Date_time.SetNull()
	o.Import_comment.SetNull()
	o.Name.SetNull()
	o.Make.SetNull()
	o.Model.SetNull()
	o.Model_generation.SetNull()
	o.Body.SetNull()
	o.Supplier.SetNull()
	o.Item_folders_ref.SetNull()
	o.Auto_makes_ref.SetNull()
	o.Auto_models_ref.SetNull()
	o.Auto_model_generations_ref.SetNull()
	o.Auto_bodies_ref.SetNull()
	o.Suppliers_ref.SetNull()
	o.Options.SetNull()
}

func NewModelMD_ImportItemList() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ImportItemList{})),
		ID: "ImportItemList_Model",
		Relation: "import_items_list",
	}
}
