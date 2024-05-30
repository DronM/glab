/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function FinExpenseTypeDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Статья затрат";
	
	options.template = window.getApp().getTemplate("FinExpenseTypeDialog");
	options.model = (options.models&&options.models.FinExpenseTypeDialog_Model)? options.models.FinExpenseTypeDialog_Model : new FinExpenseTypeDialog_Model();
	options.controller = options.controller || new FinExpenseType_Controller();
 
	let self = this;
	options.addElement = function(){
		this.addElement(new EditString(id+":name",{
			"labelCaption":"Наименование:"
		}));	
		
		this.addElement(new EditCheckBox(id+":deleted",{
			"labelCaption":"Удален"
		}));	
		this.addElement(new EditCheckBox(id+":for_cash",{
			"labelCaption":"Для кассы"
		}));	
		this.addElement(new EditCheckBox(id+":for_bank",{
			"labelCaption":"Для банка",
			"events":{
				"click":function(e){
					let v = this.getValue();
					let sec_id = self.getId()+":bank_sec";
					if(v){
						DOMHelper.show(sec_id);
					}else{
						DOMHelper.hide(sec_id);
						self.getElement("bank_match_rule").reset();
					}
				}
			}
		}));	
		this.addElement(new EditText(id+":bank_match_rule",{
			"labelCaption":"Правила соответствия"
		}));	

		this.addElement(new ButtonCmd(id+":verify_rule",{
			"caption":"Проверить",
			"onClick":function(){
				self.verifyRule();
			}
		}));	
	}
	
	FinExpenseTypeDialog_View.superclass.constructor.call(this,id,options);
	
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("name")})
		,new DataBinding({"control":this.getElement("for_bank")})
		,new DataBinding({"control":this.getElement("for_cash")})
		,new DataBinding({"control":this.getElement("deleted")})
		,new DataBinding({"control":this.getElement("bank_match_rule")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("name")})
		,new CommandBinding({"control":this.getElement("for_bank")})
		,new CommandBinding({"control":this.getElement("for_cash")})
		,new CommandBinding({"control":this.getElement("deleted")})
		,new CommandBinding({"control":this.getElement("bank_match_rule")})
	];
	this.setWriteBindings(write_b);
}
extend(FinExpenseTypeDialog_View, ViewObjectAjx);

FinExpenseTypeDialog_View.prototype.onGetData = function(resp, cmd){
	FinExpenseTypeDialog_View.superclass.onGetData.call(this, resp, cmd);

	let m = this.getModel();
	if (m.getFieldValue("for_bank")) {
		DOMHelper.show(this.getId()+":bank_sec");
	}
}

FinExpenseTypeDialog_View.prototype.verifyRule = function(){
	let pm = (new FinExpenseType_Controller()).getPublicMethod("verify_rule");
	pm.setFieldValue("rule", this.getElement("bank_match_rule").getValue());
	pm.run({
		"ok":function(){
			window.showTempOk("Правило проверено, ошибок нет", null, 5000); 
		}
	});
}
