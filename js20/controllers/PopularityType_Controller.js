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

function PopularityType_Controller(options){
	options = options || {};
	options.listModelClass = PopularityType_Model;
	options.objModelClass = PopularityType_Model;
	PopularityType_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(PopularityType_Controller,ControllerObjServer);

			PopularityType_Controller.prototype.addInsert = function(){
	PopularityType_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.alias = "ID";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Код для сортировки";options.required = true;
	var field = new FieldInt("code",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество позиций вывода";
	var field = new FieldInt("item_count",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип экрана";	
	options.enumValues = 'sm,md,lg';
	var field = new FieldEnum("screen_width_type",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			PopularityType_Controller.prototype.addUpdate = function(){
	PopularityType_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.alias = "ID";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Код для сортировки";
	var field = new FieldInt("code",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество позиций вывода";
	var field = new FieldInt("item_count",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип экрана";	
	options.enumValues = 'sm,md,lg';
	
	var field = new FieldEnum("screen_width_type",options);
	
	pm.addField(field);
	
	
}

			PopularityType_Controller.prototype.addDelete = function(){
	PopularityType_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
	options.alias = "ID";	
	pm.addField(new FieldInt("id",options));
}

			PopularityType_Controller.prototype.addGetList = function(){
	PopularityType_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "ID";
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Код для сортировки";
	pm.addField(new FieldInt("code",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Количество позиций вывода";
	pm.addField(new FieldInt("item_count",f_opts));
	var f_opts = {};
	f_opts.alias = "Тип экрана";
	pm.addField(new FieldEnum("screen_width_type",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("code");
	
}

			PopularityType_Controller.prototype.addGetObject = function(){
	PopularityType_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
	f_opts.alias = "ID";	
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

		