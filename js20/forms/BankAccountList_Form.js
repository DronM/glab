/*
 * Copyright (c) 2024
 * Andrey Mikhalevich, Katren ltd.
 */
function BankAccountList_Form(options){
	options = options || {};	
	
	options.formName = "BankAccountList";
	options.controller = "BankAccount_Controller";
	options.method = "get_list";
	
	BankAccountList_Form.superclass.constructor.call(this,options);
		
}
extend(BankAccountList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

