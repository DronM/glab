/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022

 * @extends EditJSON
 * @requires core/extend.js
 * @requires controls/EditJSON.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function ItemFeatureDataType_View(id,options){

	options = options || {};
	
	options.className = options.className || "form-group";
	
	var self = this;

	options.addElement = function(){
		var id = this.getId();

		this.addElement(new EditSelect(id+":data_type",{
			"labelCaption":"Тип данных:",
			"elements": [
				new EditSelectOption(id+":data_type:dt_list", {
					"value": "dt_list",
					"descr": "Список значений"
				})
				,new EditSelectOption(id+":data_type:dt_int", {
					"value": "dt_int",
					"descr": "Целое число"
				})
				,new EditSelectOption(id+":data_type:dt_float", {
					"value": "dt_float",
					"descr": "Дробное число"
				})
				,new EditSelectOption(id+":data_type:dt_string", {
					"value": "dt_string",
					"descr": "Строка"
				})				
				,new EditSelectOption(id+":data_type:dt_bool", {
					"value": "dt_bool",
					"descr": "Переключатель"
				})				
				
			],
			"events":{
				"change": function(e){
					self.setDataType(self.getElement("data_type").getValue());
				}
			}
		}));

		//controls specific for data types
		this.addElement(new EditNum(id+":value_length",{
			"labelCaption": "Длина:",
			"visible":false
		}));		
		this.addElement(new EditNum(id+":value_precision",{
			"labelCaption": "Точность:",
			"visible":false
		}));		

		this.addElement(new ItemFeatureValueList_Grid(id+":value_list",{
			"visible":false
			//"contClassName": "hidden"
		}));
	
	}	
	ItemFeatureDataType_View.superclass.constructor.call(this,id,options);
		
}
extend(ItemFeatureDataType_View, EditJSON);

/* Constants */


/* private members */

/* protected*/


/* public methods */

ItemFeatureDataType_View.prototype.setInitValue = function(v){
	ItemFeatureDataType_View.superclass.setInitValue.call(this, v);

	var dt;
	if (v && v.data_type){
		dt = v.data_type;
	}
	this.setDataType(dt);
	
}

ItemFeatureDataType_View.prototype.setDataType = function(dt){
	var value_length_vis = false;
	var value_precision_vis = false;
	var value_list_vis = false;
	switch(dt){
		case "dt_list":
			value_list_vis = true;
			break;
		case "dt_int":
			break;
		case "dt_float":
			value_length_vis = true;			
			value_precision_vis = true;
			break;
		case "dt_string":
			value_length_vis = true;			
			break;
		default: 			
	}
	this.getElement("value_list").setVisible(value_list_vis);
	this.getElement("value_length").setVisible(value_length_vis);
	this.getElement("value_precision").setVisible(value_precision_vis);
}



