/* Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function ManufacturerEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Производитель:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = ManufacturerList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acController = new Manufacturer_Controller(options.app);
	options.acModel = new ManufacturerList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	ManufacturerEdit.superclass.constructor.call(this,id,options);
}
extend(ManufacturerEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

