/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoModelGenerationList_View(id,options){	

	options.HEAD_TITLE = "Поколения моделей автомобилей";
	AutoModelGenerationList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoModelGenerationList_Model)? options.models.AutoModelGenerationList_Model : new AutoModelGenerationList_Model();
	var contr = new AutoModelGeneration_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);

	var edit_inline = (!options.detail&&!options.detailFilters);

	var self = this;
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline": edit_inline,
		"editViewClass":AutoModelGenerationDialog_View,
		"editWinClass":WindowFormModalBS,
		"editWinOptions":{
			"dialogWidth":"50%"
		},		
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdSearch": !options.detailFilters,
			"cmdAllCommands": !options.detailFilters
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.AutoModelGenerationList_Model)? options.detailFilters.AutoModelGenerationList_Model:null,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						!edit_inline? null : new GridCellHead(id+":grid:head:auto_makes_ref",{
							"value":"Марка",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_makes_ref"),
									"ctrlClass":AutoMakeEdit,
									"ctrlOptions":{
										"labelCaption":"",
										"onReset": function(){
											self.setMakeId(0);
										},
										"onSelect": function(f){											
											self.setMakeId(f.id.getValue());
										}
									}
								})
							]
						})
						,!edit_inline? null : new GridCellHead(id+":grid:head:auto_models_ref",{
							"value":"Модель",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_models_ref"),
									"ctrlClass":AutoModelEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_model_id"
								})
							]
						})
						
						/*
						,new GridCellHead(id+":grid:head:generation_num",{
							"value":"Номер",
							"columns":[
								new GridColumn({
									"field":model.getField("generation_num"),
									"master":true,
									"detailViewClass":AutoBodyList_View,
									"detailViewOptions":{
										"detailFilters":{
											"AutoBodyList_Model":[
												{
												"masterFieldId":"id",
												"field":"auto_model_generation_id",
												"sign":"e",
												"val":"0"
												}	
											]
										}													
									}																			
								})
							]
						})
						,new GridCellHead(id+":grid:head:model",{
							"value":"Модификация",
							"columns":[
								new GridColumn({
									"field":model.getField("model")
									,"ctrlOptions":{
										"maxLength":"100"
									}
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:series",{
							"value":"Серия",
							"columns":[
								new GridColumn({
									"field":model.getField("series")
									,"ctrlOptions":{
										"maxLength":"100"
									}
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:year_from",{
							"value":"Начало производства",
							"columns":[
								new GridColumn({
									"field":model.getField("year_from")
								})
							]
						})
						,new GridCellHead(id+":grid:head:year_to",{
							"value":"Окончание производства",
							"columns":[
								new GridColumn({
									"field":model.getField("year_to")
								})
							]
						})
						*/
						,new GridCellHead(id+":grid:head:body_count",{
							"value":"Кузова",
							"columns":[
								new GridColumn({
									"field":model.getField("body_count")
									,"ctrlEdit":false
									,"master":true
									,"detailViewClass":AutoModelGenerationBodyList_View
									,"detailViewOptions":{
										"auto_model_id":options.detailFilters.AutoModelGenerationList_Model[0].val,
										"detailFilters":{
											"AutoModelGenerationBodyList_Model":[
												{
												"masterFieldId":"id",
												"field":"auto_model_generation_id",
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
									,"ctrlEdit":false
								})
							]
						})
						
						/*
						,new GridCellHead(id+":grid:head:eurocode",{
							"value":"Еврокод",
							"columns":[
								new GridColumn({
									"field":model.getField("eurocode")
									,"ctrlOptions":{
										"maxLength":"100"
									}
								})
							]
						})
						,new GridCellHead(id+":grid:head:local_id",{
							"value":"ID",
							"columns":[
								new GridColumn({
									"field":model.getField("local_id")
									,"ctrlOptions":{
										"maxLength":"10"
									}
								})
							]
						})
						*/
						
					]
				})
			]
		}),
		"pagination":options.detailFilters? null:new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(AutoModelGenerationList_View,ViewAjxList);

AutoModelGenerationList_View.prototype.setMakeId = function(makeId){
	var g = this.getElement("grid");
	if(!g){
		return;
	}
	var v = g.getEditViewObj();
	if(!v){
		return;												
	}
	var ctrl = v.getElement("auto_models_ref");
	if(!ctrl){
		return;												
	}
	var compl = ctrl.getAutoComplete();
	if(!compl){
		return;
	}
	var pm = compl.getPublicMethod();
	if(!pm){
		return;
	}
	pm.setFieldValue("make_id", makeId);
	ctrl.reset();
}
