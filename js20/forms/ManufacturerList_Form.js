/*
 * Copyright (c) 2023
 * Andrey Mikhalevich, Katren ltd.
 */
function ManufacturerList_Form(options){
	options = options || {};	
	
	options.formName = "ManufacturerList";
	options.controller = "Manufacturer_Controller";
	options.method = "get_list";
	
	ManufacturerList_Form.superclass.constructor.call(this,options);
		
}
extend(ManufacturerList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

