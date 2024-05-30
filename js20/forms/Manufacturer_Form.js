/** Copyright (c) 2023
	Andrey Mikhalevich, Katren ltd.
*/
function Manufacturer_Form(options){
	options = options || {};	
	
	options.formName = "ManufacturerDialog";
	options.controller = "Manufacturer_Controller";
	options.method = "get_object";
	
	Manufacturer_Form.superclass.constructor.call(this,options);
	
}
extend(Manufacturer_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

