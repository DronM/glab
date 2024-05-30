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

function SupplierStore_Controller(options){
	options = options || {};
	options.listModelClass = SupplierStoreList_Model;
	options.objModelClass = SupplierStoreList_Model;
	SupplierStore_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_complete_for_supplier();
		
}
extend(SupplierStore_Controller,ControllerObjServer);

			SupplierStore_Controller.prototype.addInsert = function(){
	SupplierStore_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Поставщик";
	var field = new FieldInt("supplier_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование API";
	var field = new FieldText("name_api",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			SupplierStore_Controller.prototype.addUpdate = function(){
	SupplierStore_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Поставщик";
	var field = new FieldInt("supplier_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование API";
	var field = new FieldText("name_api",options);
	
	pm.addField(field);
	
	
}

			SupplierStore_Controller.prototype.addDelete = function(){
	SupplierStore_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			SupplierStore_Controller.prototype.addGetList = function(){
	SupplierStore_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldInt("supplier_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Поставщик";
	pm.addField(new FieldString("supplier_name",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("suppliers_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование API";
	pm.addField(new FieldText("name_api",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("supplier_name,name");
	
}

			SupplierStore_Controller.prototype.addGetObject = function(){
	SupplierStore_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			SupplierStore_Controller.prototype.add_complete_for_supplier = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('complete_for_supplier',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldText("name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("supplier_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("mid",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("count",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
	
			
	this.addPublicMethod(pm);
}

			
		