/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function PopularityTypeList_View(id,options){	

	options.HEAD_TITLE = "Типы популярности";
	PopularityTypeList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.PopularityType_Model)? options.models.PopularityType_Model : new PopularityType_Model();
	var contr = new PopularityType_Controller();
	
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
						new GridCellHead(id+":grid:head:code",{
							"value":"Код",
							"columns":[
								new GridColumn({
									"field":model.getField("code")
								})
							],
							"sortable":true,
							"sort":"desc"
						})
					
						,new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name")
								})
							],
							"sortable":true
						})
						,new GridCellHead(id+":grid:head:screen_width_type",{
							"value":"Тип экрана",
							"columns":[
								new EnumGridColumn_screen_width_types({
									"field":model.getField("screen_width_type")
								})
							]
						})						
						,new GridCellHead(id+":grid:head:item_count",{
							"value":"Количество для вывода",
							"columns":[
								new GridColumn({
									"field":model.getField("item_count"),
									"ctrlClass":EditInt
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
extend(PopularityTypeList_View,ViewAjxList);

