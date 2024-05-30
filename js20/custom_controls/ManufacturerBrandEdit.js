/* Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function ManufacturerBrandEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Брэнд:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = ManufacturerBrandList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acController = new ManufacturerBrand_Controller(options.app);
	options.acModel = new ManufacturerBrandList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	options.acDescrFunction = function(f){
		var b = f["manufacturers_ref"].getValue();
		return f["name"].getValue() + " (" + b.getDescr() + ")";
	};
	
	ManufacturerBrandEdit.superclass.constructor.call(this,id,options);
}
extend(ManufacturerBrandEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

