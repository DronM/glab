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

function SupplierItemFolderFeatureGroup_Controller(options){
	options = options || {};
	options.listModelClass = SupplierItemFolderFeatureGroupList_Model;
	options.objModelClass = SupplierItemFolderFeatureGroupList_Model;
	SupplierItemFolderFeatureGroup_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(SupplierItemFolderFeatureGroup_Controller,ControllerObjServer);

			SupplierItemFolderFeatureGroup_Controller.prototype.addInsert = function(){
	SupplierItemFolderFeatureGroup_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Папка";
	var field = new FieldInt("item_folder_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Характеристика";
	var field = new FieldInt("item_feature_group_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			SupplierItemFolderFeatureGroup_Controller.prototype.addUpdate = function(){
	SupplierItemFolderFeatureGroup_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Папка";
	var field = new FieldInt("item_folder_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Характеристика";
	var field = new FieldInt("item_feature_group_id",options);
	
	pm.addField(field);
	
	
}

			SupplierItemFolderFeatureGroup_Controller.prototype.addDelete = function(){
	SupplierItemFolderFeatureGroup_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			SupplierItemFolderFeatureGroup_Controller.prototype.addGetList = function(){
	SupplierItemFolderFeatureGroup_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Папка";
	pm.addField(new FieldInt("item_folder_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Группа характеристик ID";
	pm.addField(new FieldInt("item_feature_group_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Группа характеристик";
	pm.addField(new FieldJSON("item_feature_groups_ref",f_opts));
}

			SupplierItemFolderFeatureGroup_Controller.prototype.addGetObject = function(){
	SupplierItemFolderFeatureGroup_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

		