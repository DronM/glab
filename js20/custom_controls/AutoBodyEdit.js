/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function AutoBodyEdit(id,options){
	options = options || {};
	options.model = new AutoBodyList_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Кузов:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	//options.modelDescrFields = [options.model.getField("name")];
	options.modelDescrFormatFunction = function(f){
		var res = "";
		var auto_body_doors_ref = f.auto_body_doors_ref.getValue();
		if(auto_body_doors_ref&&!auto_body_doors_ref.isNull()){
			res = auto_body_doors_ref.getDescr();
		}
		var auto_body_types_ref = f.auto_body_types_ref.getValue();
		if(auto_body_types_ref&&!auto_body_types_ref.isNull()){
			res+= (res=="")? "":" ";
			res+= auto_body_types_ref.getDescr();
		}
		var model = f.model.getValue();
		if(model&&model.length){
			res+= (res=="")? "":" ";
			res+= "(" + model + ")";
		}
		res+= (res=="")? "":" ";
		res+= f.year_from.getValue() + "-" + f.year_to.getValue();
		
		return res;
	}
	
	var contr = new AutoBody_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	options.readPublicMethod.setFieldValue("cond_fields", "auto_model_id");
	options.readPublicMethod.setFieldValue("cond_sgns", "e");
	options.readPublicMethod.setFieldValue("cond_vals", options.auto_model_id);
	
	AutoBodyEdit.superclass.constructor.call(this,id,options);
	
}
extend(AutoBodyEdit, EditSelectRef);

