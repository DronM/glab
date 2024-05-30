/* Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemFolderEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Группа товаров:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = ItemFolderList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = ItemFolderList_Form;
	
	options.acMinLengthForQuery = 1;
	options.acController = new ItemFolder_Controller(options.app);
	options.acModel = new ItemFolderList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	ItemFolderEdit.superclass.constructor.call(this,id,options);
}
extend(ItemFolderEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

