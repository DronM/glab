/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoGenerationList_View(id,options){	

	options.HEAD_TITLE = "Поколения автомобилей";
	AutoGenerationList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoGenerationList_Model)? options.models.AutoGenerationList_Model : new AutoGenerationList_Model();
	var contr = new AutoModel_Controller();
	
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
extend(AutoGenerationList_View,ViewAjxList);

