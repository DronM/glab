/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends View
 * @requires core/extend.js
 * @requires controls/View.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function ItemPriorityCheckEdit(id,options){
	options = options || {};	
	
	options.templateOptions = {"PRIORITIES": []};
	if(options.model && options.model.getRowCount()){
		while(options.model.getNextRow()){
			options.templateOptions.PRIORITIES.push({
				"PRIOR_ID": options.model.getFieldValue("id"),
				"PRIOR_NAME": options.model.getFieldValue("name")
			});
		}
	}
	
	this.m_onChange = options.onChange;
	
	ItemPriorityCheckEdit.superclass.constructor.call(this,id,options);
}
//ViewObjectAjx,ViewAjxList
extend(ItemPriorityCheckEdit,View);

/* Constants */


/* private members */

/* protected*/
ItemPriorityCheckEdit.prototype.toDOM = function(p){
	ItemPriorityCheckEdit.superclass.toDOM.call(this, p);
	
	//add events
	var n_list = DOMHelper.getElementsByAttr("itemPriorityCheck", this.m_node, "class", false, "input");
	var self = this;
	for(var i = 0; i < n_list.length; i++){
		EventHelper.add(n_list[i], "change", function(){
			self.m_onChange();
		});
	}
}


/* public methods */
ItemPriorityCheckEdit.prototype.getValue = function(){
	//return checked items
	var res = [];
	var nodes = DOMHelper.getElementsByAttr("itemPriorityCheck", this.getNode(), "class");
	for(var i = 0; i < nodes.length; i++){
		if(nodes[i].checked === true){
			res.push(parseInt(nodes[i]["name"], 10));
		}
	}
	return res;
}
