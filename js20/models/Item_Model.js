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

function Item_Model(options){
	var id = 'Item_Model';
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
	
	options.fields.item_folder_id = new FieldInt("item_folder_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какой марки';
	filed_options.autoInc = false;	
	
	options.fields.auto_make_id = new FieldInt("auto_make_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какой модели';
	filed_options.autoInc = false;	
	
	options.fields.auto_model_id = new FieldInt("auto_model_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какого поколения модели';
	filed_options.autoInc = false;	
	
	options.fields.auto_model_generation_id = new FieldInt("auto_model_generation_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для какого кузова';
	filed_options.autoInc = false;	
	
	options.fields.auto_body_id = new FieldInt("auto_body_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Производитель';
	filed_options.autoInc = false;	
	
	options.fields.manufacturer_brand_id = new FieldInt("manufacturer_brand_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Значение фильтруемых свойств';
	filed_options.autoInc = false;	
	
	options.fields.feature_vals = new FieldText("feature_vals",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.defValue = true;
	filed_options.alias = 'Дата модификации';
	filed_options.autoInc = false;	
	
	options.fields.modified_dt = new FieldDateTimeTZ("modified_dt",filed_options);
	
						
									
		Item_Model.superclass.constructor.call(this,id,options);
}
extend(Item_Model,ModelXML);

