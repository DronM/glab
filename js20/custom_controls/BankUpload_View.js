/*
 * 
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @extends View.js
 * @requires core/extend.js  
 * @requires controls/View.js 
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {object} options
 */	
function BankUpload_View(id,options){	

	options = options || {};
	
	let self = this;
	options.addElement = function(){
		// this.addElement(new BankAccountEdit(id+":bank_account",{
		// 	"required": true,
		// 	"focus": true,
		// 	"labelCaption": "Расчетный счет:",
		// 	"title":"Расчетный счет для импорта данных"
		// }));	

		this.addElement(new EditFile(id+":bank_export_file",{
			"required": true,
			"labelCaption": "Файл из банк-клиента",
			"showPic":false,
			"title":"Файл экспорта из банк-клиента",
			"onFileAdded":function(fID){
				debugger
				DOMHelper.swapClasses(fID + "-pic", "glyphicon glyphicon-ok", "fa fa-spinner fa-spin");
			}
		}));	

		this.addElement(new ButtonCmd(id+":btnImport",{
			"caption": "Импорт",
			"title":"Импорт выписки по расчетному счету из банк-клиента",
			"onClick":function(){
				self.onImport();
			}
		}));	
		this.addElement(new ControlContainer(id+":importResultCont", "DIV", {
			"elements":[
				new Control(id+":importResultCont:res", "DIV")
			],
			"attrs":{
				"class":"alert alert-info alert-styled-left hidden"
			}
		}));	
	}
	
	BankUpload_View.superclass.constructor.call(this,id,options);
}
extend(BankUpload_View, View);

BankUpload_View.prototype.clearResult = function(){
	this.getElement("importResultCont").getElement("res").setValue(" ");
	DOMHelper.hide(this.getElement("importResultCont").getNode());
}

BankUpload_View.prototype.setResultOk = function(){
	this.getElement("importResultCont").getElement("res").setValue("Загрузка завершна");
	let n = this.getElement("importResultCont").getNode();
	DOMHelper.delClass(n, "alert-danger");
	DOMHelper.delClass(n, "alert-info");
	DOMHelper.addClass(n, "alert-success");
	DOMHelper.show(n);
}

BankUpload_View.prototype.setResultWait = function(){
	this.getElement("importResultCont").getElement("res").setValue("Загрузка выписки...");
	let n = this.getElement("importResultCont").getNode();
	DOMHelper.delClass(n, "alert-danger");
	DOMHelper.delClass(n, "alert-success");
	DOMHelper.addClass(n, "alert-info");
	DOMHelper.show(n);
}

BankUpload_View.prototype.setResultError = function(errText){
	this.getElement("importResultCont").getElement("res").setValue(errText);
	let n = this.getElement("importResultCont").getNode();
	DOMHelper.delClass(n, "alert-success");
	DOMHelper.delClass(n, "alert-info");
	DOMHelper.addClass(n, "alert-danger");
	DOMHelper.show(n);
}

BankUpload_View.prototype.onImport = function(){
	// alert("onImport");
	this.clearResult();
	let files = this.getElement("bank_export_file").getValue();
	if(!files || !files.length){
		this.getElement("bank_export_file").setNotValid("Не выбарн файл");
	}
	this.getElement("bank_export_file").setValid();

	this.m_operationId = CommonHelper.md5(DateHelper.time().toString());
	window.setGlobalWait(true);
	this.startOperationMonitor();

	let pm = (new BankFlowIn_Controller().getPublicMethod("import_from_bank"));
	pm.setFieldValue("operation_id", this.m_operationId);
	pm.setFieldValue("bank_file", files);
	pm.run({
		"ok":(function(cont){
			return function(){
				cont.setResultWait();
			}
		})(this),

		"fail":(function(cont){
			return function(resp,errCode,errStr){
				cont.setResultError(errStr);
			}
		})(this)
	});
}

BankUpload_View.prototype.startOperationMonitor = function(){	
	var srv = window.getApp().getAppSrv();
	if(srv && srv.connActive()){
		var self = this;		
		this.unsubscribeFromSrvEvents();
		this.subscribeToSrvEvents({
			"events":[
				{"id":"UserOperation." + this.m_operationId}
				,{"id":"UserOperation." + this.m_operationId}
			]
			,"onEvent":function(json){
				if(json.controllerId == "UserOperation" && json.methodId == self.m_operationId){
					if(json.params.status=="end"){
						window.setGlobalWait(false);
						if(json.params.res){
							self.setResultOk();
						}else{
							// console.log("json=", json.params)
							self.fetchOperationError(json.params.operation_id);
						}
					}
				}
			}
		});
	}
}

BankUpload_View.prototype.fetchOperationError = function(operationID){	
	let pm = (new UserOperation_Controller()).getPublicMethod("get_object");
	pm.setFieldValue("user_id", window.getApp().getServVar("user_id"));
	pm.setFieldValue("operation_id", operationID); 
	let self = this;
	pm.run({
		"ok":function(resp){
            let m = resp.getModel("UserOperationDialog_Model");
			if(!m || !m.getNextRow()){
				return;
			}
			self.setResultError(m.getFieldValue('error_text'));
		}
	})
}
