package tests

/**
 * Andrey Mikhalevich 18/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller_test.go.tmpl
 */

import(
	"testing"
	
)

const UserOperation_contr = "UserOperation_Controller"



func TestUserOperation_get_object(t *testing.T) {
	cl, params := GetClient()
	params["operation_id"] = `Some text string`
	if err := cl.SendGet(UserOperation_contr, "get_object", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestUserOperation_delete(t *testing.T) {
	cl, params := GetClient()
	params["operation_id"] = `Some text string`
	if err := cl.SendGet(UserOperation_contr, "delete", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}



