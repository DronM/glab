/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function RepCashFlow_View(id,options){

	options = options || {};
	
	var contr = new CashFlowIn_Controller();	
	options.publicMethod = contr.getPublicMethod("get_cash_flow_in_out_list");
	options.reportViewId = "ViewHTMLXSLT";
	options.templateId = "RepCashFlow";
	
	options.cmdMake = true;
	options.cmdPrint = true;
	options.cmdFilter = true;
	options.cmdExcel = true;
	options.cmdPdf = false;
	
	var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
		"valueFrom":(options.templateParams)? options.templateParams.date_from:DateHelper.dateStart(DateHelper.time()),
		"valueTo":(options.templateParams)? options.templateParams.date_to:DateHelper.dateEnd(DateHelper.time()),
		"field":new FieldDateTime("date_time")
	});
	
	options.filters = {
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
	};

	RepCashFlow_View.superclass.constructor.call(this, id, options);
	
}
extend(RepCashFlow_View,ViewReport);
