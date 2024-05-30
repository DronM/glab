/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoToGlassMatchHeadList_View(id,options){	

	options.HEAD_TITLE = "Конфигуратор комплектаций";
	AutoToGlassMatchHeadList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoToGlassMatchHeadList_Model)? options.models.AutoToGlassMatchHeadList_Model : new AutoToGlassMatchHeadList_Model();
	var contr = new AutoToGlassMatchHead_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":AutoToGlassMatchHead_Form,
		"commands":new GridCmdContainerAjx(id+":grid:cmd"),		
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:date_time",{
							"value":"Дата",
							"columns":[
								new GridColumnDateTime({
									"field":model.getField("date_time")
								})
							],
							"sortable":true,
							"sort":"desc"														
						})
						,new GridCellHead(id+":grid:head:user_code_list",{
							"value":"Коды",
							"columns":[
								new GridColumn({
									"field":model.getField("user_code_list")
								})
							]
						})
						,new GridCellHead(id+":grid:head:auto_bodies_list",{
							"value":"Автомобили",
							"columns":[
								new GridColumn({
									"field":model.getField("auto_bodies_list"),
									"formatFunction":function(f){
										var res = "";
										var b = f.auto_bodies_list.getValue();
										if(b && b.length){
											for(var i = 0; i < b.length; i ++){
												var res_b = "";
												for(var j = 0; j < b[i].length; j ++){
													res_b += (res_b=="")? "":" / ";
													res_b += 
														b[i][j].auto_make + " " +
														b[i][j].auto_model + " " + 
														b[i][j].auto_model_generation_num + " " + 
														"(" + b[i][j].auto_model_generation_year_from + "-" + b[i][j].auto_model_generation_year_to + ")";
												}
												res += (res=="")? "":", ";
												res += res_b;
											}
										}
										return res;
									}
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:users_ref",{
							"value":"Пользователь",
							"columns":[
								new GridColumnRef({
									"field":model.getField("users_ref"),
									"ctrlEdit":false
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
extend(AutoToGlassMatchHeadList_View,ViewAjxList);

