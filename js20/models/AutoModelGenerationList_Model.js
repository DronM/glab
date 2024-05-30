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

function AutoModelGenerationList_Model(options){
	var id = 'AutoModelGenerationList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Марка';
	filed_options.autoInc = false;	
	
	options.fields.auto_make_id = new FieldInt("auto_make_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.auto_makes_ref = new FieldJSON("auto_makes_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Модель';
	filed_options.autoInc = false;	
	
	options.fields.auto_model_id = new FieldInt("auto_model_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.auto_models_ref = new FieldJSON("auto_models_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Номер поколения';
	filed_options.autoInc = false;	
	
	options.fields.generation_num = new FieldText("generation_num",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Заводской индекс модели';
	filed_options.autoInc = false;	
	
	options.fields.prod_index = new FieldText("prod_index",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Начало производтва';
	filed_options.autoInc = false;	
	
	options.fields.year_from = new FieldInt("year_from",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Окончание производтва';
	filed_options.autoInc = false;	
	
	options.fields.year_to = new FieldInt("year_to",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Модификация';
	filed_options.autoInc = false;	
	
	options.fields.model = new FieldText("model",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Серия';
	filed_options.autoInc = false;	
	
	options.fields.series = new FieldText("series",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Название';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldString("name",filed_options);
							
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Количество кузовов';
	filed_options.autoInc = false;	
	
	options.fields.body_count = new FieldInt("body_count",filed_options);
	
		AutoModelGenerationList_Model.superclass.constructor.call(this,id,options);
}
extend(AutoModelGenerationList_Model,ModelXML);

