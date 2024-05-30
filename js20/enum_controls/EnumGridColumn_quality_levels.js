/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 * @class
 * @classdesc Grid column Enumerator class. Created from build/templates/enumGridColumn.js.tmpl !!!DO NOT MODIFY!!!
 
 * @extends GridColumnEnum
 
 * @requires core/extend.js
 * @requires controls/GridColumnEnum.js
 
 * @param {object} options
 */

function EnumGridColumn_quality_levels(options){
	options = options || {};
	
	options.multyLangValues = {};
	options.multyLangValues["ru"] = {};
	options.multyLangValues["ru"]["econom"] = "Эконом";
	
	options.multyLangValues["ru"]["standart"] = "Стандарт";
	
	options.multyLangValues["ru"]["premium"] = "Премиум";
	
	options.ctrlClass = options.ctrlClass || Enum_quality_levels;
	options.searchOptions = options.searchOptions || {};
	options.searchOptions.searchType = options.searchOptions.searchType || "on_match";
	options.searchOptions.typeChange = (options.searchOptions.typeChange!=undefined)? options.searchOptions.typeChange:false;
	
	EnumGridColumn_quality_levels.superclass.constructor.call(this,options);		
}
extend(EnumGridColumn_quality_levels, GridColumnEnum);

