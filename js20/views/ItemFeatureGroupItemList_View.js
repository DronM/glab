/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemFeatureGroupItemList_View(id,options){	

	ItemFeatureGroupItemList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.ItemFeatureGroupItemList_Model)? options.models.ItemFeatureGroupItemList_Model : new ItemFeatureGroupItemList_Model();
	var contr = new ItemFeatureGroupItem_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	//var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdAllCommands": false,
			"cmdSearch": false
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.ItemFeatureGroupItemList_View)? options.detailFilters.ItemFeatureGroupItemList_View:null,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:code",{
							"value":"Код",
							"columns":[
								new GridColumn({
									"field":model.getField("code"),
									"ctrlClass": EditInt,
									"ctrlOptions":{
										"title":"Используется для сортировки",
										"required":true
									}
								})
							],
							"sortable":true,
							"sort":"asc"
						})
					
						,new GridCellHead(id+":grid:head:item_features_ref",{
							"value":"Характеристика",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_features_ref"),
									"ctrlClass": ItemFeatureEdit,
									"ctrlOptions":{
										"labelCaption": ""
									},
									"ctrlBindFieldId": "item_feature_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:filter_option_type",{
							"value":"Вид фильтра",
							"columns":[
								new EnumGridColumn_item_feature_filter_option_types({
									"field":model.getField("filter_option_type")
								})
							]
						})
						,new GridCellHead(id+":grid:head:for_config",{
							"value":"Конфигуратор",
							"colAttrs":{
								"title":"Использовать для конфигуратора"
							},
							"columns":[
								new GridColumnBool({
									"field":model.getField("for_config"),
									"showFalse":false
								})
							]
						})
						
					]
				})
			]
		}),
		"pagination": null,
			/*new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
			*/
		"autoRefresh": true,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(ItemFeatureGroupItemList_View,ViewAjxList);

