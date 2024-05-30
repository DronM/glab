package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 20/12/2022
 *
 * This is AutoModel controller implimentation file.
 *
 */

import (
	"reflect"
	"context"
	"fmt"	
	"strings"
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	"github.com/jackc/pgx/v5"
)

var auto_model_list_fields string

//Method implemenation insert
func (pm *AutoModel_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoModel"], &models.AutoModel_keys{}, sock.GetPresetFilter("AutoModel"))	
}

//Method implemenation delete
func (pm *AutoModel_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoModel"], sock.GetPresetFilter("AutoModel"))	
}

//Method implemenation get_object
func (pm *AutoModel_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoModelList"], &models.AutoModelList{}, sock.GetPresetFilter("AutoModelList"))	
}

//Method implemenation get_list
func (pm *AutoModel_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["AutoModelList"], &models.AutoModelList{}, sock.GetPresetFilter("AutoModelList"))	
}

//Method implemenation update
func (pm *AutoModel_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["AutoModel"], sock.GetPresetFilter("AutoModel"))	
}

//Method implemenation complete
func (pm *AutoModel_Controller_complete_for_make) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	scan_model := &models.AutoModelList{}
	scan_model_md := app.GetMD().Models["AutoModelList"]
	
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary(gobizap.GetModelLsnValue(scan_model))
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
		
	if auto_model_list_fields == "" {
		var sb strings.Builder
		for i, fld := range strings.Split(scan_model_md.GetFieldList(""), ",") {
			if i > 0 {
				sb.WriteString(",")
			}
			sb.WriteString("t." + fld)
		}
		auto_model_list_fields = sb.String()
	}
	
	args := rfltArgs.Interface().(*models.AutoModel_complete_for_make)
	cond_vals := make([]interface{}, 3)
	cond_vals[0] = args.Make_id.GetValue()
	cond_vals[1] = args.Name.GetValue()
	
	if args.Count.GetIsSet() {
		cond_vals[2] = args.Count.GetValue()
	}else{
		cond_vals[2] = 500 //max value
	}	
	
	query := `SELECT ` +
		auto_model_list_fields +
		` FROM auto_models_list AS t
		LEFT JOIN popularity_types AS p ON p.id = t.popularity_type_id
		WHERE ($1 = 0 OR t.auto_make_id = $1) AND (t.name ILIKE '%'||$2||'%' OR t.name_variants ILIKE '%'||$2||'%')
		ORDER BY
			CASE WHEN p.code > 0 THEN 0 ELSE 1 END,
			name		
		LIMIT $3`		
//fmt.Println("CompleteOnArgsWithConn query=",query, cond_vals[0])		

	return gobizap.AddQueryResult(resp, scan_model_md, scan_model, query, "", cond_vals, conn, false)
}

//Method implemenation complete
func (pm *AutoModel_Controller_get_all_years) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err := d_store.GetSecondary("")
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()

	args := rfltArgs.Interface().(*models.AutoModel_get_all_years)

	years := struct {
		Year_from int `json:"year_from"`
		Year_to int `json:"year_to"`
	}{}
	
	//generation is selected
	gen_cond := ""
	if args.Model_generation_id.GetValue() > 0 {
		gen_cond = fmt.Sprintf(" AND id = %d", args.Model_generation_id.GetValue())
	}
	if err := conn.QueryRow(context.Background(),
		`SELECT
			min(coalesce(year_from, 0)) AS year_from,
			max(coalesce(coalesce(year_to, 0), DATE_PART('Year', NOW())::int)) AS year_to
		FROM auto_model_generations
		WHERE auto_model_id = $1 AND coalesce(year_from, 0)>0` + gen_cond,
		args.Model_id.GetValue()).Scan(&years.Year_from, &years.Year_to); err != nil && err != pgx.ErrNoRows{
		
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("AutoModel_Controller_get_all_years conn.QueryRow(): %v",err))
	}
	resp.AddModelFromStruct(model.ModelID("AutoModelYearList_Model"), &years)	
	
	return nil
}
