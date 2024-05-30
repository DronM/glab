package controllers

/**
 * Project: glab
 * Author: Andery Mikhalevich
 * Email: katrenplus@mail.ru
 * Date: 20/01/2023
 *
 * This is Item controller implimentation file.
 *
 */

import (
	"context"
	"fmt"
	"reflect"

	"github.com/dronm/ds/pgds"
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv"

	"glab/models"
)

// Method implemenation insert
func (pm *Item_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Item"], &models.Item_keys{}, sock.GetPresetFilter("Item"))
}

// Method implemenation delete
func (pm *Item_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Item"], sock.GetPresetFilter("Item"))
}

// Method implemenation get_object
func (pm *Item_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemDialog"], &models.ItemDialog{}, sock.GetPresetFilter("ItemDialog"))
}

// Method implemenation get_list
func (pm *Item_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemList"], &models.ItemList{}, sock.GetPresetFilter("ItemList"))
}

// Method implemenation update
func (pm *Item_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["Item"], sock.GetPresetFilter("Item"))
}

// Method implemenation complete
func (pm *Item_Controller_complete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.CompleteOnArgs(app, resp, rfltArgs, app.GetMD().Models["ItemList"], &models.ItemList{}, sock.GetPresetFilter("ItemList"))
	//app Applicationer, resp *response.Response, rfltArgs reflect.Value, scanModelMD *model.ModelMD, scanModel interface{}, presetConds sql.FilterCondCollection
}

func (pm *Item_Controller_set_feature) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	//db connect
	d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err_с := d_store.GetPrimary()
	if err_с != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("Item_Controller_set_feature GetPrimary(): %v", err_с))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	//*****************

	args := rfltArgs.Interface().(*models.Item_set_feature)

	var p_val *string
	if args.Val.GetIsSet() {
		s := args.Val.GetValue()
		if s != "" && s != "null" {
			p_val = &s
		}
	}
	var err error
	if p_val == nil {
		//delete feature
		_, err = conn.Exec(context.Background(),
			`DELETE FROM item_feature_vals WHERE item_id = $1 AND item_feature_id = $2`,
			args.Item_id.GetValue(), args.Feature_id.GetValue())

	} else {
		_, err = conn.Exec(context.Background(),
			`INSERT INTO item_feature_vals
			(item_id, item_feature_id, val)
			VALUES ($1, $2, $3)
			ON CONFLICT (item_id, item_feature_id) DO UPDATE
			SET val = $3`,
			args.Item_id.GetValue(), args.Feature_id.GetValue(), p_val)
	}
	return err
}

type featureFilter struct {
	Features []byte `json:"features"`
}

func (pm *Item_Controller_get_features_filter_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	//db connect
	d_store, _ := app.GetDataStorage().(*pgds.PgProvider)
	pool_conn, conn_id, err_с := d_store.GetSecondary("")
	if err_с != nil {
		return gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("Item_Controller_set_feature GetPrimary(): %v", err_с))
	}
	defer d_store.Release(pool_conn, conn_id)
	conn := pool_conn.Conn()
	//*****************

	filters_md := &model.ModelMD{Fields: fields.GenModelMD(reflect.ValueOf(featureFilter{})),
		ID: "FeaturesFilterList_Model",
	}
	return gobizap.AddQueryResult(resp, filters_md, &featureFilter{}, "SELECT features FROM item_features_filter_list", "", nil, conn, false)
}
