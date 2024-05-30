/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoModelList_View(id,options){	

	options.HEAD_TITLE = "Модели автомобилей";
	AutoModelList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoModelList_Model)? options.models.AutoModelList_Model : new AutoModelList_Model();
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
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdSearch": !options.detailFilters,
			"cmdAllCommands": !options.detailFilters
		}),				
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.AutoModelList_Model)? options.detailFilters.AutoModelList_Model:null,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						options.detail? null : new GridCellHead(id+":grid:head:auto_makes_ref",{
							"value":"Марка",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_makes_ref"),
									"ctrlClass":AutoMakeEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_make_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:body_count",{
							"value":"Кузова",
							"columns":[
								new GridColumn({
									"field":model.getField("body_count"),
									"ctrlEdit":false,
									"master":true,
									"detailViewClass":AutoBodyList_View,
									"detailViewOptions":{
										"detailFilters":{
											"AutoBodyList_Model":[
												{
												"masterFieldId":"id",
												"field":"auto_model_id",
												"sign":"e",
												"val":"0"
												}	
											]
										}													
									}																			
								})
							]
						})
						,new GridCellHead(id+":grid:head:model_generation_count",{
							"value":"Поколения",
							"columns":[
								new GridColumn({
									"field":model.getField("model_generation_count"),
									"ctrlEdit":false,
									"master":true,
									"detailViewClass":AutoModelGenerationList_View,
									"detailViewOptions":{
										"detailFilters":{
											"AutoModelGenerationList_Model":[
												{
												"masterFieldId":"id",
												"field":"auto_model_id",
												"sign":"e",
												"val":"0"
												}	
											]
										}													
									}																			
								})
							]
						})

						,new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name")
									/*
									"master":true,
									"detailViewClass":AutoModelGenerationList_View,
									"detailViewOptions":{
										"detailFilters":{
											"AutoModelGenerationList_Model":[
												{
												"masterFieldId":"id",
												"field":"auto_model_id",
												"sign":"e",
												"val":"0"
												}	
											]
										}													
									}
									*/																			
								})
							]
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
									"ctrlBindFieldId":"popularity_type_id",
									"ctrlOptions":{
										"labelCaption": "",
										"value":new RefType({"keys":{"id":3},"descr":"Непопулярна"})
									}
								})
							]
						})
						,new GridCellHead(id+":grid:head:vehicle_types_ref",{
							"value":"Тип транспорта",
							"columns":[
								new GridColumnRef({
									"field":model.getField("vehicle_types_ref"),
									"ctrlClass":VehicleTypeEdit,
									"ctrlBindFieldId":"vehicle_type_id",
									"ctrlOptions":{
										"labelCaption": "",
										"value":new RefType({"keys":{"id":1},"descr":"иномарки"})
									}
								})
							]
						})
						/*
						,new GridCellHead(id+":grid:head:model_generation_count",{
							"value":"Кол-во поколений",
							"columns":[
								new GridColumn({
									"field":model.getField("model_generation_count"),
									"ctrlEdit":false
								})
							]
						})
						*/
					]
				})
			]
		}),
		"pagination":new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(AutoModelList_View,ViewAjxList);

