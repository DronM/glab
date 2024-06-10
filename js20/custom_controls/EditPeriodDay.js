
/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc Period Edit cotrol
 
 * @extends EditPeriodDate
 
 * @requires core/extend.js
 * @requires controls/ControlContainer.js
 * @requires controls/ButtonCmd.js               
 
 * @param string id 
 * @param {namespace} options
 */
 
function EditPeriodDay(id,options){
	options = options || {};	
	
	options.template = options.template ||window.getApp().getTemplate("EditPeriodDay");
	
	options.cmdPeriodSelect = false;
	options.downFastTitle = "Предыдущая неделя";
	options.downTitle = "Предыдущий день";
	options.upFastTitle = "Следующая неделя";
	options.upTitle = "Следующий день";
	options.cmdControlTo = false;
	options.cmdControlFrom = false;
	
	if(options.dateFrom){
		options.dateFrom = new Date(options.dateFrom.getTime()+this.m_shiftStartMS);
	}
	this.m_dateFrom = DateHelper.getStartOfShift(options.dateFrom);		
	this.calcDateTo();
	
	this.m_daysOfWeek = ['Воскресенье','Понедельник','Вторник','Среда','Четверг','Пятница','Суббота'];
	this.m_dateTempl = "d/m";
	
	this.m_filters = options.filters;	
	this.m_dateFormat = options.dateFormat;
	this.m_onChange = options.onChange;
	
	EditPeriodDay.superclass.constructor.call(this,id,options);
}
extend(EditPeriodDay, EditPeriodDate);

EditPeriodDay.prototype.FAST_GO_SHIFT_CNT = 7;

EditPeriodDay.prototype.m_dateFrom;
EditPeriodDay.prototype.m_dateTo;
EditPeriodDay.prototype.m_timeFrom;

EditPeriodDay.prototype.addControls = function(){

	this.addElement(this.m_controlDownFast);
	this.addElement(this.m_controlDown);
	
	var self = this;	
	this.addElement(new Label(this.getId()+":inf",{
		"caption":this.getPeriodDescr(),
		"events":{
			"click":function(){
				self.picCustomDate();
			}
		}
	}));

	this.addElement(this.m_controlUp);
	this.addElement(this.m_controlUpFast);	
}

EditPeriodDay.prototype.picCustomDate = function(){
	var self = this;
	var p = $(this.getElement("inf").getNode());
	p.datepicker({
		format:{
			//called after date is selected
			toDisplay: function (date, format, language) {
				self.setDateFrom(new Date());
			},
			//called in ctrl edit?
			toValue: function (date, format, language) {
			}																	
		},
		language:"ru",
		daysOfWeekHighlighted:"0,6",
		autoclose:true,
		todayHighlight:true,
		orientation: "bottom right",
		//container:form,
		showOnFocus:false,
		clearBtn:true
	});
	
	p.on('hide', function(ev){
		//self.getEditControl().applyMask();
	});					
	
	p.datepicker("show");
}

EditPeriodDay.prototype.goFast = function(sign){
	this.setDateFrom(new Date(this.m_dateFrom.getTime() + this.m_shiftLengthMS*this.FAST_GO_SHIFT_CNT*sign),true);
}

EditPeriodDay.prototype.go = function(sign){
	this.setDateFrom(new Date(this.m_dateFrom.getTime() + this.m_shiftLengthMS*sign),true);
}

EditPeriodDay.prototype.setDateFrom = function(dt){
	if (!window.getApp().checkRoleViewRestriction(dt, dt)){
		return;
	}
	this.m_dateFrom = dt;
	this.calcDateTo();
	this.updateDateInf();
		
	if(this.m_grid){
		this.applyFilter();
		this.m_grid.onRefresh();
	}
	else if(this.m_onChange){
		this.m_onChange(this.m_dateFrom,this.m_dateTo);
	}
}
EditPeriodDay.prototype.getDateFrom = function(){
	return this.m_dateFrom;
}

EditPeriodDay.prototype.getDateTo = function(){
	return this.m_dateTo;
}

EditPeriodDay.prototype.calcDateTo = function(){	
	var dt = new Date(this.m_dateFrom.getTime() + this.m_shiftLengthMS - 1000);
	if (!window.getApp().checkRoleViewRestriction(dt, dt)){
		return;
	}	
	this.m_dateTo = dt;
}

EditPeriodDay.prototype.updateDateInf = function(){	
	this.getElement("inf").setValue(this.getPeriodDescr());
}

EditPeriodDay.prototype.getPeriodDescr = function(){	
	return (
		DateHelper.format(this.m_dateFrom,this.m_dateTempl)+
		" "+this.m_daysOfWeek[this.m_dateFrom.getDay()]
		/*+
		" - "+
		DateHelper.format(this.m_dateTo,this.m_dateTempl)
		*/
	);
}

EditPeriodDay.prototype.applyFilter = function(v){
	if(this.m_filters&&this.m_filters.length){
		this.m_filters[0].val = DateHelper.format(this.m_dateFrom,this.m_dateFormat);
		if(this.m_filters.length>1){
			this.m_filters[1].val = DateHelper.format(this.m_dateTo,this.m_dateFormat);
		}
	}
}

EditPeriodDay.prototype.setGrid = function(v){
	this.m_grid = v;
	if(this.m_filters&&this.m_filters.length){
		this.applyFilter();
		
		for (var i=0;i<this.m_filters.length;i++){
			this.m_grid.setFilter(this.m_filters[i]);
		}
		
	}
}
EditPeriodDay.prototype.setPredefinedPeriod = function(per){
	if (per=="shift"){
		this.setCtrlDateTime(this.getControlFrom(),DateHelper.dateStart());
		this.setCtrlDateTime(this.getControlTo(),new Date(DateHelper.dateStart().getTime()+24*60*60*1000));
	}				
	else if (per=="prev_shift"){
		this.setCtrlDateTime(this.getControlFrom(),DateHelper.dateStart(new Date(DateHelper.time().getTime()-24*60*60*1000)));
		this.setCtrlDateTime(this.getControlTo(), new Date(DateHelper.dateStart().getTime()-24*60*60*1000));
	}				
	
	EditPeriodDay.superclass.setPredefinedPeriod.call(this,per);
}
