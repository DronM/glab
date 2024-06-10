package controllers

/**
 * Andrey Mikhalevich 08/04/24
 * This file is part of the gobizap framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * This file contains method descriptions only.
 * Controller implimentation is in FinExpenseType_ControllerImp.go file
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
type FinExpenseType_Controller struct {
	gobizap.Base_Controller
}

func NewController_FinExpenseType() *FinExpenseType_Controller {
	c := &FinExpenseType_Controller{gobizap.Base_Controller{ID: "FinExpenseType", PublicMethods: make(gobizap.PublicMethodCollection)}}
	keys_fields := fields.GenModelMD(reflect.ValueOf(models.FinExpenseType_keys{}))

	//************************** method insert **********************************
	c.PublicMethods["insert"] = &FinExpenseType_Controller_insert{
		gobizap.Base_PublicMethod{
			ID:        "insert",
			Fields:    fields.GenModelMD(reflect.ValueOf(models.FinExpenseType{})),
			EventList: gobizap.PublicMethodEventList{"FinExpenseType.insert"},
		},
	}

	//************************** method delete *************************************
	c.PublicMethods["delete"] = &FinExpenseType_Controller_delete{
		gobizap.Base_PublicMethod{
			ID:        "delete",
			Fields:    keys_fields,
			EventList: gobizap.PublicMethodEventList{"FinExpenseType.delete"},
		},
	}

	//************************** method update *************************************
	c.PublicMethods["update"] = &FinExpenseType_Controller_update{
		gobizap.Base_PublicMethod{
			ID:        "update",
			Fields:    fields.GenModelMD(reflect.ValueOf(models.FinExpenseType_old_keys{})),
			EventList: gobizap.PublicMethodEventList{"FinExpenseType.update"},
		},
	}

	//************************** method get_object *************************************
	c.PublicMethods["get_object"] = &FinExpenseType_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID:     "get_object",
			Fields: keys_fields,
		},
	}

	//************************** method get_list *************************************
	c.PublicMethods["get_list"] = &FinExpenseType_Controller_get_list{
		gobizap.Base_PublicMethod{
			ID:     "get_list",
			Fields: model.Cond_Model_fields,
		},
	}

	//************************** method get_list *************************************
	c.PublicMethods["get_item_list"] = &FinExpenseType_Controller_get_item_list{
		gobizap.Base_PublicMethod{
			ID:     "get_item_list",
			Fields: model.Cond_Model_fields,
		},
	}
	//************************** method complete *************************************
	c.PublicMethods["complete"] = &FinExpenseType_Controller_complete{
		gobizap.Base_PublicMethod{
			ID:     "complete",
			Fields: fields.GenModelMD(reflect.ValueOf(models.FinExpenseType_complete{})),
		},
	}

	//************************** method verify_rule *************************************
	c.PublicMethods["verify_rule"] = &FinExpenseType_Controller_verify_rule{
		gobizap.Base_PublicMethod{
			ID:     "verify_rule",
			Fields: fields.GenModelMD(reflect.ValueOf(models.FinExpenseType_verify_rule{})),
		},
	}
	return c
}

type FinExpenseType_Controller_keys_argv struct {
	Argv models.FinExpenseType_keys `json:"argv"`
}

// ************************* INSERT **********************************************
// Public method: insert
type FinExpenseType_Controller_insert struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_insert) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.FinExpenseType_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* DELETE **********************************************
type FinExpenseType_Controller_delete struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_delete) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.FinExpenseType_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* GET OBJECT **********************************************
type FinExpenseType_Controller_get_object struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_get_object) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.FinExpenseType_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* GET LIST **********************************************
// Public method: get_list
type FinExpenseType_Controller_get_list struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_get_list) Unmarshal(payload []byte) (reflect.Value, error) {
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
type FinExpenseType_Controller_update struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_update) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.FinExpenseType_old_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************** COMPLETE ********************************************************
// Public method: complete
type FinExpenseType_Controller_complete struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_complete) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.FinExpenseType_complete_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* verify_rule **********************************************
// Public method: verify_rule
type FinExpenseType_Controller_verify_rule struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_verify_rule) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.FinExpenseType_verify_rule_argv{}
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* get_item_list **********************************************
// Public method: get_list
type FinExpenseType_Controller_get_item_list struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *FinExpenseType_Controller_get_item_list) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &model.Controller_get_list_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}
