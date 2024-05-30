/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoPriceCategoryList_View(id,options){	

	options.HEAD_TITLE = "Ценовые категории автомобилей";
	AutoPriceCategoryList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoPriceCategory_Model)? options.models.AutoPriceCategory_Model : new AutoPriceCategory_Model();
	var contr = new AutoPriceCategory_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);

	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd"),		
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:price_from",{
							"value":"Цена от",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("price_from"),
									"precision":"2",
									"ctrlClass":EditMoney
								})
							]
						})
						,new GridCellHead(id+":grid:head:price_to",{
							"value":"Цена до",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("price_to"),
									"precision":"2",
									"ctrlClass":EditMoney
								})
							]
						})
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
extend(AutoPriceCategoryList_View,ViewAjxList);

