package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 14/02/2023
 *
 * This is SupplierItem controller implimentation file.
 *
 */

import (
	"reflect"
	"context"
	"strings"
	"encoding/base64"
	"bytes"
	"fmt"
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	"github.com/dronm/gobizap/fields"
	
	rep_att "github.com/dronm/gobizap/repo/docAttachment"
	
	"github.com/jackc/pgx/v5"
)

//Method implemenation insert
func (pm *SupplierItem_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierItem"], &models.SupplierItem_keys{}, sock.GetPresetFilter("SupplierItem"))	
}

//Method implemenation delete
func (pm *SupplierItem_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierItem"], sock.GetPresetFilter("SupplierItem"))	
}

//Method implemenation get_object
func (pm *SupplierItem_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierItemDialog"], &models.SupplierItemDialog{}, sock.GetPresetFilter("SupplierItemDialog"))	
}

//Method implemenation get_list
func (pm *SupplierItem_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["SupplierItemList"], &models.SupplierItemList{}, sock.GetPresetFilter("SupplierItemList"))	
}

//Method implemenation update
func (pm *SupplierItem_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["SupplierItem"], sock.GetPresetFilter("SupplierItem"))	
}

type importObj struct {
	Id fields.ValInt
	Descr string
}

type supplierItemFeature struct {
	Id int `json:"id"`
	Name string `json:"name"`
	Val string `json:"val"`
}
type supplierItemObj struct {
	Id fields.ValInt
	Sale_price fields.ValFloat
	Cost fields.ValFloat
	Features []supplierItemFeature
}

func (pm *SupplierItem_Controller_set_feature) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	//db connect
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err_с := d_store.GetPrimary()
	if err_с != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("SupplierItem_Controller_set_feature GetPrimary(): %v",err_с))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	//*****************
	
	args := rfltArgs.Interface().(*models.SupplierItem_set_feature)

	var p_val *string
	if args.Val.GetIsSet() {
		s := args.Val.GetValue()
		if s !="" && s!= "null"{
			p_val = &s
		}
	}
	var err error
	if p_val == nil {
		//delete feature
		_, err = conn.Exec(context.Background(),
			`DELETE FROM supplier_item_feature_vals WHERE supplier_item_id = $1 AND item_feature_id = $2`,
			args.Item_id.GetValue(), args.Feature_id.GetValue())
	
	}else{
		_, err = conn.Exec(context.Background(),
			`INSERT INTO supplier_item_feature_vals
			(supplier_item_id, item_feature_id, val)
			VALUES ($1, $2, $3)
			ON CONFLICT (supplier_item_id, item_feature_id) DO UPDATE
			SET val = $3`,
			args.Item_id.GetValue(), args.Feature_id.GetValue(), p_val)
	}
	return err
}

