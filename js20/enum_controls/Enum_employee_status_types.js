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

function Enum_employee_status_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"employed_staff",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"employed_staff"],
checked:(options.defaultValue&&options.defaultValue=="employed_staff")}
	, {"value":"employed_outstaff",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"employed_outstaff"],
checked:(options.defaultValue&&options.defaultValue=="employed_outstaff")}
	, {"value":"fired",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"fired"],
checked:(options.defaultValue&&options.defaultValue=="fired")}
	];
	
	Enum_employee_status_types.superclass.constructor.call(this, id, options);
	
}
extend(Enum_employee_status_types,EditSelect);

Enum_employee_status_types.prototype.multyLangValues = {
	"ru_employed_staff":"Штатный сотрудник", "ru_employed_outstaff":"Внештатный сотрудник", "ru_fired":"Уволен"
};


