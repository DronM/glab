/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function ItemFeatureList_Form(options){
	options = options || {};	
	
	options.formName = "ItemFeatureList";
	options.controller = "ItemFeature_Controller";
	options.method = "get_list";
	
	ItemFeatureList_Form.superclass.constructor.call(this,options);
		
}
extend(ItemFeatureList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

