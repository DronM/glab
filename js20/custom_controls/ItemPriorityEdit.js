/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function ItemPriorityEdit(id,options){
	options = options || {};
	options.model = new ItemPriority_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Приоритет вывода:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new ItemPriority_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	ItemPriorityEdit.superclass.constructor.call(this,id,options);
	
}
extend(ItemPriorityEdit, EditSelectRef);

