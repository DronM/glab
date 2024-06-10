package tests

/**
 * Andrey Mikhalevich 18/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller_test.go.tmpl
 */

import(
	"testing"
	
	"glab/enums"
)

const MainMenuConstructor_contr = "MainMenuConstructor_Controller"

func TestMainMenuConstructor_insert(t *testing.T) {
	cl, params := GetClient()
	params["content"] = ``
	if err := cl.SendGet(MainMenuConstructor_contr, "insert", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestMainMenuConstructor_get_list(t *testing.T) {
	cl, params := GetClient()
	if err := cl.SendGet(MainMenuConstructor_contr, "get_list", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestMainMenuConstructor_get_object(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(MainMenuConstructor_contr, "get_object", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestMainMenuConstructor_delete(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(MainMenuConstructor_contr, "delete", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}



