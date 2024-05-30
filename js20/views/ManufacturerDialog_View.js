/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function ManufacturerDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Поставщики";
	options.model = (options.models&&options.models.ManufacturerDialog_Model)? options.models.ManufacturerDialog_Model : new ManufacturerDialog_Model();
	options.controller = options.controller || new Manufacturer_Controller();
	
	var self = this;
	options.addElement = function(){
	
		this.addElement(new EditString(id+":name",{
			"labelCaption": "Наименование:",
			"maxLength":250
		}));	
	
		this.addElement(new ManufacturerBrandList_View(id+":manufacturer_brand_list",{"detail":true}));	
	}
	
	ManufacturerDialog_View.superclass.constructor.call(this,id,options);
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("name")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("name")})
	];
	this.setWriteBindings(write_b);
	
	this.addDetailDataSet({
		"control":this.getElement("manufacturer_brand_list").getElement("grid"),
		"controlFieldId": ["manufacturer_id"],
		"value": [function(){
			return self.m_model.getFieldValue("id");
		}]
	});
	
}
extend(ManufacturerDialog_View, ViewObjectAjx);

//********************

