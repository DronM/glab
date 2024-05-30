/** Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoBodyList_View(id,options){	

	options.HEAD_TITLE = "Кузова автомобилей";
	AutoBodyList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoBodyList_Model)? options.models.AutoBodyList_Model : new AutoBodyList_Model();
	var contr = new AutoBody_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var self = this;
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline": false,
		"editViewClass":AutoBodyDialog_View,
		"editWinClass":WindowFormModalBS,
		"editWinOptions":{
			"dialogWidth":"50%"
		},		
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdSearch": !options.detailFilters,
			"cmdAllCommands": !options.detailFilters
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.AutoBodyList_Model)? options.detailFilters.AutoBodyList_Model:null,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						options.details||options.detailFilters? null : new GridCellHead(id+":grid:head:auto_models_ref",{
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
					
						,new GridCellHead(id+":grid:head:name",{
							"value":"Название",
							"columns":[
								new GridColumn({
									"field":model.getField("name")
								})
							],
							"sortable":true,
							"sort":"asc"														
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
						
						/*
						,new GridCellHead(id+":grid:head:auto_body_doors_ref",{
							"value":"Тип дверей",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_body_doors_ref"),
									"ctrlClass":AutoBodyDoorEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_body_door_id"
								})
							],
							"sortable":true
						})
						,new GridCellHead(id+":grid:head:auto_body_types_ref",{
							"value":"Тип кузова",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_body_types_ref"),
									"ctrlClass":AutoBodyTypeEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_body_type_id"
								})
							],
							"sortable":true
						})
						
						,new GridCellHead(id+":grid:head:model",{
							"value":"Модификация",
							"columns":[
								new GridColumn({
									"field":model.getField("model"),
									"ctrlClass":EditString,
									"ctrlOptions":{
										"maxLength":100
									}
								})
							]
						})						
						,new GridCellHead(id+":grid:head:auto_price_categories_ref",{
							"value":"Категория цены",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_price_categories_ref"),
									"ctrlClass": AutoPriceCategoryEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_price_category_id"
								})
							]
						})	
						,new GridCellHead(id+":grid:head:auto_body_size",{
							"value":"Размер",
							"columns":[
								new EnumGridColumn_auto_body_sizes({
									"field":model.getField("auto_body_size")
								})
							]
						})						
						,new GridCellHead(id+":grid:head:complexity_film_body",{
							"value":"Сложность пленка кузов",
							"columns":[
								new GridColumn({
									"field":model.getField("complexity_film_body"),
									"ctrlClass":EditNum
								})
							]
						})						
						,new GridCellHead(id+":grid:head:complexity_film_front",{
							"value":"Сложность пленка зад",
							"columns":[
								new GridColumn({
									"field":model.getField("complexity_film_front"),
									"ctrlClass":EditNum
								})
							]
						})						
						,new GridCellHead(id+":grid:head:complexity_film_back",{
							"value":"Сложность пленка перед",
							"columns":[
								new GridColumn({
									"field":model.getField("complexity_film_back"),
									"ctrlClass":EditNum
								})
							]
						})						
						,new GridCellHead(id+":grid:head:complexity_glass",{
							"value":"Сложность стекло",
							"columns":[
								new GridColumn({
									"field":model.getField("complexity_glass"),
									"ctrlClass":EditNum
								})
							]
						})
						*/												
					]
				})
			]
		}),
		"pagination":options.detailFilters? null : new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(AutoBodyList_View,ViewAjxList);

/*
AutoBodyList_View.prototype.setMakeId = function(makeId){
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

AutoBodyList_View.prototype.setModelId = function(modelId){
	var g = this.getElement("grid");
	if(!g){
		return;
	}
	var v = g.getEditViewObj();
	if(!v){
		return;												
	}
	var ctrl = v.getElement("auto_model_generations_ref");
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
	pm.setFieldValue("model_id", modelId);
	ctrl.reset();
}
*/
