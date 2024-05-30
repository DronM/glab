/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function WarehouseList_Form(options){
	options = options || {};	
	
	options.formName = "WarehouseList";
	options.controller = "Warehouse_Controller";
	options.method = "get_list";
	
	WarehouseList_Form.superclass.constructor.call(this,options);
		
}
extend(WarehouseList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

