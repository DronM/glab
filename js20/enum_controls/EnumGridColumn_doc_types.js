/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 * @class
 * @classdesc Grid column Enumerator class. Created from build/templates/enumGridColumn.js.tmpl !!!DO NOT MODIFY!!!
 
 * @extends GridColumnEnum
 
 * @requires core/extend.js
 * @requires controls/GridColumnEnum.js
 
 * @param {object} options
 */

function EnumGridColumn_doc_types(options){
	options = options || {};
	
	options.multyLangValues = {};
	options.multyLangValues["ru"] = {};
	options.multyLangValues["ru"]["cash_flow_in"] = "ПКО";
	
	options.multyLangValues["ru"]["cash_flow_out"] = "РКО";
	
	options.multyLangValues["ru"]["cash_flow_transfers"] = "Перемещение денег";
	
	options.multyLangValues["ru"]["bank_flow_in"] = "Строка банка поступление";
	
	options.multyLangValues["ru"]["bank_flow_out"] = "Строка банка списание";
	
	options.ctrlClass = options.ctrlClass || Enum_doc_types;
	options.searchOptions = options.searchOptions || {};
	options.searchOptions.searchType = options.searchOptions.searchType || "on_match";
	options.searchOptions.typeChange = (options.searchOptions.typeChange!=undefined)? options.searchOptions.typeChange:false;
	
	EnumGridColumn_doc_types.superclass.constructor.call(this,options);		
}
extend(EnumGridColumn_doc_types, GridColumnEnum);

