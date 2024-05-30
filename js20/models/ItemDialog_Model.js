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

function ItemDialog_Model(options){
	var id = 'ItemDialog_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldText("name",filed_options);
	
				
	
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
	filed_options.alias = 'Производитель';
	filed_options.autoInc = false;	
	
	options.fields.manufacturers_ref = new FieldJSON("manufacturers_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Производитель';
	filed_options.autoInc = false;	
	
	options.fields.manufacturer_brands_ref = new FieldJSON("manufacturer_brands_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Характеристики';
	filed_options.autoInc = false;	
	
	options.fields.features_list = new FieldJSON("features_list",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.pictures = new FieldJSON("pictures",filed_options);
	
		ItemDialog_Model.superclass.constructor.call(this,id,options);
}
extend(ItemDialog_Model,ModelXML);

