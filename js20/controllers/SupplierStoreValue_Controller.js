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

function SupplierStoreValue_Controller(options){
	options = options || {};
	options.listModelClass = SupplierStoreValueList_Model;
	options.objModelClass = SupplierStoreValueList_Model;
	SupplierStoreValue_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(SupplierStoreValue_Controller,ControllerObjServer);

			SupplierStoreValue_Controller.prototype.addInsert = function(){
	SupplierStoreValue_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Место хранения поставщика";
	var field = new FieldInt("supplier_store_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номенлатура поставщика";
	var field = new FieldInt("supplier_item_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Остаток";
	var field = new FieldText("val",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			SupplierStoreValue_Controller.prototype.addUpdate = function(){
	SupplierStoreValue_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Место хранения поставщика";
	var field = new FieldInt("supplier_store_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номенлатура поставщика";
	var field = new FieldInt("supplier_item_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Остаток";
	var field = new FieldText("val",options);
	
	pm.addField(field);
	
	
}

			SupplierStoreValue_Controller.prototype.addDelete = function(){
	SupplierStoreValue_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			SupplierStoreValue_Controller.prototype.addGetList = function(){
	SupplierStoreValue_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldInt("supplier_store_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("supplier_stores_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("supplier_item_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("supplier_items_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Остаток";
	pm.addField(new FieldText("val",f_opts));
}

			SupplierStoreValue_Controller.prototype.addGetObject = function(){
	SupplierStoreValue_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

		