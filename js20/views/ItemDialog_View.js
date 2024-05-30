/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2023

 * @extends ViewObjectAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 */
function ItemDialog_View(id,options){	

	options = options || {};
	options.HEAD_TITLE = "Номенклатура каталога";
	
	options.model = (options.models&&options.models.ItemDialog_Model)? options.models.ItemDialog_Model : new ItemDialog_Model();
	options.controller = options.controller || new Item_Controller();
	options.templateOptions = {};
	options.featuresFieldId = "features_list";
	
	
	var f_list = this.getFeatureList(options, "FEATURE_GROUPS", "features_list");
	var self = this;	
	options.addElement = function(){
	
		this.addElement(new AutoMakeEdit(id+":auto_makes_ref",{
			"onSelect":function(f){
				self.getElement("auto_models_ref").getAutoComplete().getPublicMethod().setFieldValue("make_id", f.id.getValue());
			},
			"onReset": function(){
				var ctrl = self.getElement("auto_models_ref");
				ctrl.reset();
				ctrl.getAutoComplete().getPublicMethod().unsetFieldValue("make_id");				
			}
		}));	
		this.addElement(new AutoModelEdit(id+":auto_models_ref",{
			"onSelect":function(f){
				self.getElement("auto_model_generations_ref").getAutoComplete().getPublicMethod().setFieldValue("model_id", f.id.getValue());
			},
			"onReset": function(){
				var ctrl = self.getElement("auto_model_generations_ref");
				ctrl.reset();
				ctrl.getAutoComplete().getPublicMethod().unsetFieldValue("model_id");				
			}
		}));	
		
		this.addElement(new AutoModelGenerationEdit(id+":auto_model_generations_ref",{
			"onSelect":function(f){
				self.getElement("auto_bodies_ref").getAutoComplete().getPublicMethod().setFieldValue("model_generation_id", f.id.getValue());
			},
			"onReset": function(){
				var ctrl = self.getElement("auto_bodies_ref");
				ctrl.reset();
				ctrl.getAutoComplete().getPublicMethod().unsetFieldValue("model_generation_id");				
			}
		}));	
		
		this.addElement(new AutoBodyEdit(id+":auto_bodies_ref",{
		}));	

		this.addElement(new ManufacturerBrandEdit(id+":manufacturer_brands_ref",{
		}));	
	
		this.addElement(new ItemFolderEdit(id+":item_folders_ref"));
		
		this.addFeatureControls(self, id, f_list, "ctrl_");
		
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
		
	}
	
	ItemDialog_View.superclass.constructor.call(this,id,options);
	
	this.m_attachManager = new AttachmentManager({"view": this, "dataType": "items", "attachmentViewName": "pictures"});
	//****************************************************	
	
	//read
	var read_b = [
		new DataBinding({"control":this.getElement("item_folders_ref")})
		,new DataBinding({"control":this.getElement("auto_makes_ref")})
		,new DataBinding({"control":this.getElement("auto_models_ref")})
		,new DataBinding({"control":this.getElement("auto_model_generations_ref")})
		,new DataBinding({"control":this.getElement("auto_bodies_ref")})
		,new DataBinding({"control":this.getElement("manufacturer_brands_ref")})
		,new DataBinding({"control":this.getElement("pictures")})
	];
	this.setDataBindings(read_b);
	
	//write
	var write_b = [
		new CommandBinding({"control":this.getElement("item_folders_ref"), "fieldId":"item_folder_id"})
		,new CommandBinding({"control":this.getElement("auto_makes_ref"), "fieldId":"auto_make_id"})
		,new CommandBinding({"control":this.getElement("auto_models_ref"), "fieldId":"auto_model_id"})
		,new CommandBinding({"control":this.getElement("auto_model_generations_ref"), "fieldId":"auto_model_generation_id"})
		,new CommandBinding({"control":this.getElement("auto_bodies_ref"), "fieldId":"auto_body_id"})
		,new CommandBinding({"control":this.getElement("manufacturer_brands_ref"), "fieldId":"manufacturer_brand_id"})
	];
	this.setWriteBindings(write_b);
}
extend(ItemDialog_View, ItemBaseDialog_View);

