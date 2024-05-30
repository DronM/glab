/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022

 * @extends ViewObjectAjx
 * @requires core/extend.js
 * @requires controls/ViewObjectAjx.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function AutoToGlassMatchOptionDialog_View(id,options){
	options = options || {};	
	options.cmdSave = false,
	
	options.model = (options.models&&options.models.AutoToGlassMatchOption_Model)? options.models.AutoToGlassMatchOption_Model : new AutoToGlassMatchOption_Model();
	options.controller = options.controller || new AutoToGlassMatchOption_Controller();
	
	options.templateOptions = options.templateOptions || {};
	
	this.m_headId = options.headId;
	this.m_priorityId = options.priorityId;

	if(options.editOptModel && typeof(options.editOptModel) == "object"){
		options.templateOptions.ID_LIST = [];
		options.templateOptions.BODY_DOOR_LIST = [];
		options.templateOptions.BODY_TYPE_LIST = [];
		options.templateOptions.BODY_MODEL_LIST = [];

		options.editOptModel.reset();
		while(options.editOptModel.getNextRow()){
			//id
			var eurocode_list = options.editOptModel.getFieldValue("eurocode_list");
			for(var i = 0; i < eurocode_list.length; i ++){
				var checked = false;
				options.templateOptions.ID_LIST.push({
					"ID": eurocode_list[i].id,
					"CHECKED": checked
				})				
			}

			//body_door_list
			var body_door_list = options.editOptModel.getFieldValue("body_door_list");
			for(var i = 0; i < body_door_list.length; i ++){
				var ref = CommonHelper.unserialize(body_door_list[i].ref);
				options.templateOptions.BODY_DOOR_LIST.push({
					"ID": ref.getKey("id"),
					"DESCR": ref.getDescr(),
					"CHECKED": body_door_list[i].checked
				})
			}		
			
			//body_type_list
			var body_type_list = options.editOptModel.getFieldValue("body_type_list");
			for(var i = 0; i < body_type_list.length; i ++){
				var ref = CommonHelper.unserialize(body_type_list[i].ref);
				options.templateOptions.BODY_TYPE_LIST.push({
					"ID": ref.getKey("id"),
					"DESCR": ref.getDescr(),
					"CHECKED": body_type_list[i].checked
				})
			}		

			//body_model_list
			var body_model_list = options.editOptModel.getFieldValue("body_model_list");
			for(var i = 0; i < body_model_list.length; i ++){
				options.templateOptions.BODY_MODEL_LIST.push({
					"DESCR": body_model_list[i]["name"],
					"HASH": CommonHelper.md5(body_model_list[i]["name"]),
					"CHECKED": body_model_list[i].checked
				})
			}		
		}
	}
	
	if(options.itemFeatures && typeof(options.itemFeatures) == "object"){
		options.templateOptions.OPTION_LIST = [];		
		options.itemFeatures.reset();
		while(options.itemFeatures.getNextRow()){
			options.templateOptions.OPTION_LIST.push({
				"ID": options.itemFeatures.getFieldValue("id")
			})
		}	
	}
	
	options.template = window.getApp().getTemplate("AutoToGlassMatchOptionDialog_View")
	
	options.addElement = function(){
		this.addElement(new EditNum(id+":quant_econom",{
			"labelCaption": "Эконом:",
		}));	
		
		this.addElement(new EditNum(id+":quant_standart",{
			"labelCaption": "Стандарт:",
		}));	

		this.addElement(new EditNum(id+":quant_premium",{
			"labelCaption": "Премиум:",
		}));	
		
		this.m_itemFeatureControls = [];
		if(options.itemFeatures && typeof(options.itemFeatures) == "object"){
			var app = window.getApp();
			options.itemFeatures.reset();
			while(options.itemFeatures.getNextRow()){
				var id = options.itemFeatures.getFieldValue("id");
				var ctrl = app.getItemFeatureEditCtrl(
					{
						"id": id,
						"name": options.itemFeatures.getFieldValue("name"),
						"name_lat": options.itemFeatures.getFieldValue("name_lat"),
						"comment_text": options.itemFeatures.getFieldValue("comment_text"),
						"value_attrs": options.itemFeatures.getFieldValue("value_attrs")
					},
					this.getId()+":opt:",
					id,
					undefined
				);			
				if(!ctrl){
					throw new Error("Unknown data type: "+attrs.value_attrs.data_type);
				}
				this.addElement(ctrl);				
				ctrl.cust_nameLat = options.itemFeatures.getFieldValue("name_lat");
				this.m_itemFeatureControls.push(ctrl);
			}
		}
	}
	
	AutoToGlassMatchOptionDialog_View.superclass.constructor.call(this,id,options);
	
	var self = this;
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("quant_econom")})
		,new DataBinding({"control":this.getElement("quant_standart")})
		,new DataBinding({"control":this.getElement("quant_premium")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("quant_econom")})
		,new CommandBinding({"control":this.getElement("quant_standart")})
		,new CommandBinding({"control":this.getElement("quant_premium")})
		,new CommandBinding({"func":function(pm){
			self.setPublicMethodValues(pm);
		}})
	];
	this.setWriteBindings(write_b);
	
	//events
	
	$(document.getElementById(this.getId() + ":edit_id:all")).click(function(e){
		self.setAll("edit_id", e.target.checked);
	});
	
	$(document.getElementById(this.getId() + ":edit_body_door:all")).click(function(e){
		self.setAll("edit_body_door", e.target.checked);
	});

	$(document.getElementById(this.getId() + ":edit_body_type:all")).click(function(e){
		self.setAll("edit_body_type", e.target.checked);
	});

	$(document.getElementById(this.getId() + ":edit_body_model:all")).click(function(e){
		self.setAll("edit_body_model", e.target.checked);
	});
	
}

