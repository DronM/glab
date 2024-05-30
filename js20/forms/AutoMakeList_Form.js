/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function AutoMakeList_Form(options){
	options = options || {};	
	
	options.formName = "AutoMakeList";
	options.controller = "AutoMake_Controller";
	options.method = "get_list";
	
	AutoMakeList_Form.superclass.constructor.call(this,options);
		
}
extend(AutoMakeList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

