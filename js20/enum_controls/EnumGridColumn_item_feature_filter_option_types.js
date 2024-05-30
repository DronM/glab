/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 * @class
 * @classdesc Grid column Enumerator class. Created from build/templates/enumGridColumn.js.tmpl !!!DO NOT MODIFY!!!
 
 * @extends GridColumnEnum
 
 * @requires core/extend.js
 * @requires controls/GridColumnEnum.js
 
 * @param {object} options
 */

function EnumGridColumn_item_feature_filter_option_types(options){
	options = options || {};
	
	options.multyLangValues = {};
	options.multyLangValues["ru"] = {};
	options.multyLangValues["ru"]["main"] = "Основная фильтруемая опция";
	
	options.multyLangValues["ru"]["additional"] = "Дополнительная фильтруемая опция";
	
	options.multyLangValues["ru"]["distinctive"] = "Отличительная опция";
	
	options.ctrlClass = options.ctrlClass || Enum_item_feature_filter_option_types;
	options.searchOptions = options.searchOptions || {};
	options.searchOptions.searchType = options.searchOptions.searchType || "on_match";
	options.searchOptions.typeChange = (options.searchOptions.typeChange!=undefined)? options.searchOptions.typeChange:false;
	
	EnumGridColumn_item_feature_filter_option_types.superclass.constructor.call(this,options);		
}
extend(EnumGridColumn_item_feature_filter_option_types, GridColumnEnum);

