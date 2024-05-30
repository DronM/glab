/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function SupplierItemDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Номенклатура поставщика";
	options.cmdSave = true;
	options.model = (options.models&&options.models.SupplierItemDialog_Model)? options.models.SupplierItemDialog_Model : new SupplierItemDialog_Model();
	options.controller = options.controller || new SupplierItem_Controller();
	options.templateOptions = {};
	//var f_list = this.getFeatureList(options, "FEATURE_GROUPS", "item_features_list");
	var f_supl_list = this.getFeatureList(options, "SUPPLIER_FEATURE_GROUPS", "supplier_features_list");
	
	/*var supplier_id;
	if (options.model && (options.model.getRowIndex()>=0 || options.model.getNextRow()) ){	
		supplier_id = options.model.getFieldValue("suppliers_ref");
	}*/
	
	var self = this;
	options.addElement = function(){
	
		this.addElement(new ItemEdit(id+":items_ref",{
			"cmdOpen":true			
		}));	
		this.addElement(new SupplierEdit(id+":suppliers_ref",{			
		}));	

		this.addElement(new EditMoney(id+":cost",{			
			"labelCaption":"Цена поставщика:",
			"title":"Последняя закупочная цена поставщика"
		}));	
		this.addElement(new EditMoney(id+":sale_price",{			
			"labelCaption":"Розничная цена:",
			"title":"Рекомендованная розничная цена поставщика"
		}));	

		this.addElement(new EditString(id+":artikul",{			
			"labelCaption":"Артикул:",
			"title":"Уникальный код поставщика"
		}));	

		this.addElement(new EditText(id+":comment_text",{			
			"labelCaption":"Комментарий (примечание):"
		}));	

		this.addElement(new EditText(id+":comment_note",{			
			"labelCaption":"Комментарий (текст):"
		}));	

		this.addElement(new EditString(id+":supplier_item_id",{			
			"labelCaption":"ID поставщика:"
		}));	
		
		//this.addFeatureControls(self, id, f_list, "ctrl_");
		this.addFeatureControls(self, id, f_supl_list, "supl_ctrl_");
		
		this.addElement(new EditFile(id+":pictures",{
			"multipleFiles":true			
			,"showHref":true
			,"showPic":true
			,"fileInfTemplateOptions":{
				"IMG_CLASS":"item_picture"
			}
			,"onDeleteFile":function(fileId,callBack){
				self.m_attachManager.deleteAttachment(fileId,callBack);
			}
			,"onFileAdded":function(fileId){
				self.m_attachManager.addAttachment(fileId);
			}
			,"onDownload":function(fileId){
				self.m_attachManager.downloadAttachment(fileId);
			}
			,"allowedFileExtList": ["png","jpg","jpeg"]
			//constants.allowed_attachment_extesions.getValue().split(",")
		}));	
		
		this.addElement(new SupplierStoreValueList_View(id+":supplier_store_values_list",{
			"detail":true,
			"dialogView":this
		}));
	}
	
	SupplierItemDialog_View.superclass.constructor.call(this,id,options);
	
	this.m_attachManager = new AttachmentManager({"view": this, "dataType": "supplier_items", "attachmentViewName": "pictures"});
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("items_ref")})
		,new DataBinding({"control":this.getElement("suppliers_ref")})
		,new DataBinding({"control":this.getElement("cost")})
		,new DataBinding({"control":this.getElement("sale_price")})
		,new DataBinding({"control":this.getElement("pictures")})
		,new DataBinding({"control":this.getElement("artikul")})
		,new DataBinding({"control":this.getElement("comment_text")})
		,new DataBinding({"control":this.getElement("comment_note")})
		,new DataBinding({"control":this.getElement("supplier_item_id")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("items_ref"), "fieldId":"item_id"})
		,new CommandBinding({"control":this.getElement("suppliers_ref"), "fieldId":"supplier_id"})
		,new CommandBinding({"control":this.getElement("cost")})
		,new CommandBinding({"control":this.getElement("sale_price")})
		,new CommandBinding({"control":this.getElement("artikul")})
		,new CommandBinding({"control":this.getElement("comment_text")})
		,new CommandBinding({"control":this.getElement("comment_note")})
		,new CommandBinding({"control":this.getElement("comment_note")})
	];
	this.setWriteBindings(write_b);
	
	this.addDetailDataSet({
		"control":this.getElement("supplier_store_values_list").getElement("grid"),
		"controlFieldId":"supplier_item_id",
		"field":this.m_model.getField("id")
	});
	
}
extend(SupplierItemDialog_View, ItemBaseDialog_View);

//********************

