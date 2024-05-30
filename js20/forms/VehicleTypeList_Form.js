/*
 * Copyright (c) 2023
 * Andrey Mikhalevich, Katren ltd.
 */
function VehicleTypeList_Form(options){
	options = options || {};	
	
	options.formName = "VehicleTypeList";
	options.controller = "VehicleType_Controller";
	options.method = "get_list";
	
	VehicleTypeList_Form.superclass.constructor.call(this,options);
		
}
extend(VehicleTypeList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

