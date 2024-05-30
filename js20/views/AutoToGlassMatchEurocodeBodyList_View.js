/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoToGlassMatchEurocodeBodyList_View(id,options){	

	AutoToGlassMatchEurocodeBodyList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoToGlassMatchEurocodeBodyList_Model)? options.models.AutoToGlassMatchEurocodeBodyList_Model : new AutoToGlassMatchEurocodeBodyList_Model();
	var contr = new AutoToGlassMatchEurocode_Controller();
	
	var popup_menu = null;
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"keyIds":["eurocode_local"],
		"model":model,
		"controller":contr,
		"readPublicMethod":contr.getPublicMethod("get_body_list"),
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdInsert": false,
			"cmdEdit": false,
			"cmdDelete": false,
			"cmdAllCommands": false,
			"cmdSearch": false,
			"cmdPrint":false,
			"cmdExport":false
		}),			
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:user_code",{
							"value":"Еврокод",
							"columns":[
								new GridColumn({
									"field":model.getField("eurocode_local")
								})
							]
						})
						,new GridCellHead(id+":grid:head:doors",{
							"value":"Двери",
							"columns":[
								new GridColumn({
									"field":model.getField("doors")
								})
							]
						})
						,new GridCellHead(id+":grid:head:type",{
							"value":"Тип",
							"columns":[
								new GridColumn({
									"field":model.getField("type")
								})
							]
						})						
						,new GridCellHead(id+":grid:head:model",{
							"value":"Модель",
							"columns":[
								new GridColumn({
									"field":model.getField("model")
								})
							]
						})
						
					]
				})
			]
		}),
		"pagination":null,				
		"autoRefresh":false,
		"refreshInterval":null,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(AutoToGlassMatchEurocodeBodyList_View,ViewAjxList);

