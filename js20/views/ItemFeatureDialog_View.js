/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function ItemFeatureDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Характеристика номенклатуры";
	options.cmdSave = true;
	options.model = (options.models&&options.models.ItemFeature_Model)? options.models.ItemFeature_Model : new ItemFeature_Model();
	options.controller = options.controller || new ItemFeature_Controller();
	
	var self = this;
	options.addElement = function(){
	
		this.addElement(new EditString(id+":name",{
			"labelCaption": "Наименование:",
			"title":"Краткой наименование для отображения",
			"maxLength":250
		}));	

		this.addElement(new EditString(id+":name_lat",{
			"labelCaption": "Наименование (API):",
			"title":"Наименование латиницей для поиска через API",
			"maxLength":250
		}));	

		this.addElement(new EditString(id+":comment_text",{
			"labelCaption": "Комментарий:",
			"title":"Расширенное наименование",
			"maxLength":1000
		}));	

		this.addElement(new ItemFeatureDataType_View(id+":value_attrs",{			
		}));	
		
	}
	
	ItemFeatureDialog_View.superclass.constructor.call(this,id,options);
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("name")})
		,new DataBinding({"control":this.getElement("name_lat")})
		,new DataBinding({"control":this.getElement("comment_text")})
		,new DataBinding({"control":this.getElement("value_attrs")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("name")})
		,new CommandBinding({"control":this.getElement("name_lat")})
		,new CommandBinding({"control":this.getElement("comment_text")})
		,new CommandBinding({"control":this.getElement("value_attrs")})
	];
	this.setWriteBindings(write_b);
}
extend(ItemFeatureDialog_View, ViewObjectAjx);

//********************

