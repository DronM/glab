/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 * @class
 * @classdesc Grid column Enumerator class. Created from build/templates/enumGridColumn.js.tmpl !!!DO NOT MODIFY!!!
 
 * @extends GridColumnEnum
 
 * @requires core/extend.js
 * @requires controls/GridColumnEnum.js
 
 * @param {object} options
 */

function EnumGridColumn_auto_body_sizes(options){
	options = options || {};
	
	options.multyLangValues = {};
	options.multyLangValues["ru"] = {};
	options.multyLangValues["ru"]["small"] = "Малый автомобиль";
	
	options.multyLangValues["ru"]["middle"] = "Средний автомобиль";
	
	options.multyLangValues["ru"]["large"] = "Большой автомобиль";
	
	options.multyLangValues["ru"]["extra_large"] = "Сверх большой автомобиль";
	
	options.ctrlClass = options.ctrlClass || Enum_auto_body_sizes;
	options.searchOptions = options.searchOptions || {};
	options.searchOptions.searchType = options.searchOptions.searchType || "on_match";
	options.searchOptions.typeChange = (options.searchOptions.typeChange!=undefined)? options.searchOptions.typeChange:false;
	
	EnumGridColumn_auto_body_sizes.superclass.constructor.call(this,options);		
}
extend(EnumGridColumn_auto_body_sizes, GridColumnEnum);

