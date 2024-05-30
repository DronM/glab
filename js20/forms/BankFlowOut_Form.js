/** Copyright (c) 2024
	Andrey Mikhalevich, Katren ltd.
*/
function BankFlowOut_Form(options){
	options = options || {};	
	
	options.formName = "BankFlowOutDialog";
	options.controller = "BankFlowOut_Controller";
	options.method = "get_object";
	
	BankFlowOut_Form.superclass.constructor.call(this,options);
	
}
extend(BankFlowOut_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

