/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function AutoMakeDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Марка";
	options.model = (options.models&&options.models.AutoMakeList_Model)? options.models.AutoMakeList_Model : new AutoMakeList_Model();
	options.controller = options.controller || new AutoMake_Controller();
	
	var self = this;
	options.addElement = function(){
	
		this.addElement(new EditString(id+":name",{
			"labelCaption": "Наименование:",
			"maxLength":250
		}));	
		this.addElement(new EditString(id+":name_variants",{
			"labelCaption": "Варианты наименования:",
			"maxLength":5000
		}));	

		this.addElement(new PopularityTypeEdit(id+":popularity_types_ref",{
			"labelCaption": "Популярность:",
			"required": true
		}));	
		
		this.addElement(new EditFile(id+":logo",{
			"multipleFiles":false			
			,"showHref":true
			,"showPic":true
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
		
		this.addElement(new AutoModelList_View(id+":auto_model_list",{"detail":true}));
	}
	
	AutoMakeDialog_View.superclass.constructor.call(this,id,options);
	
	this.m_attachManager = new AttachmentManager({"view": this, "dataType": "auto_makes", "attachmentViewName": "logo"});
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("name")})
		,new DataBinding({"control":this.getElement("name_variants")})
		,new DataBinding({"control":this.getElement("popularity_types_ref")})
		,new DataBinding({"control":this.getElement("logo")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("name")})
		,new CommandBinding({"control":this.getElement("name_variants")})
		,new CommandBinding({"control":this.getElement("popularity_types_ref"), "fieldId":"popularity_type_id"})
	];
	this.setWriteBindings(write_b);

	this.addDetailDataSet({
		"control":this.getElement("auto_model_list").getElement("grid"),
		"controlFieldId": ["auto_make_id"],
		"value": [function(){
			return self.m_model.getFieldValue("id");
		}]
	});
	
}
extend(AutoMakeDialog_View, ViewObjectAjx);

//********************

