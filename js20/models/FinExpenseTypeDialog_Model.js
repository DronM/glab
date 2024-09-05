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

function FinExpenseTypeDialog_Model(options){
	var id = 'FinExpenseTypeDialog_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
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
	filed_options.alias = 'Уровень';
	filed_options.autoInc = false;	
	
	options.fields.lev = new FieldInt("lev",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для кассы';
	filed_options.autoInc = false;	
	
	options.fields.for_cash = new FieldBool("for_cash",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для банка';
	filed_options.autoInc = false;	
	
	options.fields.for_bank = new FieldBool("for_bank",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Правило поиска соответствия для банка';
	filed_options.autoInc = false;	
	
	options.fields.bank_match_rule = new FieldText("bank_match_rule",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Удален, отображать не всем';
	filed_options.autoInc = false;	
	
	options.fields.deleted = new FieldBool("deleted",filed_options);
	
		FinExpenseTypeDialog_Model.superclass.constructor.call(this,id,options);
}
extend(FinExpenseTypeDialog_Model,ModelXML);

