
/*
 * Copyright (c) 2024
 * Andrey Mikhalevich, Katren ltd.
 */
function FinExpenseTypeItemList_Form(options){
	options = options || {};	
	
	options.formName = "FinExpenseTypeItemList";
	options.controller = "FinExpenseType_Controller";
	options.method = "get_item_list";
	
	FinExpenseTypeItemList_Form.superclass.constructor.call(this,options);
		
}
extend(FinExpenseTypeItemList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

