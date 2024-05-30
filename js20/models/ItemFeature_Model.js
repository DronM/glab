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

function ItemFeature_Model(options){
	var id = 'ItemFeature_Model';
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
	filed_options.alias = 'Наименование литиницей для API';
	filed_options.autoInc = false;	
	
	options.fields.name_lat = new FieldText("name_lat",filed_options);
	options.fields.name_lat.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комментарий';
	filed_options.autoInc = false;	
	
	options.fields.comment_text = new FieldText("comment_text",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Реквизиты значения: тип данных, длина, точность, значения списка';
	filed_options.autoInc = false;	
	
	options.fields.value_attrs = new FieldJSONB("value_attrs",filed_options);
	
						
		ItemFeature_Model.superclass.constructor.call(this,id,options);
}
extend(ItemFeature_Model,ModelXML);

