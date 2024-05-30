package controllers

import (
	"fmt"
	"errors"
	"context"
	"encoding/json"	
	"strings"
	
	"glab/models"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/srv/httpSrv"
	"github.com/dronm/gobizap/fields"
	"github.com/dronm/gobizap/response"
	"github.com/dronm/gobizap/sql"
	
	"github.com/jackc/pgx/v5"
)

const(
	USER_LOGIN_Q = "users_login_q"
	USER_LOGIN_PUB_KEY_Q = "users_login_pub_key"
	USER_LOGIN_UPDATE_Q = "users_login_update"
	USER_LOGIN_INSERT_Q = "users_login_insert"
	USER_LOGIN_CLOSE_Q = "users_login_close"
	USER_LOGIN_TOKEN_Q = "users_login_token"
	USER_RESET_PWD_Q = "users_reset_pwd"
)

func prepareUserLoginSQL(conn *pgx.Conn) error {
	if _, err := conn.Prepare(context.Background(), USER_LOGIN_PUB_KEY_Q,
		`SELECT pub_key, id
		FROM logins
		WHERE session_id=$1 AND user_id=$2 AND date_time_out IS NULL`); err != nil {
		
		return errors.New(fmt.Sprintf("USER_LOGIN_PUB_KEY_Q pgx.Conn.Prepare(): %v", err))
	}

	if _, err := conn.Prepare(context.Background(),
		USER_LOGIN_UPDATE_Q,
		`UPDATE logins
		SET
			user_id = $1,
			pub_key = $2,
			date_time_in = now(),
			set_date_time = now(),
			user_agent = $3::jsonb,
			ip = $4,
			headers = $5::json
			FROM (
				SELECT
					l.id AS id
				FROM logins l
				WHERE l.session_id=$6 AND l.user_id IS NULL
				ORDER BY l.date_time_in DESC
				LIMIT 1										
			) AS s
			WHERE s.id = logins.id
		RETURNING logins.id`); err != nil {
		
		return errors.New(fmt.Sprintf("USER_LOGIN_UPDATE_Q pgx.Conn.Prepare(): %v", err))
	}		

	if _, err := conn.Prepare(context.Background(),
		USER_LOGIN_INSERT_Q,
		`INSERT INTO logins
		(date_time_in, ip, session_id, pub_key, user_id, user_agent, headers)
		VALUES (now(), $1, $2, $3, $4, $5, $6)				
		RETURNING id`); err != nil {
		
		return errors.New(fmt.Sprintf("USER_LOGIN_INSERT_Q pgx.Conn.Prepare(): %v", err))
	}

	return nil
}

