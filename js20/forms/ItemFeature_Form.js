/** Copyright (c) 2022
	Andrey Mikhalevich, Katren ltd.
*/
function ItemFeature_Form(options){
	options = options || {};	
	
	options.formName = "ItemFeatureDialog";
	options.controller = "ItemFeature_Controller";
	options.method = "get_object";
	
	ItemFeature_Form.superclass.constructor.call(this,options);
	
}
extend(ItemFeature_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

