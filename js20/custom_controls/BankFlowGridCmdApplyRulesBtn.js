
/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends Button
 * @requires core/extend.js
 * @requires controls/Button.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function BankFlowGridCmdApplyRulesBtn(id,options){
	options = options || {};	
		
	if(options.cmd){
		options.colorClass = "bg-"+window.getApp().getColorClass();//"bg-blue-400";
		options.className = "btn btn-primary btn-cmd";
		options.caption = " Применить  правила";
	}
	else{
		options.className = "btn btn-default";
	}

	options.glyph = "glyphicon-refresh";
	options.title="Применить новые правила определения статей для пустых";

	var self = this;
	options.onClick = function(){
		self.onClick();
	}
	
	this.m_cmd = options.cmd;
	
	BankFlowGridCmdApplyRulesBtn.superclass.constructor.call(this,id,options);
}
//ViewObjectAjx,ViewAjxList
extend(BankFlowGridCmdApplyRulesBtn,Button);

/* Constants */


/* private members */

/* protected*/
BankFlowGridCmdApplyRulesBtn.prototype.m_grid;

/* public methods */
BankFlowGridCmdApplyRulesBtn.prototype.onClick = function(){
	let operation_id = window.getApp().startOperationMonitor(this,
		function(params){
			console.log(params);
			window.getApp().fetchUserOperationResult(operation_id, function(f){
				let cnt = f.comment_text.getValue();
				window.showTempOk("Применены новые правила определения статей расхода. Обработано докуметов: " + cnt, null, 5000);
			});
		},
		function(err, params){
			throw new Error(err);
		} 
	);
	let pm = (new BankFlowIn_Controller()).getPublicMethod("apply_rules");
	pm.setFieldValue("operation_id", operation_id);
	pm.run();
}