//ViewObjectAjx,ViewAjxList
extend(AutoToGlassMatchOptionDialog_View,ViewObjectAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */

AutoToGlassMatchOptionDialog_View.prototype.setAll = function(id, checked){
	var n_list = DOMHelper.getElementsByAttr(id + "_val", document.getElementById(this.getId() + ":" + id), "class", false);
	for (var i = 0; i < n_list.length; i ++){
		n_list[i].checked = checked;
	}
}

AutoToGlassMatchOptionDialog_View.prototype.setPublicMethodValues = function(pm){
	//auto
	this.setPublicMethodFieldValue(pm, "edit_id", "eurocode");
	this.setPublicMethodFieldValue(pm, "edit_body_door", "body_door", true);
	this.setPublicMethodFieldValue(pm, "edit_body_type", "body_type", true);
	this.setPublicMethodFieldValue(pm, "edit_body_model", "body_model");
	
	//options
	var vals = [];
	for (var i = 0; i < this.m_itemFeatureControls.length; i++ ){
		var v = this.m_itemFeatureControls[i].getValue();
		if(v!==null && v!==false){
			vals.push({
				"id": this.m_itemFeatureControls[i].getName(),
				"val": v,
				"name_lat": this.m_itemFeatureControls[i].cust_nameLat,
			});
		}
	}
	pm.setFieldValue("option_list", vals);

	pm.setFieldValue("auto_to_glass_match_head_id", this.m_headId);
	pm.setFieldValue("item_priority_id", this.m_priorityId);				
}

AutoToGlassMatchOptionDialog_View.prototype.setPublicMethodFieldValue = function(pm, id, fieldId, isObj){
	//для ID сокращаем до 1111, если отмечены все 1111-01, 1111-02, 1111-03
	//для дверей и типов толко уникальные
	//для моделей, если всевыбраны- ничего не показывать	
	var vals = [];
	var view_vals = {};
	var view_val = "";
	var n_list = DOMHelper.getElementsByAttr(id + "_val", document.getElementById(this.getId() + ":" + id), "class", false);
	for (var i = 0; i < n_list.length; i ++){
		if(n_list[i].checked){
			if(isObj){
				vals.push({
					"id": n_list[i].getAttribute(id),
					"descr": n_list[i].getAttribute(id + "_descr")
				});
			}else{
				vals.push(n_list[i].getAttribute(id));
			}
		}
		if(fieldId == "eurocode"){
			var full_code = n_list[i].getAttribute(id);
			var p = full_code.indexOf("-");
			if(p >= 0){
				var code = full_code.substring(0, p);
				if(!view_vals[code]){
					view_vals[code] = {
						"tot":0,
						"selected":[]
					}
				}
				view_vals[code].tot++;
				if(n_list[i].checked){
					view_vals[code].selected.push(full_code);
				}
			}
			
		}else if(n_list[i].checked) {
			if(!view_vals[n_list[i].getAttribute(id)]){
				view_vals[n_list[i].getAttribute(id)] = true;
				if(view_val!=""){
					view_val+= ",";
				}
				if(isObj){
					view_val+= n_list[i].getAttribute(id + "_descr");
				}else{
					view_val+= n_list[i].getAttribute(id);
				}
				
			}
		}
	}
	if(fieldId == "eurocode"){
		for(var view_val_id in view_vals){
			if(view_vals[view_val_id].tot == view_vals[view_val_id].selected.length){
				if(view_val!=""){
					view_val+= ",";
				}
				view_val+= view_val_id;
			}else{
				//not all selected
				for(i = 0; i < view_vals[view_val_id].selected.length; i++){					
					if(view_val!=""){
						view_val+= ",";
					}
					view_val+= view_vals[view_val_id].selected[i];					
				}
			}
		}
	}
	pm.setFieldValue(fieldId + "_list", vals);
	pm.setFieldValue(fieldId + "_view", view_val);
}


AutoToGlassMatchOptionDialog_View.prototype.setListValues = function(lst, id){
	if(lst && lst.length){
		for(var i = 0; i < lst.length; i++){
			var ctrl_name;
			if(typeof(lst[i]) == "object"){
				ctrl_name = lst[i].id;
			}else if(id == "edit_body_model"){	
				ctrl_name = CommonHelper.md5(lst[i]);
			}else{
				ctrl_name = lst[i];
			}
			var n = document.getElementById(this.getId() + ":" + id+ ":" + ctrl_name);
			if(!n){
				throw new Error(id + " control with ID = " + ctrl_name + " not found!");
			}
			n.checked = true;
		}
	}
}

AutoToGlassMatchOptionDialog_View.prototype.onGetData = function(resp,cmd){
	AutoToGlassMatchOptionDialog_View.superclass.onGetData.call(this, resp, cmd);
	if(cmd == "edit" || cmd == "copy"){
		//set values
		var m = this.getModel();
		this.setListValues(m.getFieldValue("eurocode_list"), "edit_id");
		this.setListValues(m.getFieldValue("body_door_list"), "edit_body_door");
		this.setListValues(m.getFieldValue("body_type_list"), "edit_body_type");
		this.setListValues(m.getFieldValue("body_model_list"), "edit_body_model");
		
		//options
		var option_list = m.getFieldValue("option_list");
		if(option_list){
			for(var i = 0; i < option_list.length; i ++){
				for(var n = 0; n < this.m_itemFeatureControls.length; n++){
					if(this.m_itemFeatureControls[n].cust_nameLat == option_list[i].name_lat){
						this.m_itemFeatureControls[n].setValue(option_list[i].val);
						break;
					}
				}
			}
		}
	}
}

