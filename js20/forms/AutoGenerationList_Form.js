/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function AutoGenerationList_Form(options){
	options = options || {};	
	
	options.formName = "AutoGenerationList";
	options.controller = "AutoGeneration_Controller";
	options.method = "get_list";
	
	AutoGenerationList_Form.superclass.constructor.call(this,options);
		
}
extend(AutoGenerationList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

