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

function SupplierItem_Model(options){
	var id = 'SupplierItem_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Базовый товар';
	filed_options.autoInc = false;	
	
	options.fields.item_id = new FieldInt("item_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Поставщик';
	filed_options.autoInc = false;	
	
	options.fields.supplier_id = new FieldInt("supplier_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'ID поставщика';
	filed_options.autoInc = false;	
	
	options.fields.supplier_item_id = new FieldText("supplier_item_id",filed_options);
	
				
	
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
	filed_options.defValue = true;
	filed_options.alias = 'Дата модификации';
	filed_options.autoInc = false;	
	
	options.fields.modified_dt = new FieldDateTimeTZ("modified_dt",filed_options);
	
						
						
						
			
		SupplierItem_Model.superclass.constructor.call(this,id,options);
}
extend(SupplierItem_Model,ModelXML);

