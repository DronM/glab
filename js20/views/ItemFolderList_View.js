/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemFolderList_View(id,options){	

	options.HEAD_TITLE = "Структура каталога товаров";
	ItemFolderList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.ItemFolderList_Model)? options.models.ItemFolderList_Model : new ItemFolderList_Model();
	var contr = new ItemFolder_Controller();

	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var self = this;
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"], 
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdSearch": false,
			"cmdAllCommands": false
		}),
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.ItemFolderList_View)? options.detailFilters.ItemFolderList_View : [{"field": "parent_item_folder_id", "sign": "i", "val": null}],
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:code",{
							"value":"Код",
							"columns":[
								new GridColumn({
									"field":model.getField("code"),
									"master":true,
									"detailViewClass":ItemFolderList_View,
									"detailViewOptions":{
										"detailFilters":{
											"ItemFolderList_View":[
												{
												"masterFieldId":"id",
												"field":"parent_item_folder_id",
												"sign":"e",
												"val":"0"
												}	
											]
										}													
									}																			
								})
							],
							"sortable":true,
							"sort":"asc"														
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
						,new GridCellHead(id+":grid:head:item_priorities_ref",{
							"value":"Тип товара (поиск)",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_priorities_ref"),
									"ctrlClass": ItemPriorityEdit,
									"ctrlBindFieldId":"item_priority_id",
									"ctrlOptions":{
										"labelCaption":""
									}
								})
							]
						})
						,new GridCellHead(id+":grid:head:vehicle_types_ref",{
							"value":"Тип транпорта",
							"columns":[
								new GridColumnRef({
									"field":model.getField("vehicle_types_ref"),
									"ctrlClass": VehicleTypeEdit,
									"ctrlBindFieldId":"vehicle_type_id",
									"ctrlOptions":{
										"labelCaption":""
									}
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:item_feature_groups_list",{
							"value":"Группы характеристик (каталог)",
							"columns":[
								new GridColumn({
									"field":model.getField("item_feature_groups_list"),
									"formatFunction": function(f){
										var v = f.item_feature_groups_list.getValue();
										if(!v || !CommonHelper.isArray(v)){
											return "";
										}
										var d = "";
										for(var i = 0; i<v.length; i++){
											if(d !=""){
												d += ", ";
											}
											d += v[i].getDescr();
										}
										return d;
									},
									"ctrlClass": ItemFolderFeatureGroupList_View
									,"ctrlOptions":function(){
										var id = self.getElement("grid").getModel().getFieldValue("id");
										if(!id){
											return {};
										}
										return {
											"detailFilters": {
												"ItemFolderFeatureGroupList_View": [{
													"field": "item_folder_id",
													"sign": "e",
													"val": id
												}]
											}
										};										
									}
								})
							]
						})
						,new GridCellHead(id+":grid:head:supplier_item_feature_groups_list",{
							"value":"Группы характеристик (поставщик)",
							"columns":[
								new GridColumn({
									"field":model.getField("supplier_item_feature_groups_list"),
									"formatFunction": function(f){
										var v = f.supplier_item_feature_groups_list.getValue();
										if(!v || !CommonHelper.isArray(v)){
											return "";
										}
										var d = "";
										for(var i = 0; i<v.length; i++){
											if(d !=""){
												d += ", ";
											}
											d += v[i].getDescr();
										}
										return d;
									},
									"ctrlClass": SupplierItemFolderFeatureGroupList_View
									,"ctrlOptions":function(){
										var id = self.getElement("grid").getModel().getFieldValue("id");
										if(!id){
											return {};
										}
										return {
											"detailFilters": {
												"SupplierItemFolderFeatureGroupList_View": [{
													"field": "item_folder_id",
													"sign": "e",
													"val": id
												}]
											}
										};										
									}
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
extend(ItemFolderList_View,ViewAjxList);

