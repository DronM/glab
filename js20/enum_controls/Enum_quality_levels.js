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

function Enum_quality_levels(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"econom",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"econom"],
checked:(options.defaultValue&&options.defaultValue=="econom")}
	, {"value":"standart",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"standart"],
checked:(options.defaultValue&&options.defaultValue=="standart")}
	, {"value":"premium",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"premium"],
checked:(options.defaultValue&&options.defaultValue=="premium")}
	];
	
	Enum_quality_levels.superclass.constructor.call(this, id, options);
	
}
extend(Enum_quality_levels,EditSelect);

Enum_quality_levels.prototype.multyLangValues = {
	"ru_econom":"Эконом", "ru_standart":"Стандарт", "ru_premium":"Премиум"
};


