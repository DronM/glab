/* Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoModelEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Модель:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = AutoModelList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 0;
	options.acController = new AutoModel_Controller(options.app);
	options.acCount = window.getApp().getServVar("popBasedCompleteCount");
	options.acPublicMethod = options.acController.getPublicMethod("complete_for_make");
	options.acModel = new AutoModelList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFunction = function(f){
		var variants = f["name_variants"].getValue();
		return f["name"].getValue() + ((variants&&variants.length)? " ("+variants+")" : "");
	};
	options.acOnBeforeSendQuery = function()	{
		return (this.getPublicMethod().getField("make_id").isSet());
	}
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	AutoModelEdit.superclass.constructor.call(this,id,options);
}
extend(AutoModelEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

