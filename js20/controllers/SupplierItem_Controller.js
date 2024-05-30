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

function SupplierItem_Controller(options){
	options = options || {};
	options.listModelClass = SupplierItemList_Model;
	options.objModelClass = SupplierItemDialog_Model;
	SupplierItem_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_import();
	this.add_set_feature();
	this.add_get_features_filter_list();
		
}
extend(SupplierItem_Controller,ControllerObjServer);

			SupplierItem_Controller.prototype.addInsert = function(){
	SupplierItem_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Базовый товар";
	var field = new FieldInt("item_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Поставщик";
	var field = new FieldInt("supplier_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "ID поставщика";
	var field = new FieldText("supplier_item_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Цена поставщика";
	var field = new FieldFloat("cost",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Рекомендованная розничная цена";
	var field = new FieldFloat("sale_price",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Артикул (код поставщика)";
	var field = new FieldText("artikul",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий текст";
	var field = new FieldText("comment_text",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий примечание";
	var field = new FieldText("comment_note",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			SupplierItem_Controller.prototype.addUpdate = function(){
	SupplierItem_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Базовый товар";
	var field = new FieldInt("item_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Поставщик";
	var field = new FieldInt("supplier_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "ID поставщика";
	var field = new FieldText("supplier_item_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Цена поставщика";
	var field = new FieldFloat("cost",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Рекомендованная розничная цена";
	var field = new FieldFloat("sale_price",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Артикул (код поставщика)";
	var field = new FieldText("artikul",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий текст";
	var field = new FieldText("comment_text",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий примечание";
	var field = new FieldText("comment_note",options);
	
	pm.addField(field);
	
	
}

			SupplierItem_Controller.prototype.addDelete = function(){
	SupplierItem_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			SupplierItem_Controller.prototype.addGetList = function(){
	SupplierItem_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldInt("item_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Базовый товар";
	pm.addField(new FieldJSON("items_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Группа товаров";
	pm.addField(new FieldJSON("item_folders_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("supplier_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Поставщик";
	pm.addField(new FieldJSON("suppliers_ref",f_opts));
}

			SupplierItem_Controller.prototype.addGetObject = function(){
	SupplierItem_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			SupplierItem_Controller.prototype.add_import = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('import',opts);
	
	pm.setRequestType('post');
	
				
	
	var options = {};
	
		pm.addField(new FieldJSON("items",options));
	
			
	this.addPublicMethod(pm);
}

			SupplierItem_Controller.prototype.add_set_feature = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('set_feature',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("feature_id",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("item_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldText("val",options));
	
			
	this.addPublicMethod(pm);
}
	
			SupplierItem_Controller.prototype.add_get_features_filter_list = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_features_filter_list',opts);
	
	this.addPublicMethod(pm);
}
			
		