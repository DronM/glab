/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function AutoBodyTypeEdit(id,options){
	options = options || {};
	options.model = new AutoBodyType_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Тип кузова:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new AutoBodyType_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	AutoBodyTypeEdit.superclass.constructor.call(this,id,options);
	
}
extend(AutoBodyTypeEdit,EditSelectRef);

