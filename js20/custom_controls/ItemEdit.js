/* Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Номенклатура:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = ItemList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = Item_Form;
	
	options.acMinLengthForQuery = 1;
	options.acController = new Item_Controller(options.app);
	options.acPublicMethod = options.acController.getPublicMethod("complete");
	options.acModel = new ItemList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	/*options.acDescrFunction = function(f){
		return f["name"].getValue()+" ("+f["name_variants"].getValue()+")";
	};*/	
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	ItemEdit.superclass.constructor.call(this,id,options);
}
extend(ItemEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

