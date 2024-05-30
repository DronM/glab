/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function EmployeeList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Сотрудники";

	EmployeeList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.EmployeeList_Model)? options.models.EmployeeList_Model : new EmployeeList_Model();
	var contr = new Employee_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	
	var filters;
	if (!options.detail){
	}
	this.addElement(new GridAjx(id+":grid",{
		"filters": filters,
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":false,
		"editWinClass":WindowFormModalBS,
		"editViewClass":EmployeeDialog_View,
		"editViewOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"Сотрудники"
			/*"addCustomCommandsAfter":function(commands){
				commands.push(new EmployeeGridCmdXXXX(id+":grid:cmd:XXXX"));
			}*/			
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.EmployeeList_Model)? options.detailFilters.EmployeeList_Model:null,	
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({"field":model.getField("name")})
							],
							"sortable":true,
							"sort":"asc"							
						}),
						,new GridCellHead(id+":grid:head:specialities_ref",{
							"value":"Спец-ть",
							"columns":[
								new GridColumnRef({
									"field":model.getField("specialities_ref"),
									"ctrlClass":SpecialityEdit,
									"ctrlOptions":{
										"lableCaption":""
									},
									"ctrlBindFieldId":"speciality_id"
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
extend(EmployeeList_View,ViewAjxList);

