/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoMakeList_View(id,options){	

	options.HEAD_TITLE = "Марки автомобилей";
	AutoMakeList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoMakeList_Model)? options.models.AutoMakeList_Model : new AutoMakeList_Model();
	var contr = new AutoMake_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":AutoMake_Form,
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
							"sortable":true
						})
						,new GridCellHead(id+":grid:head:name_variants",{
							"value":"Варианты наименования",
							"columns":[
								new GridColumn({
									"field":model.getField("name_variants")
								})
							]
						})
						,new GridCellHead(id+":grid:head:popularity_types_ref",{
							"value":"Популярность",
							"columns":[
								new GridColumnRef({
									"field":model.getField("popularity_types_ref"),
									"ctrlClass":PopularityTypeEdit,
									"ctrlBindFieldId":"popularity_type_id"
								})
							],
							"sortable":true
						})
						
						,new GridCellHead(id+":grid:head:logo",{
							"value":"Логотип",
							"columns":[
								new GridColumnPicture({
									"field":model.getField("logo"),
									"pictureWidth": "32",
									"pictureHeight": "32"
								})
							]
						})
						,new GridCellHead(id+":grid:head:model_count",{
							"value":"Кол-во моделей",
							"columns":[
								new GridColumn({
									"field":model.getField("model_count")
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
extend(AutoMakeList_View,ViewAjxList);

