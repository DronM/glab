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

type Constant_session_live_time struct {
	gobizap.ConstantTime
}

func New_Constant_session_live_time() *Constant_session_live_time {
	return &Constant_session_live_time{ gobizap.ConstantTime{ID: "session_live_time", Autoload: false }}
}

