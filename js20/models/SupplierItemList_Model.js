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

function SupplierItemList_Model(options){
	var id = 'SupplierItemList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.item_id = new FieldInt("item_id",filed_options);
	
				
	
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
	
	filed_options.autoInc = false;	
	
	options.fields.supplier_id = new FieldInt("supplier_id",filed_options);
	
				
	
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
	filed_options.alias = 'Цена поставщика';
	filed_options.autoInc = false;	
	
	options.fields.cost = new FieldFloat("cost",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Рекомендованная розничная цена';
	filed_options.autoInc = false;	
	
	options.fields.sale_price = new FieldFloat("sale_price",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Артикул (код поставщика)';
	filed_options.autoInc = false;	
	
	options.fields.artikul = new FieldText("artikul",filed_options);
				
		SupplierItemList_Model.superclass.constructor.call(this,id,options);
}
extend(SupplierItemList_Model,ModelXML);

