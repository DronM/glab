/*
 * Copyright (c) 2024
 * Andrey Mikhalevich, Katren ltd.
 */
function FinExpenseTypeList_Form(options){
	options = options || {};	
	
	options.formName = "FinExpenseTypeList";
	options.controller = "FinExpenseType_Controller";
	options.method = "get_list";
	
	FinExpenseTypeList_Form.superclass.constructor.call(this,options);
		
}
extend(FinExpenseTypeList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

