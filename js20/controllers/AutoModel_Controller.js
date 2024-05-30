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

function AutoModel_Controller(options){
	options = options || {};
	options.listModelClass = AutoModelList_Model;
	options.objModelClass = AutoModelList_Model;
	AutoModel_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_complete_for_make();
	this.add_get_all_years();
		
}
extend(AutoModel_Controller,ControllerObjServer);

			AutoModel_Controller.prototype.addInsert = function(){
	AutoModel_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Марка";
	var field = new FieldInt("auto_make_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Варианты наименования";
	var field = new FieldText("name_variants",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Популярность";
	var field = new FieldInt("popularity_type_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип ТС";
	var field = new FieldInt("vehicle_type_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			AutoModel_Controller.prototype.addUpdate = function(){
	AutoModel_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Марка";
	var field = new FieldInt("auto_make_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Варианты наименования";
	var field = new FieldText("name_variants",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Популярность";
	var field = new FieldInt("popularity_type_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип ТС";
	var field = new FieldInt("vehicle_type_id",options);
	
	pm.addField(field);
	
	
}

			AutoModel_Controller.prototype.addDelete = function(){
	AutoModel_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			AutoModel_Controller.prototype.addGetList = function(){
	AutoModel_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldInt("auto_make_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("auto_makes_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldText("name_variants",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("popularity_type_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("vehicle_type_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Популярность";
	pm.addField(new FieldJSON("popularity_types_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Тип ТС";
	pm.addField(new FieldJSON("vehicle_types_ref",f_opts));
}

			AutoModel_Controller.prototype.addGetObject = function(){
	AutoModel_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			AutoModel_Controller.prototype.add_complete_for_make = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('complete_for_make',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldText("name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("make_id",options));
	
				
	
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

			AutoModel_Controller.prototype.add_get_all_years = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_all_years',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("model_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("model_generation_id",options));
	
			
	this.addPublicMethod(pm);
}
			
			
		