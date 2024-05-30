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
function ItemFeatureQualityEdit(id,options){
	options = options || {};	
	
	/*options.templateOptions = {"QUALITIES": []};
	if(options.model && options.model.getNextRow()){
		var attrs = options.model.getFieldValue("value_attrs");		
		for(var i = 0; i < attrs.value_list.rows.length; i++){
			options.templateOptions.QUALITIES.push({
				"QUAL_ID": attrs.value_list.rows[i].fields["name"],
				"QUAL_NAME": attrs.value_list.rows[i].fields.descr
			});
		}
	}*/
	
	var self = this;
	options.elements = [
		//any
		new Control(id + ":lev_" + "any", "DIV", {
			"value": "Любой",
			"attrs":{"class":"swicth_ql swicth_ql_selected", "val": "any"},
			"events":{
				"click":function(e){											
					self.itemClick(e.target);
				}
			}
		})		
	
		//econom
		,new Control(id + ":lev_" + "econom", "DIV", {
			"value": "Эконом",
			"attrs":{"class":"swicth_ql", "val": "econom"},
			"events":{
				"click":function(e){											
					self.itemClick(e.target);
				}
			}
		})		
		//standart
		,new Control(id + ":lev_" + "standart", "DIV", {
			"value": "Стандарт",
			"attrs":{"class":"swicth_ql", "val": "standart"},
			"events":{
				"click":function(e){											
					self.itemClick(e.target);
				}
			}
		})		
		//premium
		,new Control(id + ":lev_" + "premium", "DIV", {
			"value": "Премиум",
			"attrs":{"class":"swicth_ql", "val": "premium"},
			"events":{
				"click":function(e){											
					self.itemClick(e.target);
				}
			}
		})				
	];
	
	this.m_onChange = options.onChange;
	
	ItemFeatureQualityEdit.superclass.constructor.call(this, id, "DIV", options);
}

//ViewObjectAjx,ViewAjxList
extend(ItemFeatureQualityEdit,ControlContainer);

/* Constants */


/* private members */

/* protected*/
ItemFeatureQualityEdit.prototype.itemClick = function(elem){
	if(!DOMHelper.hasClass(elem, "swicth_ql_selected")){
		var n_list = document.getElementsByClassName("swicth_ql_selected");	
		for(var i = 0; i < n_list.length; i++){
			DOMHelper.delClass(n_list[i], "swicth_ql_selected");
		}
		DOMHelper.addClass(elem, "swicth_ql_selected");
		this.m_onChange();
	}
}

/* public methods */
ItemFeatureQualityEdit.prototype.getValue = function(){
	//return checked items
	var res;
	var sel_n = DOMHelper.getElementsByAttr("swicth_ql_selected", this.getNode(), "class");
	var v;
	if(!sel_n || !sel_n.length){
		v = "any";
	}else{
		v = sel_n[0].getAttribute("val");
	}
	return (v == "any")? null : v;
}
