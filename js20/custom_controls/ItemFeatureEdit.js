/* Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemFeatureEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Отдел:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = ItemFeatureList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acController = new ItemFeature_Controller(options.app);
	options.acModel = new ItemFeatureList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	ItemFeatureEdit.superclass.constructor.call(this,id,options);
}
extend(ItemFeatureEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

