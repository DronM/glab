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

function ImportItemList_Model(options){
	var id = 'ImportItemList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дата импорта';
	filed_options.autoInc = false;	
	
	options.fields.date_time = new FieldDateTimeTZ("date_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комментарий импорта';
	filed_options.autoInc = false;	
	
	options.fields.import_comment = new FieldText("import_comment",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldText("name",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Марка';
	filed_options.autoInc = false;	
	
	options.fields.make = new FieldText("make",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Модель';
	filed_options.autoInc = false;	
	
	options.fields.model = new FieldText("model",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Поколнение';
	filed_options.autoInc = false;	
	
	options.fields.model_generation = new FieldText("model_generation",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Кузов';
	filed_options.autoInc = false;	
	
	options.fields.body = new FieldText("body",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Поставщик';
	filed_options.autoInc = false;	
	
	options.fields.supplier = new FieldText("supplier",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Группа товаров';
	filed_options.autoInc = false;	
	
	options.fields.item_folders_ref = new FieldJSON("item_folders_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какой марки';
	filed_options.autoInc = false;	
	
	options.fields.auto_makes_ref = new FieldJSON("auto_makes_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какой модели';
	filed_options.autoInc = false;	
	
	options.fields.auto_models_ref = new FieldJSON("auto_models_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какого поколения модели';
	filed_options.autoInc = false;	
	
	options.fields.auto_model_generations_ref = new FieldJSON("auto_model_generations_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какого кузова';
	filed_options.autoInc = false;	
	
	options.fields.auto_bodies_ref = new FieldJSON("auto_bodies_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какого поствщика';
	filed_options.autoInc = false;	
	
	options.fields.suppliers_ref = new FieldJSON("suppliers_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Опции';
	filed_options.autoInc = false;	
	
	options.fields.options = new FieldJSON("options",filed_options);
	
		ImportItemList_Model.superclass.constructor.call(this,id,options);
}
extend(ImportItemList_Model,ModelXML);

