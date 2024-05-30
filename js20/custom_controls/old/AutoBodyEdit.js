/* Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 *
 * Пока не используется!!!
 */
function AutoBodyEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Кузов:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	//options.selectWinClass = AutoModelGenerationlList_Form;
	//options.selectDescrIds = options.selectDescrIds || ["descr"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 0;
	options.acController = new AutoBody_Controller(options.app);
	options.acPublicMethod = options.acController.getPublicMethod("complete_for_model");
	if(options.model_id){
		options.acPublicMethod.setFieldValue("model_id", options.model_id);
	}
	options.acModel = new AutoBodyList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "descr";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFunction = function(f){
		var p_ind = f["ind"].getValue();
		var y_from = f["year_from"].getValue();
		var y_to = f["year_to"].getValue();
		return f["name"].getValue()+ ((p_ind && p_ind.length)? ", "+p_ind:"") + ( (y_from&&y_from)?  " ("+"-"+f["year_to"].getValue()+")" : "");
	};	
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	AutoBodyEdit.superclass.constructor.call(this,id,options);
}
extend(AutoBodyEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

