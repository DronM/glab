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

function ItemFolderFeatureGroupList_Model(options){
	var id = 'ItemFolderFeatureGroupList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Папка';
	filed_options.autoInc = false;	
	
	options.fields.item_folder_id = new FieldInt("item_folder_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Группа характеристик ID';
	filed_options.autoInc = false;	
	
	options.fields.item_feature_group_id = new FieldInt("item_feature_group_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Группа характеристик';
	filed_options.autoInc = false;	
	
	options.fields.item_feature_groups_ref = new FieldJSON("item_feature_groups_ref",filed_options);
	
		ItemFolderFeatureGroupList_Model.superclass.constructor.call(this,id,options);
}
extend(ItemFolderFeatureGroupList_Model,ModelXML);

