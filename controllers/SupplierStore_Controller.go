package controllers

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * This file contains method descriptions only.
 * Controller implimentation is in SupplierStore_ControllerImp.go file
 *
 */

import (
	"reflect"	
	"encoding/json"
	
	"glab/models"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

//Controller
type SupplierStore_Controller struct {
	gobizap.Base_Controller
}

func NewController_SupplierStore() *SupplierStore_Controller{
	c := &SupplierStore_Controller{gobizap.Base_Controller{ID: "SupplierStore", PublicMethods: make(gobizap.PublicMethodCollection)}}	
	keys_fields := fields.GenModelMD(reflect.ValueOf(models.SupplierStore_keys{}))
	
	//************************** method insert **********************************
	c.PublicMethods["insert"] = &SupplierStore_Controller_insert{
		gobizap.Base_PublicMethod{
			ID: "insert",
			Fields: fields.GenModelMD(reflect.ValueOf(models.SupplierStore{})),
			EventList: gobizap.PublicMethodEventList{"SupplierStore.insert"},
		},
	}
	
	//************************** method delete *************************************
	c.PublicMethods["delete"] = &SupplierStore_Controller_delete{
		gobizap.Base_PublicMethod{
			ID: "delete",
			Fields: keys_fields,
			EventList: gobizap.PublicMethodEventList{"SupplierStore.delete"},
		},
	}
	
	//************************** method update *************************************
	c.PublicMethods["update"] = &SupplierStore_Controller_update{
		gobizap.Base_PublicMethod{
			ID: "update",
			Fields: fields.GenModelMD(reflect.ValueOf(models.SupplierStore_old_keys{})),
			EventList: gobizap.PublicMethodEventList{"SupplierStore.update"},
		},
	}
	
	//************************** method get_object *************************************
	c.PublicMethods["get_object"] = &SupplierStore_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID: "get_object",
			Fields: keys_fields,
		},
	}
	
	//************************** method get_list *************************************
	c.PublicMethods["get_list"] = &SupplierStore_Controller_get_list{
		gobizap.Base_PublicMethod{
			ID: "get_list",
			Fields: model.Cond_Model_fields,
		},
	}
	
	//************************** method complete_for_supplier *************************************
	c.PublicMethods["complete_for_supplier"] = &SupplierStore_Controller_complete_for_supplier{
		gobizap.Base_PublicMethod{
			ID: "complete_for_supplier",
			Fields: fields.GenModelMD(reflect.ValueOf(models.SupplierStore_complete_for_supplier{})),
		},
	}
			
	
	return c
}

type SupplierStore_Controller_keys_argv struct {
	Argv models.SupplierStore_keys `json:"argv"`	
}

//************************* INSERT **********************************************
//Public method: insert
type SupplierStore_Controller_insert struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *SupplierStore_Controller_insert) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStore_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* DELETE **********************************************
type SupplierStore_Controller_delete struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *SupplierStore_Controller_delete) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStore_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* GET OBJECT **********************************************
type SupplierStore_Controller_get_object struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *SupplierStore_Controller_get_object) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStore_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* GET LIST **********************************************
//Public method: get_list
type SupplierStore_Controller_get_list struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *SupplierStore_Controller_get_list) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &model.Controller_get_list_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* UPDATE **********************************************
//Public method: update
type SupplierStore_Controller_update struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *SupplierStore_Controller_update) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStore_old_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************** complete_for_supplier ********************************************************
//Public method: complete_for_supplier
type SupplierStore_Controller_complete_for_supplier struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *SupplierStore_Controller_complete_for_supplier) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStore_complete_for_supplier_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}
