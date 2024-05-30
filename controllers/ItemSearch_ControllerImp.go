package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 02/02/2023
 *
 * This is ItemSearch controller implimentation file.
 *
 */

import (
	"reflect"
	"fmt"
	"context"
	"strings"	
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	//"github.com/jackc/pgx/v5"
)

//Method implemenation get_object
// Run инициализирует форму поиска
func (pm *ItemSearch_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary("")
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	//Приоритеты + группы харакеристик
	m_md := app.GetMD().Models["ItemPriority"]	
	m, err := gobizap.QueryResultToModel(m_md,
		&models.ItemPriority{},
		fmt.Sprintf(`SELECT %s FROM item_priorities`, m_md.GetFieldList("")),
		"", nil, conn, false)
	if err != nil {
		return err
	}
	resp.AddModel(m)

	//Опции с группами для отключения через приоритеты вывода
	m3 := &model.Model{ID: model.ModelID("FilterOptionList_Model"), Rows: make([]model.ModelRow, 0)}		
	rows, err := conn.Query(context.Background(),
		`SELECT
			f.id,
			f.name,
			f.comment_text,
			f.name_lat,
			gr_it.filter_option_type,
			json_agg(
				DISTINCT coalesce(fld.item_priority_id, spl_fld.item_priority_id)
			)::text AS item_priorities
		FROM item_feature_group_items AS gr_it
		LEFT JOIN item_features AS f ON f.id = gr_it.item_feature_id 
		LEFT JOIN item_feature_groups AS gr ON gr.id = gr_it.item_feature_group_id
		LEFT JOIN item_folder_feature_groups AS fld_gr ON fld_gr.item_feature_group_id = gr.id 
		LEFT JOIN supplier_item_folder_feature_groups AS sp_fld_gr ON sp_fld_gr.item_feature_group_id = gr.id 
		LEFT JOIN item_folders AS fld ON fld.id = fld_gr.item_folder_id 
		LEFT JOIN item_folders AS spl_fld ON spl_fld.id = sp_fld_gr.item_folder_id 
		WHERE
			gr_it.filter_option_type='main' OR gr_it.filter_option_type='additional'
		GROUP BY
			f.id,
			f.name,
			f.comment_text,
			f.name_lat,
			gr_it.filter_option_type`,
	)
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("ItemSearch_Controller_get_object pgx.Conn.Query(): %v",err))
	}	
	for rows.Next() {
		row := struct {
			Id int `json:"id"`
			Name string `json:"name"`
			Comment_text string `json:"comment_text"`
			Name_lat string `json:"name_lat"`
			Filter_option_type string `json:"filter_option_type"`
			Item_priorities string `json:"item_priorities"`
		}{}
		if err := rows.Scan(&row.Id,
				&row.Name,
				&row.Comment_text,
				&row.Name_lat,
				&row.Filter_option_type,
				&row.Item_priorities,
			); err != nil {		
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("QueryResultToModel pgx.Rows.Scan(): %v",err))	
		}
		m3.Rows = append(m3.Rows, &row)		
	}
	if err := rows.Err(); err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, err.Error())
	}
	resp.AddModel(m3)
	
	return nil
}


