package controllers

/**
 * Andrey Mikhalevich 16/12/22
 *
 * Controller implimentation file
 *
 */

import (
	"reflect"	
	"fmt"
	"context"
	"errors"
	
	"glab/models"
	
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/srv"
	"github.com/dronm/gobizap/socket"
	"github.com/dronm/gobizap/response"	
	
	"github.com/jackc/pgx/v5"
)
func (pm *MailMessage_Controller_insert) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.InsertOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["MailMessage"], &models.MailMessage_keys{}, sock.GetPresetFilter("MailMessage"))	
}

//Method implemenation
func (pm *MailMessage_Controller_delete) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.DeleteOnArgKeys(app, pm, resp, sock, rfltArgs, app.GetMD().Models["MailMessage"], sock.GetPresetFilter("MailMessage"))	
}

//Method implemenation
func (pm *MailMessage_Controller_get_object) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetObjectOnArgs(app, resp, rfltArgs, app.GetMD().Models["MailMessage"], &models.MailMessage{}, sock.GetPresetFilter("MailMessage"))	
}

//Method implemenation
func (pm *MailMessage_Controller_get_list) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.GetListOnArgs(app, resp, rfltArgs, app.GetMD().Models["MailMessageList"], &models.MailMessageList{}, sock.GetPresetFilter("MailMessageList"))	
}


//Method implemenation
func (pm *MailMessage_Controller_update) Run(app gobizap.Applicationer, serv srv.Server, sock socket.ClientSocketer, resp *response.Response, rfltArgs reflect.Value) error {
	return gobizap.UpdateOnArgs(app, pm, resp, sock, rfltArgs, app.GetMD().Models["MailMessage"], sock.GetPresetFilter("MailMessage"))	
}

//*********************

type mailMessage struct {
	To_addr string `json:"to_addr"`
	To_name string `json:"to_name"`
	Body string `json:"body"`
	Subject string `json:"subject"`
	Mail_type string `json:"mail_type"`
}

//sql function call
func RegisterMailFromSQL(conn *pgx.Conn, sqlFunc string, attachments []string, sqlParamValues []interface{}) error {

	sql_param_str := ""
	for i := 0; i < len(sqlParamValues); i++ {
		if sql_param_str != "" {
			sql_param_str+= ","
		}
		sql_param_str+=fmt.Sprintf("$%d", i+1)
	}
	msg := mailMessage{}
	if err := conn.QueryRow(context.Background(),
		fmt.Sprintf(`SELECT
			to_addr,
			to_name,
			body,
			subject,
			mail_type
		FROM %s(%s)`, sqlFunc, sql_param_str),
		sqlParamValues...).Scan(&msg.To_addr,
					&msg.To_name,
					&msg.Body,
					&msg.Subject,
					&msg.Mail_type,
			); err != nil && err != pgx.ErrNoRows {
	
		return err	
		
	}else if err == pgx.ErrNoRows {
		return errors.New("Не найден шаблон отправки")
	} 
	
	if msg.To_addr == "" {
		return errors.New("Не задан адрес электронной почты")
	}
	if msg.Body == "" {
		return errors.New("Не задано тело письма по шаблону")
	}
	if msg.Subject == "" {
		return errors.New("Не задана тема письма по шаблону")
	}
	if msg.Mail_type == "" {
		return errors.New("Не задан тип письма по шаблону")
	}
	
	return RegisterMail(conn, &msg, attachments)
}

//Manual registration
func RegisterMail(conn *pgx.Conn, msg *mailMessage, attachments []string) error {
//fmt.Println("RegisterMail")
	attachments_exist := (attachments != nil && len(attachments) > 0)
	
	if attachments_exist {
		if _, err := conn.Exec(context.Background(),`BEGIN`); err != nil {
			return err
		}
	}
		
	var msg_id int64
	if err := conn.QueryRow(context.Background(),
		`INSERT INTO mail_messages
		(from_addr, from_name, to_addr, to_name, reply_addr, reply_name,
		body, sender_addr, subject, mail_type)
		SELECT
			srv.val->>'user',
			srv.val->>'name',
			$1,
			$2,
			coalesce(srv.val->>'reply_mail', srv.val->>'user'),
			coalesce(srv.val->>'reply_name', srv.val->>'name'),
			$3,
			srv.val->>'user',
			$4,
			$5
		FROM const_mail_server AS srv
		LIMIT 1
		RETURNING id`,
		msg.To_addr,
		msg.To_name,
		msg.Body,
		msg.Subject,
		msg.Mail_type,
		).Scan(&msg_id); err != nil {
	
		if attachments_exist {
			conn.Exec(context.Background(),`ROLLBACK`)
		}
	
		return err	
	}			
		
	if attachments_exist {
		att_q := ""
		att_params := make([]interface{}, len(attachments))
		att_param_ind := 0
		for _, att := range attachments {
			if att_q != "" {
				att_q+= ", "
			}
			att_q+=  fmt.Sprintf("(%d, $%d)", msg_id, att_param_ind+1)
			att_params[att_param_ind] = att
			att_param_ind++
		}
//fmt.Println(`RegisterMail Attachment INSERT INTO mail_message_attachments (mail_message_id, file_name) VALUES `+att_q, "params:", att_params)		
		if _, err := conn.Exec(context.Background(),
			`INSERT INTO mail_message_attachments (mail_message_id, file_name) VALUES `+att_q,
			att_params...); err != nil {
			
			conn.Exec(context.Background(),`ROLLBACK`)
			
			return err
		}
		
		if _, err := conn.Exec(context.Background(),`COMMIT`); err != nil {
			return err
		}
		
	}
	return nil
}


