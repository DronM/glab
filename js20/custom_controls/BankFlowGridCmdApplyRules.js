
/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>,2024

 * @class
 * @classdesc
 
 * @requires core/extend.js  
 * @requires controls/GridCmd.js

 * @param {string} id Object identifier
 * @param {namespace} options
*/
function BankFlowGridCmdApplyRules(id,options){
	options = options || {};	

	options.showCmdControl = (options.showCmdControl!=undefined)? options.showCmdControl:true;
	
	this.m_btn = new BankFlowGridCmdApplyRulesBtn(id+"btn",{
		"cmd":true
	});
	
	options.controls = [
		this.m_btn
	]	
	BankFlowGridCmdApplyRules.superclass.constructor.call(this,id,options);
		
}
extend(BankFlowGridCmdApplyRules, GridCmd);

/* Constants */


/* private members */

/* protected*/


/* public methods */
BankFlowGridCmdApplyRules.prototype.setGrid = function(v){
	BankFlowGridCmdApplyRules.superclass.setGrid.call(this,v);
	
	this.m_btn.m_grid = v;
	this.m_grid = v;
}

