
/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2024
 
 * @class
 * @classdesc
	
 * @param {string} id view identifier
 * @param {namespace} options
 */	
function FinExpenseTypeItemEdit(id,options){
	let self = this;

	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Элемент:";
	}
	options.cmdInsert = true; 
	options.insertOnClick = function(){
		let nm = self.getNode().value;
		if(nm && nm.length > 0 && nm.trim().length>0){
			let pm = (new FinExpenseType_Controller()).getPublicMethod("insert");
			pm.setFieldValue("parent_id", self.m_parentId);	
			pm.setFieldValue("lev", self.m_lev);	
			pm.setFieldValue("name", nm);	
			pm.run({
				"ok":function(resp){
					debugger
					let model = resp.getModel("InsertedKey");
					if(model && model.getNextRow()){
						let new_id = model.getFieldValue("id");
						let n = self.getNode();
						DOMHelper.delClass(n, "null-ref");
						self.setValue(new RefType({"keys": {"id": new_id}, "descr": nm}));
						self.setValid();
					}
				}
			});
		}
	}

	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = FinExpenseTypeItemList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	options.selectWinParams = function(){
		return {
			"cond_fields":"parent2_id",
			"cond_sgns":"e",
			"cond_vals":self.m_parentId
		}
	}
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 0;
	options.acController = new FinExpenseType_Controller(options.app);
	// options.acPublicMethod = options.acController.getPublicMethod("get_item_list");
	
	options.acModel = new FinExpenseTypeList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	FinExpenseTypeItemEdit.superclass.constructor.call(this,id,options);
	
	this.setParentId("null");

	this.m_lev = options.lev;
}
extend(FinExpenseTypeItemEdit, EditRef);

FinExpenseTypeItemEdit.prototype.setParentId = function(id) {
	this.m_parentId = id;
	let pm = this.getAutoComplete().getPublicMethod("complete");
	let cond_fields = "parent_id@@lev@@deleted";
	let cond_vals = id +"@@"+ this.m_lev+"@@0";
	let cond_sgns = ((id=="null")? "i" : "e");
	cond_sgns+= "@@e@@e";
	pm.setFieldValue("cond_fields", cond_fields);
	pm.setFieldValue("cond_vals", cond_vals); 
	pm.setFieldValue("cond_sgns", cond_sgns); 
}
