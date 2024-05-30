/*
 * Copyright (c) 2023
 * Andrey Mikhalevich, Katren ltd.
 */
function SupplierStoreList_Form(options){
	options = options || {};	
	
	options.formName = "SupplierStoreList";
	options.controller = "SupplierStore_Controller";
	options.method = "get_list";
	
	SupplierStoreList_Form.superclass.constructor.call(this,options);
		
}
extend(SupplierStoreList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

