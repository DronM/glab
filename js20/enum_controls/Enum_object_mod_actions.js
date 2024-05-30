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

function Enum_object_mod_actions(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"insert",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"insert"],
checked:(options.defaultValue&&options.defaultValue=="insert")}
	, {"value":"update",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"update"],
checked:(options.defaultValue&&options.defaultValue=="update")}
	, {"value":"delete",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"delete"],
checked:(options.defaultValue&&options.defaultValue=="delete")}
	];
	
	Enum_object_mod_actions.superclass.constructor.call(this, id, options);
	
}
extend(Enum_object_mod_actions,EditSelect);

Enum_object_mod_actions.prototype.multyLangValues = {
	"ru_insert":"Добавление", "ru_update":"Изменение", "ru_delete":"Удаление"
};


