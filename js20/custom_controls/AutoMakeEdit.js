/* Copyright (c) 2022
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoMakeEdit(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Марка:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = AutoMakeList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acCount = window.getApp().getServVar("popBasedCompleteCount");
	options.acController = new AutoMake_Controller(options.app);
	options.acModel = new AutoMakeList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	//options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acDescrFunction = function(f){
		var vrts = f["name_variants"].getValue();
		return f["name"].getValue() + ((vrts&&vrts.length)? " ("+vrts+")" : "");
	};	
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	options.acOnCompleteTextOut = function(textHTML,modelRow){
		var pref = "";
		if(modelRow&&modelRow.logo.getValue()){
			//Contact photo
			var p = modelRow.logo.getValue();
			if(p && p.length && p[0].dataBase64){
				pref = "<img class='selectPict' src='data:image/png;base64, "+p[0].dataBase64+"'/img>";
			}
		}
		//DOMHelper.delNodesOnClass("autoLogoPict");
		return pref + textHTML;
	};
	
	AutoMakeEdit.superclass.constructor.call(this,id,options);
}
extend(AutoMakeEdit,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

