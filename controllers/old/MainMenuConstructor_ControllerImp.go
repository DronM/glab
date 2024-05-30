package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 18/03/2023
 *
 * This is MainMenuConstructor controller implimentation file.
 *
 */

import (
	"reflect"	
	"fmt"
	"encoding/xml"
	"strings"
	"context"
	
	"glab/models"
	
	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

//Method implemenation delete
func (pm *MainMenuConstructor_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["MainMenuConstructor"], sock.GetPresetFilter("MainMenuConstructor"))	
}

//Method implemenation get_object
func (pm *MainMenuConstructor_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["MainMenuConstructorDialog"], &models.MainMenuConstructorDialog{}, sock.GetPresetFilter("MainMenuConstructorDialog"))	
}

//Method implemenation get_list
func (pm *MainMenuConstructor_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["MainMenuConstructorList"], &models.MainMenuConstructorList{}, sock.GetPresetFilter("MainMenuConstructorList"))	
}

func (pm *MainMenuConstructor_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	
	args := rfltArgs.Interface().(*models.MainMenuConstructor)
	new_cont, err := gen_user_menu(app, conn, args.Content.GetValue())
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("MainMenuConstructor_Controller_insert gen_user_menu(): %v",err))
	}
	args.Model_content.SetValue(new_cont)

	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["MainMenuConstructor"], &models.MainMenuConstructor_keys{}, nil)
}

//Method implemenation
func (pm *MainMenuConstructor_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	d_store,_ := app.GetDataStorage().(*pgds.PgProvider)
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := d_store.GetPrimary()
	if err != nil {
		return err
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	
	args := rfltArgs.Interface().(*models.MainMenuConstructor_old_keys)
	if !args.Content.GetIsSet() {
		if err := conn.QueryRow(context.Background(),
			`SELECT content FROM main_menus WHERE id = $1`,
			args.Old_id.GetValue()).Scan(&args.Content); err != nil {
			return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("MainMenuConstructor_Controller_update pgx.Conn.QueryRow(): %v",err))
		}		
	}
	new_cont, err := gen_user_menu(app, conn, args.Content.GetValue())
	if err != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("MainMenuConstructor_Controller_update gen_user_menu(): %v",err))
	}
	args.Model_content.SetValue(new_cont)
	
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["MainMenuConstructor"], nil)
}

//*************************
type MenuItem struct {
	XMLName xml.Name `xml:"menuitem"`
	ViewID    string   `xml:"viewid,attr"`
	MenuItems   []MenuItem   `xml:"menuitem"`
}
type Menu struct {
    XMLName xml.Name `xml:"menu"`
    MenuItems   []MenuItem   `xml:"menuitem"`
}

func add_item(sql *strings.Builder, items []MenuItem, view_ids *[]string) {
	for _,it := range items {
		if it.ViewID == "" {
			if it.MenuItems!= nil && len(it.MenuItems) > 0 {
				add_item(sql, it.MenuItems, view_ids)
			}
			continue
		}
		if sql.Len() > 0 {
			sql.WriteString(" UNION ALL ")
		}
		sql.WriteString(fmt.Sprintf(
			`SELECT
				CASE WHEN v.c IS NOT NULL THEN 'c="' || v.c|| '"' ELSE '' END
				||CASE WHEN v.f IS NOT NULL THEN CASE WHEN v.c IS NULL THEN '' ELSE ' ' END|| 'f="' || v.f || '"' ELSE '' END
				||CASE WHEN v.t IS NOT NULL THEN CASE WHEN v.c IS NULL AND v.f IS NULL THEN '' ELSE ' ' END|| 't="' || v.t || '"' ELSE '' END
				||CASE WHEN v.limited IS NOT NULL AND v.limited THEN CASE WHEN v.c IS NULL AND v.f IS NULL AND v.t IS NULL THEN '' ELSE ' ' END|| 'limit="TRUE"' ELSE '' END
			FROM views v WHERE v.id=%s`,
			it.ViewID))		
		*view_ids = append(*view_ids, it.ViewID)
	}
}

func gen_user_menu(app gobizap.Applicationer, conn *pgx.Conn, content string) (string,error) {
	content = strings.ReplaceAll(content, `xmlns="http://www.w3.org/1999/xhtml"`, "")
	content = strings.ReplaceAll(content, `xmlns="http://www.katren.org/crm/doc/mainmenu"`, "")
	
	var menu Menu
	if err := xml.Unmarshal([]byte(content), &menu); err != nil {
		return "",err
	}
	if menu.MenuItems == nil || len(menu.MenuItems) == 0 {
		return "",nil
	}
	var sql strings.Builder;
	view_ids := []string{}
	add_item(&sql, menu.MenuItems, &view_ids)
	
	sql_q := sql.String()
	if app.GetConfig().GetDebugQueries() {
		app.GetLogger().Debugf("Query debug gen_user_menu: %s", sql_q)
	}	
	rows, err := conn.Query(context.Background(), sql_q)
	if err != nil {
		return "",err
	}
	
	view_ind := 0	
	for rows.Next() {
		cmd := ""
		if err := rows.Scan(&cmd); err != nil {		
			return "",err
		}
		content = strings.ReplaceAll(content, fmt.Sprintf(`viewid="%s"`, view_ids[view_ind]), cmd);
		content = strings.ReplaceAll(content, fmt.Sprintf(`viewid ="%s"`, view_ids[view_ind]), cmd);
		content = strings.ReplaceAll(content, fmt.Sprintf(`viewid= "%s"`, view_ids[view_ind]), cmd);
		content = strings.ReplaceAll(content, fmt.Sprintf(`viewid = "%s"`, view_ids[view_ind]), cmd);
		view_ind++
	}
	if err := rows.Err(); err != nil {
		return "",err
	}

	return content, nil
}

