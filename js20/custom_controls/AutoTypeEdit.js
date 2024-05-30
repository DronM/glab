/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function AutoTypeEdit(id,options){
	options = options || {};
	options.model = new AutoType_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Тип:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new AutoType_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	AutoTypeEdit.superclass.constructor.call(this,id,options);
	
}
extend(AutoTypeEdit,EditSelectRef);

