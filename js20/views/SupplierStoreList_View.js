/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function SupplierStoreList_View(id,options){	

	options.HEAD_TITLE = "Места хранения поставщиков";
	SupplierStoreList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.SupplierStoreList_Model)? options.models.SupplierStoreList_Model : new SupplierStoreList_Model();
	var contr = new SupplierStore_Controller();
	
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
						options.detail? null : new GridCellHead(id+":grid:head:suppliers_ref",{
							"value":"Поставщик",
							"columns":[
								new GridColumnRef({
									"field":model.getField("suppliers_ref"),
									"form":Supplier_Form,
									"ctrlClass":SupplierEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"supplier_id"
								})
							],
							"sortable":true
						})
					
						,new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name")
								})
							],
							"sortable":true,
							"sort":"asc"														
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
extend(SupplierStoreList_View,ViewAjxList);

