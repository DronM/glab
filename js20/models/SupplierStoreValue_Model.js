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

function SupplierStoreValue_Model(options){
	var id = 'SupplierStoreValue_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Место хранения поставщика';
	filed_options.autoInc = false;	
	
	options.fields.supplier_store_id = new FieldInt("supplier_store_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Номенлатура поставщика';
	filed_options.autoInc = false;	
	
	options.fields.supplier_item_id = new FieldInt("supplier_item_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Остаток';
	filed_options.autoInc = false;	
	
	options.fields.val = new FieldText("val",filed_options);
	
						
			
		SupplierStoreValue_Model.superclass.constructor.call(this,id,options);
}
extend(SupplierStoreValue_Model,ModelXML);

