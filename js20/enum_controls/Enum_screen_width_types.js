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

function Enum_screen_width_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"sm",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"sm"],
checked:(options.defaultValue&&options.defaultValue=="sm")}
	, {"value":"md",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"md"],
checked:(options.defaultValue&&options.defaultValue=="md")}
	, {"value":"lg",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"lg"],
checked:(options.defaultValue&&options.defaultValue=="lg")}
	];
	
	Enum_screen_width_types.superclass.constructor.call(this, id, options);
	
}
extend(Enum_screen_width_types,EditSelect);

Enum_screen_width_types.prototype.multyLangValues = {
	"ru_sm":"Маленький", "ru_md":"Средний", "ru_lg":"Большой"
};


