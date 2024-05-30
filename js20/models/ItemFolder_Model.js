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

function ItemFolder_Model(options){
	var id = 'ItemFolder_Model';
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
	options.fields.name.getValidator().setRequired(true);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Родитель';
	filed_options.autoInc = false;	
	
	options.fields.parent_item_folder_id = new FieldInt("parent_item_folder_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Код';
	filed_options.autoInc = false;	
	
	options.fields.code = new FieldInt("code",filed_options);
	options.fields.code.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Приоритет вывода';
	filed_options.autoInc = false;	
	
	options.fields.item_priority_id = new FieldInt("item_priority_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип транпорта';
	filed_options.autoInc = false;	
	
	options.fields.vehicle_type_id = new FieldInt("vehicle_type_id",filed_options);
	
						
									
		ItemFolder_Model.superclass.constructor.call(this,id,options);
}
extend(ItemFolder_Model,ModelXML);

