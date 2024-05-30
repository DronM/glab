/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function ItemBaseDialog_View(id,options){	

	options = options || {};
	
	ItemBaseDialog_View.superclass.constructor.call(this,id,options);
}
extend(ItemBaseDialog_View, ViewObjectAjx);

//********************
ItemBaseDialog_View.prototype.getFeatureList = function(options, featureGrId, featuresFieldId){
	var f_list;
	if (options.model && (options.model.getRowIndex()>=0 || options.model.getNextRow()) ){	
		f_list = options.model.getFieldValue(featuresFieldId);
		options.templateOptions[featureGrId] = [];
		if(!f_list){
			return f_list;
		}
		var gr;
		for(var i = 0; i < f_list.length; i++){			
			if(!gr || gr.ID != f_list[i].item_feature_groups_ref.m_keys.id){
				//new group
				gr = {
					"ID": f_list[i].item_feature_groups_ref.m_keys.id,
					"DESCR": f_list[i].item_feature_groups_ref.m_descr,
					"FEATURES": []
				};
				options.templateOptions[featureGrId].push(gr);
			}			
			gr.FEATURES.push({
				"ID": f_list[i].item_features_ref.m_keys.id
			});			
		}
	}
	return f_list;
}

ItemBaseDialog_View.prototype.addFeatureControls = function(self, id, featureList, ctrlPref){
	if(featureList){
		var app = window.getApp();
		for(var i = 0; i < featureList.length; i ++){
			var attrs = featureList[i].item_features_attrs;
			console.log(attrs)
			if(!attrs){
				continue;
			}
			var ctrl_id = featureList[i].item_features_ref.m_keys.id;
			var ctrl = app.getItemFeatureEditCtrl(
				attrs,
				id+":"+ctrlPref,
				ctrl_id,
				featureList[i].val,
				function(featureId, val){
					self.setFeatureValue(featureId, val);
				}
			);
			/*
			var ctrl;
			//types describe in ItemFeatureDataType_View
			switch(attrs.value_attrs.data_type) {
				case 'dt_list':
					var opts = [];
					var rows = attrs.value_attrs.value_list.rows;
					for (j = 0; j < rows.length; j++){
						opts.push(
							new EditSelectOption(id+":"+ctrlPref+ctrl_id+":opt_"+j,{
								"value": rows[j].fields["name"],
								"descr": rows[j].fields.descr,
								"checked": (featureList[i].val && featureList[i].val==rows[j].fields["name"])
							})
						);
					}
					ctrl = new EditSelect(id+":"+ctrlPref+ctrl_id,{
						"labelCaption": attrs.comment_text+":",
						"elements": opts,
						"attrs":{"feature_id": ctrl_id},
						"events":{
							"change":(function(){
								return function(){
									self.setFeatureValue(this.getAttr("feature_id"), this.getValue());
								}
							})()
						}
					});
					break;
				case 'dt_int':
					ctrl = new EditInt(id+":"+ctrlPref+ctrl_id,{
						"cmdSelect": false,
						"labelCaption": attrs.comment_text+":",
						"attrs":{"feature_id": ctrl_id},
						"events":{
							"input":(function(){
								return function(){
									self.setFeatureValue(this.getAttr("feature_id"), this.getValue());
								}
							})()
						},
						"value": parseInt(featureList[i].val, 10)
					});
					break;
				case 'dt_float':
					ctrl = new EditFloat(id+":"+ctrlPref+ctrl_id,{
						"cmdSelect": false,
						"labelCaption": attrs.comment_text+":",
						"length": attrs.value_attrs.value_length,
						"precision": attrs.value_attrs.value_precision,
						"attrs":{"feature_id": ctrl_id},
						"events":{
							"input":(function(){
								return function(){
									self.setFeatureValue(this.getAttr("feature_id"), this.getValue());
								}
							})()
						},
						"value": parseFloat(featureList[i].val)
					});
					break;
				case 'dt_string':
					ctrl = new EditString(id+":"+ctrlPref+ctrl_id,{
						"labelCaption": attrs.comment_text+":",
						"maxLength": attrs.value_attrs.value_length,
						"attrs":{"feature_id": ctrl_id},
						"events":{
							"input":(function(){
								return function(){
									self.setFeatureValue(this.getAttr("feature_id"), this.getValue());
								}
							})()
						},
						"onReset": function(){
							self.setFeatureValue(this.getAttr("feature_id"), "");
						},
						"value": featureList[i].val
					});
					break;
				case 'dt_bool':
					ctrl = new EditCheckBox(id+":"+ctrlPref+ctrl_id,{
						"labelCaption": attrs.comment_text+":",
						"attrs":{"feature_id": ctrl_id},
						"events":{
							"change":(function(){
								return function(){
									self.setFeatureValue(this.getAttr("feature_id"), this.getValue());
								}
							})()
						},
						"checked": (featureList[i].val=="true")
					})
					break;
			}
			*/
			/*
			if(!ctrl){
				throw new Error("Unknown data type: "+attrs.value_attrs.data_type);
			}
			*/
			this.addElement(ctrl);
		}
	}
}

ItemBaseDialog_View.prototype.setFeatureValue = function(featureId, val){
	//console.log("FeatureID="+featureId+" val="+val)
	var pm = this.getController().getPublicMethod("set_feature");
	pm.setFieldValue("item_id", this.getElement("id").getValue());
	pm.setFieldValue("feature_id", featureId);
	pm.setFieldValue("val", val? val.toString() : "null");
	pm.run();
}
	
	
