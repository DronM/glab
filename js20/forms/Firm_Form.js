/** Copyright (c) 2024
	Andrey Mikhalevich, Katren ltd.
*/
function Firm_Form(options){
	options = options || {};	
	
	options.formName = "FirmDialog";
	options.controller = "Firm_Controller";
	options.method = "get_object";
	
	Firm_Form.superclass.constructor.call(this,options);
	
}
extend(Firm_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

