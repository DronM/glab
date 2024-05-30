/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function AutoPriceCategoryEdit(id,options){
	options = options || {};
	options.model = new AutoPriceCategory_Model();
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Ценовая категория:";
	}
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	//options.modelDescrFields = [options.model.getField("price_from")];
	options.modelDescrFormatFunction = function(f){
		var pr1 = f.price_from.getValue();
		var pr2 = f.price_to.getValue();
		return (pr1? pr1.toFixed(2):"0.00") + " - " + (pr2? pr2.toFixed(2):"");
	}
	
	var contr = new AutoPriceCategory_Controller();
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	AutoPriceCategoryEdit.superclass.constructor.call(this,id,options);
	
}
extend(AutoPriceCategoryEdit, EditSelectRef);

