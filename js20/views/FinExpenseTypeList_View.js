/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function FinExpenseTypeList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Статьи расходов";

	FinExpenseTypeList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.FinExpenseTypeList_Model)? options.models.FinExpenseTypeList_Model : new FinExpenseTypeList_Model();
	var contr = new FinExpenseType_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	// var pagClass = window.getApp().getPaginationClass();

	let detFiltersExists = (options.detailFilters&&options.detailFilters.FinExpenseTypeList_Model);
	let detFilters =  detFiltersExists? options.detailFilters.FinExpenseTypeList_Model : [{"field":"parent_id","sign":"i","val":"null"}];	
	let currentLevel = 1;
	let rootNodeId = 0;
	if(detFilters.length >=2 && detFilters[1].field == "lev"){
		currentLevel = detFilters[1].val;
		if(currentLevel == 2){
			rootNodeId = detFilters[0].val;
		}else{
			rootNodeId = options.detailFilters.rootNodeId;
		}
	}

	this.addElement(new GridAjx(id+":grid",{
		"filters": null,
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":false,
		"editWinClass":WindowFormModalBS,
		"editViewClass":FinExpenseTypeDialog_View,
		"editWinOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"СтатьиРасходов"
		}),		
		"popUpMenu":popup_menu,
		"filters":detFilters,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name"),
									"master":currentLevel<3? true:false,
									"detailViewClass":FinExpenseTypeList_View,
									"detailViewOptions":{
										"detailFilters":{
											"rootNodeId":rootNodeId,
											"FinExpenseTypeList_Model":[
												{
												"masterFieldId":currentLevel==1? "id" : null,
												"field":"parent_id",
												"sign":"e",
												"val":rootNodeId
												},	
												{
												"masterFieldId":null,//fixed value
												"field":"lev",
												"sign":"e",
												"val":currentLevel+1
												}	
											]
										}													
									}																			
								})
							],
							"sortable":true,
							"sort":"asc"							
						}),
						new GridCellHead(id+":grid:head:deleted",{
							"value":"Удален",
							"columns":[
								new GridColumnBool({
									"field":model.getField("deleted"),
								    "showFalse":false	
								})
							]
						})
					]
				})
			]
		}),
		"pagination":null, //show all rows, no pagination
		 //    new pagClass(id+"_page",
			// {"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
}
extend(FinExpenseTypeList_View,ViewAjxList);

