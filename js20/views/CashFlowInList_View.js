/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function CashFlowInList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Приходные кассовые ордера";

	CashFlowInList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.CashFlowInList_Model)? options.models.CashFlowInList_Model : new CashFlowInList_Model();
	var contr = new CashFlowIn_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	
	this.m_inOutRefresh = options.inOutRefresh;

	let self = this;
	var filters;
	if (!options.detail && !options.inOut){
		var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
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
			,"cash_location":{
				"binding":new CommandBinding({
					"control":new BankAccountEdit(id+":filter-ctrl-cash_location",{
						"contClassName":"form-group-filter",
						"labelCaption":"Место выручки:"
					}),
				"field":new FieldString("cash_location_id")}),
				"sign":"e"
			}
		}
	}
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":true,
		"editWinClass":null,//WindowFormModalBS,
		"editViewClass":null,//CashFlowInDialog_View,
		/*"editViewOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},*/
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"ПриходныеКассовыеОрдера",
			"filters": filters,
			"cmdRefresh":!options.inOut
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.CashFlowInList_Model)? options.detailFilters.CashFlowInList_Model:null,	
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
						}),
						,new GridCellHead(id+":grid:head:cash_locations_ref",{
							"value":"Касса",
							"columns":[
								new GridColumnRef({
									"field":model.getField("cash_locations_ref"),
									"ctrlClass":CashLocationEdit,
									"ctrlOptions":{
										"labelCaption":"",
										"value": new RefType({"keys": {"id": 1}, "descr":"Касса"})
									},
									"ctrlBindFieldId":"cash_location_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:cash_flow_income_type",{
							"value":"Вид",
							"columns":[
								new EnumGridColumn_cash_flow_income_types({
									"field":model.getField("cash_flow_income_type"),
									"ctrlOptions":{
										"value":"cash"
									}
								})
							]
						})
						,new GridCellHead(id+":grid:head:cash_income_sources_ref",{
							"value":"Источник",
							"columns":[
								new GridColumnRef({
									"field":model.getField("cash_income_sources_ref"),
									"ctrlClass":CashIncomeSourceEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"cash_income_source_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:total",{
							"value":"Сумма",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("total"),
								})
							]
						})
						,new GridCellHead(id+":grid:head:comment_text",{
							"value":"Комментарий",
							"columns":[
								new GridColumn({
									"field":model.getField("comment_text"),
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
							//"calcOper":"sum",
							//"calcFieldId":"amount",
							"totalFieldId":"total_total",
							"gridColumn":new GridColumnFloat({"id":"tot_total"})
						})
						,new GridCell(id+":grid:foot:total_com",{
						})											
					]
				})		
			]
		}),		
		"pagination":new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":options.detailFilters? true:false,
		"refreshInterval":options.inOut? null : constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true,
		"defSrvEvents":true,
		"srvEvents":!options.inOut? null : {
			"events":[
				{"id":"CashFlowIn.insert"},
				{"id":"CashFlowIn.update"},
				{"id":"CashFlowIn.delete"}
			],
			"onEvent":function(params){
				// self.srvEventsCallBack(params);
				self.m_inOutRefresh();
			}
		}
	}));	
}
extend(CashFlowInList_View,ViewAjxList);

