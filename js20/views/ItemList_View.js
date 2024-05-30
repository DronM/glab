/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemList_View(id,options){	

	options.HEAD_TITLE = "Варианты комплектаций";
	ItemList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.ItemList_Model)? options.models.ItemList_Model : new ItemList_Model();
	var contr = new Item_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);

	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":Item_Form,
		"commands":new GridCmdContainerAjx(id+":grid:cmd"),		
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:item_folders_ref",{
							"value":"Группа",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_folders_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:manufacturer_brands_ref",{
							"value":"Брэнд",
							"columns":[
								new GridColumnRef({
									"field":model.getField("manufacturer_brands_ref")
								})
							],
							"sortable":true
						})
						,new GridCellHead(id+":grid:head:item_features_list",{
							"value":"Опции",
							"columns":[
								new GridColumn({
									"field":model.getField("item_features_list"),
									"formatFunction":function(fields){
										var res = "";
										var val = fields.item_features_list.getValue();
										if(!val){
											return res;
										}
										for (var i = 0; i < val.length; i++){
											if(res != ""){
												res+= ", ";
											}
											if(val[i].val_type == "dt_list"){
												res+= "[" + val[i].val + "]";//value only
												
											}else if(val[i].val_type == "dt_bool"){
												res+= "[" + val[i]["name"] + "]";//name only
												
											}else if(val[i].val_type == "dt_float"){
												res+= "[" + val[i]["name"] + ":"+ parseFloat(val[i].val) + "]";
											
											}else{
												res+= "[" + val[i]["name"] + ":"+ val[i].val + "]";
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
extend(ItemList_View,ViewAjxList);

