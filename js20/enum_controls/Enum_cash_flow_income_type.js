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

function Enum_cash_flow_income_type(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"cash",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"cash"],
checked:(options.defaultValue&&options.defaultValue=="cash")}
	, {"value":"bank",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"bank"],
checked:(options.defaultValue&&options.defaultValue=="bank")}
	];
	
	Enum_cash_flow_income_type.superclass.constructor.call(this, id, options);
	
}
extend(Enum_cash_flow_income_type,EditSelect);

Enum_cash_flow_income_type.prototype.multyLangValues = {
	"ru_cash":"нал", "ru_bank":"безнал"
};


