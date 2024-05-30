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

function RABankFlow_Model(options){
	var id = 'RABankFlow_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Код';
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Период';
	filed_options.autoInc = false;	
	
	options.fields.date_time = new FieldDateTime("date_time",filed_options);
	options.fields.date_time.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дебет';
	filed_options.autoInc = false;	
	
	options.fields.deb = new FieldBool("deb",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Вид документа';
	filed_options.autoInc = false;	
	
	options.fields.doc_type = new FieldEnum("doc_type",filed_options);
	filed_options.enumValues = 'cash_flow_in,cash_flow_out,cash_flow_transfers,bank_flow_in,bank_flow_out';
	options.fields.doc_type.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.doc_id = new FieldInt("doc_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.bank_account_id = new FieldInt("bank_account_id",filed_options);
	options.fields.bank_account_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сумма';
	filed_options.autoInc = false;	
	
	options.fields.total = new FieldFloat("total",filed_options);
	options.fields.total.getValidator().setMaxLength('15');
	
			
			
			
		RABankFlow_Model.superclass.constructor.call(this,id,options);
}
extend(RABankFlow_Model,ModelXML);

