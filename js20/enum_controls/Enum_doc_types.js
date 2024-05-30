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

function Enum_doc_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"cash_flow_in",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"cash_flow_in"],
checked:(options.defaultValue&&options.defaultValue=="cash_flow_in")}
	, {"value":"cash_flow_out",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"cash_flow_out"],
checked:(options.defaultValue&&options.defaultValue=="cash_flow_out")}
	, {"value":"cash_flow_transfers",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"cash_flow_transfers"],
checked:(options.defaultValue&&options.defaultValue=="cash_flow_transfers")}
	, {"value":"bank_flow_in",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"bank_flow_in"],
checked:(options.defaultValue&&options.defaultValue=="bank_flow_in")}
	, {"value":"bank_flow_out",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"bank_flow_out"],
checked:(options.defaultValue&&options.defaultValue=="bank_flow_out")}
	];
	
	Enum_doc_types.superclass.constructor.call(this, id, options);
	
}
extend(Enum_doc_types,EditSelect);

Enum_doc_types.prototype.multyLangValues = {
	"ru_cash_flow_in":"ПКО", "ru_cash_flow_out":"РКО", "ru_cash_flow_transfers":"Перемещение денег", "ru_bank_flow_in":"Строка банка поступление", "ru_bank_flow_out":"Строка банка списание"
};


