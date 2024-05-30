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

function ItemSearch_Controller(options){
	options = options || {};
	ItemSearch_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addGetObject();
	this.add_find_items();
		
}
extend(ItemSearch_Controller,ControllerObjServer);

			ItemSearch_Controller.prototype.addGetObject = function(){
	ItemSearch_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	
	pm.addField(new FieldString("mode"));
	pm.addField(new FieldString("lsn"));
}

			ItemSearch_Controller.prototype.add_find_items = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('find_items',opts);
	
				
	
	var options = {};
	
		pm.addField(new FieldJSON("criteria",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("from",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("count",options));
	
			
	this.addPublicMethod(pm);
}

		