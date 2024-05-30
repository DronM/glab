/** Copyright (c) 2023
 *	Andrey Mikhalevich, Katren ltd.
 */
function ItemSearchResult_View(id,options){	

	ItemSearchResult_View.superclass.constructor.call(this,id,options);

	var model = new ItemSearchResult_Model();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":null,
		"editInline":true,
		"editWinClass":null,
		"commands":null,		
		"popUpMenu":null,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:item_priorities_ref",{
							"value":"Тип",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_priorities_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:auto_makes_ref",{
							"value":"Марка",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_makes_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:auto_models_ref",{
							"value":"Модель",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_models_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:auto_model_generations_ref",{
							"value":"Поколение",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_model_generations_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:auto_bodies_ref",{
							"value":"Кузов",
							"columns":[
								new GridColumnRef({
									"field":model.getField("auto_bodies_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:item_folders_ref",{
							"value":"Группа",
							"columns":[
								new GridColumnRef({
									"field":model.getField("item_folders_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:suppliers_ref",{
							"value":"Поставщик",
							"columns":[
								new GridColumnRef({
									"field":model.getField("suppliers_ref")
								})
							]
						})
						,new GridCellHead(id+":grid:head:features_list",{
							"value":"Опции",
							"columns":[
								new GridColumn({
									"field":model.getField("features_list"),
									"formatFunction":function(fields){
										var res = "";
										var val = fields.features_list.getValue();
										if(!val){
											return res;
										}
										for (var i = 0; i < val.length; i++){
											if(res != ""){
												res+= ", ";
											}
											if(val[i].val_type == "dt_list"){
												res+= "[" + val[i].val + "]";//value only
												
											}else if(val[i].val_type == "dt_bool"){
												res+= "[" + val[i]["name"] + "]";//name only
												
											}else if(val[i].val_type == "dt_float"){
												res+= "[" + val[i]["name"] + ":"+ parseFloat(val[i].val) + "]";
											
											}else{
												res+= "[" + val[i]["name"] + ":"+ val[i].val + "]";
											}
											
										}
										return res;
									}									
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:cost",{
							"value":"Цена пост.",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("cost"),
									"precision":"2"
								})
							]
						})
						,new GridCellHead(id+":grid:head:sale_price",{
							"value":"Цена розн.",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("sale_price"),
									"precision":"2"
								})
							]
						})
						,new GridCellHead(id+":grid:head:artikul",{
							"value":"Артикл",
							"columns":[
								new GridColumn({
									"field":model.getField("artikul")
								})
							]
						})
						,new GridCellHead(id+":grid:head:comment_text",{
							"value":"Коммент.",
							"columns":[
								new GridColumn({
									"field":model.getField("comment_text")
								})
							]
						})
						
						,new GridCellHead(id+":grid:head:comment_note",{
							"value":"Примеч.",
							"columns":[
								new GridColumn({
									"field":model.getField("comment_note")
								})
							]
						})
						,new GridCellHead(id+":grid:head:stores_list",{
							"value":"Наличие",
							"columns":[
								new GridColumn({
									"field":model.getField("stores_list"),
									"formatFunction":function(fields){
										var res = "";
										var val = fields.stores_list.getValue();
										for (var i = 0; i < val.length; i++){
											if(res != ""){
												res+= ", ";
											}
											res+= val[i].store_name+": "+val[i].val;
										}
										return res;
									}
								})
							]
						})						
					]
				})
			]
		}),
		"pagination": null,				
		"autoRefresh":false,
		"refreshInterval": null,
		"rowSelect":false,
		"focus":true
	}));	
	
}
extend(ItemSearchResult_View, View);
