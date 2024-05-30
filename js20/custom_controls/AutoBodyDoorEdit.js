/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function AutoBodyDoorEdit(id,options){
	options = options || {};
	options.model = new AutoBodyDoor_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Вид дверей:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new AutoBodyDoor_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	AutoBodyDoorEdit.superclass.constructor.call(this,id,options);
	
}
extend(AutoBodyDoorEdit,EditSelectRef);

