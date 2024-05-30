/*
 * Copyright (c) 2023
 * Andrey Mikhalevich, Katren ltd.
 */
function ItemFolderList_Form(options){
	options = options || {};	
	
	options.formName = "ItemFolderList";
	options.controller = "ItemFolder_Controller";
	options.method = "get_list";
	
	ItemFolderList_Form.superclass.constructor.call(this,options);
		
}
extend(ItemFolderList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

