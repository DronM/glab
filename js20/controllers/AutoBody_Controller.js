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

function AutoBody_Controller(options){
	options = options || {};
	options.listModelClass = AutoBodyList_Model;
	options.objModelClass = AutoBodyList_Model;
	AutoBody_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_complete_for_model_generation();
	this.add_complete_for_model();
		
}
extend(AutoBody_Controller,ControllerObjServer);

			AutoBody_Controller.prototype.addInsert = function(){
	AutoBody_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Принадлежность к модели";
	var field = new FieldInt("auto_model_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldText("name",options);
	
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
	options.alias = "Двери";
	var field = new FieldInt("auto_body_door_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип";
	var field = new FieldInt("auto_body_type_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Категория цены";
	var field = new FieldInt("auto_price_category_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Размер кузова";	
	options.enumValues = 'small,middle,large,extra_large';
	var field = new FieldEnum("auto_body_size",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности пленка кузов";
	var field = new FieldInt("complexity_film_body",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности пленка перед";
	var field = new FieldInt("complexity_film_front",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности пленка зад";
	var field = new FieldInt("complexity_film_back",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности замена стекла";
	var field = new FieldInt("complexity_glass",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			AutoBody_Controller.prototype.addUpdate = function(){
	AutoBody_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Принадлежность к модели";
	var field = new FieldInt("auto_model_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("name",options);
	
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
	options.alias = "Двери";
	var field = new FieldInt("auto_body_door_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип";
	var field = new FieldInt("auto_body_type_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Категория цены";
	var field = new FieldInt("auto_price_category_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Размер кузова";	
	options.enumValues = 'small,middle,large,extra_large';
	
	var field = new FieldEnum("auto_body_size",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности пленка кузов";
	var field = new FieldInt("complexity_film_body",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности пленка перед";
	var field = new FieldInt("complexity_film_front",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности пленка зад";
	var field = new FieldInt("complexity_film_back",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Класс сложности замена стекла";
	var field = new FieldInt("complexity_glass",options);
	
	pm.addField(field);
	
	
}

			AutoBody_Controller.prototype.addDelete = function(){
	AutoBody_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			AutoBody_Controller.prototype.addGetList = function(){
	AutoBody_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Наименование кузова";
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Модель";
	pm.addField(new FieldInt("auto_model_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Модель";
	pm.addField(new FieldJSON("auto_models_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Тип кузова идентификатор";
	pm.addField(new FieldInt("auto_body_type_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Тип кузова";
	pm.addField(new FieldJSON("auto_body_types_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Тип дверей кузова";
	pm.addField(new FieldJSON("auto_body_doors_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Начало производтва";
	pm.addField(new FieldInt("year_from",f_opts));
	var f_opts = {};
	f_opts.alias = "Окончание производтва";
	pm.addField(new FieldInt("year_to",f_opts));
	var f_opts = {};
	f_opts.alias = "Модель";
	pm.addField(new FieldText("model",f_opts));
	var f_opts = {};
	f_opts.alias = "Категория цены";
	pm.addField(new FieldJSON("auto_price_categories_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Размер кузова";
	pm.addField(new FieldString("auto_body_size",f_opts));
	var f_opts = {};
	f_opts.alias = "Класс сложности пленка кузов";
	pm.addField(new FieldInt("complexity_film_body",f_opts));
	var f_opts = {};
	f_opts.alias = "Класс сложности пленка перед";
	pm.addField(new FieldInt("complexity_film_front",f_opts));
	var f_opts = {};
	f_opts.alias = "Класс сложности пленка зад";
	pm.addField(new FieldInt("complexity_film_back",f_opts));
	var f_opts = {};
	f_opts.alias = "Класс сложности замена стекла";
	pm.addField(new FieldInt("complexity_glass",f_opts));
}

			AutoBody_Controller.prototype.addGetObject = function(){
	AutoBody_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			AutoBody_Controller.prototype.add_complete_for_model_generation = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('complete_for_model_generation',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("model_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("model_generation_id",options));
	
				
	
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
			
			AutoBody_Controller.prototype.add_complete_for_model = function(){
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
			
			
		