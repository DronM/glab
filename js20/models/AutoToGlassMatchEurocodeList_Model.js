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

function AutoToGlassMatchEurocodeList_Model(options){
	var id = 'AutoToGlassMatchEurocodeList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.auto_to_glass_match_head_id = new FieldInt("auto_to_glass_match_head_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Код, введенный пользователем';
	filed_options.autoInc = false;	
	
	options.fields.user_code = new FieldText("user_code",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Кузовы';
	filed_options.autoInc = false;	
	
	options.fields.auto_bodies_list = new FieldJSON("auto_bodies_list",filed_options);
	
		AutoToGlassMatchEurocodeList_Model.superclass.constructor.call(this,id,options);
}
extend(AutoToGlassMatchEurocodeList_Model,ModelXML);

