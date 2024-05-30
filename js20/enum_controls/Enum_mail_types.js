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

function Enum_mail_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"password_recover",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"password_recover"],
checked:(options.defaultValue&&options.defaultValue=="password_recover")}
	];
	
	Enum_mail_types.superclass.constructor.call(this, id, options);
	
}
extend(Enum_mail_types,EditSelect);

Enum_mail_types.prototype.multyLangValues = {
	"ru_password_recover":"Восстановление пароля"
};


