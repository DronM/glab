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

const BankAccount_contr = "BankAccount_Controller"

func TestBankAccount_insert(t *testing.T) {
	cl, params := GetClient()
	params["parent_data_type"] = enums.ValEnum_data_types{}.GetValues()[0]
	if err := cl.SendGet(BankAccount_contr, "insert", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankAccount_get_list(t *testing.T) {
	cl, params := GetClient()
	if err := cl.SendGet(BankAccount_contr, "get_list", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankAccount_get_object(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(BankAccount_contr, "get_object", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}

func TestBankAccount_delete(t *testing.T) {
	cl, params := GetClient()
	params["id"] = 1
	if err := cl.SendGet(BankAccount_contr, "delete", VIEW, "", params); err != nil {
		t.Fatalf("%v", err)
	}
}



