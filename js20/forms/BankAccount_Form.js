/** Copyright (c) 2024
	Andrey Mikhalevich, Katren ltd.
*/
function BankAccount_Form(options){
	options = options || {};	
	
	options.formName = "BankAccountDialog";
	options.controller = "BankAccount_Controller";
	options.method = "get_object";
	
	BankAccount_Form.superclass.constructor.call(this,options);
	
}
extend(BankAccount_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

