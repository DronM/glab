/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function PersonDocumentEdit(id,options){
	options = options || {};
	options.model = new PersonDocumentList_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || ":";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new PersonDocument_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	PersonDocumentEdit.superclass.constructor.call(this,id,options);
	
}
extend(PersonDocumentEdit,EditSelectRef);

