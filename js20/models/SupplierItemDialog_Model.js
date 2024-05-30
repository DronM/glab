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

function SupplierItemDialog_Model(options){
	var id = 'SupplierItemDialog_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование товара';
	filed_options.autoInc = false;	
	
	options.fields.item_name = new FieldString("item_name",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Базовый товар';
	filed_options.autoInc = false;	
	
	options.fields.items_ref = new FieldJSON("items_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Группа товаров';
	filed_options.autoInc = false;	
	
	options.fields.item_folders_ref = new FieldJSON("item_folders_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Поставщик';
	filed_options.autoInc = false;	
	
	options.fields.suppliers_ref = new FieldJSON("suppliers_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'ID поставщика';
	filed_options.autoInc = false;	
	
	options.fields.supplier_item_id = new FieldJSON("supplier_item_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Производитель';
	filed_options.autoInc = false;	
	
	options.fields.item_manufacturers_ref = new FieldJSON("item_manufacturers_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Цена поставщика';
	filed_options.autoInc = false;	
	
	options.fields.cost = new FieldFloat("cost",filed_options);
	options.fields.cost.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Рекомендованная розничная цена';
	filed_options.autoInc = false;	
	
	options.fields.sale_price = new FieldFloat("sale_price",filed_options);
	options.fields.sale_price.getValidator().setMaxLength('15');
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Артикул (код поставщика)';
	filed_options.autoInc = false;	
	
	options.fields.artikul = new FieldText("artikul",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комментарий текст';
	filed_options.autoInc = false;	
	
	options.fields.comment_text = new FieldText("comment_text",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комментарий примечание';
	filed_options.autoInc = false;	
	
	options.fields.comment_note = new FieldText("comment_note",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.pictures = new FieldJSON("pictures",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Характеристики';
	filed_options.autoInc = false;	
	
	options.fields.supplier_features_list = new FieldJSON("supplier_features_list",filed_options);
				
		SupplierItemDialog_Model.superclass.constructor.call(this,id,options);
}
extend(SupplierItemDialog_Model,ModelXML);

