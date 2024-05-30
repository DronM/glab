/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function SupplierDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Поставщики";
	options.model = (options.models&&options.models.SupplierDialog_Model)? options.models.SupplierDialog_Model : new SupplierDialog_Model();
	options.controller = options.controller || new Supplier_Controller();
	
	var self = this;
	options.addElement = function(){
	
		this.addElement(new EditString(id+":name",{
			"labelCaption": "Наименование:",
			"maxLength":250
		}));	

		this.addElement(new SupplierStoreList_View(id+":supplier_store_list",{"detail":true}));
	}
	
	SupplierDialog_View.superclass.constructor.call(this,id,options);
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
		"control":this.getElement("supplier_store_list").getElement("grid"),
		"controlFieldId":"supplier_id",
		"field":this.m_model.getField("id")
	});
	
}
extend(SupplierDialog_View, ViewObjectAjx);

//********************

