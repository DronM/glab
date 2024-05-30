/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoList_View(id,options){	

	options.HEAD_TITLE = "Автомобили";
	AutoList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoList_Model)? options.models.AutoList_Model : new AutoList_Model();
	var contr = new Auto_Controller();
	
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
						new GridCellHead(id+":grid:head:auto_makes",{
							"value":"Марка",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_makes"),
									"ctrlClass":AutoMakeEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_make_id"
								})
							],
							"sortable":true
						})
						,new GridCellHead(id+":grid:head:auto_models",{
							"value":"Модель",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_models"),
									"ctrlClass":AutoModelEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_model_id"
								})
							],
							"sortable":true
						})
						,new GridCellHead(id+":grid:head:auto_generations_ref",{
							"value":"Поколение",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_generations_ref"),
									"ctrlClass":AutoGenerationEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_generation_id"
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
extend(AutoList_View,ViewAjxList);

