/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022

 * @extends ControlContainer
 * @requires core/extend.js
 * @requires controls/ControlContainer.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function ItemSearch_View(id,options){
	options = options || {};	
	
	var self = this;
	options.addElement = function(){
		this.addElement(new AutoMakeEdit(id+":auto_make",{
			"onSelect":function(f){
				self.getElement("auto_model").getAutoComplete().getPublicMethod().setFieldValue("make_id", f.id.getValue());
				self.findItems();
			},
			"onReset": function(){
				var ctrl = self.getElement("auto_model");
				ctrl.reset();
				ctrl.getAutoComplete().getPublicMethod().unsetFieldValue("make_id");				
				self.findItems();
			}
		}));	
		this.addElement(new AutoModelEdit(id+":auto_model",{
			"onSelect":function(f){
				self.getElement("auto_model_generation").getAutoComplete().getPublicMethod().setFieldValue("model_id", f.id.getValue());
				self.getElement("auto_body").getAutoComplete().getPublicMethod().setFieldValue("model_id", f.id.getValue());
				self.updateYears(f.id.getValue());
			},
			"onReset": function(){
				var ctrl = self.getElement("auto_model_generation");
				ctrl.reset();
				ctrl.getAutoComplete().getPublicMethod().unsetFieldValue("model_id");
				self.getElement("auto_body").getAutoComplete().getPublicMethod().unsetFieldValue("model_id");
				self.getElement("auto_model_years").clear();
				self.getElement("auto_model_years").toDOM();
				self.findItems();
			}
		}));	
		
		this.addElement(new AutoModelGenerationEdit(id+":auto_model_generation",{
			"onSelect":function(f){
				self.getElement("auto_body").getAutoComplete().getPublicMethod().setFieldValue("model_generation_id", f.id.getValue());
				self.getElement("auto_body").getAutoComplete().getPublicMethod().unsetFieldValue("model_id");
				self.updateYears();
				self.findItems();
			},
			"onReset": function(){
				var ctrl = self.getElement("auto_body");
				ctrl.reset();
				ctrl.getAutoComplete().getPublicMethod().unsetFieldValue("model_generation_id");				
				self.updateYears();
				self.findItems();
			}
		}));	
		
		this.addElement(new ControlContainer(id+":auto_model_years", "DIV",{
			"attrs":{"class":"swicth_year_cont",
				"title":"Возможные года выпуска"
			}
		}));
		
		this.addElement(new ItemPriorityCheckEdit(id+":item_priorities",{
			"model":(options.models&&options.models.ItemPriority_Model)? options.models.ItemPriority_Model: null,
			"onChange":function(){
				self.itemPriorityChange();				
			}
		}));	

		this.addElement(new AutoBodyEdit(id+":auto_body",{
			"onSelect":function(f){
				self.findItems();
			},
			"onReset": function(){
				self.findItems();
			}		
		}));	

		this.addElement(new ItemFeatureQualityEdit(id+":item_feature_qualities",{
			"onChange":function(){
				self.findItems();
			}
		}));	
		
		this.addElement(new ItemFeatureOptionEdit(id+":item_feature_options", {
			"model": new ModelXML("FilterOptionList_Model", {
				"data": options.models.FilterOptionList_Model.getData(),
				"fields": ["id", "name", "comment_text", "name_lat", "filter_option_type", "item_priorities"]
			}),
			"onChange":function(){
				self.findItems();
			}
		}));
		
		/*this.addElement(new ButtonCmd(id+":search", {
			"caption":"Найти",
			"onClick":function(){
				self.findItems();
			}
		}));*/

		this.addElement(new ItemSearchResult_View(id+":item_search_result"));
		
	}
	
	ItemSearch_View.superclass.constructor.call(this,id,options);
}
//ViewObjectAjx,ViewAjxList
extend(ItemSearch_View, View);


ItemSearch_View.prototype.updateYears = function(modelId){
	if(!modelId){
		var auto_models_ref = this.getElement("auto_model").getValue();
		if(auto_models_ref && !auto_models_ref.isNull()){
			modelId = auto_models_ref.getKey("id");
		}
	}
	if(!modelId){
		return;
	}
	var pm = (new AutoModel_Controller()).getPublicMethod("get_all_years");
	pm.setFieldValue("model_id", modelId);
	var model_generations_ref = this.getElement("auto_model_generation").getValue();
	if(!model_generations_ref || model_generations_ref.isNull()){
		pm.unsetFieldValue("model_generation_id");
	}else{
		pm.setFieldValue("model_generation_id", model_generations_ref.getKey("id"));
	}
	var self = this;
	pm.run({
		"ok":function(resp){
			var m = new ModelXML("AutoModelYearList_Model",{
				"data":resp.getModelData("AutoModelYearList_Model")
			});
			if(m.getNextRow()){
				var y_from = parseInt(m.getFieldValue("year_from"), 10);
				var y_to = parseInt(m.getFieldValue("year_to"), 10);
				var years = [];
				for(y = y_from; y <= y_to; y++){
					years.push(new Control(self.getId()+":auto_model_generation:y_"+y,"DIV", {
						"value": (y.toString()).substring(2),
						"attrs":{"class":"swicth_year", "val": y},
						"events":{
							"click":function(e){											
								if(!DOMHelper.hasClass(e.target, "swicth_year_selected")){
									var n_list = document.getElementsByClassName("swicth_year_selected");	
									for(var i = 0; i < n_list.length; i++){
										DOMHelper.delClass(n_list[i], "swicth_year_selected");
									}
									DOMHelper.addClass(e.target, "swicth_year_selected");
									self.findItems();
								}
							}
						}
					}));
				}
				var ctrl = self.getElement("auto_model_years");
				ctrl.clear();
				ctrl.addElements(years);			
				ctrl.toDOM();
				//to end
				ctrl.m_node.scrollLeft = ctrl.m_node.scrollWidth;
				/*console.log(ctrl.m_node.scrollHeight)
				
				console.log(ctrl.m_node.scrollTop)
				console.log(ctrl.m_node)
				*/
			}
		}
	});

}

