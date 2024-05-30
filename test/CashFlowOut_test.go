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

const CashFlowOut_contr = "CashFlowOut_Controller"

func TestCashFlowOut_insert(t *testing.T) {
	cl, params := GetClient()
	params["expence_type3_id"] = 1
	if err := cl.SendGet(CashFlowOut_contr, "insert", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestCashFlowOut_get_list(t *testing.T) {
	cl, params := GetClient()
	if err := cl.SendGet(CashFlowOut_contr, "get_list", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestCashFlowOut_get_object(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(CashFlowOut_contr, "get_object", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestCashFlowOut_delete(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(CashFlowOut_contr, "delete", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}



