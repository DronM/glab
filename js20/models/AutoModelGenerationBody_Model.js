/**	
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/models/Model_js.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 * @class
 * @classdesc Model class. Created from template build/templates/models/Model_js.xsl. !!!DO NOT MODEFY!!!
 
 * @extends ModelXML
 
 * @requires core/extend.js
 * @requires core/ModelXML.js
 
 * @param {string} id 
 * @param {Object} options
 */

function AutoModelGenerationBody_Model(options){
	var id = 'AutoModelGenerationBody_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Поколение';
	filed_options.autoInc = false;	
	
	options.fields.auto_model_generation_id = new FieldInt("auto_model_generation_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Кузов';
	filed_options.autoInc = false;	
	
	options.fields.auto_body_id = new FieldInt("auto_body_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Еврокод';
	filed_options.autoInc = false;	
	
	options.fields.eurocode = new FieldText("eurocode",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Внутренний код ID';
	filed_options.autoInc = false;	
	
	options.fields.local_id = new FieldString("local_id",filed_options);
	options.fields.local_id.getValidator().setMaxLength('10');
				
		AutoModelGenerationBody_Model.superclass.constructor.call(this,id,options);
}
extend(AutoModelGenerationBody_Model,ModelXML);

