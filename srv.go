package main

import (
	"fmt"
	"os"
	"path/filepath"

	"glab/glab_config"

	"github.com/dronm/gobizap/config"
)

func main() {

	//Configuration file: first argument or PROG_FILE_NAME.json
	var ini_file string
	if len(os.Args) >= 2 {
		ini_file = os.Args[1]
	} else {
		ini_file = os.Args[0] + ".json"
	}

	conf := &glab_config.GLabConfig{}
	err := config.ReadConf(ini_file, conf)
	if err != nil {
		panic(fmt.Sprintf("config.ReadConf() failed: %v", err))
	}
	app := &GLabApp{}
	app.BaseDir = filepath.Dir(ini_file)
	app.init(conf)

	app.Run()
}
