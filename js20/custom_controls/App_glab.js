/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022
 
 * @class
 * @classdesc
	
 * @param {object} options
 */	
function App_glab(options){
	options = options || {};
	options.lang = "ru";
	options.paginationClass = Pagination;

	console.log(options.servVars)
	this.setColorClass(options.servVars.color_palette);

	App_glab.superclass.constructor.call(this,"dpassport",options);	
}
extend(App_glab,App);

/* Constants */
App_glab.prototype.SERV_RESPONSE_MODEL_ID = "Response";
App_glab.prototype.EVENT_MODEL_ID = "Event";
App_glab.prototype.INSERTED_KEY_MODEL_ID = "InsertedKey";

App_glab.prototype.m_colorClass;
/* private members */

/* protected*/

App_glab.prototype.getColorClass = function(){
	return this.m_colorClass;
}
App_glab.prototype.setColorClass = function(v){
	this.m_colorClass = v;
}

/* public methods */
App_glab.prototype.getSidebarId = function(){
	return this.getServVar("user_name")+"_"+"sidebar-xs";
}
App_glab.prototype.toggleSidebar = function(){
	var id = this.getSidebarId();
	this.storageSet(id,(this.storageGet(id)=="xs")? "":"xs");
}


App_glab.prototype.makeItemCurrent = function(elem){
	if (elem){		
		var l = DOMHelper.getElementsByAttr("active", document.body, "class", false, "LI");
		for(var i=0; i < l.length; i++){
			//DOMHelper.delClass(l[i], "active");
			//groups!!!						
			var ch_l = DOMHelper.getElementsByAttr("has-ul", l[i], "class", true, "A");
			if(!ch_l || !ch_l.length){
				//not a group
				DOMHelper.delClass(l[i], "active");
			}
		}
		var it = (elem.tagName.toUpperCase()=="LI")? elem:elem.parentNode;
		DOMHelper.addClass(it, "active");
		/*if (elem.nextSibling){
			elem.nextSibling.style="display: block;";
		}*/
		var p = DOMHelper.getParentByTagName(it, "LI");
		if(p && !DOMHelper.hasClass(p, "active")){
			DOMHelper.addClass(p, "active");
			var ch_l = DOMHelper.getElementsByAttr("hidden-ul", p, "class", true, "UL");
			if(ch_l && ch_l.length){
				ch_l[0].style="display: block;";
			}
		}
	}
}

App_glab.prototype.showMenuItem = function(item,c,f,t,extra,title){
	App_glab.superclass.showMenuItem.call(this,item,c,f,t,extra,title);
	this.makeItemCurrent(item);
}

App_glab.prototype.formatError = function(erCode,erStr){
	return (erStr +( (erCode)? (", код:"+erCode):"" ) );
}

