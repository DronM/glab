/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function AutoToGlassMatchHead_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Конфигуратор";
	options.cmdSave = true;
	options.model = (options.models&&options.models.AutoToGlassMatchHeadList_Model)? options.models.AutoToGlassMatchHeadList_Model : new AutoToGlassMatchHeadList_Model();
	options.controller = options.controller || new AutoToGlassMatchHead_Controller();
	options.templateOptions = {};
	
	var self = this;
	options.addElement = function(){
		this.addElement(new UserEditRef(id+":users_ref",{
			"enabled":(window.getApp().getServVar("role_id") == "admin")
			,"value":new RefType({
				"keys":{"id": window.getApp().getServVar("user_id")}
				,"descr":window.getApp().getServVar("user_name")
			})
		}));
		this.addElement(new EditDateTime(id+":date_time",{
			"labelCaption":"Дата:",
			"value":DateHelper.time()
		}));
	
		this.addElement(new AutoToGlassMatchEurocodeList_View(id+":auto_codes_list",{
			"detail":true,
			"afterGridUpdate":function(){
				self.getElement("auto_bodies_list").getElement("grid").onRefresh();
			}
		}));
		this.addElement(new AutoToGlassMatchEurocodeBodyList_View(id+":auto_bodies_list",{"detail":true}));
		
		this.addElement(new AutoToGlassMatchOptionCont_View(id+":auto_options_list"));
	}
	
	AutoToGlassMatchHead_View.superclass.constructor.call(this,id,options);
	
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("date_time")})
		,new DataBinding({"control":this.getElement("users_ref")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("date_time")})
		,new CommandBinding({"control":this.getElement("users_ref"),"fieldId":"user_id"})
	];
	this.setWriteBindings(write_b);
	

	this.addDetailDataSet({
		"control":this.getElement("auto_codes_list").getElement("grid"),
		"controlFieldId":"auto_to_glass_match_head_id",
		"field":this.m_model.getField("id")
	});

	this.addDetailDataSet({
		"control":this.getElement("auto_bodies_list").getElement("grid"),
		"controlFieldId":"auto_to_glass_match_head_id",
		"field":this.m_model.getField("id")
	});

}
extend(AutoToGlassMatchHead_View, ViewObjectAjx);

//********************

AutoToGlassMatchHead_View.prototype.onGetData = function(resp,cmd){
	AutoToGlassMatchHead_View.superclass.onGetData.call(this,resp,cmd);
	
	this.getElement("auto_options_list").setHeadId(this.getModel().getFieldValue("id"));
}
