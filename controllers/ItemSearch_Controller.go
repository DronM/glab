package controllers

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * This file contains method descriptions only.
 * Controller implimentation is in ItemSearch_ControllerImp.go file
 *
 */

import (
	"reflect"
	"encoding/json"	
	
	"glab/models"
	
	"github.com/dronm/gobizap"	
	"github.com/dronm/gobizap/fields"
)

//Controller
type ItemSearch_Controller struct {
	gobizap.Base_Controller
}

func NewController_ItemSearch() *ItemSearch_Controller{
	c := &ItemSearch_Controller{gobizap.Base_Controller{ID: "ItemSearch", PublicMethods: make(gobizap.PublicMethodCollection)}}	
	
	//************************** method insert **********************************
	c.PublicMethods["get_object"] = &ItemSearch_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID: "get_object",
		},
	}
	
	//************************** method find_items *************************************
	c.PublicMethods["find_items"] = &ItemSearch_Controller_find_items{
		gobizap.Base_PublicMethod{
			ID: "find_items",
			Fields: fields.GenModelMD(reflect.ValueOf(models.ItemSearch_find_items{})),
		},
	}
	
	return c
}

//************************* GET OBJECT **********************************************
type ItemSearch_Controller_get_object struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *ItemSearch_Controller_get_object) Unmarshal(payload []byte) (reflect.Value, error) {
	res := reflect.Value(reflect.ValueOf(nil))
	return res, nil
}

//************************* find_items **********************************************
//Public method: find_items
type ItemSearch_Controller_find_items struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *ItemSearch_Controller_find_items) Unmarshal(payload []byte) (reflect.Value, error) {
	var res reflect.Value
	argv := &models.ItemSearch_find_items_argv{}
	if err := json.Unmarshal(payload, argv); err != nil {
		return res, err
	}	
	res = reflect.ValueOf(&argv.Argv).Elem()	
	return res, nil
}


