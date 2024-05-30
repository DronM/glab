/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function ManufacturerBrandList_View(id,options){	

	options.HEAD_TITLE = "Брэнды производителей";
	ManufacturerBrandList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.ManufacturerBrandList_Model)? options.models.ManufacturerBrandList_Model : new ManufacturerBrandList_Model();
	var contr = new ManufacturerBrand_Controller();
	
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
						options.detail? null: new GridCellHead(id+":grid:head:manufacturers_ref",{
							"value":"Производитель",
							"columns":[
								new GridColumnRef({
									"field":model.getField("manufacturers_ref"),
									"ctrlClass":ManufacturerEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"manufacturer_id"
								})
							]
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
						,new GridCellHead(id+":grid:head:quality_level",{
							"value":"Качество",
							"columns":[
								new EnumGridColumn_quality_levels({
									"field":model.getField("quality_level")
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
extend(ManufacturerBrandList_View,ViewAjxList);

