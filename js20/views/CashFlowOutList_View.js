/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function CashFlowOutList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Расходные кассовые ордера";

	CashFlowOutList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.CashFlowOutList_Model)? options.models.CashFlowOutList_Model : new CashFlowOutList_Model();
	var contr = new CashFlowOut_Controller();
	
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
	let grid = new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"editViewClass": CashFlowOutListEdit_View,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,//WindowFormModalBS,
		/*"editViewOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},*/
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"РасходныеКассовыеОрдера",
			"filters": filters,
			"cmdRefresh":!options.inOut
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.CashFlowOutList_Model)? options.detailFilters.CashFlowOutList_Model:null,	
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
						,new GridCellHead(id+":grid:head:fin_expense_types1_ref",{
							"value":"Вид",
							"columns":[
								new GridColumnRef({
									"field":model.getField("fin_expense_types1_ref"),
									"ctrlClass":FinExpenseTypeEdit,
									"ctrlOptions":{
										"labelCaption":"",
										"for_cash":true,
										"lev":1,
										"onClear": function(){
											let edit = self.getElement("grid").getEditViewObj();
											let ctrl = edit.getElement("fin_expense_types2_ref");											
											ctrl.reset();
											ctrl.setParentId("null");
										},
										"onSelect": function(f){
											this.setAttr("parent_id", f.parent_id.getValue());
											
											let par_id = f.id.getValue();											
											let edit = self.getElement("grid").getEditViewObj();

											let ctrl = edit.getElement("fin_expense_types2_ref");
											ctrl.setParentId(par_id);
											let ctrl_v = ctrl.getValue();
											if(ctrl_v && !ctrl_v.isNull() && ctrl_v.getKey() != par_id){
												ctrl.reset();
											}

											ctrl = edit.getElement("fin_expense_types3_ref");
											ctrl.setParentId(par_id);
											ctrl_v = ctrl.getValue();
											if(ctrl_v && !ctrl_v.isNull() && ctrl_v.getKey() != par_id){
												ctrl.reset();
											}
										}
										
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
									"no_filter":true,
									"ctrlOptions":{
										"labelCaption":"",
										"lev":2,
										"onClear": function(){
											// let edit = self.getElement("grid").getEditViewObj();
											// let ctrl = edit.getElement("fin_expense_types3_ref");											
											// ctrl.reset();
											// ctrl.setParentId("null");
										},
										"onSelect": function(f){
											this.setAttr("parent_id", f.parent_id.getValue());
											
											// let par_id = f.id.getValue();
											// let edit = self.getElement("grid").getEditViewObj();
											// let ctrl = edit.getElement("fin_expense_types3_ref");
											// ctrl.setParentId(par_id);
											// let ctrl_v = ctrl.getValue();
											// if(ctrl_v && !ctrl_v.isNull() && ctrl_v.getKey() != par_id){
											// 	ctrl.reset();
											// }
										}
										
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
									"ctrlClass":FinExpenseTypeItemEdit,
									"ctrlOptions":{
										"required":true,
										"no_filter":true,
										"lev":3,
										"labelCaption":"",
										"onSelect": function(f){
											// this.setAttr("parent_id", f.parent_id.getValue());
											this.setAttr("lev", 3);
										}
									},
									"ctrlBindFieldId":"fin_expense_type3_id"
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
						,new GridCellHead(id+":grid:head:total",{
							"value":"Сумма",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("total"),
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
							"colSpan":"6"
						})											
						,new GridCellFoot(id+":grid:foot:tot_total",{
							"attrs":{"align":"right", "nowrap":"nowrap"},
							//"calcOper":"sum",
							//"calcFieldId":"amount",
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
		"focus":true,
		"srvEvents":!options.inOut? null : {
			"events":[
				{"id":"CashFlowOut.insert"},
				{"id":"CashFlowOut.update"},
				{"id":"CashFlowOut.delete"}
			],
			"onEvent":function(params){
				// self.srvEventsCallBack(params);
				self.m_inOutRefresh();
			}
		}
	});	
	
	// grid.m_fillEditView = grid.fillEditView;
	// grid.fillEditView = function(cmd){
	// 	this.m_fillEditView(cmd);
	// 	debugger
	// 	self.onEditRow(this);
	// }
	this.addElement(grid);
}
extend(CashFlowOutList_View,ViewAjxList);


//***********************
function CashFlowOutListEdit_View(id,options){	
	debugger
	CashFlowOutListEdit_View.superclass.constructor.call(this,id,options);
}
extend(CashFlowOutListEdit_View, ViewGridEditInlineAjx);

CashFlowOutListEdit_View.prototype.onGetData = function(resp, cmd){
	CashFlowOutListEdit_View.superclass.onGetData.call(this, resp, cmd);
// debugger	
	let edit = this; //grid.getEditViewObj();
	let ctrl1 = edit.getElement("fin_expense_types1_ref");
	let ctrl2 = edit.getElement("fin_expense_types2_ref");
	let ctrl3 = edit.getElement("fin_expense_types3_ref");

	let val1 = ctrl1.getValue();
	if(val1 && !val1.isNull()){
		ctrl2.setParentId(val1.getKey());
	}

	let val2 = ctrl2.getValue();
	if(val2 && !val2.isNull()){
		ctrl3.setParentId(val2.getKey());
	}
}
