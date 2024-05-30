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

function ItemFeatureGroupItem_Controller(options){
	options = options || {};
	options.listModelClass = ItemFeatureGroupItemList_Model;
	options.objModelClass = ItemFeatureGroupItemList_Model;
	ItemFeatureGroupItem_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(ItemFeatureGroupItem_Controller,ControllerObjServer);

			ItemFeatureGroupItem_Controller.prototype.addInsert = function(){
	ItemFeatureGroupItem_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Группа";options.required = true;
	var field = new FieldInt("item_feature_group_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Харктеристика";options.required = true;
	var field = new FieldInt("item_feature_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Код сортировки";options.required = true;
	var field = new FieldInt("code",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип фильтра";	
	options.enumValues = 'main,additional,distinctive';
	var field = new FieldEnum("filter_option_type",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Используется для конфигуратора";
	var field = new FieldBool("for_config",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			ItemFeatureGroupItem_Controller.prototype.addUpdate = function(){
	ItemFeatureGroupItem_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Группа";
	var field = new FieldInt("item_feature_group_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Харктеристика";
	var field = new FieldInt("item_feature_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Код сортировки";
	var field = new FieldInt("code",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип фильтра";	
	options.enumValues = 'main,additional,distinctive';
	
	var field = new FieldEnum("filter_option_type",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Используется для конфигуратора";
	var field = new FieldBool("for_config",options);
	
	pm.addField(field);
	
	
}

			ItemFeatureGroupItem_Controller.prototype.addDelete = function(){
	ItemFeatureGroupItem_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			ItemFeatureGroupItem_Controller.prototype.addGetList = function(){
	ItemFeatureGroupItem_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Группа";
	pm.addField(new FieldInt("item_feature_group_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Харктеристика";
	pm.addField(new FieldInt("item_feature_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Харктеристика";
	pm.addField(new FieldJSON("item_features_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Код сортировки";
	pm.addField(new FieldInt("code",f_opts));
	var f_opts = {};
	f_opts.alias = "Тип фильтра";
	pm.addField(new FieldString("filter_option_type",f_opts));
	var f_opts = {};
	f_opts.alias = "Используется для конфигуратора";
	pm.addField(new FieldBool("for_config",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("code");
	
}

			ItemFeatureGroupItem_Controller.prototype.addGetObject = function(){
	ItemFeatureGroupItem_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

		