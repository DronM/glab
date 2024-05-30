/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function ImportItemList_View(id,options){	

	options.HEAD_TITLE = "Номенклатура поставщиков";
	ImportItemList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.ImportItemList_Model)? options.models.ImportItemList_Model : new ImportItemList_Model();
	var contr = new ImportItem_Controller();
	
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
			"cmdInsert": false,
			"cmdEdit": true
		}),		
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:date_time",{
							"value":"Дата",
							"columns":[
								new GridColumnDateTime({
									"field":model.getField("date_time"),
									"ctrlClass":EditDateTime,
									"ctrlEdit":false
								})
							]
						})
						,new GridCellHead(id+":grid:head:import_comment",{
							"value":"Ошибка",
							"columns":[
								new GridColumn({
									"field":model.getField("import_comment"),
									"ctrlEdit":false
								})
							]
						})
					
						,new GridCellHead(id+":grid:head:item_folders_ref",{
							"value":"Группа",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_folders_ref")
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name"),
									"ctrlClass":EditString,
									"ctrlOptions":{
										"maxLength":1000
									}
								})
							]
						})
						
						//make
						,new GridCellHead(id+":grid:head:make",{
							"value":"Марка (API)",
							"columns":[
								new GridColumn({
									"field":model.getField("make"),
									"ctrlEdit":false
								})
							]
						})						
						,new GridCellHead(id+":grid:head:auto_makes_ref",{
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
						//model
						,new GridCellHead(id+":grid:head:model",{
							"value":"Модель (API)",
							"columns":[
								new GridColumn({
									"field":model.getField("model"),
									"ctrlEdit":false
								})
							]
						})						
						,new GridCellHead(id+":grid:head:auto_models_ref",{
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
						//model_generation
						,new GridCellHead(id+":grid:head:model_generation",{
							"value":"Поколение (API)",
							"columns":[
								new GridColumn({
									"field":model.getField("model_generation"),
									"ctrlEdit":false
								})
							]
						})						
						,new GridCellHead(id+":grid:head:auto_model_generations_ref",{
							"value":"Поколение",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_model_generations_ref"),
									"ctrlClass":AutoModelGenerationEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_model_generation_id"
								})
							]
						})
						//body
						,new GridCellHead(id+":grid:head:body",{
							"value":"Кузов (API)",
							"columns":[
								new GridColumn({
									"field":model.getField("body"),
									"ctrlEdit":false
								})
							]
						})						
						,new GridCellHead(id+":grid:head:auto_makes_ref",{
							"value":"Кузов",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_bodies_ref"),
									"ctrlClass":AutoBodyEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"auto_body_id"
								})
							]
						})
						
						//supplier
						,new GridCellHead(id+":grid:head:supplier",{
							"value":"Поставщик (API)",
							"columns":[
								new GridColumn({
									"field":model.getField("supplier"),
									"ctrlEdit":false
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:suppliers_ref",{
							"value":"Поставщик",
							"columns":[
								new GridColumnRef({
									"field":model.getField("suppliers_ref"),
									"ctrlClass":SupplierEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"supplier_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:options",{
							"value":"Поставщик",
							"columns":[
								new GridColumnRef({
									"field":model.getField("options"),
									"formatFunction":function(f){
										var res = "";
										var v = f.options.getValue();
										if(v && CommonHelper.isArray(v) && v.length){
											for(var i = 0; i < v.length; i++){
												res+= (res=="")? "":", ";
												res+= v[i].db_descr + ": "+ v[i].val;
											}
										}
										return res;
									},
									"ctrlEdit":false,
									"ctrlBindFieldId":"options"
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
extend(ImportItemList_View,ViewAjxList);

