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
	var pagClass = window.getApp().getPaginationClass();
	
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
		"filters":(options.detailFilters&&options.detailFilters.FinExpenseTypeList_Model)? options.detailFilters.FinExpenseTypeList_Model : [{"field":"parent_id","sign":"i","val":"null"}],	
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("name"),
									"master":true,
									"detailViewClass":FinExpenseTypeList_View,
									"detailViewOptions":{
										"detailFilters":{
											"FinExpenseTypeList_Model":[
												{
												"masterFieldId":"id",
												"field":"parent_id",
												"sign":"e",
												"val":"0"
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
		"pagination":new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
}
extend(FinExpenseTypeList_View,ViewAjxList);

