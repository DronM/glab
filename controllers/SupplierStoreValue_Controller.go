package controllers

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * This file contains method descriptions only.
 * Controller implimentation is in SupplierStoreValue_ControllerImp.go file
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
type SupplierStoreValue_Controller struct {
	gobizap.Base_Controller
}

func NewController_SupplierStoreValue() *SupplierStoreValue_Controller{
	c := &SupplierStoreValue_Controller{gobizap.Base_Controller{ID: "SupplierStoreValue", PublicMethods: make(gobizap.PublicMethodCollection)}}	
	keys_fields := fields.GenModelMD(reflect.ValueOf(models.SupplierStoreValue_keys{}))
	
	//************************** method insert **********************************
	c.PublicMethods["insert"] = &SupplierStoreValue_Controller_insert{
		gobizap.Base_PublicMethod{
			ID: "insert",
			Fields: fields.GenModelMD(reflect.ValueOf(models.SupplierStoreValue{})),
			EventList: gobizap.PublicMethodEventList{"SupplierStoreValue.insert"},
		},
	}
	
	//************************** method delete *************************************
	c.PublicMethods["delete"] = &SupplierStoreValue_Controller_delete{
		gobizap.Base_PublicMethod{
			ID: "delete",
			Fields: keys_fields,
			EventList: gobizap.PublicMethodEventList{"SupplierStoreValue.delete"},
		},
	}
	
	//************************** method update *************************************
	c.PublicMethods["update"] = &SupplierStoreValue_Controller_update{
		gobizap.Base_PublicMethod{
			ID: "update",
			Fields: fields.GenModelMD(reflect.ValueOf(models.SupplierStoreValue_old_keys{})),
			EventList: gobizap.PublicMethodEventList{"SupplierStoreValue.update"},
		},
	}
	
	//************************** method get_object *************************************
	c.PublicMethods["get_object"] = &SupplierStoreValue_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID: "get_object",
			Fields: keys_fields,
		},
	}
	
	//************************** method get_list *************************************
	c.PublicMethods["get_list"] = &SupplierStoreValue_Controller_get_list{
		gobizap.Base_PublicMethod{
			ID: "get_list",
			Fields: model.Cond_Model_fields,
		},
	}
	
			
	
	return c
}

type SupplierStoreValue_Controller_keys_argv struct {
	Argv models.SupplierStoreValue_keys `json:"argv"`	
}

//************************* INSERT **********************************************
//Public method: insert
type SupplierStoreValue_Controller_insert struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *SupplierStoreValue_Controller_insert) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStoreValue_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* DELETE **********************************************
type SupplierStoreValue_Controller_delete struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *SupplierStoreValue_Controller_delete) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStoreValue_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* GET OBJECT **********************************************
type SupplierStoreValue_Controller_get_object struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *SupplierStoreValue_Controller_get_object) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStoreValue_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* GET LIST **********************************************
//Public method: get_list
type SupplierStoreValue_Controller_get_list struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *SupplierStoreValue_Controller_get_list) Unmarshal(payload []byte) (reflect.Value, error) {
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
type SupplierStoreValue_Controller_update struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *SupplierStoreValue_Controller_update) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.SupplierStoreValue_old_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

