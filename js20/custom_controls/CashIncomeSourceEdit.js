
/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function CashIncomeSourceEdit(id,options){
	options = options || {};
	options.model = new CashIncomeSourceList_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Источник:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new CashIncomeSource_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	CashIncomeSourceEdit.superclass.constructor.call(this,id,options);
	
}
extend(CashIncomeSourceEdit,EditSelectRef);

