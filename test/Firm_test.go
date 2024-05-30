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

const Firm_contr = "Firm_Controller"

func TestFirm_insert(t *testing.T) {
	cl, params := GetClient()
	if err := cl.SendGet(Firm_contr, "insert", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestFirm_get_list(t *testing.T) {
	cl, params := GetClient()
	if err := cl.SendGet(Firm_contr, "get_list", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestFirm_get_object(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(Firm_contr, "get_object", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestFirm_delete(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(Firm_contr, "delete", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}



