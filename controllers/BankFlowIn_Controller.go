package controllers

/**
 * Andrey Mikhalevich 08/04/24
 * This file is part of the gobizap framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * This file contains method descriptions only.
 * Controller implimentation is in BankFlowIn_ControllerImp.go file
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
type BankFlowIn_Controller struct {
	gobizap.Base_Controller
}

func NewController_BankFlowIn() *BankFlowIn_Controller {
	c := &BankFlowIn_Controller{gobizap.Base_Controller{ID: "BankFlowIn", PublicMethods: make(gobizap.PublicMethodCollection)}}
	keys_fields := fields.GenModelMD(reflect.ValueOf(models.BankFlowIn_keys{}))

	//************************** method insert **********************************
	c.PublicMethods["insert"] = &BankFlowIn_Controller_insert{
		gobizap.Base_PublicMethod{
			ID:        "insert",
			Fields:    fields.GenModelMD(reflect.ValueOf(models.BankFlowIn{})),
			EventList: gobizap.PublicMethodEventList{"BankFlowIn.insert"},
		},
	}

	//************************** method delete *************************************
	c.PublicMethods["delete"] = &BankFlowIn_Controller_delete{
		gobizap.Base_PublicMethod{
			ID:        "delete",
			Fields:    keys_fields,
			EventList: gobizap.PublicMethodEventList{"BankFlowIn.delete"},
		},
	}

	//************************** method update *************************************
	c.PublicMethods["update"] = &BankFlowIn_Controller_update{
		gobizap.Base_PublicMethod{
			ID:        "update",
			Fields:    fields.GenModelMD(reflect.ValueOf(models.BankFlowIn_old_keys{})),
			EventList: gobizap.PublicMethodEventList{"BankFlowIn.update"},
		},
	}

	//************************** method get_object *************************************
	c.PublicMethods["get_object"] = &BankFlowIn_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID:     "get_object",
			Fields: keys_fields,
		},
	}

	//************************** method get_list *************************************
	c.PublicMethods["get_list"] = &BankFlowIn_Controller_get_list{
		gobizap.Base_PublicMethod{
			ID:     "get_list",
			Fields: model.Cond_Model_fields,
		},
	}

	//************************** method import_from_bank *************************************
	c.PublicMethods["import_from_bank"] = &BankFlowIn_Controller_import_from_bank{
		gobizap.Base_PublicMethod{
			ID:     "import_from_bank",
			Fields: fields.GenModelMD(reflect.ValueOf(models.BankFlowIn_import_from_bank{})),
		},
	}

	//************************** method get_report *************************************
	c.PublicMethods["get_report"] = &BankFlowIn_Controller_get_report{
		gobizap.Base_PublicMethod{
			ID:     "get_report",
			Fields: model.Cond_Model_fields,
		},
	}

	//************************** method apply_rules *************************************
	c.PublicMethods["apply_rules"] = &BankFlowIn_Controller_apply_rules{
		gobizap.Base_PublicMethod{
			ID:     "apply_rules",
			Fields: fields.GenModelMD(reflect.ValueOf(models.BankFlowIn_apply_rules{})),
		},
	}
	return c
}

type BankFlowIn_Controller_keys_argv struct {
	Argv models.BankFlowIn_keys `json:"argv"`
}

// ************************* INSERT **********************************************
// Public method: insert
type BankFlowIn_Controller_insert struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_insert) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.BankFlowIn_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* DELETE **********************************************
type BankFlowIn_Controller_delete struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_delete) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.BankFlowIn_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* GET OBJECT **********************************************
type BankFlowIn_Controller_get_object struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_get_object) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.BankFlowIn_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* GET LIST **********************************************
// Public method: get_list
type BankFlowIn_Controller_get_list struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_get_list) Unmarshal(payload []byte) (reflect.Value, error) {
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
type BankFlowIn_Controller_update struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_update) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.BankFlowIn_old_keys_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* import_from_bank **********************************************
// Public method: import_from_bank
type BankFlowIn_Controller_import_from_bank struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_import_from_bank) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.BankFlowIn_import_from_bank_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* get_report **********************************************
// Public method: import_from_bank
type BankFlowIn_Controller_get_report struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_get_report) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &model.Controller_get_list_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}

// ************************* apply_rules **********************************************
// Public method: import_from_bank
type BankFlowIn_Controller_apply_rules struct {
	gobizap.Base_PublicMethod
}

// Public method Unmarshal to structure
func (pm *BankFlowIn_Controller_apply_rules) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.BankFlowIn_apply_rules_argv{}

	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()
	return res, nil
}
