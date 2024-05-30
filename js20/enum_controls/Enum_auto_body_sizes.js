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

function Enum_auto_body_sizes(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"small",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"small"],
checked:(options.defaultValue&&options.defaultValue=="small")}
	, {"value":"middle",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"middle"],
checked:(options.defaultValue&&options.defaultValue=="middle")}
	, {"value":"large",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"large"],
checked:(options.defaultValue&&options.defaultValue=="large")}
	, {"value":"extra_large",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"extra_large"],
checked:(options.defaultValue&&options.defaultValue=="extra_large")}
	];
	
	Enum_auto_body_sizes.superclass.constructor.call(this, id, options);
	
}
extend(Enum_auto_body_sizes,EditSelect);

Enum_auto_body_sizes.prototype.multyLangValues = {
	"ru_small":"Малый автомобиль", "ru_middle":"Средний автомобиль", "ru_large":"Большой автомобиль", "ru_extra_large":"Сверх большой автомобиль"
};


