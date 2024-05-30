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

function BankAccountList_Model(options){
	var id = 'BankAccountList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип родителя';
	filed_options.autoInc = false;	
	
	options.fields.parent_data_type = new FieldEnum("parent_data_type",filed_options);
	filed_options.enumValues = 'users,employees,bank_cards,contacts,firms';
	options.fields.parent_data_type.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'ИД родителя';
	filed_options.autoInc = false;	
	
	options.fields.parent_id = new FieldInt("parent_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Родитель';
	filed_options.autoInc = false;	
	
	options.fields.parents_ref = new FieldJSON("parents_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldText("name",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Расчетный счет';
	filed_options.autoInc = false;	
	
	options.fields.bank_acc = new FieldString("bank_acc",filed_options);
	options.fields.bank_acc.getValidator().setMaxLength('20');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.banks_ref = new FieldJSON("banks_ref",filed_options);
	
		BankAccountList_Model.superclass.constructor.call(this,id,options);
}
extend(BankAccountList_Model,ModelXML);

