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

function FinExpenseTypeItemList_Model(options){
	var id = 'FinExpenseTypeItemList_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = false;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Родитель 1 ID';
	filed_options.autoInc = false;	
	
	options.fields.parent1_id = new FieldInt("parent1_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Родитель 2 ID';
	filed_options.autoInc = false;	
	
	options.fields.parent2_id = new FieldInt("parent2_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Родитель 1';
	filed_options.autoInc = false;	
	
	options.fields.parents1_ref = new FieldJSON("parents1_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Родитель 2';
	filed_options.autoInc = false;	
	
	options.fields.parents2_ref = new FieldJSON("parents2_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldText("name",filed_options);
	
		FinExpenseTypeItemList_Model.superclass.constructor.call(this,id,options);
}
extend(FinExpenseTypeItemList_Model,ModelXML);

