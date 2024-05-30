/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function BankCardList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Виды банковских карт";

	BankCardList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.BankCard_Model)? options.models.BankCard_Model : new BankCard_Model();
	var contr = new BankCard_Controller();
	
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
		"editWinClass":null,
		"editViewClass":null,
		"editViewOptions":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{}),		
		"popUpMenu":popup_menu,
		"filters":null,	
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name"),
									"ctrlOptions":{
										"maxLength":250
									}
								})
							],
							"sortable":true,
							"sort":"asc"							
						}),
					]
				})
			]
		}),
		"pagination":new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
}
extend(BankCardList_View,ViewAjxList);

