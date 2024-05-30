/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoToGlassMatchOptionCont_View(id,options){	

	AutoToGlassMatchOptionCont_View.superclass.constructor.call(this,id, "TEMPLATE", options);
}
extend(AutoToGlassMatchOptionCont_View, Control);

AutoToGlassMatchOptionCont_View.prototype.updateView = function(resp){	
	this.m_editOptModel = new ModelXML("ModelXML",{
		"fields":[
			new FieldJSON("eurocode_list"),
			new FieldJSON("body_door_list"),
			new FieldJSON("body_type_list"),
			new FieldJSON("body_model_list")
		],
		"data": resp.getModelData("OptionEdit_Model")
	});
	var par_n = document.getElementById(this.getId() + ":cont");
	var prior_m = resp.getModel("ItemPriority_Model");
	while(prior_m.getNextRow()){
		var prior_id = prior_m.getFieldValue("id");
		var opt_v = new AutoToGlassMatchOptionList_View(this.getId() + ":cont:" + "OptionList_" +  prior_id, {			
			"models":{
				"AutoToGlassMatchOption_Model": new AutoToGlassMatchOption_Model({"data": resp.getModelData("OptionList_" +  prior_id +  "_Model")})
			},
			"itemPriorityDescr": prior_m.getFieldValue("name"),
			"itemPriorityId": prior_id,
			"itemFeatures": new ItemFeature_Model({"data": resp.getModelData("ItemFeature_" +  prior_id +  "_Model")}),
			"editOptModel": this.m_editOptModel,
			"headId":this.m_headId
		});
		opt_v.toDOM(par_n);
	}
}

AutoToGlassMatchOptionCont_View.prototype.setHeadId = function(id){
	this.m_headId = id;
	
	var self = this;
	var pm = (new AutoToGlassMatchOption_Controller()).getPublicMethod("get_conf_form");
	pm.setFieldValue("auto_to_glass_match_head_id", this.m_headId);
	pm.run({
		"ok":function(resp){
			self.updateView(resp);
		}
	})
}


