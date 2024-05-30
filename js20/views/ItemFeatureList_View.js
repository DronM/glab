/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemFeatureList_View(id,options){	

	options.HEAD_TITLE = "Характеристики номенклатуры";
	ItemFeatureList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.ItemFeatureList_Model)? options.models.ItemFeatureList_Model : new ItemFeatureList_Model();
	var contr = new ItemFeature_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":ItemFeature_Form,
		"commands":new GridCmdContainerAjx(id+":grid:cmd"),		
		"popUpMenu":popup_menu,
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
							"sortable":true,
							"sort":"asc"														
						})
						,new GridCellHead(id+":grid:head:comment_text",{
							"value":"Комментарий",
							"columns":[
								new GridColumn({
									"field":model.getField("comment_text")
								})
							]
						})
						/*
						нет такой больше, перенесено в item_feature_group_items
						,new GridCellHead(id+":grid:head:filter_option_type",{
							"value":"Вид фильтра",
							"columns":[
								new EnumGridColumn_item_feature_filter_option_types({
									"field":model.getField("filter_option_type")
								})
							]
						})
						*/
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
extend(ItemFeatureList_View,ViewAjxList);

