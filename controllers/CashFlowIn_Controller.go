package controllers

/**
 * Andrey Mikhalevich 08/04/24
 * This file is part of the gobizap framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * This file contains method descriptions only.
 * Controller implimentation is in CashFlowIn_ControllerImp.go file
 *
 */

import (
	"encoding/json"
	"reflect"

	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"

	"glab/models"
)

// Controller
type CashFlowIn_Controller struct {
	gobizap.Base_Controller
}

func NewController_CashFlowIn() *CashFlowIn_Controller {
	c := &CashFlowIn_Controller{gobizap.Base_Controller{ID: "CashFlowIn", PublicMethods: make(gobizap.PublicMethodCollection)}}
	keys_fields := fields.GenModelMD(reflect.ValueOf(models.CashFlowIn_keys{}))

	//************************** method insert **********************************
	c.PublicMethods["insert"] = &CashFlowIn_Controller_insert{
		gobizap.Base_PublicMethod{
			ID:        "insert",
			Fields:    fields.GenModelMD(reflect.ValueOf(models.CashFlowIn{})),
			EventList: gobizap.PublicMethodEventList{"CashFlowIn.insert"},
		},
	}

	//************************** method delete *************************************
	c.PublicMethods["delete"] = &CashFlowIn_Controller_delete{
		gobizap.Base_PublicMethod{
			ID:        "delete",
			Fields:    keys_fields,
			EventList: gobizap.PublicMethodEventList{"CashFlowIn.delete"},
		},
	}

	//************************** method update *************************************
	c.PublicMethods["update"] = &CashFlowIn_Controller_update{
		gobizap.Base_PublicMethod{
			ID:        "update",
			Fields:    fields.GenModelMD(reflect.ValueOf(models.CashFlowIn_old_keys{})),
			EventList: gobizap.PublicMethodEventList{"CashFlowIn.update"},
		},
	}

	//************************** method get_object *************************************
	c.PublicMethods["get_object"] = &CashFlowIn_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID:     "get_object",
			Fields: keys_fields,
		},
	}

	//************************** method get_list *************************************
	c.PublicMethods["get_list"] = &CashFlowIn_Controller_get_list{
		gobizap.Base_PublicMethod{
			ID:     "get_list",
			Fields: model.Cond_Model_fields,
		},
	}

	//************************** method get_report *************************************
	c.PublicMethods["get_report"] = &CashFlowIn_Controller_get_report{
		gobizap.Base_PublicMethod{
			ID:     "get_report",
			Fields: model.Cond_Model_fields,
		},
	}
	return c
}

type CashFlowIn_Controller_keys_argv struct {
	Argv models.CashFlowIn_keys `json:"argv"`
}

// ************************* INSERT **********************************************
// Public method: insert
type CashFlowIn_Controller_insert struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *CashFlowIn_Controller_insert) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.CashFlowIn_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* DELETE **********************************************
type CashFlowIn_Controller_delete struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *CashFlowIn_Controller_delete) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.CashFlowIn_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* GET OBJECT **********************************************
type CashFlowIn_Controller_get_object struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *CashFlowIn_Controller_get_object) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.CashFlowIn_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* GET LIST **********************************************
// Public method: get_list
type CashFlowIn_Controller_get_list struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *CashFlowIn_Controller_get_list) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &model.Controller_get_list_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* UPDATE **********************************************
// Public method: update
type CashFlowIn_Controller_update struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *CashFlowIn_Controller_update) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.CashFlowIn_old_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* get_report **********************************************
// Public method: import_from_bank
type CashFlowIn_Controller_get_report struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *CashFlowIn_Controller_get_report) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &model.Controller_get_list_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}
