
/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function FinExpenseTypeItemList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Статьи расходов";

	FinExpenseTypeItemList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.FinExpenseTypeItemList_Model)? options.models.FinExpenseTypeItemList_Model : new FinExpenseTypeItemList_Model();
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
		"publicMethod":contr.getPublicMethod("get_item_list"),
		"editInline":false,
		"editWinClass":null,
		"editViewClass":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"СтатьиРасходов"
			,"cmdInsert":false
			,"cmdDelete":false
			,"cmdEdit":false
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.FinExpenseTypeItemList_Model)? options.detailFilters.FinExpenseTypeItemList_Model : [{"field":"parent_id","sign":"i","val":"null"}],	
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:parents1_ref",{
							"value":"Вид",
							"columns":[
								new GridColumnRef({
									"field":model.getField("parents1_ref"),
									"ctrlClass":FinExpenseTypeEdit,
									"ctrlOptions":{
										"no_filter":true
									},
									"searchOptions":{
										"field":new FieldInt("parent1_id"),
										"searchType":"on_match",
										"typeChange":false
									}
								})
							]
						})
						,new GridCellHead(id+":grid:head:parents2_ref",{
							"value":"Тип",
							"columns":[
								new GridColumnRef({
									"field":model.getField("parents2_ref"),
									"ctrlClass":FinExpenseTypeEdit,
									"ctrlOptions":{
										"no_filter":true
									},
									"searchOptions":{
										"field":new FieldInt("parent2_id"),
										"searchType":"on_match",
										"typeChange":false
									}
								})
							]
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
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
}
extend(FinExpenseTypeItemList_View,ViewAjxList);

