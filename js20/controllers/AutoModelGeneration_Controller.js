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

function AutoModelGeneration_Controller(options){
	options = options || {};
	options.listModelClass = AutoModelGenerationList_Model;
	options.objModelClass = AutoModelGenerationList_Model;
	AutoModelGeneration_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_complete_for_model();
	this.add_gen_next_id();
		
}
extend(AutoModelGeneration_Controller,ControllerObjServer);

			AutoModelGeneration_Controller.prototype.addInsert = function(){
	AutoModelGeneration_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Марка";
	var field = new FieldInt("auto_model_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер поколения";
	var field = new FieldText("generation_num",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Заводской индекс модели";
	var field = new FieldText("prod_index",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Начало производтва";
	var field = new FieldInt("year_from",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Окончание производтва";
	var field = new FieldInt("year_to",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Модификация";
	var field = new FieldText("model",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Серия";
	var field = new FieldText("series",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			AutoModelGeneration_Controller.prototype.addUpdate = function(){
	AutoModelGeneration_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Марка";
	var field = new FieldInt("auto_model_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер поколения";
	var field = new FieldText("generation_num",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Заводской индекс модели";
	var field = new FieldText("prod_index",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Начало производтва";
	var field = new FieldInt("year_from",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Окончание производтва";
	var field = new FieldInt("year_to",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Модификация";
	var field = new FieldText("model",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Серия";
	var field = new FieldText("series",options);
	
	pm.addField(field);
	
	
}

			AutoModelGeneration_Controller.prototype.addDelete = function(){
	AutoModelGeneration_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			AutoModelGeneration_Controller.prototype.addGetList = function(){
	AutoModelGeneration_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Марка";
	pm.addField(new FieldInt("auto_make_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("auto_makes_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Модель";
	pm.addField(new FieldInt("auto_model_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldJSON("auto_models_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Номер поколения";
	pm.addField(new FieldText("generation_num",f_opts));
	var f_opts = {};
	f_opts.alias = "Заводской индекс модели";
	pm.addField(new FieldText("prod_index",f_opts));
	var f_opts = {};
	f_opts.alias = "Начало производтва";
	pm.addField(new FieldInt("year_from",f_opts));
	var f_opts = {};
	f_opts.alias = "Окончание производтва";
	pm.addField(new FieldInt("year_to",f_opts));
	var f_opts = {};
	f_opts.alias = "Модификация";
	pm.addField(new FieldText("model",f_opts));
	var f_opts = {};
	f_opts.alias = "Серия";
	pm.addField(new FieldText("series",f_opts));
	var f_opts = {};
	f_opts.alias = "Название";
	pm.addField(new FieldString("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Количество кузовов";
	pm.addField(new FieldInt("body_count",f_opts));
}

			AutoModelGeneration_Controller.prototype.addGetObject = function(){
	AutoModelGeneration_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			AutoModelGeneration_Controller.prototype.add_complete_for_model = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('complete_for_model',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("model_id",options));
	
				
	
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
						
			AutoModelGeneration_Controller.prototype.add_gen_next_id = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('gen_next_id',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("model_id",options));
	
				
	
	var options = {};
	
		options.maxlength = "100";
	
		pm.addField(new FieldString("eurocode",options));
	
			
	this.addPublicMethod(pm);
}
						
			
		