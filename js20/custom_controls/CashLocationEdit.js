/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function CashLocationEdit(id,options){
	options = options || {};
	options.model = new CashLocation_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Касса:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new CashLocation_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	CashLocationEdit.superclass.constructor.call(this,id,options);
	
}
extend(CashLocationEdit,EditSelectRef);

