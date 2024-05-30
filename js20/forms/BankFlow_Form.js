/** Copyright (c) 2024
	Andrey Mikhalevich, Katren ltd.
*/
function BankFlow_Form(options){
	options = options || {};	
	
	options.formName = "BankFlowDialog";
	options.controller = "BankFlow_Controller";
	options.method = "get_object";
	
	BankFlow_Form.superclass.constructor.call(this,options);
	
}
extend(BankFlow_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

