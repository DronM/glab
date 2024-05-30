/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function ItemFeatureGroupEdit(id,options){
	options = options || {};
	options.model = new ItemFeatureGroup_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Группа опций:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new ItemFeatureGroup_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	ItemFeatureGroupEdit.superclass.constructor.call(this,id,options);
	
}
extend(ItemFeatureGroupEdit,EditSelectRef);

