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

function AutoToGlassMatchEurocodeBodyList_Model(options){
	var id = 'AutoToGlassMatchEurocodeBodyList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.auto_to_glass_match_head_id = new FieldInt("auto_to_glass_match_head_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Полный код';
	filed_options.autoInc = false;	
	
	options.fields.eurocode_local = new FieldText("eurocode_local",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Кузов тип дверй';
	filed_options.autoInc = false;	
	
	options.fields.doors = new FieldText("doors",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Кузов тип';
	filed_options.autoInc = false;	
	
	options.fields.type = new FieldText("type",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Кузов модель';
	filed_options.autoInc = false;	
	
	options.fields.model = new FieldText("model",filed_options);
	
		AutoToGlassMatchEurocodeBodyList_Model.superclass.constructor.call(this,id,options);
}
extend(AutoToGlassMatchEurocodeBodyList_Model,ModelXML);

