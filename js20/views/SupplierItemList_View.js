/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function SupplierItemList_View(id,options){	

	options.HEAD_TITLE = "Номенклатура поставщиков";
	SupplierItemList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.SupplierItemList_Model)? options.models.SupplierItemList_Model : new SupplierItemList_Model();
	var contr = new SupplierItem_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":SupplierItem_Form,
		"commands":new GridCmdContainerAjx(id+":grid:cmd"),		
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						/*new GridCellHead(id+":grid:head:item_folders_ref",{
							"value":"Группа",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_folders_ref")
								})
							]
						})
						,*/
						new GridCellHead(id+":grid:head:items_ref",{
							"value":"Номенклатура",
							"columns":[
								new GridColumnRef({
									"field":model.getField("items_ref"),
									"ctrlClass":ItemEdit
								})
							],
							"sortable":true,
							"sort":"asc"														
						})
						,new GridCellHead(id+":grid:head:suppliers_ref",{
							"value":"Поставщик",
							"columns":[
								new GridColumnRef({
									"field":model.getField("suppliers_ref"),
									"ctrlClass":SupplierEdit
								})
							]
						})
						,new GridCellHead(id+":grid:head:supplier_item_id",{
							"value":"ID поставщика",
							"columns":[
								new GridColumn({
									"field":model.getField("supplier_item_id")
								})
							]
						})
						,new GridCellHead(id+":grid:head:artikul",{
							"value":"Артикул",
							"columns":[
								new GridColumn({
									"field":model.getField("artikul")
								})
							]
						})
						,new GridCellHead(id+":grid:head:artikul",{
							"value":"Артикул",
							"columns":[
								new GridColumn({
									"field":model.getField("artikul")
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
extend(SupplierItemList_View,ViewAjxList);