App_glab.prototype.getItemFeatureEditCtrl = function(attrs, ctrlPref, ctrlId, featurVal, setFeatureValue){
	var ctrl;
	switch(attrs.value_attrs.data_type) {
		case 'dt_list':
			var opts = [];
			var rows = attrs.value_attrs.value_list.rows;
			for (j = 0; j < rows.length; j++){
				opts.push(
					new EditSelectOption(ctrlPref+ctrlId+":opt_"+j,{
						"value": rows[j].fields["name"],
						"descr": rows[j].fields["name"],
						//(rows[j].fields.descr && rows[j].fields.descr.length)? rows[j].fields.descr : rows[j].fields["name"],
						"checked": (featurVal && featurVal==rows[j].fields["name"])
					})
				);
			}
			ctrl = new EditSelect(ctrlPref+ctrlId,{
				"labelCaption": attrs.comment_text+":",
				"elements": opts,
				"attrs":{"feature_id": ctrlId},
				"events":{
					"change":(function(){
						return function(){
							if(setFeatureValue){
								setFeatureValue(this.getAttr("feature_id"), this.getValue());
							}
						}
					})()
				}
			});
			break;
		case 'dt_int':
			ctrl = new EditInt(ctrlPref+ctrlId,{
				"cmdSelect": false,
				"labelCaption": attrs.comment_text+":",
				"attrs":{"feature_id": ctrlId},
				"events":{
					"input":(function(){
						return function(){
							if(setFeatureValue){
								setFeatureValue(this.getAttr("feature_id"), this.getValue());
							}
						}
					})()
				},
				"value": parseInt(featurVal, 10)
			});
			break;
		case 'dt_float':
			ctrl = new EditFloat(ctrlPref+ctrlId,{
				"cmdSelect": false,
				"labelCaption": attrs.comment_text+":",
				"length": attrs.value_attrs.value_length,
				"precision": attrs.value_attrs.value_precision,
				"attrs":{"feature_id": ctrlId},
				"events":{
					"input":(function(){
						return function(){
							if(setFeatureValue){
								setFeatureValue(this.getAttr("feature_id"), this.getValue());
							}
						}
					})()
				},
				"value": parseFloat(featurVal)
			});
			break;
		case 'dt_string':
			ctrl = new EditString(ctrlPref+ctrlId,{
				"labelCaption": attrs.comment_text+":",
				"maxLength": attrs.value_attrs.value_length,
				"attrs":{"feature_id": ctrlId},
				"events":{
					"input":(function(){
						return function(){
							if(setFeatureValue){
								setFeatureValue(this.getAttr("feature_id"), this.getValue());
							}
						}
					})()
				},
				"onReset": function(){
					setFeatureValue(this.getAttr("feature_id"), "");
				},
				"value": featurVal
			});
			break;
		case 'dt_bool':
			ctrl = new EditCheckBox(ctrlPref+ctrlId,{
				"labelCaption": attrs.comment_text+":",
				"attrs":{"feature_id": ctrlId},
				"events":{
					"change":(function(){
						return function(){
							if(setFeatureValue){
								setFeatureValue(this.getAttr("feature_id"), this.getValue());
							}
						}
					})()
				},
				"checked": (featurVal=="true")
			})
			break;
	}
	return ctrl;
}


App_glab.prototype.fetchUserOperationResult = function(operationID, callback){
	if(!callback){
		return;
	}
	let pm = (new UserOperation_Controller()).getPublicMethod("get_object");
	pm.setFieldValue("user_id", window.getApp().getServVar("user_id"));
	pm.setFieldValue("operation_id", operationID); 
	pm.run({
		"ok":function(resp){
            let m = resp.getModel("UserOperationDialog_Model");
			if(!m || !m.getNextRow()){
				return;
			}
			callback(m.getFields());
		}
	});
}
App_glab.prototype.fetchUserOperationError = function(operationID, callback){
	if(!callback){
		return;
	}
	this.fetchUserOperationResult(operationID, function(f){
		callback(f.error_text.getValue());
	});
}

App_glab.prototype.startOperationMonitor = function(cont, onOk, onError){	
	var srv = this.getAppSrv();
	if(!srv || !srv.connActive()){
		return;
	}
	let operation_id = CommonHelper.md5(DateHelper.time().toString());
	var self = this;		
	cont.unsubscribeFromSrvEvents();
	cont.subscribeToSrvEvents({
		"events":[
			{"id":"UserOperation." + operation_id}
			,{"id":"UserOperation." + operation_id} 
		]
		,"onEvent":function(json){
			if(json.controllerId == "UserOperation" && json.methodId == operation_id){
				if(json.params.status=="end"){
					if(json.params.res){
						onOk(json.params);
					}else{
						self.fetchUserOperationError(json.params.operation_id, function(err){
							onError(err, json.params);
						});

					}
				}
			}
		}
	});
	return operation_id;
}

App_glab.prototype.getDefaultCashLocation = function(){
	return new RefType({"keys": {"id": 1}, "descr":"Касса"});
}
