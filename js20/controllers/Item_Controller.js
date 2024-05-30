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

function Item_Controller(options){
	options = options || {};
	options.listModelClass = ItemList_Model;
	options.objModelClass = ItemDialog_Model;
	Item_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_complete_item();
	this.addComplete();
	this.add_set_feature();
	this.add_get_features_filter_list();
		
}
extend(Item_Controller,ControllerObjServer);

			Item_Controller.prototype.addInsert = function(){
	Item_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Группа товаров";
	var field = new FieldInt("item_folder_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какой марки";
	var field = new FieldInt("auto_make_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какой модели";
	var field = new FieldInt("auto_model_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какого поколения модели";
	var field = new FieldInt("auto_model_generation_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какого кузова";
	var field = new FieldInt("auto_body_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Производитель";
	var field = new FieldInt("manufacturer_brand_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Item_Controller.prototype.addUpdate = function(){
	Item_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Группа товаров";
	var field = new FieldInt("item_folder_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какой марки";
	var field = new FieldInt("auto_make_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какой модели";
	var field = new FieldInt("auto_model_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какого поколения модели";
	var field = new FieldInt("auto_model_generation_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Для какого кузова";
	var field = new FieldInt("auto_body_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Производитель";
	var field = new FieldInt("manufacturer_brand_id",options);
	
	pm.addField(field);
	
	
}

			Item_Controller.prototype.addDelete = function(){
	Item_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			Item_Controller.prototype.addGetList = function(){
	Item_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldInt("item_folder_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Группа товаров";
	pm.addField(new FieldJSON("item_folders_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("auto_make_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Для какой марки";
	pm.addField(new FieldJSON("auto_makes_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("auto_model_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Для какой модели";
	pm.addField(new FieldJSON("auto_models_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("auto_model_generation_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Для какого поколения модели";
	pm.addField(new FieldJSON("auto_model_generations_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("auto_body_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Для какого кузова";
	pm.addField(new FieldJSON("auto_bodies_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("manufacturer_brand_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Производитель";
	pm.addField(new FieldJSON("manufacturer_brands_ref",f_opts));
}

			Item_Controller.prototype.addGetObject = function(){
	Item_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			Item_Controller.prototype.add_complete_item = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('complete_item',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("make_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("model_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("model_generation_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("body_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("item_folder_id",options));
	
				
	
	var options = {};
	
		options.maxlength = "500";
	
		pm.addField(new FieldString("descr",options));
	
				
	
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
	
			Item_Controller.prototype.addComplete = function(){
	Item_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	f_opts.alias = "";
	var pm = this.getComplete();
	pm.addField(new FieldText("name",f_opts));
	pm.addField(new FieldInt("count", {}));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");	
}

			Item_Controller.prototype.add_set_feature = function(){
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
	
			Item_Controller.prototype.add_get_features_filter_list = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_features_filter_list',opts);
	
	this.addPublicMethod(pm);
}
			
		