func (pm *SupplierItem_Controller_get_features_filter_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	//db connect
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err_с := d_store.GetSecondary("")
	if err_с != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("SupplierItem_Controller_get_features_filter_list GetPrimary(): %v",err_с))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	//*****************

	filters_md := &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(featureFilter{})),
		ID: "FeaturesFilterList_Model",
	}
	return gobizap.AddQueryResult(resp, filters_md, &featureFilter{}, "SELECT features FROM supplier_item_features_filter_list", "", nil, conn, false)
}
//******************************************
//Method implemenation import
func (pm *SupplierItem_Controller_import) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	//All feature IDs
	feature_list := make([]*models.SupplierItem_import_item_feature, 0)
	item_f_rows, err := conn.Query(context.Background(), 
		`SELECT
			id,
			name_lat,
			name,
			coalesce(value_attrs->>'data_type', '')
		FROM item_features
		WHERE coalesce(name_lat, '') <>''`)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("SupplierItem_Controller_import pgx.Conn.Query(): %v",err))
	}
	for item_f_rows.Next() {
		f := models.SupplierItem_import_item_feature{}		
		if err := item_f_rows.Scan(&f.Db_id, &f.Id, &f.Db_descr, &f.Db_data_type); err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("SupplierItem_Controller_import SELECT item_features pgx.Conn.Scan(): %v",err))
		}
		feature_list = append(feature_list, &f)
	}
	if err := item_f_rows.Err(); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("SupplierItem_Controller_import pgx.Conn.Next(): %v",err))
	}
	
	args := rfltArgs.Interface().(*models.SupplierItem_import)
	
	make_list := make([]*importObj, 0)
	model_list := make([]*importObj, 0)
	model_gen_list := make([]*importObj, 0)
	bod_list := make([]*importObj, 0)
	supplier_list := make([]*importObj, 0)
		
	for _, it := range args.Items {
		//make
		make_obj := pm.checkMake(app, conn, it, &make_list)
		if make_obj == nil {
			continue
		}
fmt.Println("Found make")		
		//model
		model_obj := pm.checkModel(app, conn, it, make_obj.Id.GetValue(), &model_list)
		if model_obj == nil {
			continue
		}
fmt.Println("Found model")		
		//model generation
		model_gen_obj := pm.checkModelGeneration(app, conn, it, model_obj.Id.GetValue(), &model_gen_list)
		if model_gen_obj == nil {
			continue
		}
fmt.Println("Found model generation")		
		//body
		body_obj := pm.checkBody(app, conn, it, model_gen_obj.Id.GetValue(), &bod_list)
		if body_obj == nil {
			continue
		}
fmt.Println("Found body")		
		//supplier
		supplier_obj := pm.checkSupplier(app, conn, it, &supplier_list)
		if supplier_obj == nil {
			continue
		}
fmt.Println("Found supplier")				
		//item
		item_obj := pm.checkItem(app, conn, it, make_obj, model_obj, model_gen_obj, body_obj)
		if item_obj == nil {
			continue
		}
fmt.Println("Found item")								
		//supplier item
		supplier_item_obj := pm.checkSupplierItem(app, conn, it, item_obj, supplier_obj)
		if supplier_item_obj == nil {
			continue
		}
		
		//update picture if any
		if it.Picture != "" {
			picture, err := base64.StdEncoding.DecodeString(it.Picture)
			if err != nil {
				pm.logError(app, conn, it, fmt.Sprintf("SupplierItem_Controller_import base64.StdEncoding.DecodeString: %v", err))
			}else{
				file := bytes.NewReader(picture)
				args := rep_att.Attachment_add_file{}
				args.Content_info.Name = "api.jpeg"
				args.Ref = rep_att.Ref_Type{DataType: "supplie_items", Keys: rep_att.AttachmentKey{Id: rep_att.HttpInt(item_obj.Id.GetValue())}}
				_, err := rep_att.AddFileThumbnailToDb(conn, app.GetBaseDir(), file, &args.Content_info, &args.Ref);
				if err != nil {
					pm.logError(app, conn, it, fmt.Sprintf("SupplierItem_Controller_import rep_attAddFileThumbnailToDb: %v", err))
				}
			}
		}
		
		//update supplier ite attrs: price, cost
		var item_attrs_q strings.Builder
		item_attrs_cnt := 0
		item_attrs_params := make([]interface{}, 0)
		if it.Sale_price != 0 && it.Sale_price != supplier_item_obj.Sale_price.GetValue() {			
			if item_attrs_cnt > 0 {
				item_attrs_q.WriteString(",")
			}
			item_attrs_cnt++
			item_attrs_q.WriteString(fmt.Sprintf(`sale_price = $%d`, item_attrs_cnt))
			item_attrs_params = append(item_attrs_params, it.Sale_price)
		}
		if it.Cost != 0 && it.Cost != supplier_item_obj.Cost.GetValue() {
			if item_attrs_cnt > 0 {
				item_attrs_q.WriteString(",")
			}
			item_attrs_cnt++
			item_attrs_q.WriteString(fmt.Sprintf(`cost = $%d`, item_attrs_cnt))
			item_attrs_params = append(item_attrs_params, it.Cost)
		}
		if item_attrs_cnt > 0 {
			if _, err := conn.Exec(
				context.Background(),
				fmt.Sprintf(`UPDATE supplier_items
				SET %s
				WHERE id = %d`, item_attrs_q.String(), supplier_item_obj.Id.GetValue()),
				item_attrs_params...,
			); err != nil {
				pm.logError(app, conn, it, fmt.Sprintf("ошибка обновлния товара: %v", err))
				return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("SupplierItem_Controller_import UPDATE supplier_items pgx.Conn.Exec(): %v",err)) 
			}
		}
		
