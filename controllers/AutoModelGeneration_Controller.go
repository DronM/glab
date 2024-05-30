package controllers

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * This file contains method descriptions only.
 * Controller implimentation is in AutoModelGeneration_ControllerImp.go file
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
type AutoModelGeneration_Controller struct {
	gobizap.Base_Controller
}

func NewController_AutoModelGeneration() *AutoModelGeneration_Controller{
	c := &AutoModelGeneration_Controller{gobizap.Base_Controller{ID: "AutoModelGeneration", PublicMethods: make(gobizap.PublicMethodCollection)}}	
	keys_fields := fields.GenModelMD(reflect.ValueOf(models.AutoModelGeneration_keys{}))
	
	//************************** method insert **********************************
	c.PublicMethods["insert"] = &AutoModelGeneration_Controller_insert{
		gobizap.Base_PublicMethod{
			ID: "insert",
			Fields: fields.GenModelMD(reflect.ValueOf(models.AutoModelGeneration{})),
			EventList: gobizap.PublicMethodEventList{"AutoModelGeneration.insert"},
		},
	}
	
	//************************** method delete *************************************
	c.PublicMethods["delete"] = &AutoModelGeneration_Controller_delete{
		gobizap.Base_PublicMethod{
			ID: "delete",
			Fields: keys_fields,
			EventList: gobizap.PublicMethodEventList{"AutoModelGeneration.delete"},
		},
	}
	
	//************************** method update *************************************
	c.PublicMethods["update"] = &AutoModelGeneration_Controller_update{
		gobizap.Base_PublicMethod{
			ID: "update",
			Fields: fields.GenModelMD(reflect.ValueOf(models.AutoModelGeneration_old_keys{})),
			EventList: gobizap.PublicMethodEventList{"AutoModelGeneration.update"},
		},
	}
	
	//************************** method get_object *************************************
	c.PublicMethods["get_object"] = &AutoModelGeneration_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID: "get_object",
			Fields: keys_fields,
		},
	}
	
	//************************** method get_list *************************************
	c.PublicMethods["get_list"] = &AutoModelGeneration_Controller_get_list{
		gobizap.Base_PublicMethod{
			ID: "get_list",
			Fields: model.Cond_Model_fields,
		},
	}
	
	//************************** method complete_for_model *************************************
	c.PublicMethods["complete_for_model"] = &AutoModelGeneration_Controller_complete_for_model{
		gobizap.Base_PublicMethod{
			ID: "complete_for_model",
			Fields: fields.GenModelMD(reflect.ValueOf(models.AutoModelGeneration_complete_for_model{})),
		},
	}
			
	//************************** method gen_next_id *************************************
	c.PublicMethods["gen_next_id"] = &AutoModelGeneration_Controller_gen_next_id{
		gobizap.Base_PublicMethod{
			ID: "gen_next_id",
			Fields: fields.GenModelMD(reflect.ValueOf(models.AutoModelGeneration_gen_next_id{})),
		},		
	}
	
	return c
}

type AutoModelGeneration_Controller_keys_argv struct {
	Argv models.AutoModelGeneration_keys `json:"argv"`	
}

//************************* INSERT **********************************************
//Public method: insert
type AutoModelGeneration_Controller_insert struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *AutoModelGeneration_Controller_insert) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.AutoModelGeneration_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* DELETE **********************************************
type AutoModelGeneration_Controller_delete struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *AutoModelGeneration_Controller_delete) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.AutoModelGeneration_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* GET OBJECT **********************************************
type AutoModelGeneration_Controller_get_object struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *AutoModelGeneration_Controller_get_object) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.AutoModelGeneration_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************* GET LIST **********************************************
//Public method: get_list
type AutoModelGeneration_Controller_get_list struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *AutoModelGeneration_Controller_get_list) Unmarshal(payload []byte) (reflect.Value, error) {
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
type AutoModelGeneration_Controller_update struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *AutoModelGeneration_Controller_update) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.AutoModelGeneration_old_keys_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//************************** complete_for_model ********************************************************
//Public method: complete_for_model
type AutoModelGeneration_Controller_complete_for_model struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *AutoModelGeneration_Controller_complete_for_model) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.AutoModelGeneration_complete_for_model_argv{}
		
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}

//Public method: gen_next_id
type AutoModelGeneration_Controller_gen_next_id struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *AutoModelGeneration_Controller_gen_next_id) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.AutoModelGeneration_gen_next_id_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

