/* Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoModelGenerationEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Поколение:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	//options.selectWinClass = AutoModelGenerationlList_Form;
	//options.selectDescrIds = options.selectDescrIds || ["descr"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 0;
	options.acController = new AutoModelGeneration_Controller(options.app);
	options.acPublicMethod = options.acController.getPublicMethod("complete_for_model");
	options.acModel = new AutoModelGenerationList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "descr";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFunction = function(f){
		var p_ind = f["prod_index"].getValue();
		var year_from = f["year_from"].getValue();
		var year_to = f["year_to"].getValue();
		return f["generation_num"].getValue()+ ((p_ind && p_ind.length)? ", "+p_ind:"") + 
			(((year_from&&year_from.length) || (year_to&&year_to.length))?
				" (" +
				((year_from&&year_from.length)? year_from : "") +
				" - " +
				((year_to&&year_to.length)? year_to : "") +
				")"
				: ""
			);
	};
	options.acOnBeforeSendQuery = function()	{
		return (this.getPublicMethod().getField("model_id").isSet());
	}
		
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	AutoModelGenerationEdit.superclass.constructor.call(this,id,options);
}
extend(AutoModelGenerationEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

