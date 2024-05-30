/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023
 
 * @extends ViewObjectAjx.js
 * @requires core/extend.js  
 * @requires controls/ViewObjectAjx.js 
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {object} options
 */	
function BankAccountDialog_View(id,options){	

	options = options || {};
	
	options.controller = new BankAccount_Controller();
	options.model = (options.models&&options.models.BankAccountList_Model)? options.models.BankAccountList_Model : new BankAccountList_Model();
	
	options.addElement = function(){
		this.addElement(new EditString(id+":name",{
			"required": true,
			"focus": true,
			"maxLength":500,
			"labelCaption": "Наименование:",
			"placeholder":"Наименование расчетного счета",
		}));	

		this.addElement(new BankEditRef(id+":banks_ref",{
			"required": true,
			"labelCaption": "Банк:",
			"title":"Банк"
		}));	

		this.addElement(new EditString(id+":bank_acc",{
			"required": true,
			"maxLength":20,
			"labelCaption": "Расчетный счет:",
			"placeholder":"Номер расчетного счета",
		}));	

	}
	
	BankAccountDialog_View.superclass.constructor.call(this,id,options);
	
	//****************************************************
	//read
	this.setDataBindings([
		new DataBinding({"control":this.getElement("name")})
		,new DataBinding({"control":this.getElement("banks_ref")})
		,new DataBinding({"control":this.getElement("bank_acc")})
	]);
	
	//write
	this.setWriteBindings([
		new CommandBinding({"control":this.getElement("name")})
		,new CommandBinding({"control":this.getElement("banks_ref"), "fieldId":"bank_bik"})
		,new CommandBinding({"control":this.getElement("bank_acc")})
	]);
	
}
extend(BankAccountDialog_View, ViewObjectAjx);
