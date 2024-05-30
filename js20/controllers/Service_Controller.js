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

function Service_Controller(options){
	options = options || {};
	Service_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.add_reload_config();
	this.add_reload_version();
		
}
extend(Service_Controller,ControllerObjServer);

			Service_Controller.prototype.add_reload_config = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('reload_config',opts);
	
	this.addPublicMethod(pm);
}

			Service_Controller.prototype.add_reload_version = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('reload_version',opts);
	
	this.addPublicMethod(pm);
}

		