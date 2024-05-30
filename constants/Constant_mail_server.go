package constants

/**
 * Andrey Mikhalevich 20/12/21
 * This file is part of the OSBE framework
 * 
 * This file is generated from the template build/templates/constant.go.tmpl
 * All direct modification will be lost with the next build.
 * Edit template instead.
*/

import (
	"github.com/dronm/gobizap"
)

type Constant_mail_server struct {
	gobizap.ConstantJSON
}

func New_Constant_mail_server() *Constant_mail_server {
	return &Constant_mail_server{ gobizap.ConstantJSON{ID: "mail_server", Autoload: false }}
}

