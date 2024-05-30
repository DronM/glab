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

function AutoToGlassMatchOption_Controller(options){
	options = options || {};
	options.listModelClass = AutoToGlassMatchOption_Model;
	options.objModelClass = AutoToGlassMatchOption_Model;
	AutoToGlassMatchOption_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_conf_form();
		
}
extend(AutoToGlassMatchOption_Controller,ControllerObjServer);

			AutoToGlassMatchOption_Controller.prototype.addInsert = function(){
	AutoToGlassMatchOption_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Master";
	var field = new FieldInt("auto_to_glass_match_head_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Группа стекол";
	var field = new FieldInt("item_priority_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер строки";
	var field = new FieldInt("line_num",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список еврокодов с отметками";
	var field = new FieldArray("eurocode_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список еврокодов с отметками (для просмотра)";
	var field = new FieldText("eurocode_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список дверей кузовов с отметками";
	var field = new FieldJSONB("body_door_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список дверей кузовов с отметками (для просмотра)";
	var field = new FieldText("body_door_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список типов кузовов с отметками";
	var field = new FieldJSONB("body_type_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список типов кузовов с отметками (для просмотра)";
	var field = new FieldText("body_type_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список моделей кузовов с отметками";
	var field = new FieldArray("body_model_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список моделей кузовов с отметками (для просмотра)";
	var field = new FieldText("body_model_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список опций со значениями";
	var field = new FieldJSONB("option_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Минимальный складской остаток эконом";
	var field = new FieldInt("quant_econom",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Минимальный складской остаток стандарт";
	var field = new FieldInt("quant_standart",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Минимальный складской остаток премиум";
	var field = new FieldInt("quant_premium",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			AutoToGlassMatchOption_Controller.prototype.addUpdate = function(){
	AutoToGlassMatchOption_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Master";
	var field = new FieldInt("auto_to_glass_match_head_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Группа стекол";
	var field = new FieldInt("item_priority_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер строки";
	var field = new FieldInt("line_num",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список еврокодов с отметками";
	var field = new FieldArray("eurocode_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список еврокодов с отметками (для просмотра)";
	var field = new FieldText("eurocode_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список дверей кузовов с отметками";
	var field = new FieldJSONB("body_door_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список дверей кузовов с отметками (для просмотра)";
	var field = new FieldText("body_door_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список типов кузовов с отметками";
	var field = new FieldJSONB("body_type_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список типов кузовов с отметками (для просмотра)";
	var field = new FieldText("body_type_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список моделей кузовов с отметками";
	var field = new FieldArray("body_model_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список моделей кузовов с отметками (для просмотра)";
	var field = new FieldText("body_model_view",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Список опций со значениями";
	var field = new FieldJSONB("option_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Минимальный складской остаток эконом";
	var field = new FieldInt("quant_econom",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Минимальный складской остаток стандарт";
	var field = new FieldInt("quant_standart",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Минимальный складской остаток премиум";
	var field = new FieldInt("quant_premium",options);
	
	pm.addField(field);
	
	
}

			AutoToGlassMatchOption_Controller.prototype.addDelete = function(){
	AutoToGlassMatchOption_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			AutoToGlassMatchOption_Controller.prototype.addGetList = function(){
	AutoToGlassMatchOption_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Master";
	pm.addField(new FieldInt("auto_to_glass_match_head_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Группа стекол";
	pm.addField(new FieldInt("item_priority_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Номер строки";
	pm.addField(new FieldInt("line_num",f_opts));
	var f_opts = {};
	f_opts.alias = "Список еврокодов с отметками";
	pm.addField(new FieldArray("eurocode_list",f_opts));
	var f_opts = {};
	f_opts.alias = "Список еврокодов с отметками (для просмотра)";
	pm.addField(new FieldText("eurocode_view",f_opts));
	var f_opts = {};
	f_opts.alias = "Список дверей кузовов с отметками";
	pm.addField(new FieldJSONB("body_door_list",f_opts));
	var f_opts = {};
	f_opts.alias = "Список дверей кузовов с отметками (для просмотра)";
	pm.addField(new FieldText("body_door_view",f_opts));
	var f_opts = {};
	f_opts.alias = "Список типов кузовов с отметками";
	pm.addField(new FieldJSONB("body_type_list",f_opts));
	var f_opts = {};
	f_opts.alias = "Список типов кузовов с отметками (для просмотра)";
	pm.addField(new FieldText("body_type_view",f_opts));
	var f_opts = {};
	f_opts.alias = "Список моделей кузовов с отметками";
	pm.addField(new FieldArray("body_model_list",f_opts));
	var f_opts = {};
	f_opts.alias = "Список моделей кузовов с отметками (для просмотра)";
	pm.addField(new FieldText("body_model_view",f_opts));
	var f_opts = {};
	f_opts.alias = "Список опций со значениями";
	pm.addField(new FieldJSONB("option_list",f_opts));
	var f_opts = {};
	f_opts.alias = "Минимальный складской остаток эконом";
	pm.addField(new FieldInt("quant_econom",f_opts));
	var f_opts = {};
	f_opts.alias = "Минимальный складской остаток стандарт";
	pm.addField(new FieldInt("quant_standart",f_opts));
	var f_opts = {};
	f_opts.alias = "Минимальный складской остаток премиум";
	pm.addField(new FieldInt("quant_premium",f_opts));
}

			AutoToGlassMatchOption_Controller.prototype.addGetObject = function(){
	AutoToGlassMatchOption_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			AutoToGlassMatchOption_Controller.prototype.add_get_conf_form = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_conf_form',opts);
	
				
	
	var options = {};
	
		options.alias = "Master";
	
		options.required = true;
	
		pm.addField(new FieldInt("auto_to_glass_match_head_id",options));
	
			
	this.addPublicMethod(pm);
}

		