fmt.Println("Found supplier item")						
		//import feature values
		var f_query_body strings.Builder
		f_query_cnt := 0
		f_query_params := make([]interface{}, 0)
		for imp_f_i, _ := range it.Options {
			import_f := &it.Options[imp_f_i]
			if string(import_f.Val) == `""` || strings.ToLower(string(import_f.Val)) == "null" {
				continue
			}
fmt.Println("Lookig for option:", import_f.Id, "Val=", string(import_f.Val))			
			//check feature value
			var feature_for_import *models.SupplierItem_import_item_feature
			for _,f := range feature_list { //iterate over all possible features
				if f.Id == import_f.Id {
					import_f.Db_id = f.Db_id
					import_f.Db_descr = f.Db_descr
					import_f.Db_data_type = f.Db_data_type
					feature_for_import = f
					break
				}
			}
			if feature_for_import == nil {
				//feature not found!
				pm.logError(app, conn, it, fmt.Sprintf("неизвестная опция: %s", import_f.Id))
				break			
			}
			//var v_string *string
			//var v_int *int
			//var v_float *float32
			//var v_bool *bool			
			var v_typed interface{}
			var cast_err error
			//cast to type
			switch feature_for_import.Db_data_type {
			case "bool":
				v_typed, cast_err = fields.StrToBool(string(import_f.Val))
			case "int":
				v_typed, cast_err = fields.StrToInt(string(import_f.Val))
			case "float":
				v_typed, cast_err = fields.StrToFloat(string(import_f.Val))
			default:
				v_typed = fields.ExtRemoveQuotes(import_f.Val)
			}
			if cast_err != nil {
				pm.logError(app, conn, it, fmt.Sprintf("ошибка типа значения опции: %v", err))
				break
			}
			
			upd_f := true //new feature or new value
			for _, item_f := range supplier_item_obj.Features {
				if item_f.Name == import_f.Id {
					upd_f = (item_f.Val != string(import_f.Val))
					break
				}
			}
			if upd_f {
				if f_query_cnt > 0 {
					f_query_body.WriteString(",")
				}
				f_query_cnt++
				f_query_body.WriteString(fmt.Sprintf("(%d, %d, $%d)", feature_for_import.Db_id, item_obj.Id.GetValue(), f_query_cnt))
				f_query_params = append(f_query_params, v_typed)
			}
		}
		if f_query_cnt > 0 {
fmt.Println("Updating items", fmt.Sprintf(`INSERT INTO item_feature_vals (item_feature_id, item_id, val)
					VALUES %s
					ON CONFLICT (item_feature_id, item_id)
					DO UPDATE SET
						val = excluded.val,
						date_time = now()`,
					f_query_body.String(),
				))																
fmt.Println("f_query_params=",f_query_params);				
			if _, err := conn.Exec(
				context.Background(),
				fmt.Sprintf(`INSERT INTO item_feature_vals (item_feature_id, item_id, val)
					VALUES %s
					ON CONFLICT (item_feature_id, item_id)
					DO UPDATE SET val = excluded.val`,
					f_query_body.String(),
				),				
				f_query_params...,
			); err != nil {
				pm.logError(app, conn, it, fmt.Sprintf("ошибка добавления значений опций: %v", err))
				return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("SupplierItem_Controller_import INSERT INTO item_feature_vals pgx.Conn.Exec(): %v",err)) 
			}
		}
	}
	
	return nil	
}

