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

function BankAccount_Controller(options){
	options = options || {};
	options.listModelClass = BankAccountList_Model;
	options.objModelClass = BankAccountList_Model;
	BankAccount_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(BankAccount_Controller,ControllerObjServer);

			BankAccount_Controller.prototype.addInsert = function(){
	BankAccount_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип родителя";options.required = true;	
	options.enumValues = 'users,employees,bank_cards,contacts,firms';
	var field = new FieldEnum("parent_data_type",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "ИД родителя";
	var field = new FieldInt("parent_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Расчетный счет";
	var field = new FieldString("bank_acc",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "БИК банка";
	var field = new FieldString("bank_bik",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			BankAccount_Controller.prototype.addUpdate = function(){
	BankAccount_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип родителя";	
	options.enumValues = 'users,employees,bank_cards,contacts,firms';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	var field = new FieldEnum("parent_data_type",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "ИД родителя";
	var field = new FieldInt("parent_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Расчетный счет";
	var field = new FieldString("bank_acc",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "БИК банка";
	var field = new FieldString("bank_bik",options);
	
	pm.addField(field);
	
	
}

			BankAccount_Controller.prototype.addDelete = function(){
	BankAccount_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			BankAccount_Controller.prototype.addGetList = function(){
	BankAccount_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Тип родителя";
	pm.addField(new FieldEnum("parent_data_type",f_opts));
	var f_opts = {};
	f_opts.alias = "ИД родителя";
	pm.addField(new FieldInt("parent_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Расчетный счет";
	pm.addField(new FieldString("bank_acc",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("banks_ref",f_opts));
}

			BankAccount_Controller.prototype.addGetObject = function(){
	BankAccount_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

		