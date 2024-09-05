package main

/**
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/md.go.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

import (
	"github.com/dronm/gobizap"

	"glab/constants"
	"glab/controllers"
	"glab/models"
)

func initMD(md *gobizap.Metadata) {
	md.Controllers["User"] = controllers.NewController_User()
	md.Models["User"] = models.NewModelMD_User()
	md.Models["UserDialog"] = models.NewModelMD_UserDialog()
	md.Models["UserList"] = models.NewModelMD_UserList()
	md.Models["UserProfile"] = models.NewModelMD_UserProfile()

	md.Controllers["ObjectModLog"] = controllers.NewController_ObjectModLog()
	md.Models["ObjectModLog"] = models.NewModelMD_ObjectModLog()

	md.Controllers["AutoType"] = controllers.NewController_AutoType()
	md.Models["AutoType"] = models.NewModelMD_AutoType()

	md.Controllers["AutoBodyType"] = controllers.NewController_AutoBodyType()
	md.Models["AutoBodyType"] = models.NewModelMD_AutoBodyType()

	md.Controllers["AutoBodyDoor"] = controllers.NewController_AutoBodyDoor()
	md.Models["AutoBodyDoor"] = models.NewModelMD_AutoBodyDoor()

	md.Controllers["AutoBody"] = controllers.NewController_AutoBody()
	md.Models["AutoBody"] = models.NewModelMD_AutoBody()
	md.Models["AutoBodyList"] = models.NewModelMD_AutoBodyList()

	md.Controllers["AutoMake"] = controllers.NewController_AutoMake()
	md.Models["AutoMake"] = models.NewModelMD_AutoMake()
	md.Models["AutoMakeList"] = models.NewModelMD_AutoMakeList()

	md.Controllers["AutoModel"] = controllers.NewController_AutoModel()
	md.Models["AutoModel"] = models.NewModelMD_AutoModel()
	md.Models["AutoModelList"] = models.NewModelMD_AutoModelList()

	md.Controllers["AutoModelGeneration"] = controllers.NewController_AutoModelGeneration()
	md.Models["AutoModelGeneration"] = models.NewModelMD_AutoModelGeneration()
	md.Models["AutoModelGenerationList"] = models.NewModelMD_AutoModelGenerationList()

	md.Controllers["AutoModelGenerationBody"] = controllers.NewController_AutoModelGenerationBody()
	md.Models["AutoModelGenerationBody"] = models.NewModelMD_AutoModelGenerationBody()
	md.Models["AutoModelGenerationBodyList"] = models.NewModelMD_AutoModelGenerationBodyList()

	md.Controllers["ItemFolder"] = controllers.NewController_ItemFolder()
	md.Models["ItemFolder"] = models.NewModelMD_ItemFolder()
	md.Models["ItemFolderList"] = models.NewModelMD_ItemFolderList()

	md.Controllers["ItemFeature"] = controllers.NewController_ItemFeature()
	md.Models["ItemFeature"] = models.NewModelMD_ItemFeature()
	md.Models["ItemFeatureList"] = models.NewModelMD_ItemFeatureList()

	md.Controllers["ItemFeatureGroup"] = controllers.NewController_ItemFeatureGroup()
	md.Models["ItemFeatureGroup"] = models.NewModelMD_ItemFeatureGroup()

	md.Controllers["ItemFolderFeatureGroup"] = controllers.NewController_ItemFolderFeatureGroup()
	md.Models["ItemFolderFeatureGroup"] = models.NewModelMD_ItemFolderFeatureGroup()
	md.Models["ItemFolderFeatureGroupList"] = models.NewModelMD_ItemFolderFeatureGroupList()

	md.Controllers["ItemFeatureGroupItem"] = controllers.NewController_ItemFeatureGroupItem()
	md.Models["ItemFeatureGroupItem"] = models.NewModelMD_ItemFeatureGroupItem()
	md.Models["ItemFeatureGroupItemList"] = models.NewModelMD_ItemFeatureGroupItemList()

	md.Controllers["SupplierItemFolderFeatureGroup"] = controllers.NewController_SupplierItemFolderFeatureGroup()
	md.Models["SupplierItemFolderFeatureGroup"] = models.NewModelMD_SupplierItemFolderFeatureGroup()
	md.Models["SupplierItemFolderFeatureGroupList"] = models.NewModelMD_SupplierItemFolderFeatureGroupList()

	md.Controllers["ItemSearch"] = controllers.NewController_ItemSearch()

	md.Controllers["Item"] = controllers.NewController_Item()
	md.Models["Item"] = models.NewModelMD_Item()
	md.Models["ItemList"] = models.NewModelMD_ItemList()
	md.Models["ItemDialog"] = models.NewModelMD_ItemDialog()

	md.Controllers["Supplier"] = controllers.NewController_Supplier()
	md.Models["Supplier"] = models.NewModelMD_Supplier()
	md.Models["SupplierList"] = models.NewModelMD_SupplierList()
	md.Models["SupplierDialog"] = models.NewModelMD_SupplierDialog()

	md.Controllers["SupplierStore"] = controllers.NewController_SupplierStore()
	md.Models["SupplierStore"] = models.NewModelMD_SupplierStore()
	md.Models["SupplierStoreList"] = models.NewModelMD_SupplierStoreList()

	md.Controllers["SupplierStoreValue"] = controllers.NewController_SupplierStoreValue()
	md.Models["SupplierStoreValue"] = models.NewModelMD_SupplierStoreValue()
	md.Models["SupplierStoreValueList"] = models.NewModelMD_SupplierStoreValueList()

	md.Controllers["SupplierItem"] = controllers.NewController_SupplierItem()
	md.Models["SupplierItem"] = models.NewModelMD_SupplierItem()
	md.Models["SupplierItemList"] = models.NewModelMD_SupplierItemList()
	md.Models["SupplierItemDialog"] = models.NewModelMD_SupplierItemDialog()

	md.Controllers["ImportItem"] = controllers.NewController_ImportItem()
	md.Models["ImportItem"] = models.NewModelMD_ImportItem()
	md.Models["ImportItemList"] = models.NewModelMD_ImportItemList()

	md.Controllers["Manufacturer"] = controllers.NewController_Manufacturer()
	md.Models["Manufacturer"] = models.NewModelMD_Manufacturer()
	md.Models["ManufacturerList"] = models.NewModelMD_ManufacturerList()
	md.Models["ManufacturerDialog"] = models.NewModelMD_ManufacturerDialog()

	md.Controllers["ManufacturerBrand"] = controllers.NewController_ManufacturerBrand()
	md.Models["ManufacturerBrand"] = models.NewModelMD_ManufacturerBrand()
	md.Models["ManufacturerBrandList"] = models.NewModelMD_ManufacturerBrandList()

	md.Controllers["VehicleType"] = controllers.NewController_VehicleType()
	md.Models["VehicleType"] = models.NewModelMD_VehicleType()

	md.Controllers["ItemPriority"] = controllers.NewController_ItemPriority()
	md.Models["ItemPriority"] = models.NewModelMD_ItemPriority()

	md.Controllers["PopularityType"] = controllers.NewController_PopularityType()
	md.Models["PopularityType"] = models.NewModelMD_PopularityType()

	md.Controllers["AutoPriceCategory"] = controllers.NewController_AutoPriceCategory()
	md.Models["AutoPriceCategory"] = models.NewModelMD_AutoPriceCategory()

	md.Controllers["AutoToGlassMatchHead"] = controllers.NewController_AutoToGlassMatchHead()
	md.Models["AutoToGlassMatchHead"] = models.NewModelMD_AutoToGlassMatchHead()
	md.Models["AutoToGlassMatchHeadList"] = models.NewModelMD_AutoToGlassMatchHeadList()

	md.Controllers["AutoToGlassMatchEurocode"] = controllers.NewController_AutoToGlassMatchEurocode()
	md.Models["AutoToGlassMatchEurocode"] = models.NewModelMD_AutoToGlassMatchEurocode()
	md.Models["AutoToGlassMatchEurocodeList"] = models.NewModelMD_AutoToGlassMatchEurocodeList()
	md.Models["AutoToGlassMatchEurocodeBodyList"] = models.NewModelMD_AutoToGlassMatchEurocodeBodyList()

	md.Controllers["AutoToGlassMatchOption"] = controllers.NewController_AutoToGlassMatchOption()
	md.Models["AutoToGlassMatchOption"] = models.NewModelMD_AutoToGlassMatchOption()

	md.Models["ItemSearchResult"] = models.NewModelMD_ItemSearchResult()

	md.Controllers["BankCard"] = controllers.NewController_BankCard()
	md.Models["BankCard"] = models.NewModelMD_BankCard()

	md.Controllers["Department"] = controllers.NewController_Department()
	md.Models["Department"] = models.NewModelMD_Department()

	md.Controllers["Employee"] = controllers.NewController_Employee()
	md.Models["Employee"] = models.NewModelMD_Employee()
	md.Models["EmployeeList"] = models.NewModelMD_EmployeeList()
	md.Models["EmployeeDialog"] = models.NewModelMD_EmployeeDialog()

	md.Controllers["EmployeeStatus"] = controllers.NewController_EmployeeStatus()
	md.Models["EmployeeStatus"] = models.NewModelMD_EmployeeStatus()

	md.Controllers["PersonDocument"] = controllers.NewController_PersonDocument()
	md.Models["PersonDocument"] = models.NewModelMD_PersonDocument()

	md.Controllers["CashLocation"] = controllers.NewController_CashLocation()
	md.Models["CashLocation"] = models.NewModelMD_CashLocation()

	md.Controllers["FinExpenseType"] = controllers.NewController_FinExpenseType()
	md.Models["FinExpenseType"] = models.NewModelMD_FinExpenseType()
	md.Models["FinExpenseTypeList"] = models.NewModelMD_FinExpenseTypeList()
	md.Models["FinExpenseTypeItemList"] = models.NewModelMD_FinExpenseTypeItemList()
	md.Models["FinExpenseTypeDialog"] = models.NewModelMD_FinExpenseTypeDialog()

	md.Controllers["CashFlowIn"] = controllers.NewController_CashFlowIn()
	md.Models["CashFlowIn"] = models.NewModelMD_CashFlowIn()
	md.Models["CashFlowInList"] = models.NewModelMD_CashFlowInList()

	md.Controllers["CashFlowOut"] = controllers.NewController_CashFlowOut()
	md.Models["CashFlowOut"] = models.NewModelMD_CashFlowOut()
	md.Models["CashFlowOutList"] = models.NewModelMD_CashFlowOutList()
	md.Models["CashFlowOutCommentList"] = models.NewModelMD_CashFlowOutCommentList()

	md.Controllers["CashFlowTransfer"] = controllers.NewController_CashFlowTransfer()
	md.Models["CashFlowTransfer"] = models.NewModelMD_CashFlowTransfer()
	md.Models["CashFlowTransferList"] = models.NewModelMD_CashFlowTransferList()

	md.Controllers["Firm"] = controllers.NewController_Firm()
	md.Models["Firm"] = models.NewModelMD_Firm()
	md.Models["FirmList"] = models.NewModelMD_FirmList()
	md.Models["FirmDialog"] = models.NewModelMD_FirmDialog()

	md.Controllers["BankAccount"] = controllers.NewController_BankAccount()
	md.Models["BankAccount"] = models.NewModelMD_BankAccount()
	md.Models["BankAccountList"] = models.NewModelMD_BankAccountList()

	md.Controllers["BankFlowIn"] = controllers.NewController_BankFlowIn()
	md.Models["BankFlowIn"] = models.NewModelMD_BankFlowIn()
	md.Models["BankFlowInList"] = models.NewModelMD_BankFlowInList()

	md.Controllers["BankFlowOut"] = controllers.NewController_BankFlowOut()
	md.Models["BankFlowOut"] = models.NewModelMD_BankFlowOut()
	md.Models["BankFlowOutList"] = models.NewModelMD_BankFlowOutList()
	md.Models["BankFlowOutDialog"] = models.NewModelMD_BankFlowOutDialog()

	md.Controllers["CashIncomeSource"] = controllers.NewController_CashIncomeSource()
	md.Models["CashIncomeSource"] = models.NewModelMD_CashIncomeSource()
	md.Models["CashIncomeSourceList"] = models.NewModelMD_CashIncomeSourceList()

	md.Controllers["UsetOperation"] = controllers.NewController_UserOperation()
	md.Models["UserOperation"] = models.NewModelMD_UserOperation()
	//
	md.Constants["grid_refresh_interval"] = constants.New_Constant_grid_refresh_interval()
	md.Constants["session_live_time"] = constants.New_Constant_session_live_time()
	md.Constants["doc_per_page_count"] = constants.New_Constant_doc_per_page_count()

	//
	//md.Enums["data_types"] = enums.
}
