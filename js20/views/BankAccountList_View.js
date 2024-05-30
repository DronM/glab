/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function BankAccountList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Расчетные счета";

	BankAccountList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.BankAccountList_Model)? options.models.BankAccountList_Model : new BankAccountList_Model();
	var contr = new BankAccount_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	
	var filters;
	this.addElement(new GridAjx(id+":grid",{
		"filters": filters,
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":false,
		"editWinClass":WindowFormModalBS,
		"editViewClass":BankAccountDialog_View,
		"editViewOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"РасчетныеСчета"
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.BankAccountList_Model)? options.detailFilters.BankAccountList_Model:null,	
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						(options.detail)? null:
						new GridCellHead(id+":grid:head:parents_ref",{
							"value":"Владелец",
							"columns":[
								new GridColumnRef({
									"field":model.getField("parents_ref"),
									"formatFunction":function(f){
										return f.parents_ref.getValue().getDescr();
									}
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({"field":model.getField("name")})
							]
						})
						,new GridCellHead(id+":grid:head:banks_ref",{
							"value":"Банк",
							"columns":[
								new GridColumnRef({
									"field":model.getField("banks_ref"),
									"ctrlClass":BankEditRef,
									"ctrlOptions":{
										"lableCaption":""
									},
									"ctrlBindFieldId":"bank_bik"
								})
							]
						})
						,new GridCellHead(id+":grid:head:bank_acc",{
							"value":"Счет",
							"columns":[
								new GridColumn({
									"field":model.getField("bank_acc")
								})
							]
						}),
						
					]
				})
			]
		}),
		"pagination":new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detail? false:true,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
}
extend(BankAccountList_View,ViewAjxList);

