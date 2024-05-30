/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ButtonCmd
 * @requires core/extend.js
 * @requires controls/ButtonCmd.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function AutoModelGenerationNextIdBtn(id,options){
	options = options || {};	
	
	options.caption = " ID ";
	options.glyph = "glyphicon-arrow-left";
	options.title = "Получить следующий ИД такого еврокода";
	
	this.m_mainView = options.mainView;
	
	var self = this;
	options.onClick = function(){
		self.click();
	};
	
	AutoModelGenerationNextIdBtn.superclass.constructor.call(this,id,options);
}
//ViewObjectAjx,ViewAjxList
extend(AutoModelGenerationNextIdBtn, ButtonCtrl);

/* Constants */


/* private members */

/* protected*/


/* public methods */
AutoModelGenerationNextIdBtn.prototype.click = function(){
	var eurocode = this.m_mainView.getElement("eurocode").getValue();
	if(!eurocode){
		this.m_mainView.getElement("eurocode").setNotValid("Не заполнено");
		return;
	}
	this.m_mainView.getElement("eurocode").setValid();
	
	var auto_model_id = this.m_mainView.getWritePublicMethod().getFieldValue("auto_model_id");
	
	pm = (new AutoModelGeneration_Controller()).getPublicMethod("gen_next_id");
	pm.setFieldValue("model_id", auto_model_id);
	pm.setFieldValue("eurocode",eurocode);
	window.setGlobalWait(true);	
	var self = this;
	pm.run({
		"ok":function(resp){			
			var m = new ModelXML("AutoModelGenerationNextId_Model", {
				"fields":[
					new FieldString("id")
				],
				"data":resp.getModelData("AutoModelGenerationNextId_Model")
			});
			if(m.getNextRow()){
				self.m_mainView.getElement("local_id").setValue(m.getFieldValue("id"));	
			}
			
		}
		,"all":function(){
			window.setGlobalWait(false);
		}
	});
}