func (pm *SupplierItem_Controller_import) checkSupplierItem(app gobizap.Applicationer, conn *pgx.Conn, it models.SupplierItem_import_item, itemObj, supplierObj *importObj) *supplierItemObj {
	o := &supplierItemObj{}
	if err := conn.QueryRow(context.Background(),
		`SELECT
			s_it.id,
			coalesce(s_it.sale_price, 0),
			coalesce(s_it.cost, 0),
			(SELECT
				json_agg(
					json_build_object(
						'val', f_vals.val,
						'name', f.name_lat,
						'id', f_vals.item_feature_id
					)
				)
			FROM item_feature_vals AS f_vals
			LEFT JOIN item_features As f ON f.id = f_vals.item_feature_id
			WHERE f_vals.item_id = s_it.item_id
			) AS features
		FROM supplier_items AS s_it
		WHERE s_it.item_id = $1 AND s_it.supplier_id = $2`,
		itemObj.Id,
		supplierObj.Id,
	).Scan(&o.Id, &o.Sale_price, &o.Cost, &o.Features); err != nil && err != pgx.ErrNoRows {		
		pm.logError(app, conn, it, fmt.Sprintf("ошибка поиска товара поставщика: %v", err))
		return nil
		
	}else if err != nil && err != pgx.ErrNoRows {
		pm.logError(app, conn, it, "товара поставщика не найден")
		return nil
	}
	return o
}

func (pm *SupplierItem_Controller_import) checkItem(app gobizap.Applicationer, conn *pgx.Conn, it models.SupplierItem_import_item, makeObj, modelObj, modelGenObj, bodyObj *importObj) *importObj {
	if it.Name == "" {
		pm.logError(app, conn, it, "не задано наименование")
		return nil
	}

	o := &importObj{Descr: it.Name}
	if err := conn.QueryRow(context.Background(),
		`SELECT id
		FROM items
		WHERE auto_make_id = $1
			AND auto_model_id = $2
			AND auto_model_generation_id = $3
			AND auto_body_id = $4
			AND name = $5`,
		makeObj.Id,
		modelObj.Id,
		modelGenObj.Id,
		bodyObj.Id,
		it.Name,
	).Scan(&o.Id); err != nil && err != pgx.ErrNoRows {
		
		pm.logError(app, conn, it, fmt.Sprintf("ошибка поиска товара: %v", err))
		return nil
		
	}else if err != nil && err != pgx.ErrNoRows {
		pm.logError(app, conn, it, "товара не найден")
		return nil
	}

	return o
}

func (pm *SupplierItem_Controller_import) checkMake(app gobizap.Applicationer, conn *pgx.Conn, it models.SupplierItem_import_item, objList *[]*importObj) *importObj {
	if it.Make == "" {
		pm.logError(app, conn, it, "не задана марка")
		return nil
	}
	for _,m := range *objList {
		if m.Descr == it.Make {
			return m
		}
	}
	o := &importObj{Descr: it.Make}
	if err := conn.QueryRow(context.Background(),
		`SELECT id FROM auto_makes WHERE name = $1`,
		it.Make,
		).Scan(&o.Id);  err != nil && err != pgx.ErrNoRows {
		
		pm.logError(app, conn, it, fmt.Sprintf("ошибка поиска марки: %v", err))
		return nil
		
	}else if err != nil && err == pgx.ErrNoRows {
		pm.logError(app, conn, it, "марка не найдена")
		return nil
	}
	*objList = append(*objList, o)
	return o
}

func (pm *SupplierItem_Controller_import) checkModel(app gobizap.Applicationer, conn *pgx.Conn, it models.SupplierItem_import_item, makeID int64, objList *[]*importObj) *importObj {
	if it.Model == "" {
		pm.logError(app, conn, it, "не задана модель")
		return nil
	}
	for _,m := range *objList {
		if m.Descr == it.Model {
			return m
		}
	}
	o := &importObj{Descr: it.Model}
	if err := conn.QueryRow(context.Background(),
		`SELECT id FROM auto_models WHERE auto_make_id = $1 AND name = $2`,
		makeID, it.Model,
		).Scan(&o.Id);  err != nil && err != pgx.ErrNoRows {
		
		pm.logError(app, conn, it, fmt.Sprintf("ошибка поиска модели: %v", err))
		return nil
		
	}else if err != nil && err == pgx.ErrNoRows {
		pm.logError(app, conn, it, "модель не найдена")
		return nil
	}
	*objList = append(*objList, o)
	return o
}

