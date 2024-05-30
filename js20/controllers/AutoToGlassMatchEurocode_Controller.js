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

function AutoToGlassMatchEurocode_Controller(options){
	options = options || {};
	options.listModelClass = AutoToGlassMatchEurocodeList_Model;
	options.objModelClass = AutoToGlassMatchEurocodeList_Model;
	AutoToGlassMatchEurocode_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_body_list();
		
}
extend(AutoToGlassMatchEurocode_Controller,ControllerObjServer);

			AutoToGlassMatchEurocode_Controller.prototype.addInsert = function(){
	AutoToGlassMatchEurocode_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("auto_to_glass_match_head_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Кузовы";
	var field = new FieldArray("auto_bodies_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Код, введенный пользователем";options.required = true;
	var field = new FieldText("user_code",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			AutoToGlassMatchEurocode_Controller.prototype.addUpdate = function(){
	AutoToGlassMatchEurocode_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("auto_to_glass_match_head_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Кузовы";
	var field = new FieldArray("auto_bodies_list",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Код, введенный пользователем";
	var field = new FieldText("user_code",options);
	
	pm.addField(field);
	
	
}

			AutoToGlassMatchEurocode_Controller.prototype.addDelete = function(){
	AutoToGlassMatchEurocode_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			AutoToGlassMatchEurocode_Controller.prototype.addGetList = function(){
	AutoToGlassMatchEurocode_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldInt("auto_to_glass_match_head_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Код, введенный пользователем";
	pm.addField(new FieldText("user_code",f_opts));
	var f_opts = {};
	f_opts.alias = "Кузовы";
	pm.addField(new FieldJSON("auto_bodies_list",f_opts));
}

			AutoToGlassMatchEurocode_Controller.prototype.addGetObject = function(){
	AutoToGlassMatchEurocode_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			AutoToGlassMatchEurocode_Controller.prototype.add_get_body_list = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_body_list',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("from",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("count",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("field_sep",options));
	
			
	this.addPublicMethod(pm);
}

		