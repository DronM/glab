/** Copyright (c) 2016
 *	Andrey Mikhalevich, Katren ltd.
 */
function UserList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Пользователи";

	UserList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.UserList_Model)? options.models.UserList_Model : new UserList_Model();
	var contr = new User_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	
	var filters;
	if (!options.detail){
		filters = {
			/*"id":{
				"binding":new CommandBinding({
					"control":new EditNum(id+":filter-ctrl-id",{
						"contClassName":"form-group-filter",
						"labelCaption":"Идентификатор:"
					}),
				"field":new FieldInt("id")}),
				"sign":"e"		
			}*/
			"name":{
				"binding":new CommandBinding({
					"control":new EditString(id+":filter-ctrl-name",{
						"contClassName":"form-group-filter",
						"labelCaption":"Имя пользоватея:"
					}),
				"field":new FieldString("name")}),
				"sign":"lk",
				"icase": "1",
				"lwcards": true,
				"rwcards": true					
			}			
			,"banned":{
				"binding":new CommandBinding({
					"control":new EditSelect(id+":filter-ctrl-banned",{
						"contClassName":"form-group-filter",
						"labelCaption":"Доступ закрыт:",
						"elements":[
							new EditSelectOption(id+":filter-ctrl-banned:true",{
								"value": true,
								"descr": "Только с закрытым доступом"
							})
							,new EditSelectOption(id+":filter-ctrl-banned:false",{
								"value": false,
								"descr": "Только с откртым доступом"
							})						
						]
					}),
				"field":new FieldBool("banned")}),
				"sign":"e"		
			}
		}
	}
		
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":User_Form,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"filters": filters,
			"exportFileName":"Пользователи"
		}),		
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"value":"Имя пользователя",
							"columns":[
								new GridColumn({
									"field":model.getField("name")
								})
							],
							"sortable":true,
							"sort":"asc"							
						})
						
						,new GridCellHead(id+":grid:head:role_id",{
							"value":"Роль",
							"columns":[
								new EnumGridColumn_role_types({
									"field":model.getField("role_id")
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
		"focus":true,
		"srvEvents": null
	}));	
}
extend(UserList_View,ViewAjxList);
