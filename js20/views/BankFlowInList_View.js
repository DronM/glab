/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function BankFlowInList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Строки банка приходы";

	BankFlowInList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.BankFlowInList_Model)? options.models.BankFlowInList_Model : new BankFlowInList_Model();
	var contr = new BankFlowIn_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	
	var filters;
	if (!options.detail){
		var period_ctrl = new EditPeriodDate(id+":filter-ctrl-period",{
			"field":new FieldDateTime("date_time")
		});
	
		filters = {
			"period":{
				"binding":new CommandBinding({
					"control":period_ctrl,
					"field":period_ctrl.getField()
				}),
				"bindings":[
					{"binding":new CommandBinding({
						"control":period_ctrl.getControlFrom(),
						"field":period_ctrl.getField()
						}),
					"sign":"ge"
					},
					{"binding":new CommandBinding({
						"control":period_ctrl.getControlTo(),
						"field":period_ctrl.getField()
						}),
					"sign":"le"
					}
				]
			}		
			,"bank_account":{
				"binding":new CommandBinding({
					"control":new BankAccountEdit(id+":filter-ctrl-bank_account",{
						"contClassName":"form-group-filter",
						"labelCaption":"Расчетный счет:"
					}),
				"field":new FieldString("bank_account_id")}),
				"sign":"e"
			}
		}
	}
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":false,
		"editWinClass":WindowFormModalBS,
		"editViewClass":BankFlowInDialog_View,
		"editViewOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"БанковскиеВыписки",
			"filters":filters,
			"addCustomCommandsAfter":function(commands){
				commands.push(new BankFlowGridCmdApplyRules(id+":grid:cmd:applyRules"));
			}
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.BankFlowInList_Model)? options.detailFilters.BankFlowInList_Model:null,	
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
						,new GridCellHead(id+":grid:head:bank_accounts_ref",{
							"value":"Счет",
							"columns":[
								new GridColumnRef({
									"field":model.getField("bank_accounts_ref"),
									"ctrlClass":BankAccountEdit,
									"ctrlOptions":{
										"lableCaption":""
									},
									"ctrlBindFieldId":"bank_account_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:client_descr",{
							"value":"Корреспондент",
							"columns":[
								new GridColumn({
									"field":model.getField("client_descr")
								})
							]
						})
						,new GridCellHead(id+":grid:head:pay_comment",{
							"value":"Назначение платежа",
							"columns":[
								new GridColumn({
									"field":model.getField("pay_comment")
								})
							]
						})
						,new GridCellHead(id+":grid:head:total",{
							"value":"Сумма",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("total"),
									"precision":"2"
								})
							]
						})
					]
				})
			]
		}),
		"foot":new GridFoot(id+"grid:foot",{
			"autoCalc":true,			
			"elements":[
				new GridRow(id+":grid:foot:row0",{
					"elements":[
						new GridCell(id+":grid:foot:total_sp1",{
							"colSpan":"4"
						})											
						,new GridCellFoot(id+":grid:foot:tot_total",{
							"attrs":{"align":"right", "nowrap":"nowrap"},
							"totalFieldId":"total_total",
							"gridColumn":new GridColumnFloat({"id":"tot_total"})
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
extend(BankFlowInList_View,ViewAjxList);

