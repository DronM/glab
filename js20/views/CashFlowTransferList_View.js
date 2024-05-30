/** Copyright (c) 2024
 *	Andrey Mikhalevich, Katren ltd.
 */
function CashFlowTransferList_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Перемещения денег";

	CashFlowTransferList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.CashFlowTransferList_Model)? options.models.CashFlowTransferList_Model : new CashFlowTransferList_Model();
	var contr = new CashFlowTransfer_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	
	var filters;
	if (!options.detail){
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
		}
	}
	this.addElement(new GridAjx(id+":grid",{
		"filters": filters,
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":true,
		"editWinClass":null,//WindowFormModalBS,
		"editViewClass":null,//CashFlowTransferDialog_View,
		/*"editViewOptions":function(){
			return {
				"dialogWidth":"80%"
			}
		},*/
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"exportFileName" :"ПеремещенияДенег"
		}),		
		"popUpMenu":popup_menu,
		"filters":(options.detailFilters&&options.detailFilters.CashFlowTransferList_Model)? options.detailFilters.CashFlowTransferList_Model:null,	
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
						,new GridCellHead(id+":grid:head:from_cash_locations_ref",{
							"value":"Отправитель",
							"columns":[
								new GridColumnRef({
									"field":model.getField("from_cash_locations_ref"),
									"ctrlClass":CashLocationEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"from_cash_location_id"
								})
							]
						})
						,new GridCellHead(id+":grid:head:to_cash_locations_ref",{
							"value":"Получатель",
							"columns":[
								new GridColumnRef({
									"field":model.getField("to_cash_locations_ref"),
									"ctrlClass":CashLocationEdit,
									"ctrlOptions":{
										"labelCaption":""
									},
									"ctrlBindFieldId":"to_cash_location_id"
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
							"colSpan":"4"
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
		"focus":true
	}));	
}
extend(CashFlowTransferList_View,ViewAjxList);

