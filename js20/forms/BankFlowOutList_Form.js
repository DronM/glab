/*
 * Copyright (c) 2024
 * Andrey Mikhalevich, Katren ltd.
 */
function BankFlowOutList_Form(options){
	options = options || {};	
	
	options.formName = "BankFlowOutList";
	options.controller = "BankFlowOut_Controller";
	options.method = "get_list";
	
	BankFlowOutList_Form.superclass.constructor.call(this,options);
		
}
extend(BankFlowOutList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

