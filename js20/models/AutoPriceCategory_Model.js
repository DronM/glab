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

function AutoPriceCategory_Model(options){
	var id = 'AutoPriceCategory_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
							
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Цена от';
	filed_options.autoInc = false;	
	
	options.fields.price_from = new FieldFloat("price_from",filed_options);
	options.fields.price_from.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Цена до';
	filed_options.autoInc = false;	
	
	options.fields.price_to = new FieldFloat("price_to",filed_options);
	options.fields.price_to.getValidator().setMaxLength('15');
	
									
		AutoPriceCategory_Model.superclass.constructor.call(this,id,options);
}
extend(AutoPriceCategory_Model,ModelXML);

