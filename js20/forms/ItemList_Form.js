/*
 * Copyright (c) 2023
 * Andrey Mikhalevich, Katren ltd.
 */
function ItemList_Form(options){
	options = options || {};	
	
	options.formName = "ItemList";
	options.controller = "Item_Controller";
	options.method = "get_list";
	
	ItemList_Form.superclass.constructor.call(this,options);
		
}
extend(ItemList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

