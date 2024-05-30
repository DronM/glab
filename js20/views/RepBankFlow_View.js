/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function RepBankFlow_View(id,options){

	options = options || {};
	
	var contr = new BankFlowIn_Controller();	
	options.publicMethod = contr.getPublicMethod("get_report");
	options.reportViewId = "ViewHTMLXSLT";
	options.templateId = "RepBankFlow";
	
	options.cmdMake = true;
	options.cmdPrint = true;
	options.cmdFilter = true;
	options.cmdExcel = true;
	options.cmdPdf = false;
	
	var period_ctrl = new EditPeriodDate(id+":filter-ctrl-period",{
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
		,"firm":{
			"binding":new CommandBinding({
				"control":new FirmEdit(id+":filter-ctrl-firm",
					{"labelCaption":"Организация:","contClassName":"form-group-filter"}),
				"field":new FieldInt("firm_id")
			}),
			"sign":"e"
		}
		,"bank_account":{
			"binding":new CommandBinding({
				"control":new BankAccountEdit(id+":filter-ctrl-bank_account",
					{"labelCaption":"Банковский счет:","contClassName":"form-group-filter"}),
				"field":new FieldInt("bank_account_id")
			}),
			"sign":"e"
		}
	};

	RepBankFlow_View.superclass.constructor.call(this, id, options);
	
}
extend(RepBankFlow_View,ViewReport);
