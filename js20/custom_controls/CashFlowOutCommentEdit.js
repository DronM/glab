/* Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function CashFlowOutCommentEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Комментарий:";
	}
	options.cmdInsert = false;
	options.title = options.title || "Значение может быть выбрано строго из списка";
	options.placeholder = options.placeholder || "Выберите из списка";
	
	options.keyIds = options.keyIds || ["comment_text"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	options.cmdAutoComplete= true;
	options.acMinLengthForQuery = 0;
	options.acController = new CashFlowOut_Controller(options.app);
	options.acPublicMethod = options.acController.getPublicMethod("complete_comment");
	options.acModel = new CashFlowOutCommentList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "comment_text";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("comment_text")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("comment_text")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	CashFlowOutCommentEdit.superclass.constructor.call(this,id,options);
}
extend(CashFlowOutCommentEdit, EditString);

/* Constants */


/* private members */

/* protected*/


/* public methods */
CashFlowOutCommentEdit.prototype.setExpenseTypeId = function(id){
	let pm = this.getAutoComplete().getPublicMethod("complete_comment");
	pm.setFieldValue("fin_expense_type2_id", id);
}
