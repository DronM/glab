package glab_config

import (
	"github.com/dronm/gobizap/config"
)

type RedisSession struct {
	Connect   string `json:"connect"`
	Namespace string `json:"namespace"`
}

type GLabConfig struct {
	config.AppConfig //base structure

	EventServerEnabled bool         `json:"eventServerEnabled"`
	WsServerEnabled    bool         `json:"wsServerEnabled"`
	WsExtPort          int          `json:"wsExtPort"`
	WsExtPortTls       int          `json:"wsExtPortTls"`
	HTTPDir            string       `json:"httpDir"`
	JsDebug            bool         `json:"jsDebug"`
	HttpServer         string       `json:"httpServer"`
	JsHost             string       `json:"jsHost"`
	DadataKey          string       `json:"dadataKey"`
	Redis              RedisSession `json:"redis"`
}
