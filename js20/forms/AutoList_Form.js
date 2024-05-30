/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function AutoList_Form(options){
	options = options || {};	
	
	options.formName = "AutoList";
	options.controller = "Auto_Controller";
	options.method = "get_list";
	
	AutoList_Form.superclass.constructor.call(this,options);
		
}
extend(AutoList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

