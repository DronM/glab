package controllers

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * Controller implimentation should be in User_ControllerImp.go file
 *
 */

import (
	"encoding/json"
	"reflect"
	
	"glab/models"
	
	"github.com/dronm/gobizap"	
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
)

//Controller
type User_Controller struct {
	gobizap.Base_Controller
}

func NewController_User() *User_Controller{
	c := &User_Controller{gobizap.Base_Controller{ID: "User", PublicMethods: make(gobizap.PublicMethodCollection)}}
	
	keys_fields := fields.GenModelMD(reflect.ValueOf(models.User_keys{}))
	
	//************************** method insert **********************************
	c.PublicMethods["insert"] = &User_Controller_insert{
		gobizap.Base_PublicMethod{
			ID: "insert",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User{})),
			EventList: gobizap.PublicMethodEventList{"User.insert"},
		},				
	}
	
	//************************** method delete *************************************
	c.PublicMethods["delete"] = &User_Controller_delete{
		gobizap.Base_PublicMethod{
			ID: "delete",
			Fields: keys_fields,
			EventList: gobizap.PublicMethodEventList{"User.delete"},
		},		
	}

	//************************** method update *************************************
	c.PublicMethods["update"] = &User_Controller_update{
		gobizap.Base_PublicMethod{
			ID: "update",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User_old_keys{})),
			EventList: gobizap.PublicMethodEventList{"User.update"},
		},		
	}
	
	//************************** method get_object *************************************
	c.PublicMethods["get_object"] = &User_Controller_get_object{
		gobizap.Base_PublicMethod{
			ID: "get_object",
			Fields: keys_fields,
		},
	}

	//************************** method get_list *************************************
	c.PublicMethods["get_list"] = &User_Controller_get_list{
		gobizap.Base_PublicMethod{
			ID: "get_list",
			Fields: model.Cond_Model_fields,
		},		
	}

	//************************** method reset_pwd *************************************
	c.PublicMethods["reset_pwd"] = &User_Controller_reset_pwd{
		gobizap.Base_PublicMethod{
			ID: "reset_pwd",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User_reset_pwd{})),
		},		
	}

	//************************** method login *************************************
	c.PublicMethods["login"] = &User_Controller_login{
		gobizap.Base_PublicMethod{
			ID: "login",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User_login{})),
		},		
	}

	//************************** method login_token *************************************
	c.PublicMethods["login_token"] = &User_Controller_login_token{
		gobizap.Base_PublicMethod{
			ID: "login_token",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User_login_token{})),
		},		
	}

	//************************** method logout *************************************
	c.PublicMethods["logout"] = &User_Controller_logout{
		gobizap.Base_PublicMethod{
			ID: "logout",
		},		
	}
	
	//************************** method get_profile *************************************
	c.PublicMethods["get_profile"] = &User_Controller_get_profile{
		gobizap.Base_PublicMethod{
			ID: "get_profile",
		},		
	}
	
	//************************** method complete *************************************
	c.PublicMethods["complete"] = &User_Controller_complete{
		gobizap.Base_PublicMethod{
			ID: "complete",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User_complete{})),
		},		
	}
	
	//************************** method delete_photo *************************************
	c.PublicMethods["delete_photo"] = &User_Controller_delete_photo{
		gobizap.Base_PublicMethod{
			ID: "delete_photo",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User_delete_photo{})),
		},		
	}

	//************************** method password_recover *************************************
	c.PublicMethods["password_recover"] = &User_Controller_password_recover{
		gobizap.Base_PublicMethod{
			ID: "password_recover",
			Fields: fields.GenModelMD(reflect.ValueOf(models.User_password_recover{})),
		},		
	}
	
	return c
}

//**************************************************************************************
//Public method: insert
type User_Controller_insert struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *User_Controller_insert) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}

	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

//**************************************************************************************
//Public method: delete
type User_Controller_delete struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *User_Controller_delete) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_keys_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

//Public method: get_object
type User_Controller_get_object struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *User_Controller_get_object) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_keys_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

//**************************************************************************************
//Public method: get_list
type User_Controller_get_list struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *User_Controller_get_list) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &model.Controller_get_list_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}


//**************************************************************************************
//Public method: update
type User_Controller_update struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *User_Controller_update) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_old_keys_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}


//Public method: reset_pwd
type User_Controller_reset_pwd struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *User_Controller_reset_pwd) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_reset_pwd_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}


//Public method: login
type User_Controller_login struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *User_Controller_login) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_login_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}


//Public method: logout
type User_Controller_logout struct {
	gobizap.Base_PublicMethod
}
func (pm *User_Controller_logout) Unmarshal(payload []byte) (res reflect.Value, err error) {
	return
}

//Public method: login_token
type User_Controller_login_token struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *User_Controller_login_token) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_login_token_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

//********************************************************************************************
//Public method: get_profile
type User_Controller_get_profile struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *User_Controller_get_profile) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_keys_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

//********************************************************************************************
//Public method: complete
type User_Controller_complete struct {
	gobizap.Base_PublicMethod
}
//Public method Unmarshal to structure
func (pm *User_Controller_complete) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_complete_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

//
//Public method: delete_photo
type User_Controller_delete_photo struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *User_Controller_delete_photo) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_delete_photo_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

//Public method: password_recover
type User_Controller_password_recover struct {
	gobizap.Base_PublicMethod
}

//Public method Unmarshal to structure
func (pm *User_Controller_password_recover) Unmarshal(payload []byte) (res reflect.Value, err error) {

	//argument structrure
	argv := &models.User_password_recover_argv{}
	
	err = json.Unmarshal(payload, argv)
	if err != nil {
		return 
	}
	
	res = reflect.ValueOf(&argv.Argv).Elem()
	
	return
}

