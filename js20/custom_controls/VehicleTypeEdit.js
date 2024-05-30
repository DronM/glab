/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function VehicleTypeEdit(id,options){
	options = options || {};
	options.model = new VehicleType_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Тип транпорта:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new VehicleType_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	VehicleTypeEdit.superclass.constructor.call(this,id,options);
	
}
extend(VehicleTypeEdit, EditSelectRef);

