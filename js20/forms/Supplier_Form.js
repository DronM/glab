/** Copyright (c) 2023
	Andrey Mikhalevich, Katren ltd.
*/
function Supplier_Form(options){
	options = options || {};	
	
	options.formName = "SupplierDialog";
	options.controller = "Supplier_Controller";
	options.method = "get_object";
	
	Supplier_Form.superclass.constructor.call(this,options);
	
}
extend(Supplier_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

