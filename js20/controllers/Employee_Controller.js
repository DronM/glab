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

function Employee_Controller(options){
	options = options || {};
	options.listModelClass = EmployeeList_Model;
	options.objModelClass = EmployeeDialog_Model;
	Employee_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
		
}
extend(Employee_Controller,ControllerObjServer);

			Employee_Controller.prototype.addInsert = function(){
	Employee_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDate("birth_date",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("department_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("qualification",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Категории вод.удост.";
	var field = new FieldJSONB("driving_lic_cat",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Стаж";
	var field = new FieldJSONB("expirience",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Штатный сотрудник";
	var field = new FieldBool("staff",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("card_bank_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Дети";
	var field = new FieldJSONB("children",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Алименты";
	var field = new FieldBool("alimony",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Одежда";
	var field = new FieldJSONB("cloth",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("contact_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий";
	var field = new FieldText("comment_text",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Employee_Controller.prototype.addUpdate = function(){
	Employee_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDate("birth_date",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("department_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("qualification",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Категории вод.удост.";
	var field = new FieldJSONB("driving_lic_cat",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Стаж";
	var field = new FieldJSONB("expirience",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Штатный сотрудник";
	var field = new FieldBool("staff",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("card_bank_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Дети";
	var field = new FieldJSONB("children",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Алименты";
	var field = new FieldBool("alimony",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Одежда";
	var field = new FieldJSONB("cloth",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("contact_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий";
	var field = new FieldText("comment_text",options);
	
	pm.addField(field);
	
	
}

			Employee_Controller.prototype.addDelete = function(){
	Employee_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			Employee_Controller.prototype.addGetList = function(){
	Employee_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldString("name",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldDate("birth_date",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("departments_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("posts_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("qualification",f_opts));
	var f_opts = {};
	f_opts.alias = "Категории вод.удост.";
	pm.addField(new FieldJSONB("driving_lic_cat",f_opts));
	var f_opts = {};
	f_opts.alias = "Стаж";
	pm.addField(new FieldJSONB("expirience",f_opts));
	var f_opts = {};
	f_opts.alias = "Штатный сотрудник";
	pm.addField(new FieldBool("staff",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("card_banks_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Дети";
	pm.addField(new FieldJSONB("children",f_opts));
	var f_opts = {};
	f_opts.alias = "Алименты";
	pm.addField(new FieldBool("alimony",f_opts));
	var f_opts = {};
	f_opts.alias = "Одежда";
	pm.addField(new FieldJSONB("cloth",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("contacts_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Комментарий";
	pm.addField(new FieldText("comment_text",f_opts));
}

			Employee_Controller.prototype.addGetObject = function(){
	Employee_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			Employee_Controller.prototype.addComplete = function(){
	Employee_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	
	var pm = this.getComplete();
	pm.addField(new FieldString("name",f_opts));
	pm.addField(new FieldInt("count", {}));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");	
}

		