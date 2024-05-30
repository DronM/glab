/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 * @class
 * @classdesc Grid column Enumerator class. Created from build/templates/enumGridColumn.js.tmpl !!!DO NOT MODIFY!!!
 
 * @extends GridColumnEnum
 
 * @requires core/extend.js
 * @requires controls/GridColumnEnum.js
 
 * @param {object} options
 */

function EnumGridColumn_employee_status_types(options){
	options = options || {};
	
	options.multyLangValues = {};
	options.multyLangValues["ru"] = {};
	options.multyLangValues["ru"]["employed_staff"] = "Штатный сотрудник";
	
	options.multyLangValues["ru"]["employed_outstaff"] = "Внештатный сотрудник";
	
	options.multyLangValues["ru"]["fired"] = "Уволен";
	
	options.ctrlClass = options.ctrlClass || Enum_employee_status_types;
	options.searchOptions = options.searchOptions || {};
	options.searchOptions.searchType = options.searchOptions.searchType || "on_match";
	options.searchOptions.typeChange = (options.searchOptions.typeChange!=undefined)? options.searchOptions.typeChange:false;
	
	EnumGridColumn_employee_status_types.superclass.constructor.call(this,options);		
}
extend(EnumGridColumn_employee_status_types, GridColumnEnum);

