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

function AutoMakeList_Model(options){
	var id = 'AutoMakeList_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
							
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'ID';
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldText("name",filed_options);
	options.fields.name.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Варианты наименования';
	filed_options.autoInc = false;	
	
	options.fields.name_variants = new FieldText("name_variants",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.logo = new FieldJSON("logo",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Популярность брэнда';
	filed_options.autoInc = false;	
	
	options.fields.popularity_types_ref = new FieldJSON("popularity_types_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.popularity_type_id = new FieldInt("popularity_type_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Количество моделей';
	filed_options.autoInc = false;	
	
	options.fields.model_count = new FieldInt("model_count",filed_options);
	
		AutoMakeList_Model.superclass.constructor.call(this,id,options);
}
extend(AutoMakeList_Model,ModelXML);

