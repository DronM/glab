/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller_js20.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 
 * @class
 * @classdesc controller
 
 * @extends ControllerObjClient
  
 * @requires core/extend.js
 * @requires core/ControllerObjClient.js
  
 * @param {Object} options
 * @param {Model} options.listModelClass
 * @param {Model} options.objModelClass
 */ 

function SupplierItemFeatureValueList_Controller(options){
	options = options || {};
	options.listModelClass = SupplierItemFeatureValueList_Model;
	options.objModelClass = SupplierItemFeatureValueList_Model;
	SupplierItemFeatureValueList_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(SupplierItemFeatureValueList_Controller,ControllerObjClient);

			SupplierItemFeatureValueList_Controller.prototype.addInsert = function(){
	SupplierItemFeatureValueList_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	
}

			SupplierItemFeatureValueList_Controller.prototype.addUpdate = function(){
	SupplierItemFeatureValueList_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	
}

			SupplierItemFeatureValueList_Controller.prototype.addDelete = function(){
	SupplierItemFeatureValueList_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
}

			SupplierItemFeatureValueList_Controller.prototype.addGetList = function(){
	SupplierItemFeatureValueList_Controller.superclass.addGetList.call(this);
	
	
	
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

}

			SupplierItemFeatureValueList_Controller.prototype.addGetObject = function(){
	SupplierItemFeatureValueList_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

		