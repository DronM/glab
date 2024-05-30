/** Copyright (c) 2022
	Andrey Mikhalevich, Katren ltd.
*/
function ItemFolderFeature_Form(options){
	options = options || {};	
	
	options.formName = "ItemFolderFeatureDialog";
	options.controller = "ItemFolderFeature_Controller";
	options.method = "get_object";
	
	ItemFolderFeature_Form.superclass.constructor.call(this,options);
	
}
extend(ItemFolderFeature_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

