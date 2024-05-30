
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
function BankFlowOutDialog_View(id,options){	

	options = options || {};
	
	options.controller = new BankFlowOut_Controller();
	options.model = (options.models&&options.models.BankFlowOutDialog_Model)? options.models.BankFlowOutDialog_Model : new BankFlowOutDialog_Model();
	
	let self = this;
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
			"title":"Списание с расчетного счета"
			
		}));	
	
		this.addElement(new BankAccountEdit(id+":bank_accounts_ref",{
		}));	

		this.addElement(new FinExpenseTypeEdit(id+":fin_expense_types1_ref",{
			"labelCaption":"Вид:",
			"for_bank":true,
			"onClear": function(){
				let ctrl = self.getElement("fin_expense_types2_ref");											
				ctrl.reset();
				ctrl.setParentId("null");
			},
			"onSelect": function(f){
				// this.setAttr("parent_id", f.parent_id.getValue());
				let par_id = f.id.getValue();											
				let ctrl = self.getElement("fin_expense_types2_ref");
				ctrl.setParentId(par_id);
				let ctrl_v = ctrl.getValue();
				if(ctrl_v && !ctrl_v.isNull() && ctrl_v.getKey() != par_id){
					ctrl.reset();
				}
			}
		}));	
		this.addElement(new FinExpenseTypeEdit(id+":fin_expense_types2_ref",{
			"labelCaption":"Тип:",
			"no_filter":true,
			"onClear": function(){
				let ctrl = self.getElement("fin_expense_types3_ref");											
				ctrl.reset();
				ctrl.setParentId("null");
			},
			"onSelect": function(f){
				// this.setAttr("parent_id", f.parent_id.getValue());
				let par_id = f.id.getValue();
				let ctrl = self.getElement("fin_expense_types3_ref");
				ctrl.setParentId(par_id);
				let ctrl_v = ctrl.getValue();
				if(ctrl_v && !ctrl_v.isNull() && ctrl_v.getKey() != par_id){
					ctrl.reset();
				}
			}
		}));	
		this.addElement(new FinExpenseTypeEdit(id+":fin_expense_types3_ref",{
			"labelCaption":"Кому:",
			"no_filter":true
		}));	
	}
	
	BankFlowOutDialog_View.superclass.constructor.call(this,id,options);
	
	//****************************************************
	//read
	this.setDataBindings([
		new DataBinding({"control":this.getElement("date_time")})
		,new DataBinding({"control":this.getElement("client_descr")})
		,new DataBinding({"control":this.getElement("pay_comment")})
		,new DataBinding({"control":this.getElement("total")})
		,new DataBinding({"control":this.getElement("bank_accounts_ref")})
		,new DataBinding({"control":this.getElement("fin_expense_types1_ref")})
		,new DataBinding({"control":this.getElement("fin_expense_types2_ref")})
		,new DataBinding({"control":this.getElement("fin_expense_types3_ref")})
	]);
	
	//write
	this.setWriteBindings([
		new CommandBinding({"control":this.getElement("date_time")})
		,new CommandBinding({"control":this.getElement("client_descr")})
		,new CommandBinding({"control":this.getElement("pay_comment")})
		,new CommandBinding({"control":this.getElement("total")})
		,new CommandBinding({"control":this.getElement("bank_accounts_ref"), "fieldId":"bank_account_id"})
		,new CommandBinding({"control":this.getElement("fin_expense_types1_ref"), "fieldId":"fin_expense_type1_id"})
		,new CommandBinding({"control":this.getElement("fin_expense_types2_ref"), "fieldId":"fin_expense_type2_id"})
		,new CommandBinding({"control":this.getElement("fin_expense_types3_ref"), "fieldId":"fin_expense_type3_id"})
	]);
	
}
extend(BankFlowOutDialog_View, ViewObjectAjx);
