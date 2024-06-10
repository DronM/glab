/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller_js20.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 
 * @class
 * @classdesc controller
 
 * @extends ControllerObjServer
  
 * @requires core/extend.js
 * @requires core/ControllerObjServer.js
  
 * @param {Object} options
 * @param {Model} options.listModelClass
 * @param {Model} options.objModelClass
 */ 

function BankFlowIn_Controller(options){
	options = options || {};
	options.listModelClass = BankFlowInList_Model;
	options.objModelClass = BankFlowInList_Model;
	BankFlowIn_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_import_from_bank();
	this.add_get_report();
	this.add_apply_rules();
		
}
extend(BankFlowIn_Controller,ControllerObjServer);

			BankFlowIn_Controller.prototype.addInsert = function(){
	BankFlowIn_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldInt("bank_account_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Период";options.required = true;
	var field = new FieldDateTimeTZ("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Дата загрузки";
	var field = new FieldDateTimeTZ("uploaded_date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Корреспондент";
	var field = new FieldText("client_descr",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Назначение платежа";
	var field = new FieldText("pay_comment",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер платежносго поручения";
	var field = new FieldText("pp_num",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			BankFlowIn_Controller.prototype.addUpdate = function(){
	BankFlowIn_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("bank_account_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Период";
	var field = new FieldDateTimeTZ("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Дата загрузки";
	var field = new FieldDateTimeTZ("uploaded_date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Корреспондент";
	var field = new FieldText("client_descr",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Назначение платежа";
	var field = new FieldText("pay_comment",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер платежносго поручения";
	var field = new FieldText("pp_num",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
}

			BankFlowIn_Controller.prototype.addDelete = function(){
	BankFlowIn_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			BankFlowIn_Controller.prototype.addGetList = function(){
	BankFlowIn_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	
	pm.addField(new FieldInt(this.PARAM_COUNT));
	pm.addField(new FieldInt(this.PARAM_FROM));
	pm.addField(new FieldString(this.PARAM_COND_FIELDS));
	pm.addField(new FieldString(this.PARAM_COND_SGNS));
	pm.addField(new FieldString(this.PARAM_COND_VALS));
	pm.addField(new FieldString(this.PARAM_COND_JOINS));
	pm.addField(new FieldString(this.PARAM_COND_ICASE));
	pm.addField(new FieldString(this.PARAM_ORD_FIELDS));
	pm.addField(new FieldString(this.PARAM_ORD_DIRECTS));
	pm.addField(new FieldString(this.PARAM_FIELD_SEP));
	pm.addField(new FieldString(this.PARAM_FIELD_LSN));
	pm.addField(new FieldString(this.PARAM_EXP_FNAME));

	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("bank_account_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("bank_accounts_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("firm_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("firms_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Период";
	pm.addField(new FieldDateTimeTZ("date_time",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата загрузки";
	pm.addField(new FieldDateTimeTZ("uploaded_date_time",f_opts));
	var f_opts = {};
	f_opts.alias = "Корреспондент";
	pm.addField(new FieldText("client_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Назначение платежа";
	pm.addField(new FieldText("pay_comment",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("total",f_opts));
	var f_opts = {};
	f_opts.alias = "Номер платежносго поручения";
	pm.addField(new FieldText("pp_num",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("date_time");
	
}

			BankFlowIn_Controller.prototype.addGetObject = function(){
	BankFlowIn_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			BankFlowIn_Controller.prototype.add_import_from_bank = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('import_from_bank',opts);
	
	pm.setRequestType('post');
	
	pm.setEncType(ServConnector.prototype.ENCTYPES.MULTIPART);
	
				
	
	var options = {};
	
		pm.addField(new FieldText("bank_file",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "36";
	
		pm.addField(new FieldString("operation_id",options));
	
			
	this.addPublicMethod(pm);
}

			BankFlowIn_Controller.prototype.add_get_report = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_report',opts);
	
	pm.addField(new FieldInt(this.PARAM_COUNT));
	pm.addField(new FieldInt(this.PARAM_FROM));
	pm.addField(new FieldString(this.PARAM_COND_FIELDS));
	pm.addField(new FieldString(this.PARAM_COND_SGNS));
	pm.addField(new FieldString(this.PARAM_COND_VALS));
	pm.addField(new FieldString(this.PARAM_COND_JOINS));
	pm.addField(new FieldString(this.PARAM_COND_ICASE));
	pm.addField(new FieldString(this.PARAM_ORD_FIELDS));
	pm.addField(new FieldString(this.PARAM_ORD_DIRECTS));
	pm.addField(new FieldString(this.PARAM_FIELD_SEP));
	pm.addField(new FieldString(this.PARAM_FIELD_LSN));
	pm.addField(new FieldString(this.PARAM_EXP_FNAME));

				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("inline",options));
	
			
	this.addPublicMethod(pm);
}

			BankFlowIn_Controller.prototype.add_apply_rules = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('apply_rules',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "36";
	
		pm.addField(new FieldString("operation_id",options));
	
			
	this.addPublicMethod(pm);
}

		