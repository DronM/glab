/** Copyright (c) 2024
	Andrey Mikhalevich, Katren ltd.
*/
function BankFlowIn_Form(options){
	options = options || {};	
	
	options.formName = "BankFlowInDialog";
	options.controller = "BankFlowIn_Controller";
	options.method = "get_object";
	
	BankFlowIn_Form.superclass.constructor.call(this,options);
	
}
extend(BankFlowIn_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

