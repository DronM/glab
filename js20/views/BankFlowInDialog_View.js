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
function BankFlowInDialog_View(id,options){	

	options = options || {};
	
	options.controller = new BankFlowIn_Controller();
	options.model = (options.models&&options.models.BankFlowInList_Model)? options.models.BankFlowInList_Model : new BankFlowInList_Model();
	
	options.addElement = function(){
		this.addElement(new EditDateTime(id+":date_time",{
			"labelCaption":"Дата:",
			"title":"Дата платежа"
			
		}));	
		this.addElement(new EditText(id+":client_descr",{
			"labelCaption":"Корреспондент:",
			"title":"Корреспондент платежа"
			
		}));	
		this.addElement(new EditText(id+":pay_comment",{
			"labelCaption":"Назначение платежа:",
			"title":"Назначение платежа"
			
		}));	

		this.addElement(new EditMoney(id+":total",{
			"labelCaption":"Сумма:",
			"title":"Поступление на расчетный счет"
			
		}));	
	
		this.addElement(new BankAccountEdit(id+":bank_accounts_ref",{
		}));	

	}
	
	BankFlowInDialog_View.superclass.constructor.call(this,id,options);
	
	//****************************************************
	//read
	this.setDataBindings([
		new DataBinding({"control":this.getElement("date_time")})
		,new DataBinding({"control":this.getElement("client_descr")})
		,new DataBinding({"control":this.getElement("pay_comment")})
		,new DataBinding({"control":this.getElement("total")})
		,new DataBinding({"control":this.getElement("bank_accounts_ref")})
	]);
	
	//write
	this.setWriteBindings([
		new CommandBinding({"control":this.getElement("date_time")})
		,new CommandBinding({"control":this.getElement("client_descr")})
		,new CommandBinding({"control":this.getElement("pay_comment")})
		,new CommandBinding({"control":this.getElement("total")})
		,new CommandBinding({"control":this.getElement("bank_accounts_ref"), "fieldId":"bank_account_id"})
	]);
	
}
extend(BankFlowInDialog_View, ViewObjectAjx);