func (pm *SupplierItem_Controller_import) checkSupplier(app gobizap.Applicationer, conn *pgx.Conn, it models.SupplierItem_import_item, objList *[]*importObj) *importObj {
	if it.Supplier == "" {
		pm.logError(app, conn, it, "не задан поставщик")
		return nil
	}
	for _,m := range *objList {
		if m.Descr == it.Supplier {
			return m
		}
	}
	o := &importObj{Descr: it.Supplier}
	if err := conn.QueryRow(context.Background(),
		`SELECT id FROM suppliers WHERE name = $1`,
		it.Supplier,
		).Scan(&o.Id);  err != nil && err != pgx.ErrNoRows {
		
		pm.logError(app, conn, it, fmt.Sprintf("ошибка поиска поставщика: %v", err))
		return nil
		
	}else if err != nil && err == pgx.ErrNoRows {
		pm.logError(app, conn, it, "поставщик не найден")
		return nil
	}
	*objList = append(*objList, o)
	return o
}

func (pm *SupplierItem_Controller_import) checkModelGeneration(app gobizap.Applicationer, conn *pgx.Conn, it models.SupplierItem_import_item, modelID int64, objList *[]*importObj) *importObj {
	if it.Model_generation == "" {
		pm.logError(app, conn, it, "не задано поколение модели")
		return nil
	}
	for _,m := range *objList {
		if m.Descr == it.Model_generation {
			return m
			break;
		}
	}
	o := &importObj{Descr: it.Model_generation}
	if err := conn.QueryRow(context.Background(),
		`SELECT id FROM auto_model_generations WHERE auto_model_id = $1 AND generation_num = $2`,
		modelID, it.Model_generation,
		).Scan(&o.Id);  err != nil && err != pgx.ErrNoRows {
		
		pm.logError(app, conn, it, fmt.Sprintf("ошибка поиска поколения модели: %v", err))
		return nil
		
	}else if err != nil && err == pgx.ErrNoRows {
		pm.logError(app, conn, it, "поколение модели не найдено")
		return nil
	}
	*objList = append(*objList, o)
	return o
}

func (pm *SupplierItem_Controller_import) checkBody(app gobizap.Applicationer, conn *pgx.Conn, it models.SupplierItem_import_item, modelGenerationID int64, objList *[]*importObj) *importObj {
	if it.Body == "" {
		pm.logError(app, conn, it, "не задан кузов")
		return nil
	}
	for _,m := range *objList {
		if m.Descr == it.Body {
			return m
		}
	}
	o := &importObj{Descr: it.Body}
	if err := conn.QueryRow(context.Background(),
		`SELECT id FROM auto_bodies WHERE auto_model_generation_id = $1 AND name = $2`,
		modelGenerationID, it.Body,
		).Scan(&o.Id);  err != nil && err != pgx.ErrNoRows {
		
		pm.logError(app, conn, it, fmt.Sprintf("ошибка поиска кузова: %v", err))
		return nil
		
	}else if err != nil && err == pgx.ErrNoRows {
		pm.logError(app, conn, it, "кузов не найден")
		return nil
	}
	*objList = append(*objList, o)
	
	return o
}

func (pm *SupplierItem_Controller_import) logError(app gobizap.Applicationer, conn *pgx.Conn, item models.SupplierItem_import_item, erTxt string) {
	if _, err := conn.Exec(context.Background(),
		`INSERT INTO import_items
		(date_time, import_comment, name, make, model, model_generation, body, supplier, options)
		VALUES (now(), $1, $2, $3, $4, $5, $6, $7, $8)`,
		erTxt, item.Name, item.Make, item.Model, item.Model_generation, item.Body, item.Supplier, item.Options,
		);  err != nil{
		
		app.GetLogger().Errorf("SupplierItem_Controller_import.logError: %v", err)
	}
}

