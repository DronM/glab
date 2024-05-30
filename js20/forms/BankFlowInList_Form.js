/*
 * Copyright (c) 2024
 * Andrey Mikhalevich, Katren ltd.
 */
function BankFlowInList_Form(options){
	options = options || {};	
	
	options.formName = "BankFlowInList";
	options.controller = "BankFlowIn_Controller";
	options.method = "get_list";
	
	BankFlowInList_Form.superclass.constructor.call(this,options);
		
}
extend(BankFlowInList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

