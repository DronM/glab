/*
 * Copyright (c) 2024
 * Andrey Mikhalevich, Katren ltd.
 */
function BankFlowList_Form(options){
	options = options || {};	
	
	options.formName = "BankFlowList";
	options.controller = "BankFlow_Controller";
	options.method = "get_list";
	
	BankFlowList_Form.superclass.constructor.call(this,options);
		
}
extend(BankFlowList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

