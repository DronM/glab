/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function AutoModelGenerationDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Поколение";
	options.model = (options.models&&options.models.AutoModelGenerationList_Model)? options.models.AutoModelGenerationList_Model : new AutoModelGenerationList_Model();
	options.controller = options.controller || new AutoModelGeneration_Controller();
	
	var self = this;
	options.addElement = function(){

		this.addElement(new EditString(id+":generation_num",{
			"labelCaption": "Номер:",
			"maxLength":50,
			"required":true,
			"focus": true
		}));	
		this.addElement(new EditString(id+":model",{
			"labelCaption": "Модификация:",
			"maxLength":250
		}));	

		this.addElement(new EditString(id+":series",{
			"labelCaption": "Серия:",
			"maxLength":"100"
		}));	
		this.addElement(new EditNum(id+":year_from",{
			"labelCaption": "Начало производтва:"
		}));	
		this.addElement(new EditNum(id+":year_to",{
			"labelCaption": "Окончание производтва:"
		}));	
		
		/*
		this.addElement(new EditString(id+":eurocode",{
			"labelCaption": "Еврокод:",
			"maxLength":"100"
		}));	
		this.addElement(new EditString(id+":local_id",{
			"labelCaption": "ID:",
			"maxLength":"10",
			"buttonOpen": new AutoModelGenerationNextIdBtn(id+":local_id:gen_next_id",{
				"mainView":this
			})
		}));	
		*/
		
		//this.addElement(new AutoBodyList_View(id+":auto_body_list",{"detail":true}));
	}
	
	AutoModelGenerationDialog_View.superclass.constructor.call(this,id,options);
	
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("generation_num")})
		,new DataBinding({"control":this.getElement("model")})
		,new DataBinding({"control":this.getElement("series")})
		,new DataBinding({"control":this.getElement("year_from")})
		,new DataBinding({"control":this.getElement("year_to")})
		//,new DataBinding({"control":this.getElement("eurocode")})
		//,new DataBinding({"control":this.getElement("local_id")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("generation_num")})
		,new CommandBinding({"control":this.getElement("model")})
		,new CommandBinding({"control":this.getElement("series")})
		,new CommandBinding({"control":this.getElement("year_from")})
		,new CommandBinding({"control":this.getElement("year_to")})
		//,new CommandBinding({"control":this.getElement("eurocode")})
		//,new CommandBinding({"control":this.getElement("local_id")})
	];
	this.setWriteBindings(write_b);
	
	/*
	this.addDetailDataSet({
		"control":this.getElement("auto_body_list").getElement("grid"),
		"controlFieldId": ["auto_model_generation_id"],
		"value": [function(){
			return self.m_model.getFieldValue("id");
		}]
	});
	*/
}
extend(AutoModelGenerationDialog_View, ViewObjectAjx);

//********************

