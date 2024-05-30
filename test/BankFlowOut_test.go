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

const BankFlowOut_contr = "BankFlowOut_Controller"

func TestBankFlowOut_insert(t *testing.T) {
	cl, params := GetClient()
	params["date_time"] = '2024-04-26PKT09:00:19'
	if err := cl.SendGet(BankFlowOut_contr, "insert", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankFlowOut_get_list(t *testing.T) {
	cl, params := GetClient()
	if err := cl.SendGet(BankFlowOut_contr, "get_list", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankFlowOut_get_object(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(BankFlowOut_contr, "get_object", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankFlowOut_delete(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(BankFlowOut_contr, "delete", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}



