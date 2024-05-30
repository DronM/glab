/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function FirmDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Организация";
	options.model = (options.models&&options.models.FirmDialog_Model)? options.models.FirmDialog_Model : new FirmDialog_Model();
	options.controller = options.controller || new Firm_Controller();
	
	var self = this;
	options.addElement = function(){
	
		this.addElement(new EditString(id+":name",{
			"labelCaption": "Наименование:",
			"maxLength":250
		}));	
		this.addElement(new EditINN(id+":inn",{
			"labelCaption": "ИНН:",
			"isEnterprise":true
		}));	

		this.addElement(new BankAccountList_View(id+":bank_accounts_list", {"detail":true}));
	}
	
	FirmDialog_View.superclass.constructor.call(this,id,options);
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("name")})
		,new DataBinding({"control":this.getElement("inn")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("name")})
		,new CommandBinding({"control":this.getElement("inn")})
	];
	this.setWriteBindings(write_b);
	
	this.addDetailDataSet({
		"control":this.getElement("bank_accounts_list").getElement("grid"),
		"controlFieldId":["parent_data_type", "parent_id"],
		"value": ["firms", function(){
			return self.m_model.getFieldValue("id");
		}]
	});
}
extend(FirmDialog_View, ViewObjectAjx);

//********************

