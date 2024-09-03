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

function FinExpenseType_Controller(options){
	options = options || {};
	options.listModelClass = FinExpenseTypeList_Model;
	options.objModelClass = FinExpenseTypeDialog_Model;
	FinExpenseType_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.add_get_item_list();
	this.addGetObject();
	this.addComplete();
	this.add_verify_rule();
		
}
extend(FinExpenseType_Controller,ControllerObjServer);

			FinExpenseType_Controller.prototype.addInsert = function(){
	FinExpenseType_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Родитель";
	var field = new FieldInt("parent_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Уровень";
	var field = new FieldInt("lev",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для кассы";
	var field = new FieldBool("for_cash",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для банка";
	var field = new FieldBool("for_bank",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Удален, отображать не всем";
	var field = new FieldBool("deleted",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Правило поиска соответствия для банка";
	var field = new FieldText("bank_match_rule",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("bank_match_rule_cond",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			FinExpenseType_Controller.prototype.addUpdate = function(){
	FinExpenseType_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Родитель";
	var field = new FieldInt("parent_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Уровень";
	var field = new FieldInt("lev",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для кассы";
	var field = new FieldBool("for_cash",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для банка";
	var field = new FieldBool("for_bank",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Удален, отображать не всем";
	var field = new FieldBool("deleted",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Правило поиска соответствия для банка";
	var field = new FieldText("bank_match_rule",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("bank_match_rule_cond",options);
	
	pm.addField(field);
	
	
}

			FinExpenseType_Controller.prototype.addDelete = function(){
	FinExpenseType_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			FinExpenseType_Controller.prototype.addGetList = function(){
	FinExpenseType_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Родитель";
	pm.addField(new FieldInt("parent_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Уровень";
	pm.addField(new FieldInt("lev",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Для кассы";
	pm.addField(new FieldBool("for_cash",f_opts));
	var f_opts = {};
	f_opts.alias = "Для банка";
	pm.addField(new FieldBool("for_bank",f_opts));
	var f_opts = {};
	f_opts.alias = "Удален, отображать не всем";
	pm.addField(new FieldBool("deleted",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			FinExpenseType_Controller.prototype.add_get_item_list = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_item_list',opts);
	
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

	this.addPublicMethod(pm);
}

			FinExpenseType_Controller.prototype.addGetObject = function(){
	FinExpenseType_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			FinExpenseType_Controller.prototype.addComplete = function(){
	FinExpenseType_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	f_opts.alias = "";
	var pm = this.getComplete();
	pm.addField(new FieldText("name",f_opts));
	pm.addField(new FieldInt("count", {}));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");	
	
	//conditions
	pm.addField(new FieldString(this.PARAM_COND_FIELDS));
	pm.addField(new FieldString(this.PARAM_COND_SGNS));
	pm.addField(new FieldString(this.PARAM_COND_VALS));	
}

			FinExpenseType_Controller.prototype.add_verify_rule = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('verify_rule',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("rule",options));
	
			
	this.addPublicMethod(pm);
}

		