func (pm *ItemSearch_Controller_find_items) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	args := rfltArgs.Interface().(*models.ItemSearch_find_items)	
	
	cond_cnt := 0
	cond_vals := make([]interface{},0)
	cond_list := make([]string, 0)

	//Марка
	if args.Criteria.Auto_make_id > 0 {
		cond_cnt++
		cond_list = append(cond_list, fmt.Sprintf("a_mk.id = $%d", cond_cnt))
		cond_vals = append(cond_vals, args.Criteria.Auto_make_id)
	}
	
	//Модель
	if args.Criteria.Auto_model_id > 0 {
		cond_cnt++
		cond_list = append(cond_list, fmt.Sprintf("a_md.id = $%d", cond_cnt))
		cond_vals = append(cond_vals, args.Criteria.Auto_model_id)
	}
	
	//Поколение
	if args.Criteria.Auto_model_generation_id > 0 {
		cond_cnt++
		cond_list = append(cond_list, fmt.Sprintf("a_gen.id = $%d", cond_cnt))
		cond_vals = append(cond_vals, args.Criteria.Auto_model_generation_id)
		
	}else if args.Criteria.Auto_model_year > 0 {
		//model year
		cond_cnt++
		cond_list = append(cond_list, fmt.Sprintf("((a_gen.year_from - 1) <= $%d AND (a_gen.year_to + 1) >= $%d)", cond_cnt, cond_cnt))
		cond_vals = append(cond_vals, args.Criteria.Auto_model_year)		
	}
	
	//Кузов
	if args.Criteria.Auto_body_id > 0 {
		cond_cnt++
		cond_list = append(cond_list, fmt.Sprintf("a_bd.id = $%d", cond_cnt))
		cond_vals = append(cond_vals, args.Criteria.Auto_body_id)
	}

	//Уровeнь качества		
	if args.Criteria.Item_feature_qualities != "" {
		cond_cnt++
		cond_list = append(cond_list, fmt.Sprintf("s_it.quality_level = $%d", cond_cnt))
		cond_vals = append(cond_vals, args.Criteria.Item_feature_qualities)
	}

	//Приоритеты вывода
	s := "0"
	if args.Criteria.Item_priorities != nil && len(args.Criteria.Item_priorities) > 0 {		
		s = ""
		for _, pr := range args.Criteria.Item_priorities {
			if s != "" {
				s+= ","
			}
			s+= fmt.Sprintf("%d", pr)
		}				
	}
	cond_list = append(cond_list, fmt.Sprintf("s_it.item_priority_id IN (%s)", s)) //always!!!
	
	//Опции может и не быть, если все отключено
	if args.Criteria.Item_feature_options != nil && len(args.Criteria.Item_feature_options) > 0 {		
		for _, opt := range args.Criteria.Item_feature_options {
			//+condition
			pref := "" //нужно проверить, чтобы опция обязательно была
			if !opt.Val {
				pref = "NOT " //нужно проверить, чтобы опции обязательно не было
			}
			cond_list = append(cond_list, fmt.Sprintf(pref + `s_it.feature_list @> '[{"item_feature_id": %d}]'`, opt.Id))
		}
	}
	
	cond_s := ""
	if len(cond_list) > 0 {
		cond_s = "WHERE " + strings.Join(cond_list, " AND ")
	}
	
	//(SELECT json_agg(f.features) FROM item_feature_vals_list(it.id, it.item_folder_id) AS f) AS features_list
	query := fmt.Sprintf(`SELECT
		it.id AS id,
		coalesce(it.name, '') AS name,		
		auto_makes_ref(a_mk) AS auto_makes_ref,
		auto_models_ref(a_md) AS auto_models_ref,
		auto_model_generations_ref(a_gen) AS auto_model_generations_ref,
		auto_bodies_ref(a_bd) AS auto_bodies_ref,
		item_folders_ref(fld) AS item_folders_ref,
		item_priorities_ref(pr) AS item_priorities_ref,
		
		(SELECT
			json_agg(
				json_build_object(					
					'id', v_f.id,
					'name', v_f.name,
					'val', sub.val,
					'val_type', v_f.value_attrs->>'data_type',
					'main', sub.main
				)
			)
		FROM (
			(SELECT
				v1.item_feature_id,
				v1.val,
				true AS main
			FROM item_feature_vals AS v1		
			WHERE v1.item_id = it.id)
			UNION ALL
			(SELECT
				v2.item_feature_id,
				v2.val,
				false AS main
			FROM supplier_item_feature_vals AS v2
			WHERE v2.supplier_item_id = s_it.supplier_item_id)
		) AS sub
		LEFT JOIN item_features AS v_f ON v_f.id = sub.item_feature_id
		) AS features_list,
		
		suppliers_ref(sp) AS suppliers_ref,
		s_it.supplier_item_id,
		s_items.cost,
		s_items.sale_price,
		s_items.artikul,
		s_items.comment_text,
		s_items.comment_note,
		(SELECT
			json_agg(
				json_build_object(
					'store_id', st_v.supplier_store_id,
					'store_name', sp_st.name,
					'val', st_v.val
				)
			)
		FROM supplier_store_values AS st_v
		LEFT JOIN supplier_stores AS sp_st ON sp_st.id = st_v.supplier_store_id
		WHERE st_v.supplier_store_id IN (SELECT t.id FROM supplier_stores AS t WHERE t.supplier_id = sp.id)
			AND st_v.supplier_item_id = s_it.supplier_item_id
		) AS stores_list
	FROM auto_to_glass_match_supplier_items AS s_it
	LEFT JOIN supplier_items AS s_items ON s_items.id = s_it.supplier_item_id
	LEFT JOIN suppliers AS sp ON sp.id = s_items.supplier_id
	LEFT JOIN items AS it ON it.id = s_items.item_id
	LEFT JOIN auto_makes AS a_mk ON a_mk.id = s_it.auto_make_id
	LEFT JOIN auto_models AS a_md ON a_md.id = s_it.auto_model_id
	LEFT JOIN auto_bodies AS a_bd ON a_bd.id = s_it.auto_body_id
	LEFT JOIN auto_model_generations AS a_gen ON a_gen.id = s_it.auto_model_generation_id
	LEFT JOIN item_folders AS fld ON fld.id = it.item_folder_id	
	LEFT JOIN item_priorities AS pr ON pr.id = s_it.item_priority_id
	%s
	ORDER BY pr.code, it.name
	OFFSET %d LIMIT %d`, cond_s, args.From.GetValue(), args.Count.GetValue())
	
	fmt.Println(query)
	fmt.Println(cond_vals)
	
	//db connect
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err_с := d_store.GetSecondary("")
	if err_с != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("ItemSearch_Controller_find_items GetPrimary(): %v",err_с))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	return gobizap.AddQueryResult(resp, app.GetMD().Models["ItemSearchResult"], &models.ItemSearchResult{}, query, "", cond_vals, conn, false)		
}

