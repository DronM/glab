package main

/**
 * Andrey Mikhalevich, 18/12/2022
 * This file is part of the OSBE project.
 * It conains MD creation and basic initialization. Once created on project deployment it will not be changed.
 *
 */

import (
	"github.com/dronm/gobizap"
	"github.com/dronm/gobizap/about"
	gobizap_const "github.com/dronm/gobizap/constants"
	"github.com/dronm/gobizap/evnt"
	"github.com/dronm/gobizap/model"
	"github.com/dronm/gobizap/permission"
	"github.com/dronm/gobizap/service"
	"github.com/dronm/gobizap/stat"

	rep_cpt "github.com/dronm/gobizap/repo/captcha"
	rep_ct "github.com/dronm/gobizap/repo/contact/controllers"
	rep_ct_m "github.com/dronm/gobizap/repo/contact/models"
	rep_att "github.com/dronm/gobizap/repo/docAttachment"
	rep_login "github.com/dronm/gobizap/repo/login"
	rep_login_m "github.com/dronm/gobizap/repo/login/models"
	rep_menu "github.com/dronm/gobizap/repo/menu"
	rep_uop "github.com/dronm/gobizap/repo/userOperation"

	rep_bnk "github.com/dronm/gobizap/repo/bank/controllers"
	rep_bnk_m "github.com/dronm/gobizap/repo/bank/models"

	"github.com/dronm/gobizap/repo/clientSearch"
	"github.com/dronm/gobizap/repo/notif"
)

func NewMD(projVersion string) *gobizap.Metadata {
	md := gobizap.NewMetadata()
	md.Version.Value = projVersion

	model.Cond_Model_init()

	md.Controllers["About"] = about.NewController_About()
	md.Controllers["Event"] = evnt.NewController_Event()
	md.Controllers["Permission"] = permission.NewController_Permission()

	md.Controllers["Constant"] = gobizap_const.NewController_Constant()
	md.Models["ConstantValue"] = gobizap_const.NewModelMD_ConstantValue()
	md.Models["ConstantList"] = gobizap_const.NewModelMD_ConstantList()

	md.Controllers["SrvStatistics"] = stat.NewSrvStatistics_Controller()

	md.Controllers["Service"] = service.NewController_Service()

	//repo

	//menu
	md.Controllers["MainMenuConstructor"] = rep_menu.NewController_MainMenuConstructor()
	md.Models["MainMenuConstructor"] = rep_menu.NewModelMD_MainMenuConstructor()
	md.Models["MainMenuConstructorDialog"] = rep_menu.NewModelMD_MainMenuConstructorDialog()
	md.Models["MainMenuConstructorList"] = rep_menu.NewModelMD_MainMenuConstructorList()
	md.Controllers["View"] = rep_menu.NewController_View()
	md.Models["ViewList"] = rep_menu.NewModelMD_ViewList()
	md.Controllers["VariantStorage"] = rep_menu.NewController_VariantStorage()
	md.Models["VariantStorageList"] = rep_menu.NewModelMD_VariantStorageList()

	//login
	md.Controllers["Login"] = rep_login.NewController_Login()
	md.Models["Login"] = rep_login_m.NewModelMD_Login()
	md.Models["LoginList"] = rep_login_m.NewModelMD_LoginList()

	md.Controllers["LoginDevice"] = rep_login.NewController_LoginDevice()
	md.Models["LoginDeviceList"] = rep_login_m.NewModelMD_LoginDeviceList()

	md.Controllers["LoginDeviceBan"] = rep_login.NewController_LoginDeviceBan()
	md.Models["LoginDeviceBan"] = rep_login_m.NewModelMD_LoginDeviceBan()

	md.Controllers["TimeZoneLocale"] = rep_login.NewController_TimeZoneLocale()
	md.Models["TimeZoneLocale"] = rep_login_m.NewModelMD_TimeZoneLocale()

	//att
	md.Controllers["Attachment"] = rep_att.NewController_Attachment()
	md.Models["Attachment"] = rep_att.NewModelMD_Attachment()
	md.Models["AttachmentList"] = rep_att.NewModelMD_AttachmentList()

	//cpt
	md.Controllers["Captcha"] = rep_cpt.NewController_Captcha()

	//userOp
	md.Controllers["UserOperation"] = rep_uop.NewController_UserOperation()
	md.Models["UserOperation"] = rep_uop.NewModelMD_UserOperation()
	md.Models["UserOperationDialog"] = rep_uop.NewModelMD_UserOperationDialog()

	//contact
	md.Controllers["Post"] = rep_ct.NewController_Post()
	md.Models["Post"] = rep_ct_m.NewModelMD_Post()
	md.Controllers["Contact"] = rep_ct.NewController_Contact()
	md.Models["Contact"] = rep_ct_m.NewModelMD_Contact()
	md.Models["ContactList"] = rep_ct_m.NewModelMD_ContactList()
	md.Models["ContactDialog"] = rep_ct_m.NewModelMD_ContactDialog()
	md.Controllers["EntityContact"] = rep_ct.NewController_EntityContact()
	md.Models["EntityContact"] = rep_ct_m.NewModelMD_EntityContact()
	md.Models["EntityContactList"] = rep_ct_m.NewModelMD_EntityContactList()

	md.Controllers["NotifTemplate"] = notif.NewController_NotifTemplate()
	md.Models["NotifTemplate"] = notif.NewModelMD_NotifTemplate()
	md.Models["NotifTemplateList"] = notif.NewModelMD_NotifTemplateList()

	md.Controllers["Bank"] = rep_bnk.NewController_Bank()
	md.Models["Bank"] = rep_bnk_m.NewModelMD_Bank()
	md.Models["BankList"] = rep_bnk_m.NewModelMD_BankList()

	md.Controllers["ClientSearch"] = clientSearch.NewController_ClientSearch()

	return md
}
