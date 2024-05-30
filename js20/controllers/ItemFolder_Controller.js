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

function ItemFolder_Controller(options){
	options = options || {};
	options.listModelClass = ItemFolderList_Model;
	options.objModelClass = ItemFolderList_Model;
	ItemFolder_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
		
}
extend(ItemFolder_Controller,ControllerObjServer);

			ItemFolder_Controller.prototype.addInsert = function(){
	ItemFolder_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Родитель";
	var field = new FieldInt("parent_item_folder_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Код";options.required = true;
	var field = new FieldInt("code",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Приоритет вывода";
	var field = new FieldInt("item_priority_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип транпорта";
	var field = new FieldInt("vehicle_type_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			ItemFolder_Controller.prototype.addUpdate = function(){
	ItemFolder_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Родитель";
	var field = new FieldInt("parent_item_folder_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Код";
	var field = new FieldInt("code",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Приоритет вывода";
	var field = new FieldInt("item_priority_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип транпорта";
	var field = new FieldInt("vehicle_type_id",options);
	
	pm.addField(field);
	
	
}

			ItemFolder_Controller.prototype.addDelete = function(){
	ItemFolder_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			ItemFolder_Controller.prototype.addGetList = function(){
	ItemFolder_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Наименование";
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Родитель";
	pm.addField(new FieldInt("parent_item_folder_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Код";
	pm.addField(new FieldInt("code",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("item_feature_groups_list",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("vehicle_types_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("item_priorities_ref",f_opts));
}

			ItemFolder_Controller.prototype.addGetObject = function(){
	ItemFolder_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			ItemFolder_Controller.prototype.addComplete = function(){
	ItemFolder_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	f_opts.alias = "";
	var pm = this.getComplete();
	pm.addField(new FieldText("name",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");	
}

		