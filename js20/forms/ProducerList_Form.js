/*
 * Copyright (c) 2022
 * Andrey Mikhalevich, Katren ltd.
 */
function ProducerList_Form(options){
	options = options || {};	
	
	options.formName = "ProducerList";
	options.controller = "Producer_Controller";
	options.method = "get_list";
	
	ProducerList_Form.superclass.constructor.call(this,options);
		
}
extend(ProducerList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