ItemSearch_View.prototype.updateItems = function(modeldData){
console.log(modeldData)
	var grid = this.getElement("item_search_result").getElement("grid");
	grid.getModel().setData(modeldData);
	grid.onGetData();
	
	//disable filter	
	var opt_nodes = DOMHelper.getElementsByAttr("class", this.getElement("item_feature_options").m_node, "itemFeatureOptionCont", false);
	var opts = {};
	for(var i = 0; i < opt_nodes.length; i++){
		opts["opt_"+opt_nodes[i].geAttribute("feature_opt_id")] = opt_nodes[i];
		opt_nodes[i].setAttribute("disabled", "disabled");
	}
	/*var checked = [];
	var m = grid.getModel();
	m.reset();	
	while(m.getNextRow()){
		var fl = m.getFieldValue("features_list");
		for(var i = 0; i < fl.length; i++){
			if(checked.includes(fl[i].item_feature_id) || !opts["opt_"+fl[i].item_feature_id])continue;
			opt_nodes["opt_"+fl[i].item_feature_id].delAttribute("disabled");
			checked.push(fl[i].item_feature_id);
		}
	}
	*/
}

ItemSearch_View.prototype.findItems = function(){
	var grid = this.getElement("item_search_result").getElement("grid");
	grid.getModel().clear();
	grid.onGetData();
	
	var auto_make_id, auto_model_id;
	var auto_body_id = 0;
	var auto_model_generation_id = 0;
	var auto_model_year = 0;
	var y_list = document.getElementsByClassName("swicth_year_selected");	
	if(y_list && y_list.length){
		auto_model_year = parseInt(y_list[0].getAttribute("val"), 10);
	}
	
	var auto_makes_ref = this.getElement("auto_make").getValue();
	var auto_models_ref = this.getElement("auto_model").getValue();
	var auto_model_generations_ref = this.getElement("auto_model_generation").getValue();
	var auto_bodies_ref = this.getElement("auto_body").getValue();
	
	if(!auto_makes_ref || auto_makes_ref.isNull()){
		console.log("Не выбрана марка");
		return;
	}
	auto_make_id = auto_makes_ref.getKey();

	if(!auto_models_ref || auto_models_ref.isNull()){
		console.log("Не выбрана модель");
		return;
	}
	auto_model_id = auto_models_ref.getKey();

	
	if(auto_model_generations_ref && !auto_model_generations_ref.isNull()){
		auto_model_generation_id = auto_model_generations_ref.getKey();
	}	

	if(auto_bodies_ref && !auto_bodies_ref.isNull()){
		auto_body_id = auto_bodies_ref.getKey();
	}	
	
	if (auto_model_year == 0 && auto_model_generation_id == 0){
		console.log("No generation + no model year");
		return;
	}
	
	var it_prior = this.getElement("item_priorities").getValue();
	if(!it_prior){
		return;
	}
	
	var s_criteria = {
		"auto_make_id": auto_make_id,
		"auto_model_id": auto_model_id,
		"auto_model_generation_id": auto_model_generation_id,
		"auto_body_id": auto_body_id,
		"auto_model_year": auto_model_year,
		"item_priorities": it_prior,
		"item_feature_qualities": this.getElement("item_feature_qualities").getValue(),
		"item_feature_options": this.getElement("item_feature_options").getValue()
	}
	//console.log(s_criteria);
	var pm = (new ItemSearch_Controller()).getPublicMethod("find_items");
	pm.setFieldValue("criteria", s_criteria);
	pm.setFieldValue("from", 0);
	pm.setFieldValue("count", 100);
	
	var self = this;
	pm.run({
		"ok":function(resp){
			self.updateItems(resp.getModelData("ItemSearchResult_Model"));
		}
	})
}


ItemSearch_View.prototype.itemPriorityChange = function(){
	var vals = this.getElement("item_priorities").getValue();	
	console.log(vals);
	this.getElement("item_feature_options").setPriorityList(vals);
	//self.findItems();
}
