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

function PopularityType_Model(options){
	var id = 'PopularityType_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
							
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'ID';
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Код для сортировки';
	filed_options.autoInc = false;	
	
	options.fields.code = new FieldInt("code",filed_options);
	options.fields.code.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';
	filed_options.autoInc = false;	
	
	options.fields.name = new FieldText("name",filed_options);
	options.fields.name.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Количество позиций вывода';
	filed_options.autoInc = false;	
	
	options.fields.item_count = new FieldInt("item_count",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип экрана';
	filed_options.autoInc = false;	
	
	options.fields.screen_width_type = new FieldEnum("screen_width_type",filed_options);
	filed_options.enumValues = 'sm,md,lg';
	
						
		PopularityType_Model.superclass.constructor.call(this,id,options);
}
extend(PopularityType_Model,ModelXML);

