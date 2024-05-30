/*
 * Copyright (c) 2024
 * Andrey Mikhalevich, Katren ltd.
 */
function FirmList_Form(options){
	options = options || {};	
	
	options.formName = "FirmList";
	options.controller = "Firm_Controller";
	options.method = "get_list";
	
	FirmList_Form.superclass.constructor.call(this,options);
		
}
extend(FirmList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

