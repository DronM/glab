/* Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function SupplierStoreEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Место хранения поставщика:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = SupplierStoreList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acController = new SupplierStore_Controller(options.app);
	options.acPublicMethod = options.acController.getPublicMethod("complete_for_supplier");
	if(options.supplier_id){
		options.acPublicMethod.setFieldValue("supplier_id", options.supplier_id);
	}
	options.acOnBeforeSendQuery = function()	{
		return (this.getPublicMethod().getField("supplier_id").isSet());
	}
	
	options.acModel = new SupplierStoreList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	SupplierStoreEdit.superclass.constructor.call(this,id,options);
}
extend(SupplierStoreEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */
SupplierStoreEdit.prototype.setSupplierId = function(supplierId){
	this.getPublicMethod().setFieldValue("supplier_id", supplierId);
}
