/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function ManufacturerList_View(id,options){	

	options.HEAD_TITLE = "Производители";
	ManufacturerList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.ManufacturerList_Model)? options.models.ManufacturerList_Model : new ManufacturerList_Model();
	var contr = new Manufacturer_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":Manufacturer_Form,
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
						,new GridCellHead(id+":grid:head:brand_list",{
							"value":"Список брэндов",
							"columns":[
								new GridColumn({
									"field":model.getField("brand_list"),
									"edit":false,
									"formatFunction":function(f){
										var res = "";
										var b = f.brand_list.getValue();
										if(b && CommonHelper.isArray(b) && b.length){
											for(var i = 0; i < b.length; i++){
												res += (res=="")? "" : ", ";
												res += b[i]["name"];
											}
										}
										return res;
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
extend(ManufacturerList_View,ViewAjxList);

