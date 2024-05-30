/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function ManufacturerBrandList_Form(options){
	options = options || {};	
	
	options.formName = "ManufacturerBrandList";
	options.controller = "ManufacturerBrand_Controller";
	options.method = "get_list";
	
	ManufacturerBrandList_Form.superclass.constructor.call(this,options);
		
}
extend(ManufacturerBrandList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

