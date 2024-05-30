
/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function BankFlowOutList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Строки банка списания";

	BankFlowOutList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.BankFlowOutList_Model)? options.models.BankFlowOutList_Model : new BankFlowOutList_Model();
	var contr = new BankFlowOut_Controller();
	
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
		"editViewClass":BankFlowOutDialog_View,
		"editWinClassOptions":function(){
			return {
				"dialogWidth":"50%"
			}
		},
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"БанковскиеВыписки",
			"filters": filters
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.BankFlowOutList_Model)? options.detailFilters.BankFlowOutList_Model:null,	
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
							]
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
						,new GridCellHead(id+":grid:head:fin_expense_types1_ref",{
							"value":"Вид",
							"columns":[
								new GridColumnRef({
									"field":model.getField("fin_expense_types1_ref"),
									"ctrlClass":FinExpenseTypeEdit,
									"ctrlOptions":{
										"labelCaption":"",
										"for_bank":true
									},
									"searchOptions":{
										"field":new FieldInt("fin_expense_type1_id"),
										"searchType":"on_match"
									},
									"ctrlBindFieldId":"fin_expense_type1_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:fin_expense_types2_ref",{
							"value":"Тип",
							"columns":[
								new GridColumnRef({
									"field":model.getField("fin_expense_types2_ref"),
									"ctrlClass":FinExpenseTypeEdit,
									"ctrlOptions":{
										"labelCaption":"",
										"no_filter":true
									},
									"ctrlBindFieldId":"fin_expense_type2_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:fin_expense_types3_ref",{
							"value":"Кому",
							"columns":[
								new GridColumnRef({
									"field":model.getField("fin_expense_types3_ref"),
									"ctrlClass":FinExpenseTypeEdit,
									"ctrlOptions":{
										"no_filter":true,
										"labelCaption":""
									},
									"ctrlBindFieldId":"fin_expense_type3_id"
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
							"colSpan":"7"
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
extend(BankFlowOutList_View,ViewAjxList);

