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

const BankFlow_contr = "BankFlow_Controller"

func TestBankFlow_insert(t *testing.T) {
	cl, params := GetClient()
	params["uploaded_date_time"] = '2024-04-25PKT15:52:45'
	if err := cl.SendGet(BankFlow_contr, "insert", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankFlow_get_list(t *testing.T) {
	cl, params := GetClient()
	if err := cl.SendGet(BankFlow_contr, "get_list", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankFlow_get_object(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(BankFlow_contr, "get_object", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankFlow_delete(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(BankFlow_contr, "delete", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}



