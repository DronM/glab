/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function AutoModelList_Form(options){
	options = options || {};	
	
	options.formName = "AutoModelList";
	options.controller = "AutoModel_Controller";
	options.method = "get_list";
	
	AutoModelList_Form.superclass.constructor.call(this,options);
		
}
extend(AutoModelList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

