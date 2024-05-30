/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function ItemFolderFeatureDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Характеристика папки";
	options.cmdSave = false;
	options.model = (options.models&&options.models.ItemFolderFeatureList_Model)? options.models.ItemFolderFeatureList_Model : new ItemFolderFeatureList_Model();
	options.controller = options.controller || new ItemFolderFeature_Controller();
	
	var self = this;
	options.addElement = function(){
	
		this.addElement(new EditString(id+":name",{
			"labelCaption": "Наименование:",
			"maxLength":250
		}));	
	}
	
	ItemFolderFeatureDialog_View.superclass.constructor.call(this,id,options);
	
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
}
extend(ItemFolderFeatureDialog_View, ViewObjectAjx);

//********************

