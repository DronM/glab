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

function ItemFeatureGroupItemList_Model(options){
	var id = 'ItemFeatureGroupItemList_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
					
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Группа';
	filed_options.autoInc = false;	
	
	options.fields.item_feature_group_id = new FieldInt("item_feature_group_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Харктеристика';
	filed_options.autoInc = false;	
	
	options.fields.item_feature_id = new FieldInt("item_feature_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Харктеристика';
	filed_options.autoInc = false;	
	
	options.fields.item_features_ref = new FieldJSON("item_features_ref",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Код сортировки';
	filed_options.autoInc = false;	
	
	options.fields.code = new FieldInt("code",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип фильтра';
	filed_options.autoInc = false;	
	
	options.fields.filter_option_type = new FieldString("filter_option_type",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Используется для конфигуратора';
	filed_options.autoInc = false;	
	
	options.fields.for_config = new FieldBool("for_config",filed_options);
	
		ItemFeatureGroupItemList_Model.superclass.constructor.call(this,id,options);
}
extend(ItemFeatureGroupItemList_Model,ModelXML);

