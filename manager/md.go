package main

/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/md.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

import (
	"/controllers"
	"/constants"

	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/model"
)

func initMD(md *github.Metadata){
	md.Controllers["CashIncomeSource"] = controllers.NewController_CashIncomeSource()
	md.Models["CashIncomeSource"] = models.NewModelMD_CashIncomeSource()md.Models["CashIncomeSource"] = models.NewModelMD_CashIncomeSource()

}
