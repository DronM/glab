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

function AutoBodyList_Model(options){
	var id = 'AutoBodyList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование кузова';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldText("name",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Модель';
	filed_options.autoInc = false;	
	
	options.fields.auto_model_id = new FieldInt("auto_model_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Модель';
	filed_options.autoInc = false;	
	
	options.fields.auto_models_ref = new FieldJSON("auto_models_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип кузова идентификатор';
	filed_options.autoInc = false;	
	
	options.fields.auto_body_type_id = new FieldInt("auto_body_type_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип кузова';
	filed_options.autoInc = false;	
	
	options.fields.auto_body_types_ref = new FieldJSON("auto_body_types_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип дверей кузова';
	filed_options.autoInc = false;	
	
	options.fields.auto_body_doors_ref = new FieldJSON("auto_body_doors_ref",filed_options);
	
				
	
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
	filed_options.alias = 'Модель';
	filed_options.autoInc = false;	
	
	options.fields.model = new FieldText("model",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Категория цены';
	filed_options.autoInc = false;	
	
	options.fields.auto_price_categories_ref = new FieldJSON("auto_price_categories_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Размер кузова';
	filed_options.autoInc = false;	
	
	options.fields.auto_body_size = new FieldString("auto_body_size",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Класс сложности пленка кузов';
	filed_options.autoInc = false;	
	
	options.fields.complexity_film_body = new FieldInt("complexity_film_body",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Класс сложности пленка перед';
	filed_options.autoInc = false;	
	
	options.fields.complexity_film_front = new FieldInt("complexity_film_front",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Класс сложности пленка зад';
	filed_options.autoInc = false;	
	
	options.fields.complexity_film_back = new FieldInt("complexity_film_back",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Класс сложности замена стекла';
	filed_options.autoInc = false;	
	
	options.fields.complexity_glass = new FieldInt("complexity_glass",filed_options);
	
		AutoBodyList_Model.superclass.constructor.call(this,id,options);
}
extend(AutoBodyList_Model,ModelXML);

