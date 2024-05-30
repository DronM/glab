package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 03/07/2023
 *
 * This is AutoToGlassMatchOption controller implimentation file.
 *
 */

import (
	"reflect"	
	"context"
	"fmt"
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"	
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	"github.com/jackc/pgx/v5"
)

//Method implemenation insert
func (pm *AutoToGlassMatchOption_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchOption"], &models.AutoToGlassMatchOption_keys{}, sock.GetPresetFilter("AutoToGlassMatchOption"))	
}

//Method implemenation delete
func (pm *AutoToGlassMatchOption_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchOption"], sock.GetPresetFilter("AutoToGlassMatchOption"))	
}

//Method implemenation get_object
func (pm *AutoToGlassMatchOption_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoToGlassMatchOption"], &models.AutoToGlassMatchOption{}, sock.GetPresetFilter("AutoToGlassMatchOption"))	
}

//Method implemenation get_list
func (pm *AutoToGlassMatchOption_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoToGlassMatchOption"], &models.AutoToGlassMatchOption{}, sock.GetPresetFilter("AutoToGlassMatchOption"))	
}

//Method implemenation update
func (pm *AutoToGlassMatchOption_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoToGlassMatchOption"], sock.GetPresetFilter("AutoToGlassMatchOption"))	
}

//Method implemenation get_conf_form
func (pm *AutoToGlassMatchOption_Controller_get_conf_form) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	//db connect
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err_с := d_store.GetSecondary("")
	if err_с != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form GetPrimary(): %v",err_с))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	//*****************
	
	args := rfltArgs.Interface().(*models.AutoToGlassMatchOption_get_conf_form)
	head_id := args.Auto_to_glass_match_head_id.GetValue()
	
	//priorities
	prior_md := app.GetMD().Models["ItemPriority"]
	prior_struct := &models.ItemPriority{}
	prior_q := `SELECT * FROM item_priorities WHERE code<=3 ORDER BY code`
	rows, err := conn.Query(context.Background(), prior_q)	
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form ItemPriority SELECT: %v",err))
	}
	prior_m := &model.Model{ID: model.ModelID(prior_md.ID),
			SysModel: false,
			Rows: make([]model.ModelRow, 0),
			Metadata: prior_md,
	}	
	prior_ids := make([]int64, 0)
	for rows.Next() {
		row, row_fields := gobizap.GetModelStructFields(prior_struct)
		if err := rows.Scan(row_fields...); err != nil {		
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form ItemPriority pgx.Rows.Scan(): %v",err))	
		}
		prior_ids = append(prior_ids, row.(*models.ItemPriority).Id.GetValue())
		
		prior_m.Rows = append(prior_m.Rows, row)		
	}	
	if err := rows.Err(); err != nil {
		rows.Close()
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, err.Error())
	}
	rows.Close()
	resp.AddModel(prior_m)
	
	opt_q_pat := `SELECT
		id,
		auto_to_glass_match_head_id,
		item_priority_id,
		line_num,
		eurocode_list,
		eurocode_view,
		body_door_list,
		body_door_view,
		body_type_list,
		body_type_view,
		body_model_list,
		body_model_view,
		option_list,
		quant_econom,
		quant_standart,
		quant_premium
	FROM auto_to_glass_match_options WHERE auto_to_glass_match_head_id=%d AND item_priority_id = %d ORDER BY line_num`
	opt_struct := &models.AutoToGlassMatchOption{}
	
	ft_q_pat := `SELECT * FROM auto_to_glass_match_features(%d)`
	ft_struct := &models.ItemFeature{}
	
	for _, prior_id := range prior_ids {
		opt_m := &model.Model{ID: model.ModelID(fmt.Sprintf("OptionList_%d_Model", prior_id)),
				SysModel: false,
				Rows: make([]model.ModelRow, 0),
				Metadata: app.GetMD().Models["AutoToGlassMatchOption"],
		}	
		opt_rows, err := conn.Query(context.Background(), fmt.Sprintf(opt_q_pat, head_id, prior_id))	
		if err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form eurocode_to_glass_match_options for priority %d SELECT: %v", prior_id, err))
		}
		
		for opt_rows.Next() {
			opt_row, opt_row_fields := gobizap.GetModelStructFields(opt_struct)

			if err := opt_rows.Scan(opt_row_fields...); err != nil {		
				return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form eurocode_to_glass_match_options for priority %d  pgx.Rows.Scan(): %v", prior_id,err))	
			}
			
			opt_m.Rows = append(opt_m.Rows, opt_row)		
		}	
		if err := rows.Err(); err != nil {
			opt_rows.Close()
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, err.Error())
		}
		opt_rows.Close()
		resp.AddModel(opt_m)
		
		//features
		ft_m := &model.Model{ID: model.ModelID(fmt.Sprintf("ItemFeature_%d_Model", prior_id)),
				SysModel: false,
				Rows: make([]model.ModelRow, 0),
				Metadata: app.GetMD().Models["ItemFeature"],
		}	
		ft_rows, err := conn.Query(context.Background(), fmt.Sprintf(ft_q_pat, prior_id))	
		if err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form eurocode_to_glass_match_options for priority %d SELECT: %v", prior_id, err))
		}
		
		for ft_rows.Next() {
			ft_row, ft_row_fields := gobizap.GetModelStructFields(ft_struct)
			if err := ft_rows.Scan(ft_row_fields...); err != nil {		
				return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form auto_to_glass_match_features pgx.Rows.Scan(): %v",err))	
			}
			
			ft_m.Rows = append(ft_m.Rows, ft_row)		
		}	
		if err := rows.Err(); err != nil {
			ft_rows.Close()
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, err.Error())
		}
		ft_rows.Close()
		resp.AddModel(ft_m)
		
	}

	edit_m := &model.Model{ID: model.ModelID("OptionEdit_Model"),
			SysModel: false,
			Rows: make([]model.ModelRow, 0),
			Metadata: nil,
	}	
	edit_fields := struct {
		Eurocode_list fields.ValJSON `json:"eurocode_list"`
		Body_door_list fields.ValJSON `json:"body_door_list"`
		Body_type_list fields.ValJSON `json:"body_type_list"`
		Body_model_list fields.ValJSON `json:"body_model_list"`
	}{}	
	if err := conn.QueryRow(context.Background(),
		`SELECT
		  	eurocode_list,
		  	body_door_list,
		  	body_type_list,
		  	body_model_list
		FROM auto_to_glass_match_opt_edit($1)`,
		head_id,
	).Scan(&edit_fields.Eurocode_list,
		&edit_fields.Body_door_list,
		&edit_fields.Body_type_list,
		&edit_fields.Body_model_list,
	); err != nil && err != pgx.ErrNoRows {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoToGlassMatchOption_Controller_get_conf_form auto_to_glass_match_opt_edit pgx.Rows.Scan(): %v",err))	
		
	}else if err == nil {
		edit_m.Rows = append(edit_m.Rows, edit_fields)		
	}
	resp.AddModel(edit_m)

	return nil;	
}


