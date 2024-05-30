/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 *
 *	Только детальное отображение с фильтром по поколению
 */
function AutoModelGenerationBodyList_View(id,options){	

	options.HEAD_TITLE = "Кузова поколения";
	AutoModelGenerationBodyList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoModelGenerationBodyList_Model)? options.models.AutoModelGenerationBodyList_Model : new AutoModelGenerationBodyList_Model();
	var contr = new AutoModelGenerationBody_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var self = this;
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline": true,
		"editViewClass":null,
		"editWinClass":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdSearch": !options.detailFilters,
			"cmdAllCommands": !options.detailFilters
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.AutoModelGenerationBodyList_Model)? options.detailFilters.AutoModelGenerationBodyList_Model:null,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						,new GridCellHead(id+":grid:head:auto_bodies_ref",{
							"value":"Кузов",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_bodies_ref"),
									"ctrlClass":AutoBodyEdit,
									"ctrlOptions":{
										"labelCaption":"",										
										"auto_model_id": options.auto_model_id
									},
									"ctrlBindFieldId":"auto_body_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:eurocode",{
							"value":"Еврокод",
							"columns":[
								new GridColumn({
									"field":model.getField("eurocode"),
									"maxLength":"20"
								})
							]
						})
						,new GridCellHead(id+":grid:head:local_id",{
							"value":"ID",
							"columns":[
								new GridColumn({
									"field":model.getField("local_id"),
									"ctrlOptions":{
										"maxLength":"3"
									}
								})
							]
						})	
					]
				})
			]
		}),
		"pagination":null,		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(AutoModelGenerationBodyList_View, ViewAjxList);

