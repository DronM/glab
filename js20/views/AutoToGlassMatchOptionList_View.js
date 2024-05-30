/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function AutoToGlassMatchOptionList_View(id,options){	

	this.m_itemFeatures = options.itemFeatures;
	this.m_editOptModel = options.editOptModel;
	this.m_headId = options.headId;
	this.m_itemPriorityId = options.itemPriorityId;

	AutoToGlassMatchOptionList_View.superclass.constructor.call(this,id, options);
	
	var model = (options.models && options.models.AutoToGlassMatchOption_Model)? options.models.AutoToGlassMatchOption_Model : new AutoToGlassMatchOption_Model();
	var contr = new AutoToGlassMatchOption_Controller();
	var last_row_elements = [
		new GridCellHead(id+":grid:head:row2:body_door_view",{
			"value":"Двери",
			"columns":[
				new GridColumn({
					"field":model.getField("body_door_view"),
					"ctrlOptions":{
						"title":"Список дверей кузовов"
					}
				})
			]
		})
		,new GridCellHead(id+":grid:head:row2:body_type_view",{
			"value":"Тип",
			"columns":[
				new GridColumn({
					"field":model.getField("body_type_view"),
					"ctrlOptions":{
						"title":"Список типов кузовов"
					}
				})
			]
		})
		,new GridCellHead(id+":grid:head:row2:body_model_view",{
			"value":"Модель",
			"columns":[
				new GridColumn({
					"field":model.getField("body_model_view"),
					"ctrlOptions":{
						"title":"Список моделей кузовов"
					}
				})
			]
		})
		
	];
	
	while(this.m_itemFeatures.getNextRow()){
		last_row_elements.push(	
			new GridCellHead(id+":grid:head:row2:feature_" + this.m_itemFeatures.getFieldValue("name_lat"),{
				"value":this.m_itemFeatures.getFieldValue("name"),
				"colAttrs":{
					"title": this.m_itemFeatures.getFieldValue("comment_text")
				},
				"columns":[
					new GridColumn({
						"formatFunction":(function(nameLat){
							return function(f){
								var v = "";
								var opts = f.option_list.getValue();
								if(opts){
									for(var i = 0; i < opts.length; i ++ ){
										if(nameLat == opts[i].name_lat){
											if(opts[i].val===true){
												v = "Да";
											}else if(opts[i].val===false){
												v = "Нет";
											}else{
												v = opts[i].val;
											}
											break;
										}
									}
								}
								return v;
							}
						})(this.m_itemFeatures.getFieldValue("name_lat"))
					})
				]
			})
		);	
	}
	
	last_row_elements.push(	
		new GridCellHead(id+":grid:head:row2:quant_econom",{
			"value":"Эконом",
			"columns":[
				new GridColumn({
					"field":model.getField("quant_econom"),
					"ctrlClass":EditNum,
					"ctrlOptions":{										
						"title":"Минимальный остаток для эконом"
					}
				})
			]
		})
	);
	last_row_elements.push(	
		new GridCellHead(id+":grid:head:row2:quant_standart",{
			"value":"Стандарт",
			"columns":[
				new GridColumn({
					"field":model.getField("quant_standart"),
					"ctrlClass":EditNum,
					"ctrlOptions":{										
						"title":"Минимальный остаток для стандат"
					}
				})
			]
		})
	);
	last_row_elements.push(	
		new GridCellHead(id+":grid:head:row2:quant_premium",{
			"value":"Премиум",
			"columns":[
				new GridColumn({
					"field":model.getField("quant_premium"),
					"ctrlClass":EditNum,
					"ctrlOptions":{										
						"title":"Минимальный остаток для премиум"
					}
				})
			]
		})
	);

	var self = this;
	var popup_menu = new PopUpMenu();
	this.addElement(new GridAjx(id+":grid",{
		"contClassName":"auto_to_glass_match_opt",
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":WindowFormModalBS,
		"editWinOptions":{
			"dialogWidth":"70%"
		},
		"editViewClass":AutoToGlassMatchOptionDialog_View,
		"insertViewOptions":function(){
			return {
				"editOptModel": self.m_editOptModel,
				"itemFeatures": self.m_itemFeatures,
				"headId": self.m_headId,
				"priorityId": self.m_itemPriorityId
			}
		},
		"editViewOptions":function(){
			return {
				"editOptModel": self.m_editOptModel,
				"itemFeatures": self.m_itemFeatures,
				"headId": self.m_headId,
				"priorityId": self.m_itemPriorityId
			}
		},
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdAllCommands": false,
			"cmdSearch": false
		}),		
		"popUpMenu":popup_menu,
		"filters":null,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:row0:descr",{
							"value":options.itemPriorityDescr,
							"attrs":{"colspan": 4}
						})
						,new GridCellHead(id+":grid:head:row0:opts_head",{
							"value":"Опции",
							"attrs":{
								"colspan": this.m_itemFeatures.getRowCount(),
								"rowspan": 2
							}
						})
						,new GridCellHead(id+":grid:head:row0:quant_head",{
							"value":"Количество",
							"attrs":{
								"colspan": 3,
								"rowspan": 2
							}
						})						
					]
				})
				
				,new GridRow(id+":grid:head:row1",{
					"elements":[
						new GridCellHead(id+":grid:head:row1:eurocode_view",{
							"value":"ID",
							"attrs":{"rowspan": 2},
							"columns":[
								new GridColumn({
									"field":model.getField("eurocode_view")
								})
							]
						})
						,new GridCellHead(id+":grid:head:row1:body_head",{
							"value":"Кузова",
							"attrs":{"colspan": 3}
						})
					]
				})
				,new GridRow(id+":grid:head:row2",{
					"elements": last_row_elements
				})
				
			]
		}),
		"pagination": null,		
		"autoRefresh": false,
		"refreshInterval":null,
		"rowSelect":false,
		"focus":true
	}));	
}
extend(AutoToGlassMatchOptionList_View, ViewAjxList);

