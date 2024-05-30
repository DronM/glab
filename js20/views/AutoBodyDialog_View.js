/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function AutoBodyDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Кузов";
	options.model = (options.models&&options.models.AutoBodyList_Model)? options.models.AutoBodyList_Model : new AutoBodyList_Model();
	options.controller = options.controller || new AutoBody_Controller();
	
	var self = this;
	options.addElement = function(){

		this.addElement(new AutoBodyDoorEdit(id+":auto_body_doors_ref",{
		}));	
		this.addElement(new AutoBodyTypeEdit(id+":auto_body_types_ref",{
		}));	
		
		this.addElement(new EditString(id+":model",{
			"labelCaption": "Модификация:",
			"maxLength":250
		}));	

		this.addElement(new EditString(id+":name",{
			"labelCaption": "Название:",
			"maxLength":500
		}));	

		this.addElement(new EditNum(id+":year_from",{
			"labelCaption": "Начало производтва:"
		}));	
		this.addElement(new EditNum(id+":year_to",{
			"labelCaption": "Окончание производтва:"
		}));	
	}
	
	AutoBodyDialog_View.superclass.constructor.call(this,id,options);
	
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("auto_body_doors_ref")})
		,new DataBinding({"control":this.getElement("auto_body_types_ref")})
		,new DataBinding({"control":this.getElement("model")})
		,new DataBinding({"control":this.getElement("name")})
		,new DataBinding({"control":this.getElement("year_from")})
		,new DataBinding({"control":this.getElement("year_to")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("auto_body_doors_ref"), "fieldId":"auto_body_door_id"})
		,new CommandBinding({"control":this.getElement("auto_body_types_ref"), "fieldId":"auto_body_type_id"})
		,new CommandBinding({"control":this.getElement("model")})
		,new CommandBinding({"control":this.getElement("name")})
		,new CommandBinding({"control":this.getElement("year_from")})
		,new CommandBinding({"control":this.getElement("year_to")})
	];
	this.setWriteBindings(write_b);
	
}
extend(AutoBodyDialog_View, ViewObjectAjx);

//********************