//returns pub key
func doLoginUser(app gobizap.Applicationer, sock socket.ClientSocketer, conn *pgx.Conn, user_row *models.UserLogin, argWidthType string) (string, error) {
	if err := prepareUserLoginSQL(conn); err != nil {
		return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser prepareUserLoginSQL(): %v",err))
	}
	
	if user_row.Banned.GetValue() {
		return "", gobizap.NewPublicMethodError(RESP_ER_BANNED_CODE, RESP_ER_BANNED_DESCR)
	}	
	
	sess := sock.GetSession()
	sess_id := sess.SessionID()
	
	user_role := user_row.Role_id.GetValue()
	user_id := user_row.Id.GetValue()
		
	//user agent
	var err error
	user_ip := ""
	user_headers := []byte("{}") 
	user_a_s := []byte("{}")
	if sock_http, ok := sock.(*httpSrv.HTTPSocket); ok {
		user_ip = sock_http.Request.RemoteAddr
		user_ip_port_p := strings.Index(user_ip, ":")
		if user_ip_port_p >= 0 {
			user_ip = user_ip[:user_ip_port_p]
		}
		user_headers, err = json.Marshal(sock_http.Request.Header)
		if err != nil {
			//just log
			app.GetLogger().Errorf("doLoginUser json.Marshal(sock_http.Request.Header): %v", err)			
		}
		ua_s := sock_http.Request.Header.Get("User-Agent")
		if ua_s != "" {
			user_a_s, err = getUserAgentFieldValue(ua_s)
			if err != nil {
				//just log
				app.GetLogger().Errorf("doLoginUser getUserAgentFieldValue(): %v", err)			
			}
			
			if user_role != "admin" {
				device_hash := ""
				err := conn.QueryRow(context.Background(),
					`SELECT md5(login_devices_uniq($1::jsonb)) AS hash`,
					string(user_a_s)).Scan(&device_hash)
				if err != nil {
					//just log
					app.GetLogger().Errorf("doLoginUser login_devices_uniq(): %v", err)			
				}else{
					//check for banned device
					if !user_row.Ban_hash.GetIsNull() && strings.Index(user_row.Ban_hash.GetValue(), device_hash) >= 0 {
						//device is in banned list
						return "", gobizap.NewPublicMethodError(RESP_ER_BANNED_DEV_CODE, RESP_ER_BANNED_DEV_DESCR)
					}
					//No banned. New device? было ло ли в logins такое устройство?
					var date_time_in fields.ValDateTimeTZ
					err := conn.QueryRow(context.Background(),
						`SELECT
							date_time_in
						FROM login_devices_list
						WHERE user_id = $1 AND ban_hash = $2`,
						user_id, device_hash).Scan(&date_time_in)
						
					if err != nil && err != pgx.ErrNoRows {
						return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser first SELECT FROM login_devices_list: %v",err))	
							
					}
					
					/*	
					if err == pgx.ErrNoRows || date_time_in.GetIsNull() {
						//first login - ban!
						if _, err := conn.Exec(context.Background(),
							`INSERT INTO login_device_bans
								(user_id, hash) VALUES ($1, $2) ON CONFLICT (user_id, hash) DO NOTHING`,
							user_id, device_hash); err != nil {
								return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser first login ban pgx.Conn.Exec(): %v",err))	
						}
						if _, err := conn.Exec(context.Background(),
							`INSERT INTO logins
								(date_time_in, date_time_out, ip, session_id, pub_key, user_id, headers, user_agent)
								VALUES(now(), now(), $1, $2, NULL, $3, $4::json, $5::jsonb)`,
							user_ip, sess_id, 
							user_id, string(user_headers), string(user_a_s)); err != nil {
								return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser first login ban pgx.Conn.Exec(): %v",err))									
						}
						return "", gobizap.NewPublicMethodError(RESP_ER_BANNED_DEV_CODE, RESP_ER_BANNED_DEV_DESCR)						
					}
					*/
				}
			}
		}
	}
	
	pub_key := ""
	login_id := 0
	
	err = conn.QueryRow(context.Background(), USER_LOGIN_PUB_KEY_Q, sess_id, user_id).Scan(&pub_key, &login_id)
		
	if err == pgx.ErrNoRows {
		//no user login
		pub_key = genUniqID(15);
		
		err := conn.QueryRow(context.Background(), USER_LOGIN_UPDATE_Q,
				user_id,
				pub_key,
				string(user_a_s), user_ip, string(user_headers),
				sess_id).Scan(&login_id)
				
		if err == pgx.ErrNoRows {
			//no user			
			//fmt.Println("IP=",sock.GetIP(), "sess_id=",sess_id, "pub_key=", pub_key, "ID=", row.Id.GetValue())
			if err = conn.QueryRow(context.Background(),
				USER_LOGIN_INSERT_Q,
					sock.GetIP(),
					sess_id,
					pub_key,
					user_id,
					string(user_a_s),
					string(user_headers)).Scan(&login_id); err != nil {
					
				return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser users_login_insert pgx.Rows.Scan(): %v",err))	
			}		
			
			
		} else if err != nil {
			return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser users_login_update pgx.Rows.Scan(): %v",err))	
			
		}				
		
	}else if err != nil {
		return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser USER_LOGIN_PUB_KEY_Q pgx.Rows.Scan(): %v",err))	
	}
	
	//Session data
	sess.Set(gobizap.SESS_ROLE, user_role)
	sess.Set(gobizap.SESS_LOCALE, user_row.Locale_id.GetValue())
	
	user_descr := ""
	user_descr = user_row.Name.GetValue()
	
	sess.Set(SESS_VAR_NAME, user_descr)
	sess.Set(SESS_VAR_ID, user_id)	
	//sess.Set("time_zone_locales_ref", user_row.Time_zone_locales_ref.GetValue())
	//sess.Set("USER_PHONE_CEL", user_row.Phone_cel.GetValue())
	sess.Set(SESS_VAR_WIDTH_TYPE, argWidthType)
	
	//popularity complete count based on screen width	
	pop_cnt := 0
	if argWidthType != "" {
		if err := conn.QueryRow(context.Background(),
			`SELECT coalesce((SELECT item_count FROM popularity_types WHERE screen_width_type = $1), 0)`,
			argWidthType).Scan(&pop_cnt); err != nil {
			
			return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("doLoginUser popularity_types pgx.Rows.Scan(): %v",err))		
		}
	}
	sess.Set(SESS_VAR_POP_COMPLETE_COUNT, pop_cnt)
	
	//
	sess.Set(SESS_VAR_LOGIN_ID, login_id)
	sess.Set(SESS_VAR_LOGGED, true)
	if err := sess.Flush(); err != nil {
		return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_login sess.Flush(): %v",err))	
	}
	
	//******* Preset filters for all users*******************
	f := socket.NewPresetFilter()
	//UserProfile - только свои данные!
	f.Add("UserProfile", sql.FilterCondCollection{&sql.FilterCond{FieldID: "id", Value: user_id, Sign: sql.SGN_SQL_E}})	
	if err := sock.SetPresetFilter(f); err != nil {
		return "", gobizap.NewPublicMethodError(response.RESP_ER_INTERNAL, fmt.Sprintf("User_Controller_login sock.SetPresetFilter(): %v",err))	
	}
	
	return pub_key, nil
}

