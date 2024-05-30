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

function Enum_data_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"users",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"users"],
checked:(options.defaultValue&&options.defaultValue=="users")}
	, {"value":"employees",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"employees"],
checked:(options.defaultValue&&options.defaultValue=="employees")}
	, {"value":"bank_cards",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"bank_cards"],
checked:(options.defaultValue&&options.defaultValue=="bank_cards")}
	, {"value":"contacts",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"contacts"],
checked:(options.defaultValue&&options.defaultValue=="contacts")}
	, {"value":"firms",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"firms"],
checked:(options.defaultValue&&options.defaultValue=="firms")}
	];
	
	Enum_data_types.superclass.constructor.call(this, id, options);
	
}
extend(Enum_data_types,EditSelect);

Enum_data_types.prototype.multyLangValues = {
	"ru_users":"Пользователи", "ru_employees":"Сотрудники", "ru_bank_cards":"Карты банков", "ru_contacts":"Контакты", "ru_firms":"Организации"
};


