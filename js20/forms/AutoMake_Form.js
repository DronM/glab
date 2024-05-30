/** Copyright (c) 2022
	Andrey Mikhalevich, Katren ltd.
*/
function AutoMake_Form(options){
	options = options || {};	
	
	options.formName = "AutoMakeDialog";
	options.controller = "AutoMake_Controller";
	options.method = "get_object";
	
	AutoMake_Form.superclass.constructor.call(this,options);
	
}
extend(AutoMake_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

