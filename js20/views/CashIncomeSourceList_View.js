
/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function CashIncomeSourceList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Источники поступления наличных";

	CashIncomeSourceList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.CashIncomeSourceList_Model)? options.models.CashIncomeSourceList_Model : new CashIncomeSourceList_Model();
	var contr = new CashIncomeSource_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	
	var filters;
	this.addElement(new GridAjx(id+":grid",{
		"filters": filters,
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":true,
		"editWinClass":null,//WindowFormModalBS,
		"editViewClass":null,//CashIncomeSourceDialog_View,
		/*"editViewOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},*/
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"CashIncomeSource"
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.CashIncomeSourceList_Model)? options.detailFilters.CashIncomeSourceList_Model:null,	
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name")
								})
							],
							"sortable":true
						}),
						,new GridCellHead(id+":grid:head:cash_locations_ref",{
							"value":"Отправитель",
							"columns":[
								new GridColumnRef({
									"field":model.getField("cash_locations_ref"),
									"ctrlClass":CashLocationEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"cash_location_id"
								})
							]
						})
					]
				})
			]
		}),
		"pagination":new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
}
extend(CashIncomeSourceList_View,ViewAjxList);

