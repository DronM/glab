/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 * @class
 * @classdesc Enumerator class. Created from template build/templates/enum.js.tmpl. !!!DO NOT MODIFY!!!
 
 * @extends EditSelect
 
 * @requires core/extend.js
 * @requires controls/EditSelect.js
 
 * @param string id 
 * @param {object} options
 */

function Enum_item_feature_filter_option_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"main",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"main"],
checked:(options.defaultValue&&options.defaultValue=="main")}
	, {"value":"additional",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"additional"],
checked:(options.defaultValue&&options.defaultValue=="additional")}
	, {"value":"distinctive",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"distinctive"],
checked:(options.defaultValue&&options.defaultValue=="distinctive")}
	];
	
	Enum_item_feature_filter_option_types.superclass.constructor.call(this, id, options);
	
}
extend(Enum_item_feature_filter_option_types,EditSelect);

Enum_item_feature_filter_option_types.prototype.multyLangValues = {
	"ru_main":"Основная фильтруемая опция", "ru_additional":"Дополнительная фильтруемая опция", "ru_distinctive":"Отличительная опция"
};


