/** Copyright (c) 2023
	Andrey Mikhalevich, Katren ltd.
*/
function Item_Form(options){
	options = options || {};	
	
	options.formName = "ItemDialog";
	options.controller = "Item_Controller";
	options.method = "get_object";
	
	Item_Form.superclass.constructor.call(this,options);
	
}
extend(Item_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

