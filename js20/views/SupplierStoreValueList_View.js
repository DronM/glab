/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function SupplierStoreValueList_View(id,options){	

	options.HEAD_TITLE = "Остатки по местам хранения поставщиков";
	
	this.m_dialogView = options.dialogView;
	
	SupplierStoreValueList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.SupplierStoreValueList_Model)? options.models.SupplierStoreValueList_Model : new SupplierStoreValueList_Model();
	var contr = new SupplierStoreValue_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	var self = this;
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
						new GridCellHead(id+":grid:head:supplier_stores_ref",{
							"value":"Место хранения",
							"columns":[
								new GridColumnRef({
									"field":model.getField("supplier_stores_ref"),
									"ctrlBindFieldId":"supplier_store_id",
									"form":null,
									"ctrlClass":SupplierStoreEdit,									
									"ctrlOptions":(function(dialogView){
										return function(){
											var ref = dialogView.getElement("suppliers_ref").getValue();
											var supplier_id = null;
											if(ref&&!ref.isNull()){
												supplier_id = ref.getKey();
											}
											return {
												"labelCaption":"",
												"supplier_id": supplier_id
											}
										}
									})(self.m_dialogView)
								})
							],
							"sortable":true
						})
						,options.detail? null : new GridCellHead(id+":grid:head:supplier_items_ref",{
							"value":"Номенклатура",
							"columns":[
								new GridColumnRef({
									"field":model.getField("supplier_items_ref"),
									"ctrlBindFieldId":"supplier_item_id"
									/*"form":Supplier_Form,
									"ctrlClass":SupplierEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									
									*/
								})
							],
							"sortable":true
						})
					
						,new GridCellHead(id+":grid:head:val",{
							"value":"Количество",
							"columns":[
								new GridColumn({
									"field":model.getField("val"),
									"ctrlClass":EditString,
									"ctrlOptions":{
										"maxLength":"250"
									}
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
extend(SupplierStoreValueList_View,ViewAjxList);

