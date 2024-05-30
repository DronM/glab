/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoToGlassMatchEurocodeList_View(id,options){	

	this.m_afterGridUpdate = options.afterGridUpdate;
	
	AutoToGlassMatchEurocodeList_View.superclass.constructor.call(this,id,options);

	var model = (options.models && options.models.AutoToGlassMatchEurocodeList_Model)? options.models.AutoToGlassMatchEurocodeList_Model : new AutoToGlassMatchEurocodeList_Model();
	var contr = new AutoToGlassMatchEurocode_Controller();
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	var grid = new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdSearch": false,
			"cmdAllCommands": false
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
									"field":model.getField("user_code"),
									"ctrlClass":EditString,
									"ctrlOptions":{
										"labelCaption":"",
										"maxLength":"30"
									}
								})
							]
						})

						,new GridCellHead(id+":grid:head:auto_bodies_list",{
							"value":"Автомобили",
							"columns":[
								new GridColumn({
									"field":model.getField("auto_bodies_list"),
									"ctrlEdit":false,
									"formatFunction":function(f){
										var res = "";
										var b = f.auto_bodies_list.getValue();
										if(b && b.length){
											for(var i = 0; i < b.length; i ++){
												res += (res=="")? "":" / ";
												res += 
													b[i].auto_make + " " +
													b[i].auto_model + " " + 
													b[i].auto_model_generation_num + " " + 
													"(" + b[i].auto_model_generation_year_from + "-" + b[i].auto_model_generation_year_to + ")";
											}
										}
										return res;
									}
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
	});	
	this.addElement(grid);
	
	var self = this;
	this.m_grid_afterServerDelRow = grid.afterServerDelRow;
	grid.afterServerDelRow = function(){
		self.m_grid_afterServerDelRow.call(self.getElement("grid"));
		self.m_afterGridUpdate();		
	}
	this.m_grid_refreshAfterEditCont = grid.refreshAfterEditCont;
	grid.refreshAfterEditCont = function(res){
		self.m_grid_refreshAfterEditCont.call(self.getElement("grid"), res);
		if(res && res.updated){
			self.m_afterGridUpdate();		
		}
	}
}
extend(AutoToGlassMatchEurocodeList_View,ViewAjxList);

