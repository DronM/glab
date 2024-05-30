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

function Manufacture_Controller(options){
	options = options || {};
	options.listModelClass = ManufacturerList_Model;
	options.objModelClass = ManufactureDialog_Model;
	Manufacture_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
		
}
extend(Manufacture_Controller,ControllerObjServer);

			Manufacture_Controller.prototype.addInsert = function(){
	Manufacture_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	
}

			Manufacture_Controller.prototype.addUpdate = function(){
	Manufacture_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	
}

			Manufacture_Controller.prototype.addDelete = function(){
	Manufacture_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
}

			Manufacture_Controller.prototype.addGetList = function(){
	Manufacture_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "ID";
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldText("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Уровень качества";
	pm.addField(new FieldString("quality_level",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			Manufacture_Controller.prototype.addGetObject = function(){
	Manufacture_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			Manufacture_Controller.prototype.addComplete = function(){
	Manufacture_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	f_opts.alias = "";
	var pm = this.getComplete();
	pm.addField(new FieldText("name",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");	
}

		