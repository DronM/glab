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

function Enum_reg_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"cash_flow",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"cash_flow"],
checked:(options.defaultValue&&options.defaultValue=="cash_flow")}
	, {"value":"bank_flow",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"bank_flow"],
checked:(options.defaultValue&&options.defaultValue=="bank_flow")}
	];
	
	Enum_reg_types.superclass.constructor.call(this, id, options);
	
}
extend(Enum_reg_types,EditSelect);

Enum_reg_types.prototype.multyLangValues = {
	"ru_cash_flow":"Остатки в кассе", "ru_bank_flow":"Остатки на счетах"
};


