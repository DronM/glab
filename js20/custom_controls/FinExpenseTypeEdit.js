/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function FinExpenseTypeEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Статья:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;

	this.m_forCash = options.for_cash;
	this.m_forBank = options.for_bank;
	this.m_noFilter = options.no_filter;

	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = FinExpenseTypeList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 0;
	options.acController = new FinExpenseType_Controller(options.app);
	
	options.acModel = new FinExpenseTypeList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	FinExpenseTypeEdit.superclass.constructor.call(this,id,options);
	
	this.setParentId("null");
	this.m_lev = options.lev;
}
extend(FinExpenseTypeEdit, EditRef);

FinExpenseTypeEdit.prototype.setParentId = function(id) {
	let pm = this.getAutoComplete().getPublicMethod("complete");
	let cond_fields = "parent_id";
	let cond_vals = id;
	let cond_sgns = ((id=="null")? "i" : "e");
	if(this.m_forBank===true){
		cond_fields+= "@@for_bank"
		cond_vals+=	"@@" + ((this.m_forBank)? "1":"0");
		cond_sgns+= "@@e";

	}else if(this.m_forCash === true){
		cond_fields+= "@@for_cash"
		cond_vals+=	"@@" + ((this.m_forCash)? "1":"0");
		cond_sgns+= "@@e";
	}
	if(id != "null"){
		cond_fields+= "@@lev";
		cond_vals+=	"@@3";
		cond_sgns+= "@@ne";
	}
	pm.setFieldValue("cond_fields", cond_fields);
	pm.setFieldValue("cond_vals", cond_vals); 
	pm.setFieldValue("cond_sgns", cond_sgns); 
}
