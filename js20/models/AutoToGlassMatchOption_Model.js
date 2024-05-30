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

function AutoToGlassMatchOption_Model(options){
	var id = 'AutoToGlassMatchOption_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Master';
	filed_options.autoInc = false;	
	
	options.fields.auto_to_glass_match_head_id = new FieldInt("auto_to_glass_match_head_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Группа стекол';
	filed_options.autoInc = false;	
	
	options.fields.item_priority_id = new FieldInt("item_priority_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Номер строки';
	filed_options.autoInc = false;	
	
	options.fields.line_num = new FieldInt("line_num",filed_options);
													
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список еврокодов с отметками';
	filed_options.autoInc = false;	
	
	options.fields.eurocode_list = new FieldArray("eurocode_list",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список еврокодов с отметками (для просмотра)';
	filed_options.autoInc = false;	
	
	options.fields.eurocode_view = new FieldText("eurocode_view",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список дверей кузовов с отметками';
	filed_options.autoInc = false;	
	
	options.fields.body_door_list = new FieldJSONB("body_door_list",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список дверей кузовов с отметками (для просмотра)';
	filed_options.autoInc = false;	
	
	options.fields.body_door_view = new FieldText("body_door_view",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список типов кузовов с отметками';
	filed_options.autoInc = false;	
	
	options.fields.body_type_list = new FieldJSONB("body_type_list",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список типов кузовов с отметками (для просмотра)';
	filed_options.autoInc = false;	
	
	options.fields.body_type_view = new FieldText("body_type_view",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список моделей кузовов с отметками';
	filed_options.autoInc = false;	
	
	options.fields.body_model_list = new FieldArray("body_model_list",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список моделей кузовов с отметками (для просмотра)';
	filed_options.autoInc = false;	
	
	options.fields.body_model_view = new FieldText("body_model_view",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Список опций со значениями';
	filed_options.autoInc = false;	
	
	options.fields.option_list = new FieldJSONB("option_list",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.defValue = true;
	filed_options.alias = 'Минимальный складской остаток эконом';
	filed_options.autoInc = false;	
	
	options.fields.quant_econom = new FieldInt("quant_econom",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.defValue = true;
	filed_options.alias = 'Минимальный складской остаток стандарт';
	filed_options.autoInc = false;	
	
	options.fields.quant_standart = new FieldInt("quant_standart",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.defValue = true;
	filed_options.alias = 'Минимальный складской остаток премиум';
	filed_options.autoInc = false;	
	
	options.fields.quant_premium = new FieldInt("quant_premium",filed_options);
													
															
		AutoToGlassMatchOption_Model.superclass.constructor.call(this,id,options);
}
extend(AutoToGlassMatchOption_Model,ModelXML);

