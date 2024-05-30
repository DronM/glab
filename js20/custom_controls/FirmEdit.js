
/**
 * author
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function FirmEdit(id,options){
	options = options || {};
	options.model = new FirmList_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Организация:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new Firm_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	FirmEdit.superclass.constructor.call(this,id,options);
	
}
extend(FirmEdit,EditSelectRef);

