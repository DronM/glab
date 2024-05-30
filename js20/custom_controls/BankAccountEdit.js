/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function BankAccountEdit(id,options){
	options = options || {};
	options.model = new BankAccountList_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Расчетный счет:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new BankAccount_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	BankAccountEdit.superclass.constructor.call(this,id,options);
	
}
extend(BankAccountEdit,EditSelectRef);

