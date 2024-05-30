/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 * @class
 * @classdesc Grid column Enumerator class. Created from build/templates/enumGridColumn.js.tmpl !!!DO NOT MODIFY!!!
 
 * @extends GridColumnEnum
 
 * @requires core/extend.js
 * @requires controls/GridColumnEnum.js
 
 * @param {object} options
 */

function EnumGridColumn_data_types(options){
	options = options || {};
	
	options.multyLangValues = {};
	options.multyLangValues["ru"] = {};
	options.multyLangValues["ru"]["users"] = "Пользователи";
	
	options.multyLangValues["ru"]["employees"] = "Сотрудники";
	
	options.multyLangValues["ru"]["bank_cards"] = "Карты банков";
	
	options.multyLangValues["ru"]["contacts"] = "Контакты";
	
	options.multyLangValues["ru"]["firms"] = "Организации";
	
	options.ctrlClass = options.ctrlClass || Enum_data_types;
	options.searchOptions = options.searchOptions || {};
	options.searchOptions.searchType = options.searchOptions.searchType || "on_match";
	options.searchOptions.typeChange = (options.searchOptions.typeChange!=undefined)? options.searchOptions.typeChange:false;
	
	EnumGridColumn_data_types.superclass.constructor.call(this,options);		
}
extend(EnumGridColumn_data_types, GridColumnEnum);

