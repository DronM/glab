/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends View
 * @requires core/extend.js
 * @requires controls/View.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 * @param {function} options.onChange 
 */
function ItemFeatureOptionEdit(id,options){
	options = options || {};	
	
	options.templateOptions = {
		"FEATURE_OPTIONS_MAIN": [],
		"FEATURE_OPTIONS_ADD": []
	};
	if(options.model && options.model.getRowCount()){
		while(options.model.getNextRow()){
			if(options.model.getFieldValue("filter_option_type") == "main"){
				options.templateOptions.FEATURE_OPTIONS_MAIN.push({
					"FEATURE_OPT_ID": options.model.getFieldValue("id"),
					"FEATURE_OPT_DESCR": options.model.getFieldValue("name"),
					"FEATURE_OPT_COMMENT": options.model.getFieldValue("comment_text"),
					"PRIOR_LIST": options.model.getFieldValue("item_priorities")
				});
			}else if(options.model.getFieldValue("filter_option_type") == "additional"){
				options.templateOptions.FEATURE_OPTIONS_ADD.push({
					"FEATURE_OPT_ID": options.model.getFieldValue("id"),
					"FEATURE_OPT_DESCR": options.model.getFieldValue("name"),
					"FEATURE_OPT_COMMENT": options.model.getFieldValue("comment_text"),
					"PRIOR_LIST": options.model.getFieldValue("item_priorities")
				});
			}
		}
	}
	
	this.m_onChange = options.onChange;
	
	ItemFeatureOptionEdit.superclass.constructor.call(this,id,options);
}
//ViewObjectAjx,ViewAjxList
extend(ItemFeatureOptionEdit,View);

/* Constants */


/* private members */

/* protected*/
ItemFeatureOptionEdit.prototype.toDOM = function(p){
	ItemFeatureOptionEdit.superclass.toDOM.call(this, p);
	
	var self = this;

	//main
	EventHelper.add(document.getElementById(this.getId()+":mainOptionSwitch"), "click", (function(cont){
		return function(e){
			//show/hide main options
			DOMHelper.toggle(document.getElementById(self.getId()+":mainOptions"));		
		}
	})(self));
	
	//additional
	EventHelper.add(document.getElementById(this.getId()+":addOptionSwitch"), "click", (function(cont){
		return function(e){
			//show/hide additional options
			DOMHelper.toggle(document.getElementById(self.getId()+":additionlOptions"));		
		}
	})(self));
	
	//add events
	var n_list = DOMHelper.getElementsByAttr("itemFeatureOption", this.m_node, "class", false, "input");	
	for(var i = 0; i < n_list.length; i++){
		EventHelper.add(n_list[i], "change", (function(cont){
			return function(e){
				cont.m_onChange();
			}			
		})(self));
		EventHelper.add(n_list[i], "click", (function(cont){
			return function(e){
				e.stopPropagation();
			}			
		})(self));
		
	}
	
}

/* public methods */
ItemFeatureOptionEdit.prototype.getValue = function(){
	//return checked items
	var res = [];
	var nodes = DOMHelper.getElementsByAttr("itemFeatureOption", this.getNode(), "class");
	for(var i = 0; i < nodes.length; i++){
		if(nodes[i].checked === true){
			var v = undefined;
			if(nodes[i].value == "true"){
				v = true;
			}else if(nodes[i].value == "false"){
				v = false;
			}
			if(v !== undefined){
				res.push({
					"id": parseInt(nodes[i].getAttribute("opt_id"), 10),
					"val": v
				});
			}
		}
	}
	return res;
}


//Disables some options based on passed array 
ItemFeatureOptionEdit.prototype.setPriorityList = function(priorityList){
	var nodes = DOMHelper.getElementsByAttr("itemFeatureOptionCont", this.getNode(), "class");
	for(var i = 0; i < nodes.length; i++){
		var prior_list = JSON.parse(nodes[i].getAttribute("prior_list"));
		for(var j = 0; j < prior_list.length; j++){
			var enabled = (CommonHelper.inArray(prior_list[j], priorityList) >= 0);
			var fields = nodes[i].getElementsByTagName("input");
			for(var n = 0; n < fields.length; n++){
				if(enabled){
					DOMHelper.delAttr(fields[n], "disabled");
				}else{
					DOMHelper.addAttr(fields[n], "disabled", "disabled");
				}
			}
			if(enabled){
				DOMHelper.delAttr(nodes[i], "disabled");
				DOMHelper.delClass(nodes[i], "text-muted");
				DOMHelper.delClass(nodes[i].parentNode, "text-muted");
			}else{
				DOMHelper.addAttr(nodes[i], "disabled", "disabled");
				DOMHelper.addClass(nodes[i], "text-muted");
				DOMHelper.addClass(nodes[i].parentNode, "text-muted");
			}
		}		
	}
}

