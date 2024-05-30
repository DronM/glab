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

type ItemDialog struct {
	Id fields.ValInt `json:"id" primaryKey:"true" autoInc:"true"`
	Name fields.ValText `json:"name" alias:"Наименование"`
	Item_folders_ref fields.ValJSON `json:"item_folders_ref" alias:"Группа товаров"`
	Auto_makes_ref fields.ValJSON `json:"auto_makes_ref" alias:"Для какой марки"`
	Auto_models_ref fields.ValJSON `json:"auto_models_ref" alias:"Для какой модели"`
	Auto_model_generations_ref fields.ValJSON `json:"auto_model_generations_ref" alias:"Для какого поколения модели"`
	Auto_bodies_ref fields.ValJSON `json:"auto_bodies_ref" alias:"Для какого кузова"`
	Manufacturers_ref fields.ValJSON `json:"manufacturers_ref" alias:"Производитель"`
	Manufacturer_brands_ref fields.ValJSON `json:"manufacturer_brands_ref" alias:"Производитель"`
	Features_list fields.ValJSON `json:"features_list" alias:"Характеристики"`
	Pictures fields.ValJSON `json:"pictures"`
}

func (o *ItemDialog) SetNull() {
	o.Id.SetNull()
	o.Name.SetNull()
	o.Item_folders_ref.SetNull()
	o.Auto_makes_ref.SetNull()
	o.Auto_models_ref.SetNull()
	o.Auto_model_generations_ref.SetNull()
	o.Auto_bodies_ref.SetNull()
	o.Manufacturers_ref.SetNull()
	o.Manufacturer_brands_ref.SetNull()
	o.Features_list.SetNull()
	o.Pictures.SetNull()
}

func NewModelMD_ItemDialog() *model.ModelMD{
	return &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(ItemDialog{})),
		ID: "ItemDialog_Model",
		Relation: "items_dialog",
	}
}
