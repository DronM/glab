package controllers

import (
	"time"
	"fmt"
	"context"
	"strings"
	
	"github.com/dronm/gobizap/logger"
	"github.com/dronm/ds/pgds"
	
	"github.com/stvoidit/gosmtp"
	//"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

const MAIL_SERVER_SELECT_Q = "mail_server_select"

var quitMailReader chan bool

func sendMail(dStore *pgds.PgProvider, l logger.Logger, attachPath string) {
	l.Debug("MailServer: sending mail")			
	
	//slave
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := dStore.GetSecondary("")
	if err != nil {
		l.Debugf("MailServer: dStore.GetPrimary(): %v", err)
		return
	}
	defer dStore.Release(pool_conn, conn_id)
	conn_sec := pool_conn.Conn()

	//master
	var conn_id_m pgds.ServerID
	var pool_conn_m *pgxpool.Conn
	pool_conn_m, conn_id_m, err_m := dStore.GetPrimary()
	if err_m != nil {
		l.Debugf("MailServer: dStore.GetPrimary(): %v", err_m)
		return
	}
	defer dStore.Release(pool_conn_m, conn_id_m)
	conn_m := pool_conn_m.Conn()
	
	if _, err := conn_sec.Prepare(context.Background(),
			MAIL_SERVER_SELECT_Q,
			`WITH m_sender AS (
				SELECT
					coalesce(srv.val->>'smtp_host', '') AS host,
					coalesce(srv.val->>'user', '') AS u_name,
					coalesce(srv.val->>'pwd', '') AS pwd
				FROM const_mail_server AS srv
			)
			SELECT
				m.id,
				(SELECT host FROM m_sender),
				(SELECT u_name FROM m_sender),
				(SELECT pwd FROM m_sender),
				coalesce(m.from_addr, '') AS from_addr,
				coalesce(m.from_name, '') AS from_name,
				coalesce(m.to_addr, '') AS to_addr,
				coalesce(m.to_name, '') AS to_name,
				coalesce(m.reply_name, '') AS reply_name,
				coalesce(m.body, '') AS body,
				coalesce(m.sender_addr, '') AS sender_addr,
				coalesce(m.subject, '') AS subject,
				(SELECT
					ARRAY_AGG(att.file_name)
				FROM mail_message_attachments AS att
				WHERE att.mail_message_id = m.id
				) AS attachments
			FROM mail_messages AS m
			WHERE coalesce(m.sent, FALSE)=FALSE`); err != nil {
		
		l.Debugf("MailServer: conn_sec.Prepare(): %v", err)
		return
	}

	rows, err := conn_sec.Query(context.Background(), MAIL_SERVER_SELECT_Q)
	if err != nil {
		l.Debugf("MailServer MAIL_SERVER_SELECT_Q pgx.conn_sec.Query(): %v",err)
		return
	}	

	if rows.Next() {		
		msg := struct {
			id int
			smtp_host string
			smtp_user string
			smtp_pwd string
			from_addr string
			from_name string
			to_addr string
			to_name string
			reply_name string
			body string
			sender_addr string
			subject string
			attachments []string
		}{}
		
	
		if err := rows.Scan(&msg.id,
				&msg.smtp_host,
				&msg.smtp_user,
				&msg.smtp_pwd,
				&msg.from_addr,
				&msg.from_name,
				&msg.to_addr,
				&msg.to_name,
				&msg.reply_name,
				&msg.body,
				&msg.sender_addr,
				&msg.subject,
				&msg.attachments); err != nil {
			
			l.Debugf("MailServer pgx.Rows.Scan(): %v",err)	
			return
		}
		email_client := gosmtp.NewSender(
			msg.smtp_user,
			msg.smtp_pwd,
			msg.from_addr,
			msg.smtp_host)
			
		var recipients = [][]string{
			{msg.to_addr},
		}
		var files []string
		if msg.attachments != nil && len(msg.attachments)>0 {
			files = make([]string, 0)
			for _, a := range msg.attachments {
				files = append(files, attachPath + a)			
			}
		}
		
		for _, recs := range recipients {
			var email_msg = gosmtp.NewMessage().
				SetTO(recs...).
				SetSubject(msg.subject)
			if strings.Contains(msg.body, "</") && strings.Contains(msg.body, ">"){
				email_msg.SetHTML(msg.body)
			}else{
				email_msg.SetText(msg.body)
			}
			if files != nil && len(files) >0 {
				email_msg.AddAttaches(files...)
			}
			if err := email_client.SendMessage(email_msg); err != nil {
				l.Errorf("MailServer SendMessage(): %v",err)	
				
				if _, err := conn_m.Exec(context.Background(),
					fmt.Sprintf(`UPDATE mail_messages
						SET
							error_str = $1,
							sent = TRUE,
							sent_date_time = now()
						WHERE id = %d`, msg.id), err.Error()); err != nil {
						
					l.Debugf("MailServer UPDATE conn_m.Exec(): %v",err)	
				}		
				
			}else{
				if _, err := conn_m.Exec(context.Background(),
					fmt.Sprintf(`UPDATE mail_messages
						SET
							sent = TRUE,
							sent_date_time = now(),
							error_str = null
						WHERE id = %d`, msg.id)); err != nil {
						
					l.Debugf("MailServer conn_m.Exec(): %v",err)	
				}		
			}
		}
		
	}
}

func StartMailSender(dStore *pgds.PgProvider, l logger.Logger, baseDir string) {
	var conn_id pgds.ServerID
	var pool_conn *pgxpool.Conn
	pool_conn, conn_id, err := dStore.GetSecondary("")
	if err != nil {
		l.Errorf("StartMailSender GetSecondary(): %v", err)
		return
	}
	conn := pool_conn.Conn()

	var check_interval_ms int
	if err := conn.QueryRow(context.Background(),
		`SELECT text_to_int_safe_cast(val->>'check_interval_ms') FROM const_mail_server LIMIT 1`,
		).Scan(&check_interval_ms); err != nil {
		
		dStore.Release(pool_conn, conn_id)
		l.Errorf("StartMailSender conn.QueryRow(): %v", err)
		return
	}
	
	dStore.Release(pool_conn, conn_id)
	quitMailReader = make(chan bool)
		
	go (func(dStore *pgds.PgProvider, l logger.Logger, checkIntervalMS int) {		
	
		l.Debugf("MailServer: starting send mail message loop, interval (ms): %d", checkIntervalMS)
		for {
			select {
			case <- quitMailReader:				
				l.Debug("MailServer: mail message loop is stopped")
				return
			default:		
				sendMail(dStore, l, baseDir + "/" + CACHE_PATH + "/")
				time.Sleep(time.Duration(checkIntervalMS) * time.Millisecond)				
			}
		}						
	})(dStore, l, check_interval_ms)	
}

