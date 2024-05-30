/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 *
 *	Headless grid for detail view from ItemFolderList
 */
function SupplierItemFolderFeatureGroupList_View(id,options){	

	options.tagName = "TD";
	SupplierItemFolderFeatureGroupList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.SupplierItemFolderFeatureGroupList_Model)? options.models.SupplierItemFolderFeatureGroupList_Model : new SupplierItemFolderFeatureGroupList_Model();
	var contr = new SupplierItemFolderFeatureGroup_Controller();

	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);

	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"], 
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"showHead": false,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdSearch": false
			,"cmdAllCommands": false
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.SupplierItemFolderFeatureGroupList_View)? options.detailFilters.SupplierItemFolderFeatureGroupList_View : [{"field": "item_folder_id", "sign": "e", "val": null}],
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:item_feature_groups_ref",{
							"value":"Группа характеристик",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_feature_groups_ref")
									,"ctrlClass": ItemFeatureGroupEdit
									,"ctrlOptions": {
										"labelCaption":""
									}
									,"ctrlBindFieldId": "item_feature_group_id"
								})
							]
						})
					]
				})
			]
		}),
		"pagination": null,		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(SupplierItemFolderFeatureGroupList_View,ViewAjxList);

