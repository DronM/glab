/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function PopularityTypeEdit(id,options){
	options = options || {};
	options.model = new PopularityType_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Тип популярности:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new PopularityType_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	PopularityTypeEdit.superclass.constructor.call(this,id,options);
	
}
extend(PopularityTypeEdit, EditSelectRef);

