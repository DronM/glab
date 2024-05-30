/** Copyright (c) 2023
	Andrey Mikhalevich, Katren ltd.
*/
function SupplierItem_Form(options){
	options = options || {};	
	
	options.formName = "SupplierItemDialog";
	options.controller = "SupplierItem_Controller";
	options.method = "get_object";
	
	SupplierItem_Form.superclass.constructor.call(this,options);
	
}
extend(SupplierItem_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

