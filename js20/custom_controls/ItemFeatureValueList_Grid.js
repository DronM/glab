/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2022

 * @extends GridAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 * @param {string} options.className
 */
function ItemFeatureValueList_Grid(id,options){
	options = options || {};
	var model = new ItemFeatureValueList_Model({
		//"sequences":{"id":0},
		//"simpleStructure": true
	});

	CommonHelper.merge(options,
	{	
		"model":model,
		"keyIds":["name"],
		"controller":new ItemFeatureValueList_Controller({"clientModel":model}),
		"editInline":true,
		"editWinClass":null,
		"inlineInsertPlace":"last",
		"popUpMenu":new PopUpMenu(),
		"commands":new GridCmdContainerAjx(id+":cmd",{
			"cmdInsert":true,
			"cmdEdit":true,
			"cmdSearch":false,
			"cmdExport":false
		}),
		"head":new GridHead(id+":head",{
			"elements":[
				new GridRow(id+":head:row0",{
					"elements":[
						new GridCellHead(id+":head:code",{
							"value":"Код",
							"columns":[
								new GridColumn({
									"field":model.getField("code")
									,"ctrlClass":EditNum
									,"ctrlBindFieldId":"code"
								})							
							]
						})
						,new GridCellHead(id+":head:name",{
							"value":"Представление",
							"columns":[
								new GridColumn({
									"field":model.getField("name")
									,"ctrlClass":EditString
									,"ctrlBindFieldId":"name"
								})							
							]
						})					
						,new GridCellHead(id+":head:descr",{
							"value":"Описание",
							"columns":[
								new GridColumn({
									"field":model.getField("descr")
									,"ctrlClass":EditString
									,"ctrlBindFieldId":"descr"
								})							
							]
						})
					]
				})
			]
		}),
		"pagination":null,				
		"autoRefresh":false,
		"refreshInterval":0,
		"rowSelect":true
	});
	
	ItemFeatureValueList_Grid.superclass.constructor.call(this,id,options);
}
extend(ItemFeatureValueList_Grid, GridAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */
ItemFeatureValueList_Grid.prototype.getValue = function(){	
	if (this.m_model){
		return this.m_model.getData();
	}
}

