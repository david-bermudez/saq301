unit MCDMActs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Math, Db, DBTables, Variants, MCTypes, MCObjcts, ADODB, Rio,
  SOAPHTTPClient;

type
  TdmActs = class(TDataModule)
    SsnActPaid: TSession;
    dbActPaid: TDatabase;
    SQLActs: TQuery;
    tblDetail: TTable;
    StblDetail: TDataSource;
    SQLItems: TQuery;
    SQLSuppliers: TQuery;
    SQLSearchUserPositionID: TQuery;
    SQLSuppliersSUPPLIER_NAME: TStringField;
    SQLSupplier: TQuery;
    SQLSupplierSUPPLIER_NAME: TStringField;
    SQLSuppliersSUPPLIER_NO: TStringField;
    SQLContract: TQuery;
    SQLPortion: TQuery;
    dbLocal: TDatabase;
    tblSearch: TTable;
    StblSearch: TDataSource;
    tblDetailELEMENT_NO: TStringField;
    tblDetailCATEGORY_NO: TStringField;
    tblDetailCATEGORY_DESC: TStringField;
    tblDetailBY_GLOBAL: TStringField;
    tblDetailQUANTITY: TFloatField;
    tblDetailUNITARIAN_VALUE: TCurrencyField;
    tblDetailGLOBAL_VALUE: TCurrencyField;
    tblDetailVALUE: TCurrencyField;
    tblSearchCONTRACT_NO: TStringField;
    tblSearchPORTION_NO: TStringField;
    tblSearchACT_PAID_NO: TStringField;
    tblSearchACT_PAID_DATE: TStringField;
    tblSearchSTATUS: TStringField;
    tblSearchSUPPLIER_NAME: TStringField;
    tblSearchAPPROVED_BY: TStringField;
    tblSearchUSER_ID: TStringField;
    tblSearchPOSITION_ID: TStringField;
    SQLCntPrtEleCat: TQuery;
    SQLInsActPaid: TQuery;
    SQLInsEleCat: TQuery;
    SQLUpdEleCat: TQuery;
    SQLContractCONTRACT_NO: TStringField;
    SQLContractCONTRACT_DESC: TStringField;
    SQLContractSUPPLIER_NO: TStringField;
    SQLContractCURRENCY_TYPE: TStringField;
    SQLContractRESPONS_CODE_1: TStringField;
    SQLContractRESPONS_CODE_2: TStringField;
    SQLContractRESPONS_CODE_3: TStringField;
    SQLContractRESPONS_CODE_4: TStringField;
    SQLLastActCode: TQuery;
    tblDetailCATEG_BASE_UN: TStringField;
    tblCosts: TTable;
    StblCosts: TDataSource;
    SQLElements: TQuery;
    SQLElementsTABLE_CODE: TStringField;
    SQLElementsTABLE_DESC: TStringField;
    SQLCntPrtEle: TQuery;
    SQLCntPrtEleELEMENT_NO: TStringField;
    tblSearchSUPPLIER_NO: TStringField;
    SQLSetActStatus: TQuery;
    SQLCntPrtEleCatELEMENT_NO: TStringField;
    SQLCntPrtEleCatELEMENT_CODE: TStringField;
    SQLCntPrtEleCatCATEGORY_NO: TStringField;
    SQLCntPrtEleCatCATEG_CODE: TStringField;
    SQLCntPrtEleCatTABLE_DESC: TStringField;
    SQLCntPrtEleCatCATEG_BASE_UN: TStringField;
    SQLCntPrtEleCatCATEG_BASE_VAL: TCurrencyField;
    SQLCntPrtEleCatCATEG_BASE_PRC_RT: TCurrencyField;
    SQLRep01: TQuery;
    SQLRep02: TQuery;
    SQLRep03: TQuery;
    SQLRep04: TQuery;
    SQLItemsELEMENT_NO: TStringField;
    SQLItemsCATEGORY_NO: TStringField;
    SQLItemsQUANTITY: TFloatField;
    SQLItemsPAID_VALUE: TFloatField;
    SQLRep03CONTRACT_NO: TStringField;
    SQLRep03CNTRCT_BASE_DT: TStringField;
    SQLRep03CONTRACT_VAL: TCurrencyField;
    SQLRep03SUPPLIER_NO: TStringField;
    SQLCntVal: TQuery;
    SQLLogo: TQuery;
    SSQLLogo: TDataSource;
    SQLRep02CONTRACT_NO: TStringField;
    SQLRep02ELEMENT_NO: TStringField;
    SQLRep02CATEGORY_NO: TStringField;
    SQLRep02CATEG_CODE: TStringField;
    SQLRep02CATEG_BASE_VAL: TFloatField;
    SQLInfoUser: TQuery;
    SQLRep04CONTRACT_NO: TStringField;
    SQLRep04ACT_PAID_NO: TStringField;
    SQLRep04ACT_PAID_DATE: TStringField;
    SQLCntPrtEleELEMENT_CODE: TStringField;
    SQLRep04PORTION_NO: TStringField;
    SQLRep02PORTION_NO: TStringField;
    SQLRep02TABLE_DESC: TStringField;
    SQLRep01CONTRACT_NO: TStringField;
    SQLRep01PORTION_NO: TStringField;
    SQLRep01ELEMENT_NO: TStringField;
    SQLRep01CATEGORY_NO: TStringField;
    SQLRep01CATEG_CODE: TStringField;
    SQLRep01CATEG_BASE_VAL: TFloatField;
    SQLRep01TABLE_DESC: TStringField;
    SQLContractCONTRACT_VAL: TCurrencyField;
    SQLEmployee: TQuery;
    SQLEmployeeSURNAME: TStringField;
    SQLEmployeeFIRST_NAME: TStringField;
    SQLEmployeeSECOND_NAME: TStringField;
    SQLEmployeeTHIRD_NAME: TStringField;
    SQLActPaidExt: TQuery;
    SQLActPaidExtCREATED_BY: TStringField;
    SQLActPaidExtAPPROVED_BY: TStringField;
    SQLPortionORIG_START_DT: TStringField;
    SQLPortionORIG_COMPL_DT: TStringField;
    SQLPortionPORTION_VAL: TFloatField;
    SQLCntPrtVal: TQuery;
    SQLItemsRATE_VALUE: TCurrencyField;
    SQLActValue: TQuery;
    SQLCntPrtEleCatVal: TQuery;
    SQLCntDate: TQuery;
    SQLPrtDate: TQuery;
    SQLCosts: TQuery;
    SQLPrtDateORIG_START_DT: TStringField;
    SQLPrtDateAMEND_START_DT: TStringField;
    tblCostsCONTRACT_NO: TStringField;
    tblCostsACT_PAID_NO: TStringField;
    tblCostsELEMENT_NO: TStringField;
    tblCostsGL_ACCOUNT: TStringField;
    tblCostsDOCUMENT_TYPE: TStringField;
    tblCostsDOCUMENT_NO: TStringField;
    tblCostsEQUIP_NO: TStringField;
    tblCostsPERCENT: TStringField;
    SQLCCVal: TQuery;
    SQLCostsGL_ACCOUNT: TStringField;
    SQLCostsEQUIP_NO: TStringField;
    SQLCostsWORK_ORDER: TStringField;
    SQLCostsPROJECT_NO: TStringField;
    SQLCostsALLOC_PC: TFloatField;
    SQLCCValACCOUNT_CODE: TStringField;
    SQLPendents: TQuery;
    StblApprove: TDataSource;
    SQLRep04STATUS: TStringField;
    tblApprove: TTable;
    tblApproveCONTRACT_NO: TStringField;
    tblApprovePORTION_NO: TStringField;
    tblApproveACT_PAID_NO: TStringField;
    tblApproveACT_PAID_DATE: TStringField;
    tblApproveSUPPLIER_NO: TStringField;
    tblApproveSTATUS: TStringField;
    tblApproveCURRENCY: TStringField;
    tblApproveSUPPLIER_NAME: TStringField;
    tblApproveCONTRACT_VAL: TCurrencyField;
    tblApproveVALUE: TCurrencyField;
    tblApproveBUDGET_VALUE: TCurrencyField;
    SQLPendentsCONTRACT_NO: TStringField;
    SQLPendentsPORTION_NO: TStringField;
    SQLPendentsACT_PAID_NO: TStringField;
    SQLPendentsSUPPLIER_NO: TStringField;
    SQLPendentsCONTRACT_VAL: TCurrencyField;
    SQLSetApproved: TQuery;
    SQLPendentsACT_PAID_DATE: TStringField;
    SQLRep01CATEG_BASE_QTY: TFloatField;
    SQLRep02CATEG_BASE_QTY: TFloatField;
    SQLContractAPPROVED_BY: TStringField;
    SQLContractEMPLOY_TYPE_1: TStringField;
    SQLContractEMPLOY_TYPE_2: TStringField;
    SQLContractEMPLOY_TYPE_3: TStringField;
    SQLContractEMPLOY_TYPE_4: TStringField;
    SQLRep03CONTRACT_DESC: TStringField;
    SQLRep03ORIG_COMPL_DT: TStringField;
    SQLRep03AMEND_COMPL_DT: TStringField;
    SQLRep03FINAL_COMPL_DT: TStringField;
    SQLSupplierId: TQuery;
    SQLRep03DSTRCT_CODE: TStringField;
    SQLPortionPORTION_DESC: TStringField;
    SQLContractDSTRCT_CODE: TStringField;
    SQLPortionAMEND_COMPL_DT: TStringField;
    SQLPortionFINAL_COMPL_DT: TStringField;
    SQLPortionAMEND_START_DT: TStringField;
    SQLActPaidExtPRV_EXEC_VALUE: TFloatField;
    SQLContracts: TQuery;
    SQLContractsCONTRACT_NO: TStringField;
    SQLContractsCNTRCT_BASE_DT: TStringField;
    SQLContractsCONTRACT_DESC: TStringField;
    SQLRep04PRV_EXEC_VALUE: TCurrencyField;
    SQLContractCNTRCT_BASE_DT: TStringField;
    SQLCompany: TQuery;
    SQLContractORIG_START_DT: TStringField;
    SQLContractAMEND_START_DT: TStringField;
    SQLContractORIG_COMPL_DT: TStringField;
    SQLContractAMEND_COMPL_DT: TStringField;
    SQLContractFINAL_COMPL_DT: TStringField;
    SQLActPaidExtPRV_EXEC_VALUE1: TFloatField;
    SQLCstmCtg: TQuery;
    SQLCC_WO: TQuery;
    SQLCC_Equip: TQuery;
    SQLCC_Project: TQuery;
    SQLCntPrtEleELEMENT_VAL: TCurrencyField;
    SQLActPaidExtTYPE_COMMENTS: TStringField;
    SQLActPaidExtTYPE_CNTRCT_EXT: TStringField;
    SQLUserConfig: TQuery;
    SQLUserConfigDSTRCT_CODE: TStringField;
    SQLUserConfigEMPLOYEE_ID: TStringField;
    SQLUserConfigCC_TYPE_DSTRB: TStringField;
    SQLUserConfigCC_DEFAULT_DSTRB: TStringField;
    SQLUserConfigTYPE_COMMENTS: TStringField;
    SQLUserConfigTYPE_CNTRCT_EXT: TStringField;
    SQLUserConfigLOAD_INV_TYPE: TStringField;
    SQLUserConfigACT_VALIDATION: TStringField;
    SQLUserConfigTYPE_CNT_LIMIT: TStringField;
    SQLCCCurrent: TQuery;
    SQLCCCurrentELEMENT_NO: TStringField;
    SQLCCCurrentGL_ACCOUNT: TStringField;
    SQLCCCurrentDOCUMENT_TYPE: TStringField;
    SQLCCCurrentDOCUMENT_NO: TStringField;
    SQLCCCurrentEQUIP_NO: TStringField;
    SQLCCCurrentPERCENT: TStringField;
    SQLComments: TQuery;
    SQLCommentsACT_COMMENTS: TMemoField;
    SQLCommentsCONTRACT_NO: TStringField;
    SQLInsMemo: TQuery;
    SQLUpdMemo: TQuery;
    SQLInsCCCrr: TQuery;
    SQLUpdCCCrr: TQuery;
    SQLDelCCCrr: TQuery;
    SQLUpdActPaid: TQuery;
    SQLGetInvAut: TQuery;
    SQLGetCntExt: TQuery;
    SQLUserConfigINV_VALIDATION: TStringField;
    SQLCntPrtEleVal: TQuery;
    SQLValEleAct: TQuery;
    tblCostsVALUE: TCurrencyField;
    SQLEmployeeEMPLOYEE_ID: TStringField;
    SQLGetCrrRt: TQuery;
    SQLContractPERF_GTEE_VAL: TFloatField;
    SQLGetLocCrr: TQuery;
    SQLPendentsCURRENCY_TYPE: TStringField;
    SQLUserConfigAP_INFO_ATAX: TStringField;
    SQLActPaidExtCC_TYPE_DSTRB: TStringField;
    SQLActPaidExtAP_INFO_ATAX: TStringField;
    SQLActPaidExtINV_CURRENCY: TStringField;
    SQLActPaidExtINV_CHANGE_RATE: TFloatField;
    SQLActPaidExtINV_CHANGE_RATE_DT: TStringField;
    SQLInfoAtax: TQuery;
    SQLInfoAtaxCONTRACT_NO: TStringField;
    SQLInfoAtaxACT_PAID_NO: TStringField;
    SQLInfoAtaxATAX_CODE: TStringField;
    SQLInfoAtaxATAX_RATE: TFloatField;
    SQLInfoAtaxATAX_BASE: TFloatField;
    SQLInfoAtaxATAX_VALUE: TFloatField;
    tblInfoAtax: TTable;
    tblInfoAtaxATAX_CODE: TStringField;
    tblInfoAtaxATAX_RATE: TFloatField;
    tblInfoAtaxATAX_BASE: TCurrencyField;
    tblInfoAtaxATAX_VALUE: TCurrencyField;
    StblInfoAtax: TDataSource;
    SQLAtaxCodes010: TQuery;
    tblInfoAtaxATAX_LK_CODE: TStringField;
    SQLAtaxCodes010TABLE_CODE: TStringField;
    SQLAtaxCodes010TABLE_DESC: TStringField;
    SQLAtaxCodes010ASSOC_REC: TStringField;
    tblInfoAtaxATAX_LK_DESC: TStringField;
    SQLGetCrr: TQuery;
    SQLInsInfAtx: TQuery;
    SQLDelInfAtx: TQuery;
    SQLPrvAPCode: TQuery;
    SQLActPaidExtAPPROVE_DATE: TStringField;
    SQLUserConfigAP_RIGHT: TStringField;
    SQLPortionRESPONS_CODE_1: TStringField;
    SQLPortionRESPONS_CODE_2: TStringField;
    SQLPortionRESPONS_CODE_3: TStringField;
    SQLPortionRESPONS_CODE_4: TStringField;
    SQLActBdgVal: TQuery;
    SQLToday: TQuery;
    SQLEleNoDefs: TQuery;
    SQLEleNoDefsTABLE_CODE: TStringField;
    SQLEleNoDefsASSOC_REC: TStringField;
    SQLThrdPrtyInv: TQuery;
    SQLItemsDISCOUNT_FLAG: TStringField;
    SQLItemsTPI_FLAG: TStringField;
    SQLActPaidExtPERIOD_FROM: TStringField;
    SQLActPaidExtPERIOD_TO: TStringField;
    SQLPortionCONTRACT_LOCAT: TStringField;
    SQLPortionLIQ_DAM_BASE: TStringField;
    SQLCntOriCod: TQuery;
    SQLValCCDst: TQuery;
    SQLValCCDstELEMENT_NO: TStringField;
    SQLValCCDstGL_ACCOUNT: TStringField;
    SQLValCCDstDOCUMENT_TYPE: TStringField;
    SQLValCCDstDOCUMENT_NO: TStringField;
    SQLItemsPERCENT_FLAG: TStringField;
    SQLElementPlus: TQuery;
    SQLUserConfigAP_SECUENCE: TStringField;
    SQLAIUXPrc: TQuery;
    tblInfoAtaxATAX_CALC_VALUE: TCurrencyField;
    SQLValSppAct: TQuery;
    SQLValCCMims: TQuery;
    SQLValGLMims: TQuery;
    SQLCurrentHier: TQuery;
    SQLActEnviadoPor: TQuery;
    SQLValMinMaxACCP: TQuery;
    SQLBuscaSup: TQuery;
    SQLGetSecCurr: TQuery;
    SQLGetCurrType: TQuery;
    SQLUpdAppr: TQuery;
    SQLupdEnviador: TQuery;
    SQLGetCurrStatus: TQuery;
    SQLGetUserIdPos: TQuery;
    SQLGetPosApprover: TQuery;
    SQLBuscaSub: TQuery;
    SQLDelCCA3Zero: TQuery;
    SQLDelCCA6Zero: TQuery;
    SQLGetEmpNames: TQuery;
    SQLValorPrevio: TQuery;
    SQLValorActa: TQuery;
    UpdValorPevio: TQuery;
    SQLRestaValor: TQuery;
    SQLGetAnalista: TQuery;
    SQLGetElemAI: TQuery;
    SQLGetLastChg: TQuery;
    SQLSupplierSUP_TYPEX5: TStringField;
    SQLValorPagado: TQuery;
    SQLGetSentDate: TQuery;
    SQLCstmCtgELEMENT_NO: TStringField;
    SQLCstmCtgCATEGORY_NO: TStringField;
    SQLCstmCtgCATEG_DESC: TStringField;
    SQLContractSTATUS_384: TStringField;
    SQLGetContractAdministrator: TQuery;
    SQLGetAtaxDesc010: TQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    SQLPortionLIQ_DAM_LIMIT: TFloatField;
    SQLGetAuthyValue: TQuery;
    tblDetailELEMENT_CODE: TStringField;
    SQLGetMinPorEle: TQuery;
    SQLLevelAccess: TQuery;
    SQLLevelAccessReal: TQuery;
    SQLDeleteSpecialChar: TQuery;
    tblSearchEXT_INV_NO: TStringField;
    SQLDeleteZeroPaidValue: TQuery;
    SQLCheckCCList: TQuery;
    SQLElementCode: TQuery;
    {tblSearchUSER_ID: TStringField;
    tblSearchPOSITION_ID: TStringField;}
    //SQLValnNo: TQuery;
    {SQLElementPlusTABLE_CODE: TStringField;
    SQLElementPlusASSOC_REC: TStringField;}
    procedure dmActsDestroy(Sender: TObject);
    procedure tblDetailCalcFields(DataSet: TDataSet);
    procedure tblDetailQUANTITYValidate(Sender: TField);
    procedure tblDetailGLOBAL_VALUEValidate(Sender: TField);
    procedure tblSearchSTATUSGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure tblCostsDOCUMENT_TYPEGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure tblCostsPERCENTGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure tblCostsPERCENTSetText(Sender: TField; const Text: String);
    procedure tblCostsBeforeInsert(DataSet: TDataSet);
    procedure tblCostsNewRecord(DataSet: TDataSet);
    procedure tblCostsBeforePost(DataSet: TDataSet);
    procedure tblCostsBeforePost2(DataSet: TDataSet);
    procedure tblCostsBeforePostJuvinao();
    procedure tblApproveSTATUSSetText(Sender: TField; const Text: String);
    procedure tblApproveAfterPost(DataSet: TDataSet);
    procedure tblApproveBeforeInsert(DataSet: TDataSet);
    procedure tblDetailAfterPost(DataSet: TDataSet);
    procedure tblApproveBeforePost(DataSet: TDataSet);
    procedure tblCostsDOCUMENT_TYPESetText(Sender: TField;
      const Text: String);
    procedure tblInfoAtaxNewRecord(DataSet: TDataSet);
    procedure SsnActPaidStartup(Sender: TObject);
    procedure tblInfoAtaxBeforePost(DataSet: TDataSet);
    procedure tblCostsDOCUMENT_NOSetText(Sender: TField;
      const Text: String);
    procedure tblCostsDOCUMENT_NOGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure tblCostsGL_ACCOUNTSetText(Sender: TField;
      const Text: String);
    procedure tblDetailBeforePost(DataSet: TDataSet);
    procedure tblInfoAtaxCalcFields(DataSet: TDataSet);
    procedure tblInfoAtaxATAX_RATEChange(Sender: TField);
    procedure tblDetailQUANTITYGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure tblDetailGLOBAL_VALUEGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    function GetContractAdministrator(Contract_no, portion_no: string):string;
    procedure tblInfoAtaxATAX_CODEChange(Sender: TField);
    function GetAtaxDesc(AtaxCode : String) : String;
    function GetValuationAuth(AuthorityType : String):Boolean;
    function IsValidCCList(ContractNo, PortionNo : String): boolean;
    function GetMinPorEle(AContract, APortion : String):String;
    function VerifyComments(MimsFieldValue : String):String;
  private
    { Private declarations }
    FElements:          TElementList;{ Cache list for Elements }
    FEleXPercent:       TEleXPercent;{ Cache list for Elements calculated by percent }
    FOldEleXPrc:        TEleXPercent; { List of original Elements in FEleXPercent }
    FElementNoDefs:     TElementNoDefs; { Cache list for Elements No General Definitions }
    FCrrEleNoDef:       TElementNoDefs; { Cache list for Elements No Current Definitions in the Act }
    FElementActs:       TElementActs;{ Elements used by the Acts }
    FEleNoEleCodes:     TEleNoEleCodes; { Links between Elements No and its Elements Code }
    FElementValues:     TElementVals;{ Values of the elements in the current Act }
    FSuppliers:         TStringList;{ Cache list for Suppliers }
    FCurrentLoadStep:   Integer;    { Number of the current step loading the program }
    FCurrentCompany:    String;     { Name of the current company }
    FCurrentUserID:     String;     { User_Id of the current user }
    FCurrentHost:       String;
    FCurrentEnv:        String;
    FCurrentPassword:   String;
    FCurrentUser:       String;     { Employee_Id of the current user }
    FUserIDType:        String;     { ID Type (Mnemonic or Employee_Id) }
    FCurrentDistrict:   String;     { District code of the current session }
    FCurrentSupplier:   String;     { Supplier code used for reports }
    FHost:              String;     { Host machine }
    FPort:              String;     { Port }
    FHostUserName:      String;     { Name of the user logged on the host }
    FHostPassword:      String;     { Password of the user logged on the host }
    FMimsPassword:      String;     { Password to connect MIMS }
    FMimsPosition:      String;     { User position in MIMS }
    FLocalCurrency:     String;     { Local currency for the current district }
    FMaxToApprove:      Currency;   { Max Value of an Act that the user can approve }
    FUserRights:        TUserRights;{ User rights access on SAQ301 }
    FUseAsCCC:          Boolean;    { True = Use the Cost Center in the Act as Currents }
    FDetails:           TCategoryList;{ Cache list for categories in the Contract }
    FCurrentActPaid:    TActPaidDef;{ Fields of the Current Act Paid }
    FValInActLoaded:    Boolean;    { Internal Flag to optimize load of element values }
    FEnabledInsert:     Boolean;    { Flag to enable/disable Insert operations }
    FOnFeedBack:        TNotifyEvent;{ Used to show to user the progress in the operations }
    FDefaultPercent:    String;     { Default percent for a new Cost Center in an element }
    FMIMSHelpFile:      String;     { MIMS Help File. Full Name }
    FMIMSAppHelpFile:   String;     { MIMS Application Help File. Full Name }

    FProjEntryInd:      String;     { Project Entry Indicator MSF966 }

    FCategoryNames:     TCstmCtgNms;{ Custom Category Names }
    FUserConfig:        TUserConfig;{ User Preferences Configuration }
    FCCCList:           TCCCList;   { List of current default Cost Centers }
    FCCClipboard:       TCCCBList;  { List of Cost Centers in Clipboard }
    FCurrencyList:      TStringList;{ List of avalaible Currencies }
    FPrivateDirectory:  String;     { Private Directory for the session }
    FOnlyAlertOnError:  Boolean;    { Flag to decide if an error must be critic or only an Alert }
    FEditMode:          Boolean;    { True = User is editing an Act , False = Not }
    FDefaultLoading:    Boolean;    { Rolando Celedón 2003/04/30. True = System is loading default values }
    FLoadingActPaid:    Boolean;    { Rolando Celedón 2003/02/19. True = System is loading an Act Paid }
    FMustShowWarning:   Boolean;    { Rolando Celedón 2003/02/19. True = Show warning about inactive CC }
    { Param Objects for the SQLInsEleCat Query }
    FPIECContract:      TParam;
    FPIECActPaid:       TParam;
    FPIECElement:       TParam;
    FPIECCategory:      TParam;
    FPIECRateValue:     TParam;
    FPIECQuantity:      TParam;
    FPIECValue:         TParam;
    FPIECDiscountFlag:  TParam;
    FPIECTPIFlag:       TParam;
    FPIECPercentFlag:   TParam;
    { Param Objects for the SQLUpdEleCat Query }
    FPUECContract:      TParam;
    FPUECActPaid:       TParam;
    FPUECElement:       TParam;
    FPUECCategory:      TParam;
    FPUECQuantity:      TParam;
    FPUECValue:         TParam;
    { Param Objects for the SQLInsCCCrr Query }
    FPICCContract:      TParam;
    FPICCPortion:       TParam;
    FPICCElement:       TParam;
    FPICCGLAccount:     TParam;
    FPICCDocumentType:  TParam;
    FPICCDocument:      TParam;
    FPICCEquip:         TParam;
    FPICCPercent:       TParam;
    { Param Objects for the SQLUpdCCCrr Query }
    FPUCCContract:      TParam;
    FPUCCPortion:       TParam;
    FPUCCElement:       TParam;
    FPUCCGLAccount:     TParam;
    FPUCCDocumentType:  TParam;
    FPUCCDocument:      TParam;
    FPUCCEquip:         TParam;
    FPUCCPercent:       TParam;
    { Param Objects for the SQLDelCCCrr Query }
    FPDCCContract:      TParam;
    FPDCCPortion:       TParam;
    FPDCCElement:       TParam;
    FPDCCGLAccount:     TParam;
    { Param Objects for the SQLSetApproved Query }
    FPSAAnStatus:       TParam;
    FPSAAUser:          TParam;
    FPSAADate:          TParam;
    FPSAAPrtValue:      TParam;
    FPSAACntValue:      TParam;
    FPSAAContract:      TParam;
    FPSAAActPaid:       TParam;
    FPSAAOldStatus:     TParam;
    { TField Objects for the SQLActs Query. Differents for each Search. }
    SQLActsContractNo:  TField;
    SQLActsActPaidNo:   TField;
    SQLActsPortionNo:   TField;
    SQLActsActPaidDate: TField;
    SQLActsStatus:      TField;
    SQLActsSupplierNo:  TField;
    SQLActsEmpAprobador:TField;
    SQLActsPosAprobador:TField;
    SQLActsExtInvNo    :TField;

    //SQLActsValnNo     :  TField;

{De Moya - 2002-07-08}
{SQLActsApproved_by was not defined}
    SQLActsApproved_by:  TField;
    { Rolando Celedón 2003-06-19 Flag to detect if
      the system is editing a New Act }
    FNewAct:            Boolean;
    FApproveAct:        Boolean;
    //FValnNo:            String;
    FShowCombineError:  Boolean;
    Function GettblDetailVALUE:Currency;
    Function GetCompanyName:String;
    Function SameCategory(Node:TCategoryDef):Boolean;
    Function AreThereChanges(Node:TCategoryDef):Boolean;
    Function GetDateTimeInServer:TDateTime;
    Function GetCurrentDate:String;
    Function GetActPaidNewNetValue:Currency;
    Function GetActPaidNetValue:Currency;
    Function GetActPaidNewValue:Currency;
    Function GetCostCenterForEquip(AnEquip:String):String;
    Function GetCostCenterForWO(AnOrder:String):String;
    Function GetCostCenterForProject(AProject:String):String;
    Function GetAuthorisedLimitToApprove:Currency;
    Function GetLocalCurrency(ADistrict:String):String;
    Function GetExecAPValue:Currency;
    Function GetLevelAccess(MimsPosition:String):String;
    Function GetLevelAccessReal(MimsPosition:String):String;
    Procedure ValidateEquip(AnEquip:String);
    Procedure ValidateWorkOrder(AnOrder:String);
    Procedure ValidateProject(AProject,AccountCode:String);
    Procedure ValidateThirdPartyInv(AThirdPartyInv:String);
    Procedure ValidateDocumentType(ADocumentType:TDocument);
    Procedure CreatetblDetailDefinition;
    Procedure InitTemporalTable(ATable:TTable);
    procedure DeleteTemporalTable(ATable:TTable);
    Procedure GetParamObjectsForSQLInsEleCat;
    Procedure GetParamObjectsForSQLUpdEleCat;
    Procedure GetParamObjectsForSQLInsCCCrr;
    Procedure GetParamObjectsForSQLUpdCCCrr;
    Procedure GetParamObjectsForSQLDelCCCrr;
    Procedure GetParamObjectsForSQLSetApproved;
    procedure LoadRegistryInformation;
    procedure LoadElementsTopValues;
    Procedure LoadPaidsToElements;
    Procedure LoadElementsValuesInAct;
    Procedure ValidateElementNoFlags(AnElementNo:String);
    Procedure ValidateElementNoFlags2(AnElementNo:String);
    Procedure ValidateCCDistributionLine;
    procedure ValidateCostCenter;
    Procedure ValidateByElement(AContract,APortion,AnAct:String);
    Procedure ValidateByPortion;
    Procedure ValidateByContract;
    Procedure ValidateBySignedPortion;
    Procedure ValidateBySignedContract;
    Procedure RedefineSQLPendents;
    Procedure InitActStructures;
    Procedure SetCCPercentFromValues;
    Procedure SaveCurrentCC;
    Procedure ForceSaveCurrentCC;
    Procedure CreateCurrencyList;
    Procedure DeleteInfoAtax(AContract,AnActPaid:String);
    Procedure InsertInfoAtaxCode;
    Procedure UpdateInfoAtaxForAct;
    Procedure UpdateActsStatusToSent;
    Procedure UpdateActsStatusToApproved;
    procedure ValidateCCDataField(AField:TField);
    Procedure ValidateNegativeValue(AnElement,AType:String;AValue:Double);
    Procedure DeleteInTblCostsACCFrom(AnElementNo:String;ACC:TCCByPercent);
    Procedure DeleteInTblCostsCCsFrom(AnElement:TElementPercent);
    Procedure DeleteInTblCostsCCsNotIn(AnElementNo:String;ACCSrcs,ACCsTrg:TCCsByPercent);
    Procedure DeleteCCByPercentsNotLongerUsed;
  {  Procedure AbrirLog;  }
  protected
    { Protected declarations }
    Procedure DoOnFeedBack(Sender:TObject); virtual;
  public
    { Public declarations }
  {  ArcLog:             TextFile; }
    Destructor Destroy; override;
    procedure DeleteTemporalTables;
    Function ConnectToDBMIMS: boolean;
    //Function SQLGetValnNo(AContract,AActPaidNo:String) : String;
    Function IsElementNoDiscount(AnElementNo:String):Boolean;
    Function IsElementNoThirdPartyInv(AnElementNo:String):Boolean;
    Function GetEmployeeName(AnEmployee:String;MustExists:Boolean):String;
    Function GetEmployeeNameAnalista(AnEmployee:String;MustExists:Boolean):String;
    Function GetSupplierId(ADistrict,ASupplier:String):String;
    Function GetSupplierName(ASupplier:String):String;
    //Begin Cbanquet 2016-10-10
    Function GetUserIdInSearch(AContract,AnActPaid:String):String;
    Function GetPositionIdInSearch(AContract,AnActPaid:String):String;
    Function GetContractDate(AContract:String):String;
    Function GetPortionDate(AContract,APortion:String):String;
    Function GetPaidsToContract(AContract:String):Currency;
    Function GetPaidsToPortion(AContract,APortion:String):Currency;
    Function GetEmployeeID(AUser:String):String;
    Function GetUserEmployeeID(AUser:String):String;
    Function GetElementCode(AContractNo,APortionNo,AElementNo:String):String;
    Function GetLastCodeOfActPaid(AContract:String):Integer;
    Function GetActPaidValue(AContract,AnActPaid:String):Currency;
    Function GetActPaidBudgetValue(AContract,AnActPaid:String):Currency;
    Function GetCurrentElementValue:Currency;
    Function GetTotalPercentAssigned:Integer;
    Function GetCCValuesAssignedByElement:Currency;
    Function GetTotalApproved:Currency;
    Function GetCurrencyRate(ALocalCrr,AForeignCrr,ADate:String):Double;
    Function HasRight(AField:TField;AType:String):Boolean;
    Function CanCreateAct:Boolean;
    Function GetContractExtDate(AContract:String):String;
    Function GetPreviousActPaidCode(AContract,ADate:String):String;
    Function ToLocalCurrency(ACurrency:String;AValue:Currency):Currency;
    Function ElementOrderOf(AnElement:String):Integer;
    Function SortByElementKind(Item1, Item2: Pointer): Integer;
    Function GetOriginalContractCode(AContract:String):String;
    Procedure GetActPaidInfoAtax(AContract,AnActPaid:String);
    Procedure CreateTemporalAtaxTable;
    Procedure CreateTemporalAtaxTableFromDistrictDefault;
    Procedure GetPaidsToCategory(AContract,APortion,AnElement,ACategory:String;
                                 Var AValue:Currency;Var AQuantity:Double);
    Procedure GetActPaidExt(AContract,AnActPaid:String;
                            Var AnAdministrator,AnApprover,AnApproveDate:String;
                            Var APaidPrtExe,APaidCntExe:Currency;
                            Var AnInvCurrency,AnInvChangeRateDt:String;
                            Var AnInvChangeRate:Double;
                            Var APeriodFrom,APeriodTo:String);
    Procedure GetPaidsToElements(AContract,APortion:String);
    Procedure GetElementsValuesInAct(AContract,AnActPaid:String);
    Procedure LoadUserConfiguration;
    Procedure LoadElements;
    Procedure LoadElementsIn(AContract,APortion:String);
    Procedure LoadElementNoDefinitions;
    Procedure GetSuppliers(AMask,AnIdentity:String);
    Procedure LoadSuppliers(AList:TListBox;AMask,AnIdentity:String);
    Procedure SearchResultsToAuxiliaryTable(ACommon:TActPaidDef);
    Procedure GetContractDefinition(AContract:String);
    Procedure GetPortionDefinition(AContract,APortion:String);
    Procedure GetActElementsFor(AContract,APortion:String);
    Procedure LoadCustomCategoryNames(AContract,APortion:String);
    Procedure RefreshCustomCategoryNames(AContract,APortion:String);
    Procedure GetContractCategories(AContract,APortion:String);
    Procedure GetActCategories(AContract,AnAct:String);
    Procedure GetActsPaid(SelectLine,Condition:String);
    Procedure GetFieldsDefinitionForActs;
    Procedure SaveCategoriesInMemory;
    Procedure CombineCategories;
    Procedure CombineCategories2;
    Procedure CompleteLoadOfCrrEleNoDef;
    Procedure CreateListOfElementsByPercent;
    Procedure CreateListOfOldElementsByPercent;
    Procedure ElementsCategoriesToAuxiliaryTable;
    Procedure SetCategoryRangeForDisplay(AnElement:String);
    Procedure ValidateCCDistribution(AContract,AnActPaid:String);
    Procedure ValidateActPaidEditions;
    Procedure InsertActPaid(AContract,APortion,AnActPaid:String);
    Procedure UpdateActPaid(AContract,AnActPaid,
                            AnInvCurrency,AnInvChangeRateDt:String;
                            AnInvChangeRate:Double;
                            APeriodFrom,APeriodTo:String);
    Procedure SaveActPaidDocument(MmComments:TMemo;
                                  AnInvCurrency,AnInvChangeRateDt:String;
                                  AnInvChangeRate:Double;
                                  APeriodFrom,APeriodTo:String);
    Procedure OpenComments;
    Procedure SaveComments(AQuery:TQuery;AMemo:TMemo);
    Procedure SetActPaidStatus(AContract,AnActPaid,AnStatus,AOldStatus:String);
    Procedure SetActPaidApproved(AContract,AnActPaid:String;ACntValue,APrtValue:Currency);
    Procedure InsertCategory(AnElement,ACategory:String;
                             AQuantity:Double;ARate,AValue:Currency);
    Procedure UpdateCategory(AnElement,ACategory:String;
                             AQuantity:Double;AValue:Currency);
    Procedure InsertCostCenter;
    Procedure UpdateCostCenter;
    Procedure DeleteCostCenter(AnElement,AGLAccount:String);
    Procedure DeleteCCNoUsed;
    Procedure SaveCategoriesToDisk;
    Procedure LoadLogotype(ADistrict:String);
    Procedure ReadCurrentCostCentersFor(AContract,APortion:String);
    Procedure GetOriginalCostCenters(AContract,APortion,AnElement:String);
    Procedure GetCurrentCostCenters(AContract,APortion:String);
    Procedure SetCostCentersRangeForDisplay(AContract,AnAct,AnElement:String);
    Procedure SetCostCentersRangeForDisplay2(AContract,AnAct,AnElement:String);
    Procedure SetCostCentersRangeForDisplayJuvinao(AContract,AnAct,AnElement:String);
    Procedure SetCostCentersRangeForSave(AContract,AnAct:String);
    Procedure CopyCostCentersFromContractToActs;
    Procedure CopyCostCentersFromCurrentToActs;
    Procedure DefaultCostCenterFromContract;
    Procedure DefaultCostCenterFromCurrent;
    Procedure GetSentActsTo(AnApprover:String);
    Procedure CopyPendentsToTemporalTable;
    Procedure ApproveActPaid;
    Procedure UpdateActsStatus;
    Procedure GetContractRange(Var StartDateStr,FinalDateStr:String);
    Procedure GetPortionRange(Var StartDateStr,FinalDateStr:String);
    Function FindCategoryWithText(AText:String):Boolean;
    Procedure ValidateSupplierStatus(ASupplierId:String);
    { Routines relatives to Elements "calculated by percent" }
    Function IsAIUCCPercentDistributionOn:Boolean;
    Procedure GetEditValueOfTheElements;
    Function GetEditValueOfTheElementsJuvinao (ElementNo:String):Boolean;
    Procedure CalcElementsByPercent;
    Procedure SetDetailValuesForElementsByPercent;
    Procedure ProcessCCs(AnElement:TElementPercent;AnElementNo:String;APercent:Double);
    Procedure CalcCCByPercents(AnEleXPercent:TEleXPercent);
    Procedure SaveInCacheCCByPercents;
    Procedure SaveCCCalcToTblCost;
    Procedure ValidateZeroPaidValue(ContractNo,ActPaidNo:String);
    { Queries used by the reports of the Acts module }
    Procedure GetUserContracts;
    Procedure ExecQueryForRep01;
    Procedure ExecQueryForRep02(ACondition:String);
    Procedure ExecQueryForRep03;
    Procedure ExecQueryForRep04(ACondition:String);
    Property MIMSHelpFile:String        Read FMIMSHelpFile;
    Property MIMSAppHelpFile:String     Read FMIMSAppHelpFile;
    Property CurrentCompany:String      Read FCurrentCompany;
    Property CurrentUserID:String       Read FCurrentUserID Write FCurrentUserID;
    Property CurrentUser:String         Read FCurrentUser Write FCurrentUser;
    Property DateTimeInServer:TDateTime Read GetDateTimeInServer;
    Property CurrentDate:String         Read GetCurrentDate;
    Property CurrentDistrict:String     Read FCurrentDistrict;
    Property CurrentPassword:String     Read FCurrentPassword;
    Property CurrentHost:String         Read FCurrentHost;
    Property CurrentEnv:String          Read FCurrentEnv;
    Property UserIDType:String          Read FUserIDType;
    Property CurrentActPaid:TActPaidDef Read FCurrentActPaid;
    Property CurrentSupplier:String     Read FCurrentSupplier Write FCurrentSupplier;
    Property ShowCombineError:Boolean   Read FShowCombineError Write FShowCombineError;
    Property MimsPosition:String        Read FMimsPosition Write FMimsPosition;
    Property LocalCurrency:String       Read FLocalCurrency Write FLocalCurrency;
    Property MaxToApprove:Currency      Read FMaxToApprove Write FMaxToApprove;
    Property UseAsCCC:Boolean           Read FUseAsCCC Write FUseAsCCC;
    Property ValInActLoaded:Boolean     Read FValInActLoaded Write FValInActLoaded;
    Property Elements:TElementList      Read FElements;
    Property EleXPercent:TEleXPercent   Read FEleXPercent;
    Property OldEleXPrc:TEleXPercent    Read FOldEleXPrc;
    Property CrrEleNoDef:TElementNoDefs Read FCrrEleNoDef;
    Property ElementActs:TElementActs   Read FElementActs;
    Property EleNoEleCodes:TEleNoEleCodes Read FEleNoEleCodes;
    Property ElementValues:TElementVals Read FElementValues;
    Property Details:TCategoryList      Read FDetails;
    Property ActPaidNewNetValue:Currency Read GetActPaidNewNetValue;
    Property ActPaidNetValue:Currency   Read GetActPaidNetValue;
    Property ActPaidNewValue:Currency   Read GetActPaidNewValue;
    Property CategoryNames:TCstmCtgNms  Read FCategoryNames;
    Property CCClipboard:TCCCBList      Read FCCClipboard;
    Property CCCList:TCCCList           Read FCCCList;
    Property CurrencyList:TStringList   Read FCurrencyList;
    Property EnabledInsert:Boolean      Read FEnabledInsert Write FEnabledInsert;
    Property UserConfig:TUserConfig     Read FUserConfig;
    Property UserRights:TUserRights     Read FUserRights;
    Property ExecAPValue:Currency       Read GetExecAPValue;
    Property DefaultLoading:Boolean     Read FDefaultLoading   Write FDefaultLoading;
    Property OnFeedBack:TNotifyEvent    Read FOnFeedBack       Write FOnFeedBack;
    Property OnlyAlertOnError:Boolean   Read FOnlyAlertOnError Write FOnlyAlertOnError;
    Property EditMode:Boolean           Read FEditMode         Write FEditMode;
    Property LoadingActPaid:Boolean     Read FLoadingActPaid   Write FLoadingActPaid;
    Property MustShowWarning:Boolean    Read FMustShowWarning  Write FMustShowWarning;
    Property NewAct:Boolean             Read FNewAct           Write FNewAct;
    Property ApproveAct:Boolean         Read FApproveAct       Write FApproveAct;
    //Property ValnNo:String              Read FValnNo           Write FValnNo;
    Property ProjEntryInd:String        Read FProjEntryInd;
  end;

var
  dmActs: TdmActs;

implementation

uses MCUtils, MCConnct, SAQ300002, SAQ300003, saq301001, saq301005, SAQUtils;

{$R *.DFM}

{ Get the current date and time setting in the server. The command used
  is only valid for Oracle. This routine must be updated to include other
  databases }
Function TdmActs.GetDateTimeInServer:TDateTime;
Begin
     With SQLToday Do Begin
          Try
             Try
                Active := True;
                If Fields[0].IsNull Then Begin
                   raise Exception.CreateFmt(ME_178,[SQL[0]]);
                End;
                GetDateTimeInServer := Fields[0].AsDateTime;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_179,[E.Message]);
             End;
          End;
     End;
End;
{ Get the current date in the format yyyymmdd. }
Function TdmActs.GetCurrentDate:String;
Var OldShortDateFormat : String;
Begin
     OldShortDateFormat:=ShortDateFormat;
     Try
        ShortDateFormat:='yyyymmdd';
        GetCurrentDate := DateToStr(DateTimeInServer);
     Finally
        ShortDateFormat:=OldShortDateFormat;
     End;
End;
{ Get the name of the current company from MSF000_SC0001, field COY_NAME }
Function TdmActs.GetCompanyName:String;
Var
   CompanyName:         String;
Begin
     With SQLCompany Do Begin
          Try
             Try
                Active := True;
                If Fields[0].IsNull Then Begin
                   raise Exception.Create(ME_083);
                End;
                CompanyName := Trim(Fields[0].AsString);
                If CompanyName = '' Then Begin
                   raise Exception.Create(ME_083);
                End;
                GetCompanyName := CompanyName;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                ShowMessage(Format(ME_084,[E.Message]));
                GetCompanyName := '';
             End;
          End;
     End;
End;
{ Use this function to get the net value. The net value is the value
  already saved to disk. Check the difference with GetActPaidNewNetValue }
Function TdmActs.GetActPaidNetValue:Currency;
Var
   NetEditedValue:      Currency;
   ListIndex:           Integer;
   TheCategory:         TCategoryDef;
Begin
     NetEditedValue := 0;
     ListIndex := 0;
     While ListIndex < FDetails.Count Do Begin
           TheCategory := FDetails.CategoryAt[ListIndex];
           If Not FElementNoDefs.IsDiscount[TheCategory.CategoryElement + TheCategory.CategoryElementCode] Then Begin
              NetEditedValue := NetEditedValue + TheCategory.CategoryGlobal;
           End;
           Inc(ListIndex);
     End;
     GetActPaidNetValue := NetEditedValue;
End;   {
Procedure TdmActs.AbrirLog;
Begin
     AssignFile(ArcLog,'C:\Temp\LogMisterio.txt');
     ReWrite(ArcLog);
End;      }
{ Use this function to get the act new net value. The new net value is the
  value still in memory (i.e not saved to disk .. yet ) }
Function TdmActs.GetActPaidNewNetValue:Currency;
Var
   NetEditedValue:      Currency;
   ListIndex:           Integer;
   TheCategory:         TCategoryDef;
 {  TheValue:            String;   }
Begin
    { WriteLn(ArcLog,'Inicia Traceo');   }
     NetEditedValue := 0;
     ListIndex      := 0;
     While ListIndex < FDetails.Count Do Begin
           TheCategory := FDetails.CategoryAt[ListIndex];
           {TheValue    := '';    }
           If Not FElementNoDefs.IsDiscount[TheCategory.CategoryElement + TheCategory.CategoryElementCode] Then Begin
              {TheValue := Format('%m',[TheCategory.CategoryValue]); }
              NetEditedValue := NetEditedValue + TheCategory.CategoryValue;
           End;
         {  WriteLn(ArcLog,ListIndex:5,' ',TheCategory.CategoryElement,TheValue);  }
           Inc(ListIndex);
     End;
    { TheValue := Format('%m',[NetEditedValue]);
     WriteLn(ArcLog,'Fin Traceo : ',TheValue); }
     GetActPaidNewNetValue := NetEditedValue;
End;
Function TdmActs.GetActPaidNewValue:Currency;
Begin
     GetActPaidNewValue := FDetails.EditedValue;
End;
{ Obsolete. Initially, It was used by CanCreateAct to verify if the user
  had right to create an act; but, now, all the user with some right over
  the corresponding contract will be authorized not only to create act,
  also to approve. We preserve HasRight only to future changes; but,
  actually, it's not called since any routine }

Function TdmActs.HasRight(AField:TField;AType:String):Boolean;
Begin
     HasRight := (AField.AsString = AType) Or (AField.AsString = ADC_Owner);
End;
{ Use this routine to verify if the current user is able to create new acts }
Function TdmActs.CanCreateAct:Boolean;
Begin
     If UserRights = urFullAccess Then Begin
        //ShowMessage(SQLPortionRESPONS_CODE_1.Value + SQLPortionRESPONS_CODE_2.Value +
        //SQLPortionRESPONS_CODE_3.Value + SQLPortionRESPONS_CODE_4.Value);
        Case UserConfig.APRight Of
        aprPortion  : CanCreateAct :=
                         ((CurrentUser=SQLPortionRESPONS_CODE_1.Value) Or
                          (CurrentUser=SQLPortionRESPONS_CODE_2.Value) Or
                          (CurrentUser=SQLPortionRESPONS_CODE_3.Value) Or
                          (CurrentUser=SQLPortionRESPONS_CODE_4.Value) );
        aprContract : CanCreateAct :=
                         ((CurrentUser=SQLContractRESPONS_CODE_1.Value) Or
                          (CurrentUser=SQLContractRESPONS_CODE_2.Value) Or
                          (CurrentUser=SQLContractRESPONS_CODE_3.Value) Or
                          (CurrentUser=SQLContractRESPONS_CODE_4.Value) );
        Else raise Exception.Create(ME_172);
        End; End
     Else Begin
        CanCreateAct := False;
     End;
End;

Procedure TdmActs.CreatetblDetailDefinition;
Begin
     With tblDetail Do Begin
          If Exists Then Begin
             Active := False;
             DeleteTable;
          End;
          with IndexDefs do begin
               Clear;
               { The 1st index has no name because it is
               { a Paradox primary key }
               with AddIndexDef do begin
                    Name   := '';
                    Fields := 'ELEMENT_NO;CATEGORY_NO';
                    Options := [ixPrimary];
               end;
               with AddIndexDef do begin
                    Name := 'BYDESC';
                    Fields := 'ELEMENT_NO;CATEGORY_DESC';
                    Options := [ixCaseInsensitive];
               end;
          end;
     End
End;
{ Create and Active a temporal table. The temporal Tables are located in the
  MIMS temporal directory (Alias MIMS) }
Procedure TdmActs.InitTemporalTable(ATable:TTable);
Begin
     With ATable Do Begin
          If Not Exists Then Begin
             CreateTable;
          End;
          Active := True;
     End;
End;
{ Delete a temporal table }
procedure TdmActs.DeleteTemporalTable(ATable:TTable);
begin
     With ATable Do Begin
          If UpdatesPending Then Begin
             CancelUpdates;
          End;
          Active := False;
          If Exists Then Begin
             DeleteTable;
          End;
     End;
end;
{ Param Objects for the SQLInsEleCat Query }
Procedure TdmActs.GetParamObjectsForSQLInsEleCat;
Begin
     With SQLInsEleCat.Params Do Begin
          FPIECContract     := ParamByName('AContract');
          FPIECActPaid      := ParamByName('AnActPaid');
          FPIECElement      := ParamByName('AnElement');
          FPIECCategory     := ParamByName('ACategory');
          FPIECRateValue    := ParamByName('ARateValue');
          FPIECQuantity     := ParamByName('AQuantity');
          FPIECValue        := ParamByName('AValue');
          FPIECDiscountFlag := ParamByName('ADiscountFlag');
          FPIECTPIFlag      := ParamByName('ATPIFlag');
          FPIECPercentFlag  := ParamByName('APercentFlag');
     End;
End;
{ Param Objects for the SQLUpdEleCat Query }
Procedure TdmActs.GetParamObjectsForSQLUpdEleCat;
Begin
     With SQLUpdEleCat.Params Do Begin
          FPUECContract  := ParamByName('AContract');
          FPUECActPaid   := ParamByName('AnActPaid');
          FPUECElement   := ParamByName('AnElement');
          FPUECCategory  := ParamByName('ACategory');
          FPUECQuantity  := ParamByName('AQuantity');
          FPUECValue     := ParamByName('AValue');
     End;
End;
{ Param Objects for the SQLInsCCCrr Query }
Procedure TdmActs.GetParamObjectsForSQLInsCCCrr;
Begin
     With SQLInsCCCrr.Params Do Begin
          FPICCContract     := ParamByName('AContract');
          FPICCPortion      := ParamByName('APortion');
          FPICCElement      := ParamByName('AnElement');
          FPICCGLAccount    := ParamByName('AGLAccount');
          FPICCDocumentType := ParamByName('ADocumentType');
          FPICCDocument     := ParamByName('ADocument');
          FPICCEquip        := ParamByName('AnEquip');
          FPICCPercent      := ParamByName('APercent');
     End;
End;
{ Param Objects for the SQLUpdCCCrr Query }
Procedure TdmActs.GetParamObjectsForSQLUpdCCCrr;
Begin
     With SQLUpdCCCrr.Params Do Begin
          FPUCCContract     := ParamByName('AContract');
          FPUCCPortion      := ParamByName('APortion');
          FPUCCElement      := ParamByName('AnElement');
          FPUCCGLAccount    := ParamByName('AGLAccount');
          FPUCCDocumentType := ParamByName('ADocumentType');
          FPUCCDocument     := ParamByName('ADocument');
          FPUCCEquip        := ParamByName('AnEquip');
          FPUCCPercent      := ParamByName('APercent');
     End;
End;
{ Param Objects for the SQLDelCCCrr Query }
Procedure TdmActs.GetParamObjectsForSQLDelCCCrr;
Begin
     With SQLDelCCCrr.Params Do Begin
          FPDCCContract     := ParamByName('AContract');
          FPDCCPortion      := ParamByName('APortion');
          FPDCCElement      := ParamByName('AnElement');
          FPDCCGLAccount    := ParamByName('AGLAccount');
     End;
End;
{ Param Objects for the SQLSetApproved Query }
Procedure TdmActs.GetParamObjectsForSQLSetApproved;
Begin
     With SQLSetApproved.Params Do Begin
          FPSAAnStatus   := ParamByName('AnStatus');
          FPSAAUser      := ParamByName('AnApprover');
          FPSAADate      := ParamByName('AnApproveDate');
          FPSAAPrtValue  := ParamByName('APrtValue');
          FPSAACntValue  := ParamByName('ACntValue');
          FPSAAContract  := ParamByName('AContract');
          FPSAAActPaid   := ParamByName('AnActPaidNo');
          FPSAAOldStatus := ParamByName('AOldStatus');
     End;
End;
{ Use this routine to call the OnFeedBack event. We use the standard methodology
  in spite of it's unnecessary because maybe other applications will use this
  data module }
Procedure TdmActs.DoOnFeedBack(Sender:TObject);
Begin
     If Assigned(FOnFeedBack) Then Begin
        FOnFeedBack(Sender);
     End;
End;
{ This function verify if the Node in the categories cache list is the same
  item that the corresponding record in the table Details }
Function TdmActs.SameCategory(Node:TCategoryDef):Boolean;
Begin
     SameCategory:=(Node.CategoryElement = tblDetailELEMENT_NO.AsString) And
                   (Node.CategoryNro = tblDetailCATEGORY_NO.AsString)
End;
{ This function verify if the user did changes to the information in the Node
  current in the categories cache list }
Function TdmActs.AreThereChanges(Node:TCategoryDef):Boolean;
Var
   HasChanges:          Boolean;
   IsByPercent:         Boolean;
   Difference:          Double;
Begin
     IsByPercent := CrrEleNoDef.IsPercent[tblDetailELEMENT_NO.AsString + tblDetailELEMENT_CODE.AsString];
     With Node Do Begin
          If CategoryByGlobal Or IsByPercent Then Begin
             Difference := CategoryGlobal - tblDetailGLOBAL_VALUE.AsCurrency;
             HasChanges := Abs(Difference) > Delta;End
          Else Begin
             Difference := CategoryQuantity - tblDetailQUANTITY.AsFloat;
             HasChanges := Abs(Difference) > Delta;
             If Not HasChanges Then Begin
                Difference := CategoryRate - tblDetailUNITARIAN_VALUE.AsCurrency;
                HasChanges := Abs(Difference) > Delta;
             End;
          End;
     End;
     AreThereChanges := HasChanges;
End;
{dbermudez}
Function TdmActs.GetElementCode(AContractNo,APortionNo,AElementNo:String):String;
begin
    With SQLElementCode Do Begin
          Try
             Active:=False;
             Params[0].AsString := trim(AContractNo);
             Params[1].AsString := trim(APortionNo);
             Params[2].AsString := trim(AElementNo);
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Not Fields[0].IsNull Then
                GetElementCode := Fields[0].AsString
             else
                GetElementCode := '';
          Except
             On E:Exception Do Begin
                GetElementCode := '';
             End;
          End;
     End;
End;

function TdmActs.GetMinPorEle(AContract, APortion : String):String;
Begin
     With SQLGetMinPorEle Do Begin
          Try
             Active:=False;
             Params[0].AsString := trim(AContract);
             Params[1].AsString := trim(APortion);
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Not Fields[0].IsNull Then
                GetMinPorEle := Fields[0].AsString
             else
                GetMinPorEle := '00';
          Except
             On E:Exception Do Begin
                GetMinPorEle := '00';
                {2004-03-31 De Moya Suprimo mensaje de error para la autoridad
                CPAU}
                {ShowMessageFmt(ME_119,[E.Message]);}
             End;
          End;
     End;
End;
function TdmActs.GetValuationAuth(AuthorityType : String):Boolean;
Begin
     With SQLGetAuthyValue Do Begin
          Try
             Active:=False;
             Params[0].AsString := trim(FMimsPosition);
             Params[1].AsString := trim(FCurrentDistrict);
             Params[2].AsString := trim(AuthorityType);
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then
                GetValuationAuth := false
             else
                GetValuationAuth := true;
          Except
             On E:Exception Do Begin
                GetValuationAuth := false;
                {2004-03-31 De Moya Suprimo mensaje de error para la autoridad
                CPAU}
                {ShowMessageFmt(ME_119,[E.Message]);}
             End;
          End;
     End;
End;
Function TdmActs.GetAuthorisedLimitToApprove:Currency;
Begin
     With SQLGetInvAut Do Begin
          Try
             Active:=False;
             Params[0].AsString := FMimsPosition;
             Params[1].AsString := FCurrentDistrict;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                raise Exception.CreateFmt(ME_118,[FMimsPosition,
                                                  FCurrentDistrict]);
             End;
             ShowMessage(Fields[0].AsString);
             GetAuthorisedLimitToApprove := Fields[0].AsCurrency;
          Except
             On E:Exception Do Begin
                GetAuthorisedLimitToApprove := 0;
                {2004-03-31 De Moya Suprimo mensaje de error para la autoridad
                CPAU}
                {ShowMessageFmt(ME_119,[E.Message]);}
             End;
          End;
     End;
End;
{ True = User is only able to use Cost Center distribution by Percent
         because he(she) is in the AIU user group
  False = User is able to choice the Cost Center Distribution : By Value
          or By percent }
Function TdmActs.IsAIUCCPercentDistributionOn:Boolean;
Begin
     IsAIUCCPercentDistributionOn := False;
     With SQLAIUXPrc Do Begin
          Try
             Active := False;
             Params[0].AsString := FMimsPosition;
             Params[1].AsString := FCurrentDistrict;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Not Fields[0].IsNull Then Begin
                IsAIUCCPercentDistributionOn := UpperCase(Fields[0].AsString) = 'Y';
                {raise Exception.CreateFmt(ME_118,[FMimsPosition,
                                                  FCurrentDistrict]); }
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_202,[FMimsPosition,
                                                  FCurrentDistrict,
                                                  E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to get the portion definition when an Act Paid is
  going to be created or to be edited }

Procedure TdmActs.GetPortionDefinition(AContract,APortion:String);
Begin
     With SQLPortion Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AContract;
             Params[1].AsString:=APortion;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_034);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_009,[APortion,AContract,E.Message]);
             End;
          End;
     End;
End;

Function TdmActs.IsElementNoDiscount(AnElementNo:String):Boolean;
Begin
     IsElementNoDiscount := FCrrEleNoDef.IsDiscount[AnElementNo];
End;
Function TdmActs.IsElementNoThirdPartyInv(AnElementNo:String):Boolean;
Begin
     IsElementNoThirdPartyInv := FCrrEleNoDef.IsThirdPartyInv[AnElementNo];
End;
{ Use this function to get the name of the employee with EMPLOYEE_ID = AnEmployee.
  The parameter MustExists force to validate that MSF810 has an Employee
  with EMPLOYEE_ID = AnEmployee. The validation require this EMPLOYEE_ID
  has a valid name defined in MSF810; it's not enough that MSF810 has
  a record for this EMPLOYEE_ID }

Function TdmActs.GetEmployeeName(AnEmployee:String;MustExists:Boolean):String;
Var
   NotName:             Boolean;    { True = User doesn't have a name }
Begin
     GetEmployeeName := '';
     With SQLEmployee Do Begin
          Try
             Active:=False;
 {De Moya 2006-08-17 Coloco trim para que la variable AnEmployee no tenga valores en
 blanco}
             Params[0].AsString:=trim(AnEmployee);
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active:=True;
                If MustExists And IsEmptyField(SQLEmployeeEMPLOYEE_ID) Then Begin
                   raise Exception.Create(ME_030);
                End;
                NotName := IsEmptyField(SQLEmployeeSURNAME);
                NotName := NotName And IsEmptyField(SQLEmployeeTHIRD_NAME);
                NotName := NotName And IsEmptyField(SQLEmployeeFIRST_NAME);
                NotName := NotName And IsEmptyField(SQLEmployeeSECOND_NAME);
                If NotName And MustExists Then Begin
                   raise Exception.Create(ME_137);
                End;
                If Not NotName Then Begin
                   GetEmployeeName := Trim(SQLEmployeeSURNAME.AsString) + ' '+
                                      Trim(SQLEmployeeTHIRD_NAME.AsString) + ', '+
                                      Trim(SQLEmployeeFIRST_NAME.AsString) + ' '+
                                      Trim(SQLEmployeeSECOND_NAME.AsString);

                End;
             Finally
                Active:=False;
             End;
          Except
             On E:Exception Do Begin
                GetEmployeeName := '';
                ShowMessageFmt(ME_031,[AnEmployee,E.Message]);
             End;
          End;
     End;
End;
{Jafeth// Se creo un metodo para sacar el nombre del analista y su USER-ID}
Function TdmActs.GetEmployeeNameAnalista(AnEmployee:String;MustExists:Boolean):String;
Var
   NotName:             Boolean;    { True = User doesn't have a name }
Begin
     GetEmployeeNameAnalista := '';
     With SQLEmployee Do Begin
          Try
             Active:=False;
 {De Moya 2006-08-17 Coloco trim para que la variable AnEmployee no tenga valores en
 blanco}
             Params[0].AsString:=trim(AnEmployee);
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active:=True;
                If MustExists And IsEmptyField(SQLEmployeeEMPLOYEE_ID) Then Begin
                   raise Exception.Create(ME_030);
                End;
                NotName := IsEmptyField(SQLEmployeeSURNAME);
                NotName := NotName And IsEmptyField(SQLEmployeeTHIRD_NAME);
                NotName := NotName And IsEmptyField(SQLEmployeeFIRST_NAME);
                NotName := NotName And IsEmptyField(SQLEmployeeSECOND_NAME);
                If NotName And MustExists Then Begin
                   raise Exception.Create(ME_137);
                End;
                If Not NotName Then Begin
                   GetEmployeeNameAnalista := AnEmployee +' ('+Trim(SQLEmployeeSURNAME.AsString) + ' '+
                                      Trim(SQLEmployeeTHIRD_NAME.AsString) + ' '+
                                      Trim(SQLEmployeeFIRST_NAME.AsString) + ' '+
                                      Trim(SQLEmployeeSECOND_NAME.AsString)+')';
//                                      #13#10+

                End;
             Finally
                Active:=False;
             End;
          Except
             On E:Exception Do Begin
                GetEmployeeNameAnalista := '';
                ShowMessageFmt(ME_031,[AnEmployee,E.Message]);
             End;
          End;
     End;
End;

{ Use this routine to get the goverment identification for the supplier
  with code ASupplier in the district ADistrict }
Function TdmActs.GetSupplierId(ADistrict,ASupplier:String):String;
Begin
     GetSupplierId := '';
     With SQLSupplierId Do Begin
          Try
             Active             := False;
             Params[0].AsString := ADistrict;
             Params[1].AsString := ASupplier;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active:=True;
                GetSupplierId := Fields[0].AsString;
             Finally
                Active:=False;
             End;
          Except
             On E:Exception Do Begin
                GetSupplierId := '';
                ShowMessage(Format(ME_076,[ASupplier,ADistrict,E.Message]));
             End;
          End;
     End;
End;
{ This function is used whenever the supplier name is required. The routine
  try to get the name from a cache list; if don't exist in this list, then
  try to get it from the table MSF200, if the query is successful, it also
  include the new name in the cache list }

Function TdmActs.GetSupplierName(ASupplier:String):String;
Var
   Node:                TSupplierDef; { Data Definition of a Supplier }
   SupplierIndex:       Integer;      { Supplier index in Cache List }
Begin
     { First, check if Supplier is in Cache Supplier List }
     If FSuppliers.Find(ASupplier,SupplierIndex) Then Begin
        Node:=FSuppliers.Objects[SupplierIndex] As TSupplierDef;
        GetSupplierName:=Node.SupplierName;End
     Else Begin
        { In other case, get it from Data Base }
        With SQLSupplier Do Begin
             Try
                Close;
                Params[0].AsString:=ASupplier;
                If Not Prepared Then Begin
                   Prepare;
                End;
                Open;
                If SQLSupplierSUPPLIER_NAME.IsNull Then Begin
                   GetSupplierName:=ME_003;End
                Else Begin
                   { Add Supplier to Supplier List }
                   Node:=TSupplierDef.Create;
                   Node.SupplierCode := ASupplier;
                   Node.SupplierName := SQLSupplierSUPPLIER_NAME.AsString;
                   FSuppliers.AddObject(ASupplier,Node);
                   GetSupplierName:=Node.SupplierName;
                End;
             Except
                On E:Exception Do Begin
                   GetSupplierName:=ME_003;
                   raise Exception.CreateFmt(ME_004,[ASupplier,E.Message]);
                End;
             End;
        End;
     End;
End;
//Begin Cbanquet 2016-10-10
Function TdmActs.GetUserIdInSearch(AContract,AnActPaid:String):String;
 VAR
   strUserId : String;
Begin
        strUserId := '';
        With SQLSearchUserPositionID Do Begin
             Try
                Active := False;
                Params[0].AsString:=AContract;
                Params[1].AsString:=AnActPaid;
                If Not Prepared Then Begin
                   Prepare;
                End;
                Active := True;
                strUserId := Trim(Fields[1].AsString);
                GetUserIdInSearch := strUserId;
             Except
                On E:Exception Do Begin
                   GetUserIdInSearch:=ME_003;
                   {raise Exception.CreateFmt(ME_004,[ASupplier,E.Message]); }
                End;
             End;
        End;

End;
Function TdmActs.GetPositionIdInSearch(AContract,AnActPaid:String):String;
 VAR
   strPositionId : String;
Begin
        strPositionId := '';
        With SQLSearchUserPositionID Do Begin
             Try
                Active := False;
                Params[0].AsString:=AContract;
                Params[1].AsString:=AnActPaid;
                If Not Prepared Then Begin
                   Prepare;
                End;
                Active := True;
                strPositionId := Trim(Fields[0].AsString);
                GetPositionIdInSearch := strPositionId;
             Except
                On E:Exception Do Begin
                   GetPositionIdInSearch:=ME_003;
                   {raise Exception.CreateFmt(ME_004,[ASupplier,E.Message]); }
                End;
             End;
        End;

End;

{ Use this routine to get the contract definition when an Act Paid is
  going to be created or to be edited }
Procedure TdmActs.GetContractDefinition(AContract:String);
Begin
     {De Moya 2006-03-02}
     AContract:=GetMimsKey(AContract,8);
     With SQLContract Do Begin
          Try
             Active:=False;
             Params[0].AsString:= AContract;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_011,[AContract,E.Message]);
             End;
          End;
     End;
End;
{ Get the element definitions for the couple Contract-Portion }
Procedure TdmActs.GetActElementsFor(AContract,APortion:String);
Begin
     With SQLCntPrtEle Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AContract;
             Params[1].AsString:=APortion;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_016,[APortion,AContract,E.Message]);
             End;
          End;
     End;
End;
{ Load in FCategoryNames the custon names of the categories in the Contract.
  The custom names are the field TABLE_DESC in the table '+CE' in MSF010.
  In this table the field TABLE_CODE is the combination : Contract +
  Portion + Element + Category. It's very important to be awake every
  field in this key must have its maximun length (8,2,2,2); for example,
  if the Contract is 12, the portion 1, the element 2 and the category 7,
  TABLE_CODE must be 00000012010207 }
Procedure TdmActs.LoadCustomCategoryNames(AContract,APortion:String);
Var
   LowRange:            String;
   HighRange:           String;
   LastChar:            Integer;
Begin
     {De Moya 2005-11-15 IC721}
     With SQLCstmCtg Do Begin
          Try
             Active    := False;
             { Set Range for the Query. The range is intended to include all
               the custom names for AContract-APortion }
             {LowRange  := GetFullMIMSKey(AContract,8) + GetFullMIMSKey(APortion,2);}
             LowRange  := GetFullMIMSKey(AContract,8);
             {HighRange := LowRange;
             LastChar  := Length(HighRange);
             HighRange[LastChar] := Chr(Ord(HighRange[LastChar])+1); }
             HighRange:=GetFullMIMSKey(APortion,2);
             Params[0].AsString  := LowRange;
             Params[1].AsString  := HighRange;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                { Load the custom names }
                Active := True;
                While Not EoF Do Begin
                      {FCategoryNames.AddCategoryName(
                                        SQLCstmCtgTABLE_CODE.AsString,
                                        SQLCstmCtgTABLE_DESC.AsString);}
                      FCategoryNames.AddCategoryName(
                                        LowRange + HighRange +
                                        SQLCstmCtgELEMENT_NO.AsString+
                                        SQLCstmCtgCATEGORY_NO.AsString,
                                        SQLCstmCtgCATEG_DESC.AsString);
                      Next;
                End;
                { If Load successful, mark the portion as Loaded in the
                  CategoryNames list }
                FCategoryNames.SetLoadFlagFor(AContract,APortion);
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_091,[E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.RefreshCustomCategoryNames(AContract,APortion:String);
Begin
     If Not FCategoryNames.IsPortionLoaded(AContract,APortion) Then Begin
        LoadCustomCategoryNames(AContract,APortion);
     End;
End;
{ Use this routine to get the date of the extension to the contract }
Function TdmActs.GetContractExtDate(AContract:String):String;
Begin
     With SQLGetCntExt Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AContract;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active:=True;
                GetContractExtDate := Fields[0].AsString;
             Finally
                Active:=False;
             End;
          Except
             On E:Exception Do Begin
                GetContractExtDate := '';
                ShowMessageFmt(ME_117,[E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to convert the value AValue in the currency ACurrency, to
  the corresponding current value in the MIMS local currency }
Function TdmActs.ToLocalCurrency(ACurrency:String;AValue:Currency):Currency;
Var
   InvCurrentDate:      String;     { Current Date in Inverse format }
   ChangeRate:          Double;     { Current Change Rate from Local to Foreign }
Begin
     If ACurrency = LocalCurrency Then Begin
        ToLocalCurrency := AValue; End
     Else Begin
        InvCurrentDate  := GetInverseDate(CurrentDate);
        ChangeRate      := GetCurrencyRate(LocalCurrency,
                                           ACurrency,
                                           InvCurrentDate);
        ToLocalCurrency := AValue / ChangeRate;
     End;
End;
{ Get the categories in the Contract }
Procedure TdmActs.GetContractCategories(AContract,APortion:String);
Begin
     { First, load the full information of the categories. This information
       provide a default name for each category from the table 'CE' in
       MSF010 }
     With SQLCntPrtEleCat Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AContract;
             Params[1].AsString:=APortion;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_001,[E.Message]);
             End;
          End;
     End;
     { Now, load any custom name for a category from the table '+CE' in
       MSF010. After it, the custom name are avalaibles from the list
       CategoryNames }
     LoadCustomCategoryNames(AContract,APortion);
End;
{ Get the categories in the Act }
Procedure TdmActs.GetActCategories(AContract,AnAct:String);
Begin
     With SQLItems Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AContract;
             Params[1].AsString:=AnAct;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_001,[E.Message]);
             End;
          End;
     End;
End;

{ Use this routine to get extended information about the Act Paid. This
  routine use a non standard technique to get the user preferences for
  the Act : As these preferences must stay into the UserConfig property,
  the corresponding values are assigned to the UserConfig subproperties
  immediately into this routine, they are not worked as output arguments
  for GetActPaidExt }
Procedure TdmActs.GetActPaidExt(AContract,AnActPaid:String;
                                Var AnAdministrator,AnApprover,AnApproveDate:String;
                                Var APaidPrtExe,APaidCntExe:Currency;
                                Var AnInvCurrency,AnInvChangeRateDt:String;
                                Var AnInvChangeRate:Double;
                                Var APeriodFrom,APeriodTo:String);
Begin
     With SQLActPaidExt Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active := True;
                { Act Paid extended data }
                If SQLActPaidExtCREATED_BY.IsNull Then Begin
                   AnAdministrator := ''; End
                Else Begin
                   AnAdministrator := SQLActPaidExtCREATED_BY.AsString;
                End;
                APeriodFrom := SQLActPaidExtPERIOD_FROM.AsString;
                APeriodTo   := SQLActPaidExtPERIOD_TO.AsString;
                { Approve information }
                If SQLActPaidExtAPPROVED_BY.IsNull Then Begin
                   AnApprover := ''; End
                Else Begin
                   AnApprover := SQLActPaidExtAPPROVED_BY.AsString;
                End;
                AnApproveDate := SQLActPaidExtAPPROVE_DATE.AsString;
                { Previous Act Paid executed, portion and contract }
                APaidPrtExe := SQLActPaidExtPRV_EXEC_VALUE.AsCurrency;
                APaidCntExe := SQLActPaidExtPRV_EXEC_VALUE1.AsCurrency;
                { Invoice informations }
               { AnInvCurrency     := SQLActPaidExtINV_CURRENCY.AsString;}
                AnInvCurrency     := SQLContractCURRENCY_TYPE.AsString;
                AnInvChangeRateDt := SQLActPaidExtINV_CHANGE_RATE_DT.AsString;
                AnInvChangeRate   := SQLActPaidExtINV_CHANGE_RATE.AsFloat;
                { User preferences for the Act }
                UserConfig.DCCDefaultDstrb := UserConfig.CCDefaultDstrb;
                UserConfig.DTypeComments   := TTypeComments(Ord(SQLActPaidExtTYPE_COMMENTS.AsInteger));
                UserConfig.DTypeCntrctExt  := TTypeCntrctExt(Ord(SQLActPaidExtTYPE_CNTRCT_EXT.AsInteger));
                UserConfig.DCCTypeDstrb    := TCCTypeDstrb(Ord(SQLActPaidExtCC_TYPE_DSTRB.AsInteger));
                UserConfig.DAPInfoAtax     := TAPInfoAtax(Ord(SQLActPaidExtAP_INFO_ATAX.AsInteger));
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_033,[AContract,AnActPaid,E.Message]);
             End;
          End;
     End;
End;
{ Try to get the last code of the Acts Paid. The function returns this value
  when the codes are integer values; in other case, it returns the following
  values :
  - 1 : Not able to get the code; probably because codes are not numerics
    0 : Acts Paid table empty  }
Function TdmActs.GetLastCodeOfActPaid(AContract:String):Integer;
Begin
     With SQLLastActCode Do Begin
          Try
             Try
                Params[0].AsString := AContract;
                If Not Prepared Then Begin
                   Prepare;
                End;
                Active := True;
                If Fields[0].IsNull Then Begin
                   GetLastCodeOfActPaid := 0;End
                Else Begin
                   GetLastCodeOfActPaid := Fields[0].AsInteger;
                End;
             Finally
                Active:=False;
             End;
          Except
             On E:Exception Do GetLastCodeOfActPaid := -1;
          End;
     End;
End;
Function TdmActs.GetContractDate(AContract:String):String;
Begin
     With SQLCntDate Do Begin
          Try
             Active             := False;
             Params[0].AsString := AContract;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active          := True;
                GetContractDate := Fields[0].AsString;
             Finally
                Active          := False;
             End;
          Except
             On E:Exception Do GetContractDate := '';
          End;
     End;
End;
{ Use this function to get the start date of the portion. If the portion
  has an amendment, then it use the start date fixed in this amendment,
  in other case, it use the original start date }
Function TdmActs.GetPortionDate(AContract,APortion:String):String;
Var
   PortionDate:         String;     { Portion date (format yyyymmdd) }
Begin
     With SQLPrtDate Do Begin
          Try
             Active             := False;
             Params[0].AsString := AContract;
             Params[1].AsString := APortion;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active         := True;
                PortionDate := '';
                If Not SQLPrtDateAMEND_START_DT.IsNull Then Begin
                   PortionDate := Trim(SQLPrtDateAMEND_START_DT.AsString);
                End;
                If PortionDate = '' Then Begin
                   PortionDate := SQLPrtDateORIG_START_DT.AsString;
                End;
                GetPortionDate := PortionDate;
             Finally
                Active         := False;
             End;
          Except
             On E:Exception Do GetPortionDate := '';
          End;
     End;
End;
Function TdmActs.GetPaidsToContract(AContract:String):Currency;
Begin
     GetPaidsToContract := 0;
     With SQLCntVal Do Begin
          Try
             Active := False;
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := AContract;
             Params[1].AsString := AContract;
             Active := True;
             GetPaidsToContract := Fields[0].AsCurrency;
          Except
             On E:Exception Do Begin
                ShowMessageFmt(ME_022,[AContract,E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to get the total value already paid to the portion.
  It's primarly intended to be used after the changes uncommited to an
  act. The function get the commit and uncommited values and the program
  will use this value to verify the max payment authorized for the portion }
Function TdmActs.GetPaidsToPortion(AContract,APortion:String):Currency;
Begin
     GetPaidsToPortion:=0;
     With SQLCntPrtVal Do Begin
          Try
             Active := False;
             ParamByName('AContract0').AsString := AContract;
             ParamByName('AContract1').AsString := AContract;
             ParamByName('APortion').AsString   := APortion;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active := True;
                GetPaidsToPortion := Fields[0].AsCurrency;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_038,[APortion,AContract,E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to get the total value already paid to the each element
  in the portion.
  It's primarly intended to be used after the changes uncommited to an
  act. The function get the commit and uncommited values and the program
  will use this value to verify the max payment authorized for each element }
Procedure TdmActs.GetPaidsToElements(AContract,APortion:String);
Begin
     With SQLCntPrtEleVal Do Begin
          Try
             Active := False;
             ParamByName('AContract0').AsString := AContract;
             ParamByName('AContract1').AsString := AContract;
             ParamByName('APortion').AsString   := APortion;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_123,[APortion,AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.GetElementsValuesInAct(AContract,AnActPaid:String);
Begin
     With SQLValEleAct Do Begin
          Try
             Active := False;
             ParamByName('AContract').AsString := AContract;
             ParamByName('AnActPaid').AsString := AnActPaid;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_124,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.GetPaidsToCategory(AContract,APortion,AnElement,ACategory:String;
                                     Var AValue:Currency;Var AQuantity:Double);
Begin
     With SQLCntPrtEleCatVal Do Begin
          Try
             Active := False;
             ParamByName('AContract0').AsString := AContract;
             ParamByName('AContract1').AsString := AContract;
             ParamByName('APortion').AsString   := APortion;
             ParamByName('AnElement').AsString  := AnElement;
             ParamByName('ACategory').AsString  := ACategory;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active    := True;
                AValue    := Fields[0].AsCurrency;
                AQuantity := Fields[1].AsFloat;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_043,[AContract,APortion,AnElement,
                                                  ACategory,E.Message]);
             End;
          End;
     End;
End;
{ Get the Act Paid value. This value is the real value of the Act.
  However, for the acumulated values (or executed values), can be
  differents because the categories corresponding to Discount Elements
  mustn't be included; therefore use other functions when you need the
  value to be counted as executed values, as the GetActPaidBudgetValue
  function }
Function TdmActs.GetActPaidValue(AContract,AnActPaid:String):Currency;
Begin
     {De Moya 2006-03-02}
     AContract:=GetMimsKey(AContract,8);
     GetActPaidValue := 0;
     With SQLActValue Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             GetActPaidValue := Fields[0].AsCurrency;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_039,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
{ Get the Act Paid value cover by the original budget (i.e. categories
  with DISCOUNT_FLAG = 'N').
  To get the real Act Paid value use GetActPaidValue }
Function TdmActs.GetActPaidBudgetValue(AContract,AnActPaid:String):Currency;
Begin
     GetActPaidBudgetValue := 0;
     With SQLActBdgVal Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             GetActPaidBudgetValue := Fields[0].AsCurrency;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_173,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.GetActPaidInfoAtax(AContract,AnActPaid:String);
Begin
     With SQLInfoAtax Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AContract;
             Params[1].AsString:=AnActPaid;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_149,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.CreateTemporalAtaxTable;
Begin
     With SQLInfoAtax Do Begin
          Try
             While Not EoF Do Begin
                   tblInfoAtax.Append;
                   tblInfoAtaxATAX_CODE.AsString    := SQLInfoAtaxATAX_CODE.AsString;
                   tblInfoAtaxATAX_RATE.AsFloat     := SQLInfoAtaxATAX_RATE.AsFloat;
                   tblInfoAtaxATAX_BASE.AsCurrency  := SQLInfoAtaxATAX_BASE.AsCurrency;
                   tblInfoAtaxATAX_VALUE.AsCurrency := SQLInfoAtaxATAX_VALUE.AsCurrency;
                   tblInfoAtax.Post;
                   Next;
             End;
          Finally
             Active := False;
          End;
     End;
End;
Procedure TdmActs.CreateTemporalAtaxTableFromDistrictDefault;
Var
   AssocRec:            String;
   AtaxRate:            Double;
Begin
     With SQLAtaxCodes010 Do Begin
          First;
          While Not EoF Do Begin
                AssocRec := SQLAtaxCodes010ASSOC_REC.AsString;
                If AssocRec[1] = 'Y' Then Begin
                   AtaxRate := StrToInt(Trim(Copy(AssocRec,2,Length(AssocRec)-1)));
                   AtaxRate := AtaxRate / 100000;
                   tblInfoAtax.Append;

                   tblInfoAtaxATAX_CODE.AsString    := Trim(SQLAtaxCodes010TABLE_CODE.AsString);
                   tblInfoAtaxATAX_RATE.AsFloat     := AtaxRate;
                   tblInfoAtaxATAX_BASE.AsCurrency  := 0;
                   tblInfoAtaxATAX_VALUE.AsCurrency := 0;
                   tblInfoAtax.Post;
                End;
                Next;
          End;
     End;
End;
Function TdmActs.GetPreviousActPaidCode(AContract,ADate:String):String;
Begin
     GetPreviousActPaidCode := '';
     With SQLPrvAPCode Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             Params[1].AsString := ADate;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active := True;
                If Not Fields[0].IsNull Then Begin
                   GetPreviousActPaidCode := Fields[1].AsString;
                End;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_156,[E.Message,AContract,ADate]);
             End;
          End;
     End;
End;
{ Get the Acts required by the user from the search button }
Procedure TdmActs.GetActsPaid(SelectLine,Condition:String);
Begin
     With SQLActs Do Begin
          Try
             Close;
             SQL.Clear;
             SQL.Add(SelectLine);
             SQL.Add(Condition);
             Open;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_002,[E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to get the TField objects for the fields retrieved
  in the current search. Each search has a different set of objects.
  The local routine GetObjectOf return the object for a field, or nil,
  if the field was not retrieved in the current search }
Procedure TdmActs.GetFieldsDefinitionForActs;
  Function GetObjectOf(AFieldName:String):TField;
  Begin
       Try
          GetObjectOf := SQLActs.FieldByName(AFieldName);
       Except
          GetObjectOf := Nil;
       End;
  End;
var
     a : String;
Begin
     SQLActsContractNo  := GetObjectOf('CONTRACT_NO');
     SQLActsActPaidNo   := GetObjectOf('ACT_PAID_NO');
     SQLActsPortionNo   := GetObjectOf('PORTION_NO');
     SQLActsActPaidDate := GetObjectOf('ACT_PAID_DATE');
     SQLActsStatus      := GetObjectOf('STATUS');
     SQLActsSupplierNo  := GetObjectOf('SUPPLIER_NO');
     SQLActsApproved_by := GetObjectOf('APPROVED_BY');
     SQLActsEmpAprobador:= GetObjectOf('EMP_APROBADOR');
     SQLActsPosAprobador:= GetObjectOf('POS_APROBADOR');
     SQLActsExtInvNo    := GetObjectOf('EXT_INV_NO');

     //SQLActsValnNo      := GetObjectOf('VALN_NO');
End;
{ Use this routine to load the User Preferences Configuration. This
  configuration is really for all the user in the current district;
  however, some options are only a default, the user is able to change
  them for each document }
Procedure TdmActs.LoadUserConfiguration;
Begin
     With SQLUserConfig,UserConfig Do Begin
          Try
             Active := False;
             Params[0].AsString := CurrentDistrict;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active         := True;
             CCTypeDstrb    := TCCTypeDstrb(Ord(SQLUserConfigCC_TYPE_DSTRB.AsInteger));
             CCDefaultDstrb := TCCDefaultDstrb(Ord(SQLUserConfigCC_DEFAULT_DSTRB.AsInteger));
             TypeComments   := TTypeComments(Ord(SQLUserConfigTYPE_COMMENTS.AsInteger));
             TypeCntrctExt  := TTypeCntrctExt(Ord(SQLUserConfigTYPE_CNTRCT_EXT.AsInteger));
             LoadInvType    := TLoadInvType(Ord(SQLUserConfigLOAD_INV_TYPE.AsInteger));
             ActValidation  := TActValidation(Ord(SQLUserConfigACT_VALIDATION.AsInteger));
             InvValidation  := TInvValidation(Ord(SQLUserConfigINV_VALIDATION.AsInteger));
             TypeCntLimit   := TTypeCntLimit(Ord(SQLUserConfigTYPE_CNT_LIMIT.AsInteger));
             APRight        := TAPRight(Ord(SQLUserConfigAP_RIGHT.AsInteger));
             APSecuence     := TAPSecuence(Ord(SQLUserConfigAP_SECUENCE.AsInteger));
             APInfoAtax     := TAPInfoAtax(Ord(SQLUserConfigAP_INFO_ATAX.AsInteger));
             Active         := False;
          Except
             On E:Exception Do Begin
                ShowMessageFmt(ME_099,[CurrentDistrict,E.Message]);
             End;
          End;
     End;
End;
{ Load all the elements defined in the system from MSF010 TABLE_TYPE = 'EN' }
Procedure TdmActs.LoadElements;
Var
   Node:                TElementDef;{ Data Definition for an Element }
Begin
     With SQLElements Do Begin
          Try
             Try
                Active := True;
                While Not EoF Do Begin
                      Node := TElementDef.Create;
                      //Node.ElementCode := SQLElementsTABLE_CODE.AsString;
                      Node.ElementCode := trim(SQLElementsTABLE_CODE.AsString);
                      Node.ElementName := SQLElementsTABLE_DESC.AsString;
                      FElements.AddObject(Node.ElementCode,Node);
                      Next;
                End;
                FElements.Sorted:=True;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                ShowMessage(Format(ME_015,[E.Message]));
                Application.Terminate;
             End;
          End;
     End;
End;
{ Load in ElementActs all the elements defined for AContract-APortion }
Procedure TdmActs.LoadElementsIn(AContract,APortion:String);
Begin
     { Only load if the elements are not already loaded }
     If Not ElementActs.ExistsContractPortion(AContract,APortion) Then Begin
        Try
           { Get in SQLCntPrtEle the records from MSF386 }
           GetActElementsFor(AContract,APortion);
           { Copy the records to ElementActs }
           With SQLCntPrtEle Do Begin
                While Not EoF Do Begin
                      ElementActs.AddElement(AContract,APortion,
                                             SQLCntPrtEleELEMENT_NO.AsString,
                                             SQLCntPrtEleELEMENT_CODE.AsString);
                      Next;
                End;
           End;
        Finally
           SQLCntPrtEle.Active := False;
        End;
     End;
End;
Procedure TdmActs.LoadElementNoDefinitions;
Var
   Node:                TEleNoDef;
Begin
     With SQLEleNoDefs Do Begin
          Try
             Try
                Active := True;
                While Not EoF Do Begin
                      Node := TEleNoDef.Create(
                                        //SQLEleNoDefsTABLE_CODE.AsString,
                                        Trim(SQLEleNoDefsTABLE_CODE.AsString),
                                        SQLEleNoDefsASSOC_REC.AsString);
                      FElementNoDefs.AddDefinition(Node);
                      Next;
                End;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                ShowMessageFmt(ME_183,[E.Message]);
                Application.Terminate;
             End;
          End;
     End;
End;
{ Use this function to get the Employee ID of the user AUser. }

Function TdmActs.GetEmployeeID(AUser:String):String;
Begin
     {AUser:=copy(AUser+'          ',1,10);}
     With SQLInfoUser Do Begin
          Try
             Params[0].AsString := UpperCase(AUser);
             Try
                Active := True;
                If Fields[0].IsNull Then Begin
                   raise Exception.Create(ME_032);
                End;
                GetEmployeeID := Fields[0].AsString;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                ShowMessageFmt(ME_024,[AUser,E.Message]);
                Application.Terminate;
             End;
          End;
     End;
     {GetEmployeeID:=AUser;}
End;

{ Use this function to get the Employee ID of the current user.
  There are two cases :
  If the current User ID is really the Employee ID, then the function
  GetEmployeeName must get a value; in other case, the current User ID
  is an independent MIMS ID and the Employee ID must be get from MSF020
  by using GetEmployeeID. }

Function TdmActs.GetUserEmployeeID(AUser:String):String;
Begin
     If GetEmployeeName(AUser,False) = '' Then Begin
        GetUserEmployeeID := GetEmployeeID(AUser); End
     Else Begin
        GetUserEmployeeID := AUser;
     End;
End;

{ Use this routine to get the list of suppliers required by the user .
  If AnIdentity is not blank, then search the one supplier with that
  identity; in other case, check AMask. If AMask is blank, then get
  all the suppliers, in other case, get the suppliers with a name beginning
  with AMask; for it, use a LIKE clause in a Where condition; as the
  LIKE clause need a "%" character at end, check if the user wrote it,
  if he(she) don't, then add the character. }

Procedure TdmActs.GetSuppliers(AMask,AnIdentity:String);
Var
   SupplierNameMask:    String;     { Mask for LIKE condition }
   LastCharacter:       String;     { Last character in AMask }
   LastPosition:        Integer;    { Position of the last character in AMask }
Begin
     With SQLSuppliers Do Begin
          Active:=False;
          SQL.Clear;
          SQL.Add(SQLSuppliers01);
          If Length(AnIdentity)=0 Then Begin
             LastPosition := Length(AMask);
             If LastPosition > 0 Then Begin
                { Ever use LIKE condition for searching }
                LastCharacter := AMask[LastPosition];
                If LastCharacter = '%' Then Begin
                   SupplierNameMask := AMask; End
                Else Begin
                   If LastCharacter = '*' Then Begin
                      SupplierNameMask := Copy(AMask,1,LastPosition-1) +'%'; End
                   Else Begin
                      SupplierNameMask := AMask + '%';
                   End;
                End;
                SQL.Add(Format(SQLSuppliers02,[SupplierNameMask]));
             End; End
          Else Begin
             SQL.Add(Format(SQLSuppliers03,[AnIdentity]));
          End;
          SQL.Add(SQLSuppliers04);
          Active:=True;
     End;
End;
{ Load the Supplier List. At the same time, load the list box in the form
  FrmSuppliers (parameter AListBox) with the supplier names in alphabetic
  order.

  This routine use the following steps :

  1. Exec the Query SQLSuppliers to get all the suppliers defined,
     in alphabetic order.
  2. The Supplier list is the owner of the TSupplierDef nodes; therefore,
     before to clear AList, set all its Objects to nil, calling
     DisconnectObjectsIn .
  2. Desactive Sorted property in AList to improve performance
     because the list can be too large.
  3. Add every Supplier in SQLSuppliers to the Supplier list.
  4. Active Sorted again to order AList by Supplier Name }

Procedure TdmActs.LoadSuppliers(AList:TListBox;AMask,AnIdentity:String);
Var
   Node:                TSupplierDef; { Data Definition of a Supplier }
   AIndex:              Integer;      { Supplier Index }
Begin
     Try
        Try
           GetSuppliers(AMask,AnIdentity);
           DisconnectObjectsIn(AList.Items);
           AList.Clear;
           AList.Sorted:=False;
           While Not SQLSuppliers.EoF Do Begin
                 If FSuppliers.Find(SQLSuppliersSUPPLIER_NO.AsString,AIndex) Then Begin
                    Node := FSuppliers.Objects[AIndex] As TSupplierDef;
                    Node.SupplierName := SQLSuppliersSUPPLIER_NAME.AsString; End
                 Else Begin
                    { Add Supplier to Supplier List }
                    Node := TSupplierDef.Create;
                    Node.SupplierCode := SQLSuppliersSUPPLIER_NO.AsString;
                    Node.SupplierName := SQLSuppliersSUPPLIER_NAME.AsString;
                    FSuppliers.AddObject(Node.SupplierCode,Node);
                 End;
                 { Add to the list items in the Suppliers list box  }
                 AList.Items.AddObject(Node.SupplierName,Node);
                 SQLSuppliers.Next;
           End;
           AList.Sorted:=True;
        Finally
           SQLSuppliers.Active:=False;
        End;
     Except
        On E:Exception Do Begin
           { Clear the list to enable a next try to load }
           DisconnectObjectsIn(AList.Items);
           AList.Clear;
           raise Exception.CreateFmt(ME_006,[E.Message]);
        End;
     End;
End;
{ Copy the records found in the search to an auxiliary Paradox table.
  The parameter ACommon has the common values specified in the options
  search }
Procedure TdmActs.SearchResultsToAuxiliaryTable(ACommon:TActPaidDef);

  Procedure SetFieldFrom(ATarget,ASource:TField;ACommon:String);
  Begin
       If Assigned(ASource) Then Begin
          ATarget.AsString := ASource.AsString;End
       Else Begin
          ATarget.AsString := ACommon;
       End;
  End;
  Procedure SetSearchRecordRetrieved;
  Begin
       With ACommon Do Begin
            SetFieldFrom(tblSearchCONTRACT_NO  , SQLActsContractNo,
                                                 ActPaidContract);
            SetFieldFrom(tblSearchACT_PAID_NO  , SQLActsActPaidNo,
                                                 ActPaidCode);
            SetFieldFrom(tblSearchPORTION_NO   , SQLActsPortionNo,
                                                 ActPaidPortion);
            SetFieldFrom(tblSearchACT_PAID_DATE, SQLActsActPaidDate,
                                                 ActPaidDate);
            SetFieldFrom(tblSearchSUPPLIER_NO  , SQLActsSupplierNo,
                                                 ActPaidSupplier);
            SetFieldFrom(tblSearchSTATUS       , SQLActsStatus,
                                                 ActPaidStatusS);
{De Moya - 2002-07-08}
{tblSearchAPPROVED_By was not initialized}
            SetFieldFrom(tblSearchAPPROVED_BY  , SQLActsApproved_by,
                                                 ActPaidContract);

            {SetFieldFrom(tblSearchVALN_NO      , SQLActsValnNo,
                                                 ActPaidValnNo);}

            SetFieldFrom(tblSearchUSER_ID     , SQLActsEmpAprobador,
                                                 ' ');
            SetFieldFrom(tblSearchPOSITION_ID , SQLActsPosAprobador,
                                                 ' ');
            SetFieldFrom(tblSearchEXT_INV_NO , SQLActsExtInvNo,
                                                 ' ');
       End;
       tblSearchSUPPLIER_NAME.AsString := GetSupplierName(
                                             tblSearchSUPPLIER_NO.AsString);

        if AnsiCompareStr(Trim(tblSearchSTATUS.AsString), '2') = 0 then Begin
              tblSearchUSER_ID.AsString := GetUserIdInSearch(tblSearchCONTRACT_NO.AsString, tblSearchACT_PAID_NO.AsString);
              tblSearchPOSITION_ID.AsString := GetPositionIdInSearch(tblSearchCONTRACT_NO.AsString, tblSearchACT_PAID_NO.AsString);
        End
        {Else Begin
            SetFieldFrom(tblSearchUSER_ID     , SQLActsEmpAprobador,
                                                 ' ');
            SetFieldFrom(tblSearchPOSITION_ID , SQLActsPosAprobador,
                                                 ' ');
        End;   }

  End;
var
  algo : String;
Begin
     With SQLActs Do Begin
          algo := SQL.Text;
          algo := IntToStr(SQLActs.RecordCount) + '';
          Try
             { First, clear the previous search }
             With tblSearch Do Begin
                  Active := True;
                  If UpdatesPending Then Begin
                     CancelUpdates;
                  End;
             End;
             { Now, add the records in the new search }
             While Not EoF Do Begin
                   tblSearch.Append;
                   SetSearchRecordRetrieved;
                   {tblSearchAPPROVED_BY: TStringField;  }
                   tblSearch.Post;
                   Next;
             End;
          Finally
             Active := False;
          End;
     End;
End;
{ Copy the records Element-Category in Contract-Portion to an auxiliary
  cache list. Check the following :
  When CategoryRate = 0, the category value is not "Rate * Quantity",
  the category uses a global value. CategoryByGlobal is intended for it.
  In order, to check it, we use Abs(CategoryRate) < Delta to avoid
  precision errors because the conversions between the data format in
  the Database and the format used by BDE }
Procedure TdmActs.SaveCategoriesInMemory;
Var
   Node:                TCategoryDef; { Category Definition for the module }
Begin
     FDetails.Clear;
     CategoryNames.Contract := CurrentActPaid.ActPaidContract;
     CategoryNames.Portion  := CurrentActPaid.ActPaidPortion;
     With SQLCntPrtEleCat Do Begin
          Try
             While Not EoF Do Begin
                   Node := TCategoryDef.Create;
                   With Node Do Begin
                        CategoryElement  := SQLCntPrtEleCatELEMENT_NO.AsString;
                        CategoryElementCode := SQLCntPrtEleCatELEMENT_CODE.AsString;
                        CategoryNro      := SQLCntPrtEleCatCATEGORY_NO.AsString;
                        CategoryCode     := SQLCntPrtEleCatCATEG_CODE.AsString;
                        CategoryDesc     := SQLCntPrtEleCatTABLE_DESC.AsString;
                        { Check if exist a custom name for the category; in that
                          case, use this name over the global definition }
                        With CategoryNames Do Begin
                             Element  := CategoryElement;
                             Category := CategoryNro;
                             If CategoryName <> '' Then Begin
                                CategoryDesc := CategoryName;
                             End;
                        End;
                        { Find the measure, if the Category is not by Global Value }
                        If SQLCntPrtEleCatCATEG_BASE_UN.IsNull Or
                           (Trim(SQLCntPrtEleCatCATEG_BASE_UN.AsString)='') Then Begin
                           CategoryMeasure := '    '; End
                        Else Begin
                           CategoryMeasure := SQLCntPrtEleCatCATEG_BASE_UN.AsString;
                        End;
                        CategoryRate     := SQLCntPrtEleCatCATEG_BASE_PRC_RT.AsCurrency;
                        CategoryQuantity := 0;
                        CategoryGlobal   := 0;
                        //CategoryTopValue := SQLCntPrtEleCatCATEG_BASE_VAL.AsCurrency;
                        CategoryTopValue := SQLCntPrtEleCatCATEG_BASE_PRC_RT.AsCurrency;
                        CategoryInAct    := False;
                        CategoryByGlobal := Abs(CategoryRate) < Delta;
                   End;
                   FDetails.Add(Node);
                   Next;
             End;
          Finally
             Active:=False;
          End;
     End;
End;

Procedure TdmActs.ValidateElementNoFlags(AnElementNo:String);
Var
   Node:                TEleNoDef;
   CurrentFlag:         String;
   OtherFlag:           String;
   ElementCode:         String;
   ElementNo:           String;
Begin
     ElementCode := Trim(Copy(AnElementNo,3,Length(AnElementNo) - 2));
     ElementNo   := Trim(Copy(AnElementNo,1,2));

     If FCrrEleNoDef.IndexOf(ElementNo) < 0 Then Begin
        Node := TEleNoDef.Create(ElementNo,
                                 SQLItemsDISCOUNT_FLAG.AsString +
                                 SQLItemsTPI_FLAG.AsString +
                                 SQLItemsPERCENT_FLAG.AsString);
        FCrrEleNoDef.AddDefinition(Node);
     End;
     CurrentFlag := FCrrEleNoDef.DiscountFlag[ElementNo];
     OtherFlag := FElementNoDefs.DiscountFlag[AnElementNo];

     If (CurrentFlag <> FElementNoDefs.DiscountFlag[AnElementNo]) Or
        (CurrentFlag <> SQLItemsDISCOUNT_FLAG.AsString) Then Begin
        ShowMessageFmt(ME_187,['DISCOUNT_FLAG',
                               Copy(AnElementNo,1,2),
                               CurrentActPaid.ActPaidCode,
                               CurrentActPaid.ActPaidContract]);
     End;
     CurrentFlag := FCrrEleNoDef.TPIFlag[ElementNo];
     If (CurrentFlag <> FElementNoDefs.TPIFlag[AnElementNo]) Or
        (CurrentFlag <> SQLItemsTPI_FLAG.AsString) Then Begin
        ShowMessageFmt(ME_187,['TPI_FLAG',
                               Copy(AnElementNo,1,2),
                               CurrentActPaid.ActPaidCode,
                               CurrentActPaid.ActPaidContract]);
     End;
     CurrentFlag := FCrrEleNoDef.PercentFlag[ElementNo];
     If (CurrentFlag <> FElementNoDefs.PercentFlag[AnElementNo]) Or
        (CurrentFlag <> SQLItemsPERCENT_FLAG.AsString) Then Begin
        ShowMessageFmt(ME_187,['PERCENT_FLAG',
                               Copy(AnElementNo,1,2),
                               CurrentActPaid.ActPaidCode,
                               CurrentActPaid.ActPaidContract]);
     End;
End;
Procedure TdmActs.ValidateElementNoFlags2(AnElementNo:String);
Var
   Node:                TEleNoDef;
   CurrentFlag:         String;
   OtherFlag:           String;
   ElementCode:         String;
   ElementNo:           String;
Begin
     ElementCode := Trim(Copy(AnElementNo,3,Length(AnElementNo) - 2));
     ElementNo   := Trim(Copy(AnElementNo,1,2));

     If FCrrEleNoDef.IndexOf(ElementCode) < 0 Then Begin
        Node := TEleNoDef.Create(ElementCode,
                                 SQLItemsDISCOUNT_FLAG.AsString +
                                 SQLItemsTPI_FLAG.AsString +
                                 SQLItemsPERCENT_FLAG.AsString);
        FCrrEleNoDef.AddDefinition(Node);
     End;
     CurrentFlag := FCrrEleNoDef.DiscountFlag[ElementNo];
     OtherFlag := FElementNoDefs.DiscountFlag[AnElementNo];

     If (CurrentFlag <> FElementNoDefs.DiscountFlag[AnElementNo]) Or
        (CurrentFlag <> SQLItemsDISCOUNT_FLAG.AsString) Then Begin
        {ShowMessageFmt(ME_187,['DISCOUNT_FLAG',
                               Copy(AnElementNo,1,2),
                               CurrentActPaid.ActPaidCode,
                               CurrentActPaid.ActPaidContract]);}
     End;
     CurrentFlag := FCrrEleNoDef.TPIFlag[ElementNo];
     If (CurrentFlag <> FElementNoDefs.TPIFlag[AnElementNo]) Or
        (CurrentFlag <> SQLItemsTPI_FLAG.AsString) Then Begin
        {ShowMessageFmt(ME_187,['TPI_FLAG',
                               Copy(AnElementNo,1,2),
                               CurrentActPaid.ActPaidCode,
                               CurrentActPaid.ActPaidContract]);}
     End;
     CurrentFlag := FCrrEleNoDef.PercentFlag[ElementNo];
     If (CurrentFlag <> FElementNoDefs.PercentFlag[AnElementNo]) Or
        (CurrentFlag <> SQLItemsPERCENT_FLAG.AsString) Then Begin
        {ShowMessageFmt(ME_187,['PERCENT_FLAG',
                               Copy(AnElementNo,1,2),
                               CurrentActPaid.ActPaidCode,
                               CurrentActPaid.ActPaidContract]);}
     End;
End;

{ Combine the categories in the Act with the categories in the Contract }
Procedure TdmActs.CombineCategories;
Var
   Node:                TCategoryDef; { Category Definition for the module }
   TheElementNo:        String;
   TheCategoryNo:       String;
Begin
     FCrrEleNoDef.Clear;
     With SQLItems Do Begin
          First;
          While Not EoF Do Begin
                TheElementNo  := SQLItemsELEMENT_NO.AsString;
                TheCategoryNo := SQLItemsCATEGORY_NO.AsString;
                Node := Details.FindNode(TheElementNo,TheCategoryNo);
                ValidateElementNoFlags(TheElementNo + Node.CategoryElementCode);
                If Not Assigned(Node) Then Begin
                     raise Exception.CreateFmt(ME_040,
                                             [TheCategoryNo,TheElementNo]);
                End;
                With Node Do Begin
                     CategoryRate     := SQLItemsRATE_VALUE.Value;
                     CategoryQuantity := SQLItemsQUANTITY.Value;
                     CategoryGlobal   := SQLItemsPAID_VALUE.Value;
                     CategoryInAct    := True;
                End;
                Next;
          End;
     End
End;
{ Combine the categories in the Act with the categories in the Contract }
Procedure TdmActs.CombineCategories2;
Var
   Node:                TCategoryDef; { Category Definition for the module }
   TheElementNo:        String;
   TheCategoryNo:       String;
Begin
     FCrrEleNoDef.Clear;
     With SQLItems Do Begin
          First;
          While Not EoF Do Begin
                TheElementNo  := SQLItemsELEMENT_NO.AsString;
                TheCategoryNo := SQLItemsCATEGORY_NO.AsString;
                Node := Details.FindNode(TheElementNo,TheCategoryNo);
                ValidateElementNoFlags2(TheElementNo + Node.CategoryElementCode);
                {If Not Assigned(Node) Then Begin
                     raise Exception.CreateFmt(ME_040,
                                             [TheCategoryNo,TheElementNo]);
                End;}
                With Node Do Begin
                     CategoryRate     := SQLItemsRATE_VALUE.Value;
                     CategoryQuantity := SQLItemsQUANTITY.Value;
                     CategoryGlobal   := SQLItemsPAID_VALUE.Value;
                     CategoryInAct    := True;
                End;
                Next;
          End;
     End
End;

Procedure TdmActs.CompleteLoadOfCrrEleNoDef;
Var
   Node:                TCategoryDef; { Category Definition for the module }
   ElementNoCache:      String;
   GenEleNoDef:         TEleNoDef;
   LocEleNoDef:         TEleNoDef;
   ListIndex:           Integer;
Begin
     ElementNoCache := '';
     ListIndex      := 0;
     While ListIndex < FDetails.Count Do Begin
           Node := TCategoryDef(FDetails[ListIndex]);
           If Node.CategoryElement <> ElementNoCache Then Begin
              ElementNoCache := Node.CategoryElement;
              If FCrrEleNoDef.IndexOf(ElementNoCache) < 0 Then Begin
                 GenEleNoDef := FElementNoDefs.DefinitionOf[ElementNoCache + Node.CategoryElementCode];
                 If Assigned(GenEleNoDef) Then Begin
                    //LocEleNoDef := TEleNoDef.Create(ElementNoCache,GenEleNoDef.Flags);
                    LocEleNoDef := TEleNoDef.Create(Trim(Node.CategoryElementCode),GenEleNoDef.Flags);
                    FCrrEleNoDef.AddDefinition(LocEleNoDef);
                 End;
              End;
           End;
           Inc(ListIndex);
     End;
End;
{ Create the list EleXPercent. Each item in this list is the definition
  of one element "calculated by percent" and it's an object of the class
  TElementPercent. This is filled as follow :

  For each posible category in the act (i.e all the categories of all
  the elements defined in the contract-portion) we check if its Element No
  is "calculated by percent", if so, then we check if that Element No
  is already in the list EleXPercent, if not yet, then we create its
  definition and add it to the list. After it, we add the category as
  a category for the this Element No "calculated by percent" }
Procedure TdmActs.CreateListOfElementsByPercent;
Var
   Node:                TCategoryDef;    { Category Definition }
   ElementPercent:      TElementPercent; { Definition on an Element By Percent }
   EleNoEleCode:        TEleNoEleCode; { Link from Element No to its Element Code }
   ListIndex:           Integer;
Begin
     FEleXPercent.Clear;
     ListIndex := 0;
     While ListIndex < Details.Count Do Begin
           With TCategoryDef(Details[ListIndex]) Do Begin
                {dbermudez - begin new code 10/10/2016}
                If FCrrEleNoDef.IsPercent[Trim(CategoryElement) + Trim(CategoryElementCode)] Then Begin
                {dbermudez - end new code 10/10/2016}
                {dbermudez - begin old code 30/09/2016}
                //If (FCrrEleNoDef.IsPercent[Trim(CategoryElement)] Or
                // FCrrEleNoDef.IsPercent[Trim(CategoryElementCode)]) Then Begin
                {dbermudez - end old code 30/09/2016}
                   ElementPercent := FEleXPercent.Element[CategoryElement];
                   If Not Assigned(ElementPercent) Then Begin
                      EleNoEleCode               := FEleNoEleCodes.ElementDef[CategoryElement];
                      ElementPercent             := TElementPercent.Create;
                      ElementPercent.ElementNo   := CategoryElement;
                      ElementPercent.ElementName := EleNoEleCode.ElementNoName;
                      FEleXPercent.AddObject(CategoryElement,ElementPercent)
                   End;
                   ElementPercent.AddCategory(CategoryNro,
                                              CategoryDesc,
                                              CategoryTopValue);
                End;
           End;
           Inc(ListIndex);
     End;
End;
{ Rolando Celedón 2003-06-19.
  New routine to fix an error because in the original version, when an
  CC assigned to an element "calculated by percent" was not longer used,
  its values were not being deleted of the database.
  Use this routine to make a list of the elements "calculated by percent",
  including into that list the CCs that already exits when an acts is going
  to be edited. This list will be used later, when we are saving the act,
  to check what elements have CCs not longer used; therefore the routine
  CreateListOfOldElementsByPercent must be called just after to make the
  EleXPercent list (i.e just after the
  routine CreateListOfElementsByPercent) }
Procedure TdmActs.CreateListOfOldElementsByPercent;
Var
   ListIndex:           Integer;
   CategoryIndex:       Integer;
   Category1:           TPercentRange;
   ElementPercent1:     TElementPercent; { Definition on an Element By Percent }
   ElementPercent2:     TElementPercent; { Copy of Definition on an Element By Percent }
Begin
     FOldEleXPrc.Clear;
     ListIndex := 0;
     While ListIndex < FEleXPercent.Count Do Begin
           ElementPercent1 := FEleXPercent.ElementAt[ListIndex];
           ElementPercent2 := TElementPercent.Create;
           ElementPercent2.ElementNo   := ElementPercent1.ElementNo;
           ElementPercent2.ElementName := ElementPercent1.ElementName;
           CategoryIndex := 0;
           While CategoryIndex < ElementPercent1.Categories.Count Do Begin
                 Category1 := ElementPercent1.Categories.CategoryAt[CategoryIndex];
                 ElementPercent2.AddCategory(Category1.CategoryNo,
                                             Category1.CategoryName,
                                             Category1.Percent);
                 Inc(CategoryIndex);
           End;
           FOldEleXPrc.AddObject(ElementPercent2.ElementNo,ElementPercent2);
           Inc(ListIndex);
     End;
End;
Function TdmActs.GettblDetailVALUE:Currency;
Var
   IsByPercent:         Boolean;
   TheElementNo:        String;
   TheElementCode:      String;
begin
     IsByPercent := CrrEleNoDef.IsPercent[tblDetailELEMENT_NO.AsString + tblDetailELEMENT_CODE.AsString];
     If tblDetailBY_GLOBAL.AsBoolean Or IsByPercent Then Begin
        GettblDetailVALUE := tblDetailGLOBAL_VALUE.Value;End
     Else Begin
        If tblDetailQUANTITY.IsNull Then Begin
           GettblDetailVALUE := 0;End
        Else Begin
        {De Moya: 2002-08-12.  Program is using the input given by user, but
        it has more decimal digits that DB definition, making that the
        DetailValue is not equal to multiply two values (quantity by unitarian
        value) after values are saved.
        To avoid this, a roundto function is added}
           GettblDetailVALUE := Roundto(tblDetailQUANTITY.Value,-4)*
                                   tblDetailUNITARIAN_VALUE.Value;
        End;
     End;
     TheElementNo := tblDetailELEMENT_NO.AsString;
     TheElementCode := tblDetailELEMENT_CODE.AsString;

     If Not FElementNoDefs.PreserveSign[TheElementNo + TheElementCode] Then Begin
        If FElementNoDefs.IsCost[TheElementNo + TheElementCode] Then Begin
           { The Cost element are ever positives }
           GettblDetailVALUE := Abs(tblDetailVALUE.Value);
        End;
        If FElementNoDefs.IsDiscount[TheElementNo] Then Begin
           { The Cost element are ever negatives }
           GettblDetailVALUE := -Abs(tblDetailVALUE.Value);
        End;
     End;
end;
{ Copy the records Element-Category in Contract-Portion from the cache
  list to an auxiliary Paradox table. The Paradox table is a temporal
  table, it uses cache updated to best performance and never write really
  to disk }
Procedure TdmActs.ElementsCategoriesToAuxiliaryTable;
Var
   I:                   Integer;
   value: String;
Begin
     I:=0;
     While I<FDetails.Count Do Begin
           tblDetail.Append;
           With TCategoryDef(FDetails.Items[I]) Do Begin
                tblDetailELEMENT_NO.Value    := CategoryElement;
                tblDetailCATEGORY_NO.Value   := CategoryNro;
                tblDetailCATEGORY_DESC.Value := CategoryDesc;
                tblDetailCATEG_BASE_UN.Value := CategoryMeasure;
                tblDetailBY_GLOBAL.AsBoolean := CategoryByGlobal;
                tblDetailELEMENT_CODE.AsString := CategoryElementCode;
                value := CategoryElementCode;
                If CategoryByGlobal Then Begin
                   tblDetailGLOBAL_VALUE.AsCurrency := CategoryGlobal;End
                Else Begin
                   tblDetailQUANTITY.Value        := CategoryQuantity;
                   tblDetailUNITARIAN_VALUE.Value := CategoryRate;
                End;
                CategoryValue := GettblDetailVALUE;
                tblDetail.Post;
           End;
           Inc(I);
     End;
End;
{ Use this routine to do visibles in the table Detail only the categories
  in the element AnElement }
Procedure TdmActs.SetCategoryRangeForDisplay(AnElement:String);
Begin
     With tblDetail Do Begin
          SetRangeStart;
          tblDetailELEMENT_NO.Value    := AnElement;
          tblDetailCATEGORY_DESC.Value := '  ';
          SetRangeEnd;
          tblDetailELEMENT_NO.Value    := AnElement;
          tblDetailCATEGORY_DESC.Value := 'zz';
          ApplyRange;
     End;
End;
procedure TdmActs.LoadElementsTopValues;
Var
   CrrEleVal:           TElementVal;{ Values of the current element }
Begin
     With SQLCntPrtEle Do Begin
          Try
             ElementValues.ClearAndFree;
             While Not EoF Do Begin
                   CrrEleVal := TElementVal.Create;
                   CrrEleVal.ElementNo     := SQLCntPrtEleELEMENT_NO.AsString;
                   CrrEleVal.ElementValCnt := SQLCntPrtEleELEMENT_VAL.AsCurrency;
                   CrrEleVal.ElementValCC  := 0;
                   ElementValues.AddObject(CrrEleVal.ElementNo,CrrEleVal);
                   Next;
             End;
          Finally
             Active := False;
          End;
     End;
End;
Procedure TdmActs.LoadPaidsToElements;
Begin
     With SQLCntPrtEleVal Do Begin
          First;
          While Not EoF Do Begin
                ElementValues.ElementPaid[Fields[0].AsString] := Fields[1].AsCurrency;
                Next;
          End;
          Active := False;
     End;
End;
Procedure TdmActs.LoadElementsValuesInAct;
Var
   CrrElement:          TElementVal;
   ElementNo:           String;
Begin
     With SQLValEleAct Do Begin
          Try
             First;
             While Not EoF Do Begin
                   ElementNo  := Fields[0].AsString;
                   CrrElement := ElementValues.ElementDef[ElementNo];
                   If Not Assigned(CrrElement) Then Begin
                      raise Exception.CreateFmt(ME_157,[ElementNo]);
                   End;
                   CrrElement.ElementExeAct := Fields[1].AsCurrency;
                   Next;
             End;
          Finally
             Active := False;
          End;
     End;
End;
{ Use this routine when the method to validate editions to the Act Paid is :
  "The full payment to any element MUST be less than, or equal, to the Element
  value in the contract". In this method the top value in an element cann't be
  exceded. }
Procedure TdmActs.ValidateByElement(AContract,APortion,AnAct:String);
Begin
     GetPaidsToElements(AContract,APortion);
     LoadPaidsToElements;
     If Not ValInActLoaded Then Begin
        GetElementsValuesInAct(AContract,AnAct);
        LoadElementsValuesInAct;
     End;
     ElementValues.ValidateElementTops;
End;
{ Use this routine when the method to validate editions to the Act Paid is :
  "Payments to the Portion ONLY need to be less than, or equal, to the Portion
  value in the contract". In this method the top value in an element can be
  exceded. }
Procedure TdmActs.ValidateByPortion;
Var
   EditedValue:         Currency;   { Edited Value of the current Portion }
   MaxValue:            Currency;   { Max Value authorized for the portion }
Begin
     MaxValue    := SQLPortionPORTION_VAL.AsCurrency;
     EditedValue := GetPaidsToPortion(CurrentActPaid.ActPaidContract,
                                      CurrentActPaid.ActPaidPortion);

     With dmacts.SQLRestaValor Do Begin
        Try
           Active:=False;
           Params[0].AsString:=CurrentActPaid.ActPaidContract;
           Params[1].AsString:=CurrentActPaid.ActPaidCode;
           Params[2].AsString:=CurrentActPaid.ActPaidPortion;
           If Not Prepared Then Begin
              Prepare;
           End;
           Active:=True;
           {De Moya 2004-04-02 Suprimido para que no falle cuando
           no hay datos en la saf3a1, por ejemplo en contrato nuevo}
           {If Fields[0].IsNull Then Begin
           raise Exception.Create(ME_010);
           End;}
        Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_011,[' ',E.Message]);
           End;
        End;
     End;
     if dmacts.SQLRestaValor.Fields[0].isnull then
        EditedValue := 0
     else
        EditedValue:=dmacts.SQLRestaValor.Fields[0].AsFloat;

//   EditedValue := EditedValue + ActPaidNewValue;
     EditedValue := EditedValue + ActPaidNewNetValue;
     If EditedValue > MaxValue Then Begin
        if ((EditedValue-MaxValue)>=0.01) then
           raise Exception.CreateFmt(ME_037,[EditedValue,MI_017,MaxValue]);
     End;
End;
{ Use this routine when the method to validate editions to the Act Paid is :
  "Payments to the Contract ONLY need to be less than, or equal, to the Contract
  value in the contract". In this method the top value in an element, or a
  Portion can be exceded. }
Procedure TdmActs.ValidateByContract;
Var
   EditedValue:         Currency;   { Edited Value of the current Contract }
   MaxValue:            Currency;   { Max Value authorized for the Contract }
Begin
     MaxValue    := SQLContractCONTRACT_VAL.AsCurrency;
     EditedValue := GetPaidsToContract(CurrentActPaid.ActPaidContract);

     With dmacts.SQLRestaValor Do Begin
        Try
           Active:=False;
           Params[0].AsString:=CurrentActPaid.ActPaidContract;
           Params[1].AsString:=CurrentActPaid.ActPaidCode;
           Params[2].AsString:=CurrentActPaid.ActPaidPortion;
           If Not Prepared Then Begin
              Prepare;
           End;
           Active:=True;
           {De Moya 2004-04-02 Suprimido para que no falle cuando
           no hay datos en la saf3a1, por ejemplo en contrato nuevo}
           {If Fields[0].IsNull Then Begin
           raise Exception.Create(ME_010);
           End;}
        Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_011,[' ',E.Message]);
           End;
        End;
     End;
     if dmacts.SQLRestaValor.Fields[0].isnull then
        EditedValue := 0
     else
        EditedValue:=dmacts.SQLRestaValor.Fields[0].AsFloat;

//   EditedValue := EditedValue + ActPaidNewValue;
     EditedValue := EditedValue + ActPaidNewNetValue;
     If EditedValue > MaxValue Then Begin
        if ((EditedValue-MaxValue)>=0.01) then
           raise Exception.CreateFmt(ME_093,[EditedValue,MI_017,MaxValue]);
     End;

End;
{ Use this routine when the method to validate editions to the Act Paid is :
  "Payments to the Portion ONLY need to be less than, or equal, to the Portion
  signed value in the contract". In this method the top value in an element
  can be exceded. }
Procedure TdmActs.ValidateBySignedPortion;
Var
   EditedValue:         Currency;   { Edited Value of the current Portion }
   MaxValue:            Currency;   { Max Value authorized for the portion }
   Round : integer;
Begin
     MaxValue    := SQLPortionLIQ_DAM_LIMIT.AsCurrency;
     EditedValue := GetPaidsToPortion(CurrentActPaid.ActPaidContract,
                                      CurrentActPaid.ActPaidPortion);

     With dmacts.SQLRestaValor Do Begin
        Try
           Active:=False;
           Params[0].AsString:=CurrentActPaid.ActPaidContract;
           Params[1].AsString:=CurrentActPaid.ActPaidCode;
           Params[2].AsString:=CurrentActPaid.ActPaidPortion;
           If Not Prepared Then Begin
              Prepare;
           End;
           Active:=True;
           {De Moya 2004-04-02 Suprimido para que no falle cuando
           no hay datos en la saf3a1, por ejemplo en contrato nuevo}
           {If Fields[0].IsNull Then Begin
           raise Exception.Create(ME_010);
           End;}
        Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_011,[' ',E.Message]);
           End;
        End;
     End;
     if dmacts.SQLRestaValor.Fields[0].isnull then
        EditedValue := 0
     else
        EditedValue:=dmacts.SQLRestaValor.Fields[0].AsFloat;

//   EditedValue:= EditedValue + ActPaidNewValue;
     EditedValue := EditedValue + ActPaidNewNetValue;
     If EditedValue > MaxValue Then Begin
        if ((EditedValue-MaxValue)>=0.01) then
           raise Exception.CreateFmt(ME_037,[EditedValue,MI_018,MaxValue]);
     End;
End;
{ Use this routine when the method to validate editions to the Act Paid is :
  "Payments to the Contract ONLY need to be less than, or equal, to the Contract
  signed value in the contract". In this method the top value in an element,
  or a Portion can be exceded. }
Procedure TdmActs.ValidateBySignedContract;
Var
   EditedValue:         Currency;   { Edited Value of the current Contract }
   MaxValue:            Currency;   { Max Value authorized for the Contract }
Begin
     MaxValue    := SQLContractPERF_GTEE_VAL.AsCurrency;
     EditedValue := GetPaidsToContract(CurrentActPaid.ActPaidContract);

     With dmacts.SQLRestaValor Do Begin
        Try
           Active:=False;
           Params[0].AsString:=CurrentActPaid.ActPaidContract;
           Params[1].AsString:=CurrentActPaid.ActPaidCode;
           Params[2].AsString:=CurrentActPaid.ActPaidPortion;
           If Not Prepared Then Begin
              Prepare;
           End;
           Active:=True;
           {De Moya 2004-04-02 Suprimido para que no falle cuando
           no hay datos en la saf3a1, por ejemplo en contrato nuevo}
           {If Fields[0].IsNull Then Begin
           raise Exception.Create(ME_010);
           End;}
        Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_011,[' ',E.Message]);
           End;
        End;
     End;
     if dmacts.SQLRestaValor.Fields[0].isnull then
        EditedValue := 0
     else
        EditedValue:=dmacts.SQLRestaValor.Fields[0].AsFloat;


     EditedValue := EditedValue + ActPaidNewValue;
     If EditedValue > MaxValue Then Begin
        if ((EditedValue-MaxValue)>=0.01) then
           raise Exception.CreateFmt(ME_093,[EditedValue,MI_018,MaxValue]);
     End;
End;
Procedure TdmActs.ValidateCCDistributionLine;
Var
   TypeDocument:        Integer;
Begin
     TypeDocument := SQLValCCDstDOCUMENT_TYPE.AsInteger;
     If (TypeDocument < Ord(Low(TDocument))) Or
        (TypeDocument > Ord(High(TDocument))) Then Begin
        raise Exception.CreateFmt(ME_196,
                                  [SQLValCCDstELEMENT_NO.AsString,
                                   SQLValCCDstGL_ACCOUNT.AsString]);
     End;
     If TypeDocument <> Ord(tdNone) Then Begin
        If Trim(SQLValCCDstDOCUMENT_NO.AsString) = '' Then Begin
           raise Exception.CreateFmt(ME_195,
                                  [SQLValCCDstDOCUMENT_TYPE.DisplayText,
                                   SQLValCCDstELEMENT_NO.AsString,
                                   SQLValCCDstGL_ACCOUNT.AsString]);
        End;
     End;
End;
Procedure TdmActs.ValidateCCDistribution(AContract,AnActPaid:String);
Var
   CCRecords:           Integer;

Begin
     CCRecords := 0;
     {De Moya 2006-03-02}
     AContract:=GetMimsKey(AContract,8);
     With SQLValCCDst Do Begin
          Try
             Active := False;
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             Try
                Active := True;
                While Not EoF Do Begin
                      ValidateCCDistributionLine;
                      Inc(CCRecords);
                      Next;
                End;
                If CCRecords < 1 Then Begin
                   raise Exception.Create(ME_194);
                End;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_193,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to validate the global conditions to save the editions
  to the current Act Paid. The first condition to validate is defined by
  the ActValidation property in the current user preferences configuration.
  The second condition to validate is defined by the TypeCntLimit property
  in the current user preferences configuration.
  This routine must be called after the uncommited changes to the current
  Act Paid and before to commit them }
Procedure TdmActs.ValidateActPaidEditions;
Begin
     Case UserConfig.ActValidation Of
     avNone     : Nothing;
     avElement  : ValidateByElement(CurrentActPaid.ActPaidContract,
                                    CurrentActPaid.ActPaidPortion,
                                    CurrentActPaid.ActPaidCode);
     avPortion  : ValidateByPortion;
     avContract : ValidateByContract;
     Else raise Exception.CreateFmt(ME_126,[MI_017]);
     End;
     Case UserConfig.TypeCntLimit Of
     tclNone     : Nothing;
     tclPortion  : ValidateBySignedPortion;
     tclContract : ValidateBySignedContract;
     Else raise Exception.CreateFmt(ME_126,[MI_018]);
     End;
End;
Function TdmActs.GetCurrencyRate(ALocalCrr,AForeignCrr,ADate:String):Double;
Begin
     With SQLGetCrrRt Do Begin
          Try
             Active := False;
             Params[0].AsString := Trim(ALocalCrr);
             Params[1].AsString := Trim(AForeignCrr);
             Params[2].AsString := ADate;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active := True;
                If Fields[0].IsNull Then Begin
                   raise Exception.Create(ME_077);
                End;
                GetCurrencyRate := Fields[0].AsFloat;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_145,[AForeignCrr,
                                                  ALocalCrr,
                                                  E.Message]);
             End;
          End;
     End;
End;
Function TdmActs.GetLocalCurrency(ADistrict:String):String;
Begin
     With SQLGetLocCrr Do Begin
          Try
             Active := False;
             Params[0].AsString := ADistrict;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_143);
             End;
             GetLocalCurrency := Fields[0].AsString;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_144,[ADistrict,E.Message]);
             End;
          End;
     End;
End;
{ Use this function to calculate the executed value for the current Act Paid.
  The executed value is the sum of all the items in the Act differents to
  discounts. We calculate it by using the current Detail list in memory }
Function TdmActs.GetExecAPValue:Currency;
Var
   FExecAPValue:       Currency;
   FDetailIndex:       Integer;
Begin
     FExecAPValue := 0;
     FDetailIndex := 0;
     While FDetailIndex < Details.Count Do Begin
           With TCategoryDef(Details.Items[FDetailIndex]) Do Begin
                If Not CrrEleNoDef.IsDiscount[CategoryElement + CategoryElementCode] Then Begin
                   FExecAPValue := FExecAPValue + CategoryGlobal;
                End;
           End;
           Inc(FDetailIndex);
     End;
     GetExecAPValue := FExecAPValue;
End;
Function TdmActs.ElementOrderOf(AnElement:String):Integer;
Begin
     ElementOrderOf := 0;
     If FCrrEleNoDef.IsPercent[AnElement] Then Begin
        ElementOrderOf := 1; End
     Else Begin
        If FCrrEleNoDef.IsDiscount[AnElement] Then Begin
           ElementOrderOf := 2;
        End;
     End;
End;
Function TdmActs.SortByElementKind(Item1, Item2: Pointer): Integer;
Var
   CategoryItem1:       TCategoryDef;
   CategoryItem2:       TCategoryDef;
   Order1:              Integer;
   Order2:              Integer;
Begin
     CategoryItem1 := TCategoryDef(Item1);
     CategoryItem2 := TCategoryDef(Item2);
     Order1        := ElementOrderOf(CategoryItem1.CategoryElement);
     Order2        := ElementOrderOf(CategoryItem2.CategoryElement);
     If Order1 < Order2 Then Begin
        SortByElementKind := -1; End
     Else Begin
        If Order1 > Order2 Then Begin
           SortByElementKind := 1; End
        Else Begin
           If CategoryItem1.CategoryElement < CategoryItem2.CategoryElement Then Begin
              SortByElementKind := -1; End
           Else Begin
              If CategoryItem1.CategoryElement > CategoryItem2.CategoryElement Then Begin
                 SortByElementKind := 1; End
              Else Begin
                 SortByElementKind := 0;
              End;
           End;
        End;
     End;
End;
Procedure TdmActs.CreateCurrencyList;
Var
   NewCurrency:         String;
   CurrencyIndex:       Integer;
Begin
     With SQLGetCrr Do Begin
          Try
             Try
                CurrencyList.Clear;
                Active := True;
                While Not EoF Do Begin
                      NewCurrency := Fields[0].AsString;
                      If Not CurrencyList.Find(NewCurrency,CurrencyIndex) Then Begin
                         CurrencyList.Add(NewCurrency);
                      End;
                      Next;
                End;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_150,[E.Message]);
             End;
          End;
     End;
End;

Procedure TdmActs.InsertActPaid(AContract,APortion,AnActPaid:String);
Begin
     With SQLInsActPaid Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString   := AContract;
             Params[1].AsString   := APortion;
             Params[2].AsString   := AnActPaid;
             Params[3].AsString   := CurrentDate;
             Params[4].AsString   := CurrentUser;
             Params[5].AsString   := CurrentUser;
             Params[6].AsString   := IntToStr(Ord(UserConfig.TypeComments));
             Params[7].AsString   := IntToStr(Ord(UserConfig.TypeCntrctExt));
             Params[8].AsString   := IntToStr(Ord(UserConfig.APInfoAtax));
             Params[9].AsString   := IntToStr(Ord(UserConfig.DCCTypeDstrb));
             Params[10].AsString  := SQLPortionLIQ_DAM_BASE.AsString;
             Params[11].AsString  := dmActs.MimsPosition;
             ExecSQL;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_025,[AContract,APortion,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.UpdateActPaid(AContract,AnActPaid,
                                AnInvCurrency,AnInvChangeRateDt:String;
                                AnInvChangeRate:Double;
                                APeriodFrom,APeriodTo:String);
Var
   Mns:                 String;
Begin
     With SQLUpdActPaid Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             ParamByName('AContract').AsString         := AContract;
             ParamByName('AnActPaid').AsString         := AnActPaid;
             ParamByName('ALastChangeBy').AsString     := CurrentUser;
             ParamByName('ATypeComments').AsString     := IntToStr(Ord(UserConfig.DTypeComments));
             ParamByName('ATypeCntrctExt').AsString    := IntToStr(Ord(UserConfig.DTypeCntrctExt));
             ParamByName('AnAPInfoAtax').AsString      := IntToStr(Ord(UserConfig.DAPInfoAtax));
             ParamByName('AnInvCurrency').AsString     := AnInvCurrency;
             ParamByName('AnInvChangeRate').AsFloat    := AnInvChangeRate;
             ParamByName('AnInvChangeRateDt').AsString := AnInvChangeRateDt;
             ParamByName('APeriodFrom').AsString       := APeriodFrom;
             ParamByName('APeriodTo').AsString         := APeriodTo;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_116,[AContract,AnActPaid,E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
End;
{ Use this routine to get the right percent for each Cost Center when the
  Type Distribution is ByValue. Note the following, if the method is ByValue,
  we know the values assigned to the Cost Centers; but, we need to calculate
  the percents }
Procedure TdmActs.SetCCPercentFromValues;
Var
   ElementNo:           String;     { Current Element No }
   ElementIndex:        Integer;    { Index of the current element }
   CrrElement:          TElementVal;{ Definition of the current Element }
   CCValue:             Currency;   { Value of current Cost Center }
   CCPercent:           Integer;    { Percent of the current Cost Center }
   CCPercentStr:        String;     { CCPercent in string format }
  Procedure ValidateTotalByElement;
  Begin
       CrrElement := ElementValues.Objects[ElementIndex] As TElementVal;
       With CrrElement Do Begin
            If Abs(ElementExeAct) > 0.00005 Then Begin
               If Abs(ElementExeAct-ElementValCC) > 0.0001 Then Begin
                  raise Exception.CreateFmt(ME_129,[ElementNo,
                                                    ElementExeAct,
                                                    ElementValCC]);
               End;
            End;
       End;
  End;
Begin
     GetElementsValuesInAct(CurrentActPaid.ActPaidContract,
                            CurrentActPaid.ActPaidCode);
     LoadElementsValuesInAct;
     ElementValues.ClearCCValues;
     ValInActLoaded := True;
     With tblCosts Do Begin
          First;
          If tblCostsELEMENT_NO.IsNull Then Begin
             raise Exception.Create(ME_128);
          End;
          While Not Eof Do Begin
                CCValue      := tblCostsVALUE.AsCurrency;
                ElementNo    := tblCostsELEMENT_NO.AsString;
                CrrElement   := ElementValues.ElementDef[ElementNo];
                With CrrElement Do Begin
                     ElementValCC := ElementValCC + CCValue;
                     If Abs(ElementExeAct) < 0.0001 Then Begin
                        CCPercent := 0; End
                     Else Begin
                        CCPercent := Round(10000*(CCValue/ElementExeAct));
                     End;
                     If (CCPercents + CCPercent) > 10000 Then Begin
                        CCPercent := 10000 - CCPercents;
                     End;
                     CCPercents   := CCPercents + CCPercent;
                     CCPercentStr := Format('%5.5d',[CCPercent]);
                     If CCPercentStr <> tblCostsPERCENT.AsString Then Begin
                        Edit;
                        tblCostsPERCENT.AsString := CCPercentStr;
                        Post;
                     End;
                End;
                Next;
          End;
     End;
     ElementIndex := 0;
     While ElementIndex < ElementValues.Count Do Begin
           ValidateTotalByElement;
           Inc(ElementIndex);
     End;
End;
{ Use this routine to save into SAF3A6 the new default cost centers
  for the current contract - portion }
Procedure TdmActs.SaveCurrentCC;
Var
   Key:                 String;
   CCIndex:             Integer;
   {De Moya 2006-09-12. IC845 - El campo tblCostsDOCUMENT_NO.AsString podria tener valor nulo}
   StrDocument_no:      String;
Begin
     With tblCosts Do Begin
          First;
          While Not EoF Do Begin
                If UpdateStatus in [usModified, usInserted] Then Begin
                   if tblCostsDOCUMENT_NO.AsString = '' then
                   begin
                     StrDocument_no:=' ';
                   end
                   else
                   begin
                     StrDocument_no:=tblCostsDOCUMENT_NO.AsString;
                   end;
                   Key := tblCostsELEMENT_NO.AsString +
                          tblCostsGL_ACCOUNT.AsString +
                          tblCostsDOCUMENT_TYPE.AsString +
                          {tblCostsDOCUMENT_NO.AsString +}
                          StrDocument_no +
                          tblCostsEQUIP_NO.AsString;
                   CCIndex := CCCList.IndexOf(Key);
                   If CCIndex < 0  Then Begin
                      InsertCostCenter; End
                   Else Begin
                      UpdateCostCenter;
                      (CCCList.Objects[CCIndex] As TCCCurrent).IsOld := False;
                   End;
                   { Show Progress, because the previous operation is different
                     to the update on tblCosts }
                   DoOnFeedBack(Self);
                End
                {De Moya - 2004-02-25. El programa borra los centros de costos
                cuando no se modifican.  Agrego el siguiente ELSE y suprimo el
                punto y coma (;) del END inmediatamente anterior}
                Else
                begin
                  Key := tblCostsELEMENT_NO.AsString +
                          tblCostsGL_ACCOUNT.AsString +
                          tblCostsDOCUMENT_TYPE.AsString +
                          tblCostsDOCUMENT_NO.AsString +
                          tblCostsEQUIP_NO.AsString;
                  CCIndex := CCCList.IndexOf(Key);
                  if CCIndex >= 0 then
                  begin
                    (CCCList.Objects[CCIndex] As TCCCurrent).IsOld := False;
                  end;
                end;
                Next;
          End;
     End;
End;

{dbermudez 14-02-2017 begin}
Procedure TdmActs.ForceSaveCurrentCC;
Var
   Key:                 String;
   CCIndex:             Integer;
   StrDocument_no:      String;
Begin
     With tblCosts Do Begin
          First;
          While Not EoF Do Begin
                   if tblCostsDOCUMENT_NO.AsString = '' then
                   begin
                     StrDocument_no:=' ';
                   end
                   else
                   begin
                     StrDocument_no:=tblCostsDOCUMENT_NO.AsString;
                   end;
                   Key := tblCostsELEMENT_NO.AsString +
                          tblCostsGL_ACCOUNT.AsString +
                          tblCostsDOCUMENT_TYPE.AsString +
                          {tblCostsDOCUMENT_NO.AsString +}
                          StrDocument_no +
                          tblCostsEQUIP_NO.AsString;
                   CCIndex := CCCList.IndexOf(Key);
                   If CCIndex < 0  Then Begin
                      InsertCostCenter; End
                   Else Begin
                      UpdateCostCenter;
                      (CCCList.Objects[CCIndex] As TCCCurrent).IsOld := False;
                   End;
                   { Show Progress, because the previous operation is different
                     to the update on tblCosts }
                   DoOnFeedBack(Self);
                Next;
          End;
     End;
End;
{dbermudez 14-02-2017 end}

Procedure TdmActs.DeleteInfoAtax(AContract,AnActPaid:String);
Begin
     With SQLDelInfAtx Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             ExecSQL;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_153,[E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.InsertInfoAtaxCode;
Begin
     With SQLInsInfAtx Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := CurrentActPaid.ActPaidContract;
             Params[1].AsString := CurrentActPaid.ActPaidCode;
             Params[2].AsString := tblInfoAtaxATAX_CODE.AsString;
             Params[3].AsFloat  := tblInfoAtaxATAX_RATE.AsFloat;
             Params[4].AsFloat  := tblInfoAtaxATAX_BASE.AsCurrency;
             Params[5].AsFloat  := tblInfoAtaxATAX_VALUE.AsCurrency;
             ExecSQL;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_151,
                                         [E.Message,
                                          tblInfoAtaxATAX_CODE.AsString]);
             End;
          End;
     End;
End;
Procedure TdmActs.UpdateInfoAtaxForAct;
Begin
     With tblInfoAtax Do Begin
          First;
          While Not EoF Do Begin
                InsertInfoAtaxCode;
                Next;
          End;
     End;
End;

{ Use this routine to calculate the current values for categories of
  elements "calculated by percent" }
Procedure TdmActs.CalcElementsByPercent;
Var
   ElementPercent:      TElementPercent; { Definition for Elements calculated by percents }
   ListIndex:           Integer;
   ElementIndex:        Integer;
   CategoryIndex:       Integer;
   ElementVal:          TElementVal;
   Category:            TPercentRange;
   DetailKey:           Variant;
Begin
     ListIndex := 0;
     While ListIndex < EleXPercent.Count Do Begin
           ElementPercent := EleXPercent.ElementAt[ListIndex];
           { Calculate the values of every category in the element }
           ElementPercent.ClearCategoryValues;
           ElementPercent.CalcValuesByPercent(ElementValues);
           { Now, Copy the category values in the element, to the cache
             list of all the categories in the act }
           CategoryIndex := 0;
           While CategoryIndex < ElementPercent.Categories.Count Do Begin
                 Category  := TPercentRange(ElementPercent.Categories[CategoryIndex]);
                 DetailKey := VarArrayOf([ElementPercent.ElementNo,Trim(Category.CategoryName)]);
                 If Not TblDetail.Locate(KNL_003,DetailKey,[])  Then Begin
                    raise Exception.CreateFmt(ME_072,[ElementPercent.ElementNo,
                                                      trim(Category.CategoryName)]);
                 End;
                 TblDetail.Edit;
                 tblDetailGLOBAL_VALUE.Value := Category.Value;
                 TblDetail.Post;
                 Inc(CategoryIndex);
           End;
           Inc(ListIndex);
     End;
End;
{ Use this routine to init the CategoryValue field in the items of the
  detail list for Elements calculated by percent. This action must be
  executed before to init the edition of an act and after to calculate
  this kind of elements by using the routine CalcElementsByPercent; }
Procedure TdmActs.SetDetailValuesForElementsByPercent;
Var
   TheCategory:         TCategoryDef;
   ListIndex:           Integer;
Begin
     ListIndex := 0;
     While ListIndex < FDetails.Count Do Begin
           TheCategory := FDetails.CategoryAt[ListIndex];
           If FElementNoDefs.IsPercent[TheCategory.CategoryElement + TheCategory.CategoryElementCode] Then Begin
              TheCategory.CategoryValue := TheCategory.CategoryGlobal;
           End;
           Inc(ListIndex);
     End;
End;
{ This routine process all the cost centers of the element AnElementNo
  by getting the corresponding percent according to its original value
  and the percent to by applied by the element "calculated by percent"
  AnElement }
Procedure TdmActs.ProcessCCs(AnElement:TElementPercent;AnElementNo:String;APercent:Double);
Var
   CCValue:             Currency;
   CrrElement:          TElementVal;{ Definition of the current Element }
Begin
     With tblCosts Do Begin
          First;
          While Not EoF Do Begin
                If AnElementNo = tblCostsELEMENT_NO.AsString Then Begin
                   If UserConfig.DCCTypeDstrb = cctdValue Then Begin
                      CCValue := tblCostsVALUE.AsCurrency; End
                   Else Begin
                      CrrElement := ElementValues.ElementDef[AnElementNo];
                      CCValue    := tblCostsPERCENT.AsInteger;
                      CCValue    := CCValue / 10000.0;
                      CCValue    := CCValue * CrrElement.ElementEdtAct;
                   End;
                   AnElement.ProcessCC(tblCostsGL_ACCOUNT.AsString,
                                       tblCostsDOCUMENT_TYPE.AsString,
                                       tblCostsDOCUMENT_NO.AsString,
                                       tblCostsEQUIP_NO.AsString,
                                       APercent*CCValue);
                End;
                Next;
          End;
     End;
End;

{ Use this routine to calculate the cost center distribution for
  Elements "calculated by percent". The method is the following :
  First, get the proportional value for every cost centers of the
  elements includes in the list of elements to be used by elements
  "calculated by percents"
  Second, if the distribution method is by percent, then get each
  value as percent of the total value of the element "calculated by
  percent"  }
Procedure TdmActs.CalcCCByPercents(AnEleXPercent:TEleXPercent);
Var
   ElementPercent:      TElementPercent; { Definition for Elements calculated by percents }
   Category:            TPercentRange;   { Category "calculated by percent" }
   ListIndex:           Integer;         { Index of Elements "calculated by percent" }
   CategoryIndex:       Integer;         { Index of Categories "calculated by percent" }
   ElementIndex:        Integer;         { Index of Elements to be applied a percent into a category }
   ElementNo:           String;          { ElementNo of an Element to be applied a percent into a category }
Begin
     ListIndex := 0;
     While ListIndex < AnEleXPercent.Count Do Begin
           ElementPercent := AnEleXPercent.ElementAt[ListIndex];
           { Get the total values for every CC in the element }
           CategoryIndex := 0;
           While CategoryIndex < ElementPercent.Categories.Count  Do Begin
                 Category     := ElementPercent.Categories.CategoryAt[CategoryIndex];
                 ElementIndex := 0;
                 While ElementIndex < Category.Elements.Count Do Begin
                       ElementNo := Category.Elements[ElementIndex];
                       ProcessCCs(ElementPercent,ElementNo,Category.Percent);
                       Inc(ElementIndex);
                 End;
                 Inc(CategoryIndex);
           End;
           If UserConfig.DCCTypeDstrb = cctdPercent Then Begin
              { If the Cost Center Distribution is by percent, set
                the corresponding percents }
              ElementPercent.CalcCCPercents;
           End;
           Inc(ListIndex);
     End;
End;
{ Delete the CC by percent not longer used. The method is the following :
  1. For each "element by percent" in the original list (FOldEleXPrc), we
     check if it still exits in the current list (FEleXPercent)
  2. If the element not longer exist, we delete all its CCs from tblCost
  3. If the element still exist, we check each CCs assigned to it,
  4. If a CC's doesn't exist in the current list, then we also delete it

  This process is supported by four routines : DeleteInTblCostsCCsFrom,
  DeleteInTblCostsACCFrom, DeleteInTblCostsCCsNotIn, and as main routine,
  DeleteCCByPercentsNotLongerUsed  }

Procedure TdmActs.DeleteInTblCostsACCFrom(AnElementNo:String;ACC:TCCByPercent);
Var
   CCKey:               Variant;
Begin
     CCKey := VarArrayOf([AnElementNo,
                          ACC.CCCode,
                          ACC.CCDocumentType,
                          ACC.CCDocumentNo,
                          ACC.CCEquip]);
     If tblCosts.Locate(KNL_004,CCKey,[]) Then Begin
        tblCosts.Delete;
     end;
End;
Procedure TdmActs.DeleteInTblCostsCCsFrom(AnElement:TElementPercent);
Var
   CCIndex:             Integer;         { Index of CCs "calculated by percent" }
   CCDefinition:        TCCByPercent;
   TheKey:              Variant;
Begin
     CCIndex := 0;
     While CCIndex < AnElement.CCs.Count Do Begin
           CCDefinition := AnElement.CCs.CCAt[CCIndex];
           DeleteInTblCostsACCFrom(AnElement.ElementNo,CCDefinition);
           Inc(CCIndex);
     End;
End;
Procedure TdmActs.DeleteInTblCostsCCsNotIn(AnElementNo:String;ACCSrcs,ACCsTrg:TCCsByPercent);
Var
   CCIndex:             Integer;         { Index of CCs "calculated by percent" }
   CCDefinition:        TCCByPercent;
   TheKey:              Variant;
Begin
     CCIndex := 0;
     While CCIndex < ACCSrcs.Count Do Begin
           CCDefinition := ACCSrcs.CCAt[CCIndex];
           If ACCsTrg.IndexOf(CCDefinition.CCKey) < 0 Then Begin
              DeleteInTblCostsACCFrom(AnElementNo,CCDefinition);
           End;
           Inc(CCIndex);
     End;
End;
Procedure TdmActs.DeleteCCByPercentsNotLongerUsed;
Var
   ElementPercent1:     TElementPercent; { Definition for Elements calculated by percents }
   ElementPercent2:     TElementPercent; { Definition for Elements calculated by percents }
   ListIndex:           Integer;         { Index of Elements "calculated by percent" }
Begin
     ListIndex := 0;
     While ListIndex < FOldEleXPrc.Count Do Begin
           ElementPercent1 := FOldEleXPrc.ElementAt[ListIndex];
           ElementPercent2 := FEleXPercent.Element[ElementPercent1.ElementNo];
           if Assigned(ElementPercent2) Then Begin
              DeleteInTblCostsCCsNotIn(ElementPercent1.ElementNo,
                                       ElementPercent1.CCs,
                                       ElementPercent2.CCs);end
           else Begin
              DeleteInTblCostsCCsFrom(ElementPercent1);
           end;
           Inc(ListIndex);
     End;
End;
Procedure TdmActs.SaveInCacheCCByPercents;
Var
   ElementPercent:      TElementPercent; { Definition for Elements calculated by percents }
   CC:                  TCCByPercent;    { CC "calculated by percent" }
   CCPercent:           Integer;         { 100* (CC Percent) }
   ListIndex:           Integer;         { Index of Elements "calculated by percent" }
   CCIndex:             Integer;         { Index of CCs "calculated by percent" }
   CCKey:               Variant;
Begin
     ListIndex := 0;
     While ListIndex < FEleXPercent.Count Do Begin
           ElementPercent := EleXPercent.ElementAt[ListIndex];
           CCIndex := 0;
           {De Moya 2003-11-24 Quito el último IC534 - Agregar -1}
           While CCIndex < ElementPercent.CCs.Count  Do Begin
                 CC := ElementPercent.CCs.CCAt[CCIndex];
                 CCKey := VarArrayOf([ElementPercent.ElementNo,
                                      CC.CCCode,
                                      CC.CCDocumentType,
                                      CC.CCDocumentNo,
                                      CC.CCEquip]);
                 If tblCosts.Locate(KNL_004,CCKey,[]) Then Begin
                    tblCosts.Edit; End
                 Else Begin
                    tblCosts.Append;
                    tblCostsELEMENT_NO.AsString    := ElementPercent.ElementNo;
                    tblCostsGL_ACCOUNT.AsString    := CC.CCCode;
                    tblCostsDOCUMENT_TYPE.AsString := CC.CCDocumentType;
                    tblCostsDOCUMENT_NO.AsString   := CC.CCDocumentNo;
                    tblCostsEQUIP_NO.AsString      := CC.CCEquip;
                 End;
                 If UserConfig.DCCTypeDstrb = cctdValue Then Begin
                    tblCostsVALUE.AsCurrency := CC.Total; End
                 Else Begin
                    {dbermudez - begin old code 30/09/2016}
                    //tblCostsPERCENT.AsString := Format('%5.5d',[CC.Percent100]);
                    {dbermudez - begin new code 30/09/2016}
                    if (CC.Percent100 >= 0) then begin
                      tblCostsPERCENT.AsString := Format('%5.5d',[CC.Percent100]);
                    end else begin
                      tblCostsPERCENT.AsString := Format('%5.4d',[CC.Percent100]);
                    end;
                 End;
                 tblCosts.Post;
                 Inc(CCIndex);
           End;
           Inc(ListIndex);
     End;
End;
Procedure TdmActs.SaveCCCalcToTblCost;
Var
   ABeforeInsert:       TDataSetNotifyEvent;
Begin
     Try
        tblCosts.BeforeInsert := Nil;
        SaveInCacheCCByPercents;
     Finally
        tblCosts.BeforeInsert := ABeforeInsert;
     End;
End;
Procedure TdmActs.SaveActPaidDocument(MmComments:TMemo;
                                      AnInvCurrency,AnInvChangeRateDt:String;
                                      AnInvChangeRate:Double;
                                      APeriodFrom,APeriodTo:String);
Begin
     dbActPaid.StartTransaction;
     { Process Elements "calculated by percent" }
     GetEditValueOfTheElements;
     CalcElementsByPercent;
     SaveCategoriesToDisk;
     CalcCCByPercents(FEleXPercent);
     SaveCCCalcToTblCost;
     DeleteCCByPercentsNotLongerUsed;
     OnFeedBack(Nil);
     If UserConfig.DTypeComments <> tcNone Then Begin
        If SQLCommentsCONTRACT_NO.IsNull Then Begin
           SaveComments(SQLInsMemo,MmComments); End
        Else Begin
           SaveComments(SQLUpdMemo,MmComments);
        End;
     End;
     ValInActLoaded := False;
     If UserConfig.DCCTypeDstrb = cctdValue Then Begin
        SetCCPercentFromValues;
     End;
     CCCList.MarkAsOld;
     If UseAsCCC Then Begin
        SaveCurrentCC;
        DeleteCCNoUsed;
     End;

     {dbermudez 14-02-2017 begin}
     if not IsValidCCList(CurrentActPaid.ActPaidContract,CurrentActPaid.ActPaidPortion) then begin
        ForceSaveCurrentCC;
     end;
     {dbermudez 14-02-2017 end}

     tblCosts.ApplyUpdates;
     ValidateActPaidEditions;
     UpdateActPaid(CurrentActPaid.ActPaidContract,
                   CurrentActPaid.ActPaidCode,
                   AnInvCurrency,AnInvChangeRateDt,AnInvChangeRate,
                   APeriodFrom,APeriodTo);
     DeleteInfoAtax(CurrentActPaid.ActPaidContract,
                    CurrentActPaid.ActPaidCode);
     If UserConfig.DAPInfoAtax = apiaYes Then Begin
        UpdateInfoAtaxForAct;
     End;
     dbActPaid.Commit;
     tblCosts.CommitUpdates;
End;
{ Use this routine to active the Comments field for an Act Paid. This
  comments is stored in SAF3A7, a table parallel to SAF3A0. This method
  is used by performance because we avoid the overhead when comments
  are not required }
Procedure TdmActs.OpenComments;
Begin
     With SQLComments,CurrentActPaid Do Begin
          Try
             Active := False;
             Params[0].AsString := ActPaidContract;
             Params[1].AsString := ActPaidCode;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_100,[ActPaidCode,
                                                  ActPaidContract,
                                                  E.Message]);
             End;
          End;
     End;
End;

Function TdmActs.VerifyComments(MimsFieldValue:String):String;
VAR
    MimsFieldValue_cp : String;
Begin
                MimsFieldValue_cp:=' ';

                With SQLDeleteSpecialChar Do Begin

                     Try
                        Active := False;
                        Params[0].AsString := MimsFieldValue;
                        If Not Prepared Then Begin
                                Prepare;
                        End;
                        Active := True;
                        MimsFieldValue_cp := Fields[0].AsString;
                        VerifyComments := Trim(MimsFieldValue_cp);
                     Except
                        On E:Exception Do Begin
                                raise Exception.CreateFmt(ME_101, [E.Message]);
                        End;
                     End;
                End;
End;

Procedure TdmActs.SaveComments(AQuery:TQuery;AMemo:TMemo);
VAR
   MimsFieldValue : String;
   MimsFieldValue_cp : String;
Begin
     MimsFieldValue := Trim(AMemo.Text);
     {if MimsFieldValue<>'' Then Begin
         MimsFieldValue := VerifyComments(Trim(AMemo.Text));
     End; }

     With AQuery,CurrentActPaid Do Begin
          Try
             Active := False;
             ParamByName('AContract').AsString   := ActPaidContract;
             ParamByName('AnActPaid').AsString   := ActPaidCode;
             ParamByName('AnActComments').AsMemo := MimsFieldValue;
             {ParamByName('AnActComments').AsMemo := AMemo.Text;}
             If Not Prepared Then Begin
                Prepare;
             End;
             ExecSQL;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_101,[ActPaidCode,
                                                  ActPaidContract,
                                                  E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.SetActPaidStatus(AContract,AnActPaid,AnStatus,AOldStatus:String);
Begin
     {De Moya 2006-03-02}
     AContract:=GetMimsKey(AContract,8);
     With SQLSetActStatus Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString   := AnStatus;
             Params[1].AsString   := CurrentUser;

             {Added by David Bermudez}
             Params[2].AsString   := MimsPosition;

             Params[3].AsString   := AContract;
             Params[4].AsString   := AnActPaid;
             Params[5].AsString   := AOldStatus;

             ExecSQL;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_021,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;

Procedure TdmActs.SetActPaidApproved(AContract,AnActPaid:String;ACntValue,APrtValue:Currency);
Var
   Mns:                 String;     { Error Message }
Begin
     With SQLSetApproved Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             FPSAAnStatus.AsString    := StrStatusOf(asApproved);
             FPSAAUser.AsString       := CurrentUser;
             FPSAADate.AsString       := DateTimeToDate8(Date);
             FPSAAPrtValue.AsCurrency := APrtValue;
             FPSAACntValue.AsCurrency := ACntValue;
             FPSAAContract.AsString   := AContract;
             FPSAAActPaid.AsString    := AnActPaid;
             FPSAAOldStatus.AsString  := StrStatusOf(asSent);
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns := Format(ME_021,[AnActPaid,AContract,E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
End;
{ Use this routine to insert values for a new category in the Act }
Procedure TdmActs.InsertCategory(AnElement,ACategory:String;
                                 AQuantity:Double;ARate,AValue:Currency);
Var
   Mns:                 String;     { Error Message }
Begin
     With SQLInsEleCat Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             FPIECContract.AsString     := CurrentActPaid.ActPaidContract;
             FPIECActPaid.AsString      := CurrentActPaid.ActPaidCode;
             FPIECElement.AsString      := Copy(AnElement,1,2);
             FPIECCategory.AsString     := ACategory;
             FPIECRateValue.AsCurrency  := ARate;
             FPIECQuantity.AsFloat      := AQuantity;
             FPIECValue.AsCurrency      := AValue;
             FPIECDiscountFlag.AsString := FElementNoDefs.DiscountFlag[AnElement];
             FPIECTPIFlag.AsString      := FElementNoDefs.TPIFlag[AnElement];
             FPIECPercentFlag.AsString  := FElementNoDefs.PercentFlag[AnElement];
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_012,[MI_005,AnElement,ACategory,E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
End;
Procedure TdmActs.UpdateCategory(AnElement,ACategory:String;
                                AQuantity:Double;AValue:Currency);
Var
   Mns:                 String;     { Error Message }
Begin
     With SQLUpdEleCat Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             FPUECContract.AsString := CurrentActPaid.ActPaidContract;
             FPUECActPaid.AsString  := CurrentActPaid.ActPaidCode;
             FPUECElement.AsString  := AnElement;
             FPUECCategory.AsString := ACategory;
             FPUECQuantity.AsFloat  := AQuantity;
             FPUECValue.AsCurrency  := AValue;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_012,[MI_006,AnElement,ACategory,E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
End;
{ Use this routine to insert values for a new Cost Center in the
  current cost center tables for the Contract-Portion-Element key }
Procedure TdmActs.InsertCostCenter;
Var
   Mns:                 String;     { Error Message }
Begin
     With SQLInsCCCrr Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             FPICCContract.AsString     := CurrentActPaid.ActPaidContract;
             FPICCPortion.AsString      := CurrentActPaid.ActPaidPortion;
             FPICCElement.AsString      := tblCostsELEMENT_NO.AsString;
             FPICCGLAccount.AsString    := tblCostsGL_ACCOUNT.AsString;
             FPICCDocumentType.AsString := tblCostsDOCUMENT_TYPE.AsString;
             FPICCDocument.AsString     := tblCostsDOCUMENT_NO.AsString;
             FPICCEquip.AsString        := tblCostsEQUIP_NO.AsString;
             FPICCPercent.AsString      := tblCostsPERCENT.AsString;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_104,[CurrentActPaid.ActPaidContract,
                                    CurrentActPaid.ActPaidPortion,
                                    tblCostsELEMENT_NO.AsString,
                                    tblCostsGL_ACCOUNT.AsString,
                                    E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
End;
{ Use this routine to update the values for the
  Contract-Portion-Element-Cost Center key in the table of the current
  cost center distribution (SAF3A6) }
Procedure TdmActs.UpdateCostCenter;
Var
   Mns:                 String;     { Error Message }
Begin
     With SQLUpdCCCrr Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             FPUCCContract.AsString     := CurrentActPaid.ActPaidContract;
             FPUCCPortion.AsString      := CurrentActPaid.ActPaidPortion;
             FPUCCElement.AsString      := tblCostsELEMENT_NO.AsString;
             FPUCCGLAccount.AsString    := tblCostsGL_ACCOUNT.AsString;
             FPUCCDocumentType.AsString := tblCostsDOCUMENT_TYPE.AsString;
             FPUCCDocument.AsString     := tblCostsDOCUMENT_NO.AsString;
             FPUCCEquip.AsString        := tblCostsEQUIP_NO.AsString;
             FPUCCPercent.AsString      := tblCostsPERCENT.AsString;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_105,[tblCostsGL_ACCOUNT.AsString,
                                    CurrentActPaid.ActPaidContract,
                                    CurrentActPaid.ActPaidPortion,
                                    tblCostsELEMENT_NO.AsString,
                                    E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
End;
{ Delete the cost center for the element AnElement from the default
  cost centers table (SAF3A6) }
Procedure TdmActs.DeleteCostCenter(AnElement,AGLAccount:String);
Var
   Mns:                 String;     { Error Message }
Begin
     With SQLDelCCCrr Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             FPDCCContract.AsString     := CurrentActPaid.ActPaidContract;
             FPDCCPortion.AsString      := CurrentActPaid.ActPaidPortion;
             FPDCCElement.AsString      := AnElement;
             FPDCCGLAccount.AsString    := AGLAccount;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_106,[AGLAccount,
                                    CurrentActPaid.ActPaidContract,
                                    CurrentActPaid.ActPaidPortion,
                                    AnElement,
                                    E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
End;
{ Delete from SAF3A6 the cost centers not longer used as default for
  the current contract - portion }
Procedure TdmActs.DeleteCCNoUsed;
Var
   Node:                TCCCurrent;
   CCIndex:             Integer;    { Index of the current Cost Center }
Begin
     CCIndex := 0;
     While CCIndex < CCCList.Count Do Begin
           Node := CCCList.Objects[CCIndex] As TCCCurrent;
           With Node Do Begin
                If IsOld Then Begin
                   DeleteCostCenter(ElementNo,GLAccount);
                   { Show Progress }
                   DoOnFeedBack(Self);
                End;
           End;
           Inc(CCIndex);
     End;
End;
{ This routine save the categories in the cache table (tblDetail) to
  the DataBase; but, only if the category fields are differents to the
  original values stored in FDetails }
Procedure TdmActs.SaveCategoriesToDisk;
Var
   Node:                TCategoryDef; { Category Definition for the module }
   I:                   Integer;
Begin
     tblDetail.First;
     I := 0;
     While I < FDetails.Count Do Begin
           Node := FDetails.Items[I];
           { Node and record in table must be the same couple element-category
             because table and list are parallels; therefore we check for any
             any internal error }
           If Not SameCategory(Node) Then Begin
              raise Exception.Create(ME_035);
           End;
           If AreThereChanges(Node) Then Begin
              If Not Node.CategoryInAct Then Begin
                 InsertCategory(tblDetailELEMENT_NO.Value + tblDetailELEMENT_CODE.Value,
                                tblDetailCATEGORY_NO.Value,
                                tblDetailQUANTITY.Value,
                                tblDetailUNITARIAN_VALUE.Value,
                                tblDetailVALUE.Value);End
              Else Begin
                 UpdateCategory(tblDetailELEMENT_NO.Value,
                                tblDetailCATEGORY_NO.Value,
                                tblDetailQUANTITY.Value,
                                tblDetailVALUE.Value);
              End;
           End;
           tblDetail.Next;
           Inc(I);
           { Show Progress }
           DoOnFeedBack(Self);
     End;
End;
{ Use this routine to load the logotype required by the reports.
  The logotype must be defined in the table SAF3A2 (logotypes table)
  The code for SAQ300 module is SAAP. The routine try to load a logotype
  for the district code of the current user; if It's not successful,
  then try to load a generic logotype (District Code = '****') }
Procedure TdmActs.LoadLogotype(ADistrict:String);
Begin
     With SQLLogo Do Begin
          Try
             Active:=False;
             Params[0].AsString:='SAAP';
             Params[1].AsString:=ADistrict;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                Active:=False;
                Params[0].AsString:='SAAP';
                Params[1].AsString:='****';
                Active:=True;
                If Fields[0].IsNull Then Begin
                   raise Exception.Create(ME_026);
                End;
             End;
          Except
             On E:Exception Do Begin
               ShowMessage(Format(ME_027,[E.Message]));
             End;
          End;
     End;
End;
{ Use this routine to get the original cost centers and percents assigned to
  an element. These values are the default values for SAF3A2. We get these
  values from MSF232. The primary key for MSF232 is an special case :
  1. DSTRCT_CODE    = ' '
  2. REQ_232_TYPE   = 'C'
  3. REQUISITION_NO = Combination of AContract,APortion,AnElement :
     AContract  = 8 characteres
     APortion   = 2 characteres
     AnElement  = 2 characteres
     All of them Left justified, filled with blanks }
Procedure TdmActs.GetOriginalCostCenters(AContract,APortion,AnElement:String);
Var
   MSF232Key:           String;     { AContract,APortion,AnElement }
Begin
     With SQLCosts Do Begin
          Try
             { Construct the special key (Requisition_No) }
             MSF232Key := AContract;
             While Length(MSF232Key) < 8 Do Begin
                   MSF232Key := MSF232Key + ' ';
             End;
             MSF232Key := MSF232Key + APortion;
             While Length(MSF232Key) < 10 Do Begin
                   MSF232Key := MSF232Key + ' ';
             End;
             MSF232Key := MSF232Key + AnElement;
             While Length(MSF232Key) < 12 Do Begin
                   MSF232Key := MSF232Key + ' ';
             End;
             { Exec the query }
             Active := False;
             Params[0].AsString := MSF232Key;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
               ShowMessage(Format(ME_027,[E.Message]));
             End;
          End;
     End;
End;
{ Get in SQLCCCurrent the list of the current cost centers distribution
  for the contract AContract, portion APortion. }
Procedure TdmActs.ReadCurrentCostCentersFor(AContract,APortion:String);
Begin
     With SQLCCCurrent Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             Params[1].AsString := APortion;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
               ShowMessageFmt(ME_102,[AContract,APortion,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.GetCurrentCostCenters(AContract,APortion:String);
Var
   Node:                TCCCurrent;
Begin
     { Only load if this is the first call (list empty) }
     If CCCList.Count = 0 Then Begin
        Try
           { Read the current cost centers from SAF3A6 }
           ReadCurrentCostCentersFor(AContract,APortion);
           { Copy the cost centers in memory  }
           With SQLCCCurrent Do Begin
                While Not EoF Do Begin
                      Node := TCCCurrent.Create;
                      Node.ElementNo    := SQLCCCurrentELEMENT_NO.AsString;
                      Node.GLAccount    := TrimLeft(SQLCCCurrentGL_ACCOUNT.AsString);
                      Node.DocumentType := SQLCCCurrentDOCUMENT_TYPE.AsString;
                      Node.DocumentNo   := SQLCCCurrentDOCUMENT_NO.AsString;
                      Node.EquipNo      := SQLCCCurrentEQUIP_NO.AsString;
                      Node.Percent      := SQLCCCurrentPERCENT.AsString;
                      CCCList.AddObject(Node.Key,Node);
                      Next;
                End;
           End;
        Finally
           SQLCCCurrent.Active := False;
        End;
     End;
End;
Procedure TdmActs.SetCostCentersRangeForDisplay(AContract,AnAct,AnElement:String);
Begin
     With tblCosts Do Begin
          Try
             BeforePost := Nil;
             SetRangeStart;
             tblCostsCONTRACT_NO.Value := AContract;
             tblCostsACT_PAID_NO.Value := AnAct;
             tblCostsELEMENT_NO.Value  := AnElement;
             tblCostsGL_ACCOUNT.Value  := ' ';
             SetRangeEnd;
             tblCostsCONTRACT_NO.Value := AContract;
             tblCostsACT_PAID_NO.Value := AnAct;
             tblCostsELEMENT_NO.Value  := AnElement;
             tblCostsGL_ACCOUNT.Value  := 'z';
             ApplyRange;
          Finally
             BeforePost := tblCostsBeforePost;
          End;
     End;
End;
Procedure TdmActs.SetCostCentersRangeForDisplayJuvinao(AContract,AnAct,AnElement:String);
Begin
     With tblCosts Do Begin
          Try
             BeforePost := Nil;
             SetRangeStart;
             tblCostsCONTRACT_NO.Value := AContract;
             tblCostsACT_PAID_NO.Value := AnAct;
             tblCostsELEMENT_NO.Value  := AnElement;
             tblCostsGL_ACCOUNT.Value  := ' ';
             SetRangeEnd;
             tblCostsCONTRACT_NO.Value := AContract;
             tblCostsACT_PAID_NO.Value := AnAct;
             tblCostsELEMENT_NO.Value  := AnElement;
             tblCostsGL_ACCOUNT.Value  := 'z';
             ApplyRange;
          Finally
             {BeforePost := tblCostsBeforePostJuvinao; }
             tblCostsBeforePostJuvinao;
          End;
     End;

End;
Procedure TdmActs.SetCostCentersRangeForDisplay2(AContract,AnAct,AnElement:String);
Begin
     With tblCosts Do Begin
          Try
             BeforePost := Nil;
             SetRangeStart;
             tblCostsCONTRACT_NO.Value := AContract;
             tblCostsACT_PAID_NO.Value := AnAct;
             tblCostsELEMENT_NO.Value  := AnElement;
             tblCostsGL_ACCOUNT.Value  := ' ';
             SetRangeEnd;
             tblCostsCONTRACT_NO.Value := AContract;
             tblCostsACT_PAID_NO.Value := AnAct;
             tblCostsELEMENT_NO.Value  := AnElement;
             tblCostsGL_ACCOUNT.Value  := 'z';
             ApplyRange;
          Finally
             BeforePost := tblCostsBeforePost2;
          End;
     End;
End;

Procedure TdmActs.SetCostCentersRangeForSave(AContract,AnAct:String);
Begin
     With tblCosts Do Begin
          SetRangeStart;
          tblCostsCONTRACT_NO.Value := AContract;
          tblCostsACT_PAID_NO.Value := AnAct;
          tblCostsELEMENT_NO.Value  := ' ';
          tblCostsGL_ACCOUNT.Value  := ' ';
          SetRangeEnd;
          tblCostsCONTRACT_NO.Value := AContract;
          tblCostsACT_PAID_NO.Value := AnAct;
          tblCostsELEMENT_NO.Value  := 'z';
          tblCostsGL_ACCOUNT.Value  := 'z';
          ApplyRange;
     End;
End;
{ Use this routine to assign default values to the Cost Center distribution
  for the Act Paid by taking the distribution values from the distribution
  defined in the Contract. This routine is required when the method to get
  the default cost center distribution is ccddContract }
Procedure TdmActs.CopyCostCentersFromContractToActs;
Var
   PercentAsInteger:    Integer;
Begin
     With SQLCosts Do Begin
          While Not EoF Do Begin
                tblCosts.Append;
                tblCostsGL_ACCOUNT.Value    := SQLCostsGL_ACCOUNT.Value;
                tblCostsDOCUMENT_TYPE.Value := IntToStr(Ord(tdNone));
                If IsEmptyField(SQLCostsWORK_ORDER) Then Begin
                   If Not IsEmptyField(SQLCostsPROJECT_NO) Then Begin
                      tblCostsDOCUMENT_TYPE.Value := IntToStr(Ord(tdProject));
                      tblCostsDOCUMENT_NO.Value   := SQLCostsPROJECT_NO.Value;
                   End;End
                Else Begin
                   tblCostsDOCUMENT_TYPE.Value := IntToStr(Ord(tdWorkOrder));
                   tblCostsDOCUMENT_NO.Value   := SQLCostsWORK_ORDER.Value;
                End;
                {De Moya 2005-11-15 IC721 Valido que el QLCostsEQUIP_NO.Value
                 no sea nulo}
                if SQLCostsEQUIP_NO.Value <> '' then
                  tblCostsEQUIP_NO.Value := SQLCostsEQUIP_NO.Value
                else
                  tblCostsEQUIP_NO.Value := ' ';
                PercentAsInteger       := Round(100*SQLCostsALLOC_PC.AsFloat);
                tblCostsPERCENT.Value  := Format('%5.5d',[PercentAsInteger]);
                tblCosts.Post;
                Next;
          End;
     End;
End;
{ Use this routine to assign default values to the Cost Center distribution
  for the Act Paid by taking the distribution values from the current
  distribution for the Contract. The current distribution is mainteined by
  the user by saving in the table SAF3A6 the distribution of an Act.
  This routine is required when the method to get the default cost center
  distribution is ccddCurrent }
Procedure TdmActs.CopyCostCentersFromCurrentToActs;
Var
   PercentAsInteger:    Integer;
   CCIndex:             Integer;
   Node:                TCCCurrent;
Begin
     CCIndex := 0;
     While CCIndex < CCCList.Count Do Begin
           Node := CCCList.Objects[CCIndex] As TCCCurrent;
           If Node.ElementNo = CurrentActPaid.ActPaidElement Then Begin
              tblCosts.Append;
              tblCostsGL_ACCOUNT.Value    := Node.GLAccount;
              tblCostsDOCUMENT_TYPE.Value := Node.DocumentType;
              tblCostsDOCUMENT_NO.Value   := Node.DocumentNo;
              tblCostsEQUIP_NO.Value      := Node.EquipNo;
              tblCostsPERCENT.Value       := Node.Percent;
              tblCosts.Post;
           End;
           Inc(CCIndex);
     End;
End;
{ Assign to the current element its default Cost Center distribution
  taking it from the original distribution in the contract }
Procedure TdmActs.DefaultCostCenterFromContract;
Begin
     With CurrentActPaid Do Begin
          GetOriginalCostCenters(ActPaidContract,ActPaidPortion,ActPaidElement);
     End;
     CopyCostCentersFromContractToActs;
End;
{ Assign to the current element its default Cost Center distribution
  taking it from the historic distribution of Cost Centers in the Act Paids
  of its contract (table SAF3A6) }
Procedure TdmActs.DefaultCostCenterFromCurrent;
Begin
     With CurrentActPaid Do Begin
          If CCCList.ExistsElement[ActPaidElement] Then Begin
             CopyCostCentersFromCurrentToActs; End
          Else Begin
             { If the current historic distribution doesn't still have Cost
               Centers for the Element, then we get the default from the
               original distribution in the contract }
             DefaultCostCenterFromContract;
          End;
     End;
End;
Procedure TdmActs.GetSentActsTo(AnApprover:String);
Begin
     With SQLPendents Do Begin
          Try
             Active := False;
             Params[0].AsString := AnApprover;
             Params[1].AsString := AnApprover;
             Params[2].AsString := AnApprover;
             Params[3].AsString := AnApprover;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_050,[AnApprover,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.CopyPendentsToTemporalTable;
  Procedure CopyRegister;
  Begin
       tblApproveCONTRACT_NO.AsString    := SQLPendentsCONTRACT_NO.AsString;
       tblApprovePORTION_NO.AsString     := SQLPendentsPORTION_NO.AsString;
       tblApproveACT_PAID_NO.AsString    := SQLPendentsACT_PAID_NO.AsString;
       tblApproveACT_PAID_DATE.AsString  := SQLPendentsACT_PAID_DATE.AsString;
       tblApproveSUPPLIER_NO.AsString    := SQLPendentsSUPPLIER_NO.AsString;
       tblApproveCONTRACT_VAL.AsCurrency := SQLPendentsCONTRACT_VAL.AsCurrency;
       tblApproveSTATUS.AsString         := StrStatusOf(asSent);
       tblApproveCURRENCY.AsString       := SQLPendentsCURRENCY_TYPE.AsString;
       tblApproveSUPPLIER_NAME.AsString  := GetSupplierName(SQLPendentsSUPPLIER_NO.AsString);
       tblApproveVALUE.AsCurrency        := GetActPaidValue(SQLPendentsCONTRACT_NO.AsString,
                                                            SQLPendentsACT_PAID_NO.AsString);
       tblApproveBUDGET_VALUE.AsCurrency := GetActPaidBudgetValue(SQLPendentsCONTRACT_NO.AsString,
                                                            SQLPendentsACT_PAID_NO.AsString);
  End;
Begin
     With SQLPendents Do Begin
          Try
             Try
                While Not EoF Do Begin
                      tblApprove.Append;
                      CopyRegister;
                      tblApprove.Post;
                      Next;
                End;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_052,[E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to change the Act Paid Status to asApproved. The routine
  verify the new executed values don't exceed the authorised top according
  to the setting for the validation method in the user configuration }
Procedure TdmActs.ApproveActPaid;
Var
   PrvCntExeValue:      Currency;   { Contract Value executed before to approve }
   PrvPrtExeValue:      Currency;   { Portion Value executed before to approve }
   NewCntExeValue:      Currency;   { Contract Value executed after to approve }
   NewPrtExeValue:      Currency;   { Portion Value executed after to approve }
   MaxValue:            Currency;   { Top Budget Value according to the validation method }
   MaxSgnValue:         Currency;   { Top Signed Value according to the validation method }
   PrvCntExeValLoaded:  Boolean;    { True = PrvCntExeValue loaded }
   PrvPrtExeValLoaded:  Boolean;    { True = PrvPrtExeValue loaded }
   APContract:          String;     { CONTRACT_NO for the current Act Paid }
   APPortion:           String;     { PORTION_NO for the current Act Paid }
   APCode:              String;     { Code of the current Act Paid }
Begin
     PrvCntExeValLoaded := False;
     PrvPrtExeValLoaded := False;
     APContract := tblApproveCONTRACT_NO.AsString;
     APPortion  := tblApprovePORTION_NO.AsString;
     APCode     := tblApproveACT_PAID_NO.AsString;
     { Verify supplier status (It must be active) }
     ValidateSupplierStatus(tblApproveSUPPLIER_NO.AsString);
     { check by Acts without values. Although, the VALUE must be >=  0, we
       check using Abs function to avoid precision errors }
     If Abs(tblApproveVALUE.AsCurrency)<0.01 Then Begin
        raise Exception.CreateFmt(ME_074,[APCode,APContract]);
     End;
     { Case : Validation By Contract }
     If UserConfig.ActValidation = avElement Then Begin
        GetActElementsFor(APContract,APPortion);
        LoadElementsTopValues;
        ValidateByElement(APContract,APPortion,APCode);
     End;
     { Case : Validation By Portion }
     If UserConfig.ActValidation = avPortion Then Begin
        PrvPrtExeValue := GetPaidsToPortion(APContract,APPortion);
        Try
           GetPortionDefinition(APContract,APPortion);
           MaxValue    := SQLPortionPORTION_VAL.AsCurrency;
           MaxSgnValue := SQLPortionLIQ_DAM_LIMIT.AsCurrency;
        Finally
           SQLPortion.Active := False;
        End;
        NewPrtExeValue := PrvPrtExeValue + tblApproveBUDGET_VALUE.AsCurrency;
        If NewPrtExeValue > MaxValue Then Begin
           raise Exception.CreateFmt(ME_037,[NewPrtExeValue,MI_017,MaxValue]);
        End;
        PrvPrtExeValLoaded := True;
     End;
     { Case : Validation By Signed Portion }
     If UserConfig.TypeCntLimit = tclPortion Then Begin
        If UserConfig.ActValidation <> avPortion Then Begin
           PrvPrtExeValue := GetPaidsToPortion(APContract,APPortion);
           Try
              GetPortionDefinition(APContract,APPortion);
              MaxSgnValue := SQLPortionLIQ_DAM_LIMIT.AsCurrency;
           Finally
              SQLPortion.Active := False;
           End;
           NewPrtExeValue := PrvPrtExeValue + tblApproveBUDGET_VALUE.AsCurrency;
        End;
        If NewPrtExeValue > MaxSgnValue Then Begin
           raise Exception.CreateFmt(ME_037,[NewPrtExeValue,MI_018,MaxSgnValue]);
        End;
        PrvPrtExeValLoaded := True;
     End;
     { Case : Validation By Contract }
     If UserConfig.ActValidation = avContract Then Begin
        PrvCntExeValue := GetPaidsToContract(APContract);
        NewCntExeValue := PrvCntExeValue + tblApproveBUDGET_VALUE.AsCurrency;
        MaxValue       := tblApproveCONTRACT_VAL.AsCurrency;
        If MaxValue < NewCntExeValue Then Begin
           raise Exception.CreateFmt(ME_093,[NewCntExeValue,MI_017,MaxValue]);
        End;
        PrvCntExeValLoaded := True;
     End;
     { Case : Validation By Signed Contract }
     If UserConfig.TypeCntLimit = tclContract Then Begin
        If UserConfig.ActValidation <> avContract Then Begin
           PrvCntExeValue := GetPaidsToContract(APContract);
           NewCntExeValue := PrvCntExeValue + tblApproveBUDGET_VALUE.AsCurrency;
        End;
        MaxValue := tblApproveCONTRACT_VAL.AsCurrency;
        If MaxValue < NewCntExeValue Then Begin
           raise Exception.CreateFmt(ME_093,[NewCntExeValue,MI_018,MaxValue]);
        End;
        PrvCntExeValLoaded := True;
     End;
     { If the previous values for the contract are not still loaded, then load
       them. We use flags, in spite of is more clear to load them previously
       because performance (if there is an error, using this technique we can
       avoid unneccesaries SQL commands ) }
     If Not PrvCntExeValLoaded Then Begin
        PrvCntExeValue := GetPaidsToContract(APContract);
     End;
     If Not PrvPrtExeValLoaded Then Begin
        PrvPrtExeValue := GetPaidsToPortion(APContract,APPortion);
     End;
     SetActPaidApproved(APContract,APCode,PrvCntExeValue,PrvPrtExeValue);
End;
Procedure TdmActs.UpdateActsStatusToSent;
Begin
     SetActPaidStatus(tblApproveCONTRACT_NO.AsString,
                      tblApproveACT_PAID_NO.AsString,
                      tblApproveSTATUS.AsString,
                      IntToStr(Ord(asSent)));
End;
Procedure TdmActs.UpdateActsStatusToApproved;
Var
   MsgNoSave:           String;
Begin
     { Try to Approve. On Error, identify the Act and raise the exception again }
     Try
        ApproveActPaid;
     Except
        On E:Exception Do Begin
           MsgNoSave := Format(ME_125,[tblApproveACT_PAID_NO.AsString,
                                       tblApproveCONTRACT_NO.AsString,
                                       E.Message]);
           raise Exception.Create(MsgNoSave);
        End;
     End;
End;
Procedure TdmActs.UpdateActsStatus;
Var
   NewStatus:           Byte;
   MsgNoSave:           String;
Begin
     With tblApprove Do Begin
          First;
          While Not EoF Do Begin
                NewStatus := Ord(tblApproveSTATUS.AsInteger);
                Case TActStatus(NewStatus) Of
                asPendent  : UpdateActsStatusToSent;
                asApproved : UpdateActsStatusToApproved;
                End;
                Next;
          End;
     End;
End;
{ Use this routine to get the current Start Date and Final Date for the
  current contract in the format 8. The routine ONLY work well after to call
  GetContractDefinition. }
Procedure TdmActs.GetContractRange(Var StartDateStr,FinalDateStr:String);
Begin
     If IsValidDateField(SQLContractAMEND_START_DT) Then Begin
        StartDateStr := SQLContractAMEND_START_DT.AsString; End
     Else Begin
        If IsValidDateField(SQLContractORIG_START_DT) Then Begin
           StartDateStr := SQLContractORIG_START_DT.AsString;End
        Else Begin
           StartDateStr := SQLContractCNTRCT_BASE_DT.AsString;
        End;
     End;
     If IsValidDateField(SQLContractFINAL_COMPL_DT) Then Begin
        FinalDateStr := SQLContractFINAL_COMPL_DT.AsString; End
     Else Begin
        If IsValidDateField(SQLContractAMEND_COMPL_DT) Then Begin
           FinalDateStr := SQLContractAMEND_COMPL_DT.AsString; End
        Else Begin
           FinalDateStr := SQLContractORIG_COMPL_DT.AsString;
        End;
     End;
End;
{ Use this routine to get the current Start Date and Final Date for the
  current portion in the format 8. The routine ONLY work well after to call
  GetPortionDefinition. }
Procedure TdmActs.GetPortionRange(Var StartDateStr,FinalDateStr:String);
Begin
     If IsValidDateField(SQLPortionAMEND_START_DT) Then Begin
        StartDateStr := SQLPortionAMEND_START_DT.AsString; End
     Else Begin
        StartDateStr := SQLPortionORIG_START_DT.AsString;
     End;

     If IsValidDateField(SQLPortionAMEND_COMPL_DT) Then Begin
           FinalDateStr := SQLPortionAMEND_COMPL_DT.AsString; End
     Else Begin
           FinalDateStr := SQLPortionORIG_COMPL_DT.AsString;
     End;

End;
Function TdmActs.FindCategoryWithText(AText:String):Boolean;
Var
   TextFound:           Boolean;
Begin
     TextFound := False;
     While Not (TextFound Or tblDetail.Eof) Do Begin
           TextFound := Pos(AText,tblDetailCATEGORY_DESC.AsString) > 0;
           If Not TextFound Then Begin
              tblDetail.Next;
           End;
     End;
     FindCategoryWithText := TextFound;
End;
Procedure TdmActs.ValidateSupplierStatus(ASupplierId:String);
Begin
     With SQLValSppAct Do Begin
          Try
             Active := False;
             Params[0].AsString := ASupplierId;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active := True;
                if IsEmpty or IsEmptyField(Fields[0]) then Begin
                   raise  Exception.Create(ME_003);
                end;
                If Fields[0].AsString <> '3' Then Begin
                   raise  Exception.Create(ME_205);
                End;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_204,[ASupplierId,E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to get all the contracts assigned to the user }
Procedure TdmActs.GetUserContracts;
Begin
     With SQLContracts Do Begin
          Try
             Active:=False;
             Params[0].AsString := CurrentUser;
             Params[1].AsString := CurrentUser;
             Params[2].AsString := CurrentUser;
             Params[3].AsString := CurrentUser;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_081,[E.Message]);
             End;
          End;
     End;
End;
{dbermudez 14-02-2017 begin}
function TdmActs.IsValidCCList(ContractNo, PortionNo : String): boolean;
var
    isValid : boolean;
Begin
    isValid := true;
     With SQLCheckCCList Do Begin
          Try
             Active:=False;
             Params[0].AsString := ContractNo;
             Params[1].AsString := PortionNo;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             while (not EOF) do begin
                if (FieldByName('total').AsString <> '10000') then begin
                    isValid := false;
                end;
                Next;
             end;

             Result := isValid;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_081,[E.Message]);
             End;
          End;
     End;
End;
{dbermudez 14-02-2017 end}
Procedure TdmActs.ExecQueryForRep01;
Begin
     With SQLRep01 Do Begin
          Try
             Active:=False;
             Params[0].AsString := CurrentSupplier;
             Params[1].AsString := CurrentUser;
             Params[2].AsString := CurrentUser;
             Params[3].AsString := CurrentUser;
             Params[4].AsString := CurrentUser;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_023,['01',E.Message]);
             End;
          End;
     End;
End;
Procedure  TdmActs.ExecQueryForRep02(ACondition:String);
Begin
     With SQLRep02,SQL Do Begin
          Try
             Active:=False;
             Clear;
             Add(SQLRep0201);
             Add(SQLRep0202);
             Add(SQLRep0203);
             Add(SQLRep0204);
             Add(Format(SQLRep0205,[ACondition]));
             Add(SQLRep0206);
             Add(SQLRep0207);
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_023,['02',E.Message]);
             End;
          End;
     End;
End;
Procedure  TdmActs.ExecQueryForRep03;
Begin
     With SQLRep03 Do Begin
          Try
             Active:=False;
             Params[0].AsString:=CurrentUser;
             Params[1].AsString:=CurrentUser;
             Params[2].AsString:=CurrentUser;
             Params[3].AsString:=CurrentUser;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_023,['03',E.Message]);
             End;
          End;
     End;
End;
Procedure  TdmActs.ExecQueryForRep04(ACondition:String);
Begin
     With SQLRep04,SQL Do Begin
          Try
             Active:=False;
             Clear;
             Add(SQLRep0401);
             Add(SQLRep0402);
             Add(SQLRep0403);
             Add(Format(SQLRep0404,[ACondition]));
             Add(SQLRep0405);
             Active:=True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_023,['04',E.Message]);
             End;
          End;
     End;
End;
procedure TdmActs.LoadRegistryInformation;
Var FMIMSRegistry : TMIMSRegistry;
  Procedure SetHelpFiles;
  Begin
       //FMIMSRegistry        := TMIMSRegistry.Create;
       FMIMSHelpFile        := ExtractFilePath(Application.ExeName) + 'msyhmims.hlp';// FMIMSRegistry.HelpDirectory;
       FMIMSAppHelpFile     := ExtractFilePath(Application.ExeName) + 'msyhapps.hlp';//FMIMSRegistry.HelpDirectory+'\msyhapps.hlp';
       Application.HelpFile := ExtractFilePath(Application.ExeName) + 'SAQ301.hlp';  //FMIMSRegistry.HelpDirectory+'\SAQ301.hlp';
  End;
begin
     Try
        Try
           SetHelpFiles;
        Except
           On E:Exception Do Begin
              ShowMessage(Format(ME_070,[E.Message]));
           End;
        End;
     Finally
        //FMIMSRegistry.Free;
     End;
End;
{ Use this routine to redefine SQLPendents when the rights on the acts
  must be checked by Portion. Really, only change a reference to MSF384
  by a reference to MSF385; but, It's necessary to assign all the SQL
  command again }
Procedure TdmActs.RedefineSQLPendents;
Begin
     With SQLPendents.SQL Do Begin
          Clear;
          Add(SQL_Pendents01);
          Add(SQL_Pendents02);
          Add(SQL_Pendents03);
          Add(SQL_Pendents04);
          Add(SQL_Pendents05);
          Add(SQL_Pendents06);
          Add(SQL_Pendents07);
          Add(SQL_Pendents08);
          Add(SQL_Pendents09);
          Add(SQL_Pendents10);
          Add(SQL_Pendents11);
          Add(SQL_Pendents12);
     End;
End;
{ This routine is used to initializate the global variables, tables and
  data structures used by the Act Paid module }
Procedure TdmActs.InitActStructures;
Begin
     LoadRegistryInformation;
     FCurrentLoadStep := 4;
     FLocalCurrency   := GetLocalCurrency(FCurrentDistrict);
     FMaxToApprove    := GetAuthorisedLimitToApprove;
     FCurrentLoadStep := 5;
     FEnabledInsert   := True;
     FUserConfig      := TUserConfig.Create;
     LoadUserConfiguration;
     If UserConfig.APRight = aprPortion Then Begin
        RedefineSQLPendents;
     End;
     FCurrentLoadStep := 6;
     FCurrentCompany  := GetCompanyName;
     FCurrentLoadStep := 7;
     { Set the user identification properties }
     {De Moya 2006-03-02}
     FCurrentUserID   := GetMIMSKey2(FCurrentUserID,10);
     FCurrentUser     := GetUserEmployeeID(FCurrentUserID);

     FCurrentUser := FCurrentUser + StringOfChar(' ', 10 - Length(FCurrentUser));
     FCurrentUserID := FCurrentUser;

     FCurrentLoadStep := 8;
     { Init tables cache }
     tblCosts.Active := True;
     CreatetblDetailDefinition;
     InitTemporalTable(tblDetail);
     InitTemporalTable(tblInfoAtax);
     InitTemporalTable(tblSearch);
     InitTemporalTable(tblApprove);
     FCurrentLoadStep := 9;
     { Load Logotype for printed documents }
     LoadLogotype(FCurrentDistrict);
     FCurrentLoadStep := 10;
     { Init auxiliary list }
     FElements             := TElementList.Create;
     FEleXPercent          := TEleXPercent.Create;
     FOldEleXPrc           := TEleXPercent.Create;
     FElementActs          := TElementActs.Create(FElements);
     FElementValues        := TElementVals.Create;
     FElementNoDefs        := TElementNoDefs.Create;
     FCrrEleNoDef          := TElementNoDefs.Create;
     FEleNoEleCodes        := TEleNoEleCodes.Create;
     FCCCList              := TCCCList.Create;
     FCCClipboard          := TCCCBList.Create;
     FCurrencyList         := TStringList.Create;
     FCurrencyList.Sorted  := True;
     FSuppliers            := TStringList.Create;
     FSuppliers.Sorted     := True;
     FCategoryNames        := TCstmCtgNms.Create;
     FCategoryNames.Sorted := True;
     FDetails              := TCategoryList.Create;
     FCurrentActPaid       := TActPaidDef.Create;
     FCurrentLoadStep      := 11;
     { Get TParam object of queries with too many parameters and often used }
     GetParamObjectsForSQLInsEleCat;
     GetParamObjectsForSQLUpdEleCat;
     GetParamObjectsForSQLInsCCCrr;
     GetParamObjectsForSQLUpdCCCrr;
     GetParamObjectsForSQLDelCCCrr;
     GetParamObjectsForSQLSetApproved;
     FCurrentLoadStep := 12;
     { Create the list of avalaibles currencies }
     CreateCurrencyList;
     FCurrentLoadStep := 13;
End;

Function TdmActs.ConnectToDBMIMS: boolean;
Var
   MIMSXServer:         TMIMSXServer;
begin
     frmSAQ300003Connecting := Nil;
     FCurrentLoadStep       := 0;
     Try
        { First, connect to MIMS. Close the connection as soon as it's not
          longer necessary }
        //Try
           MIMSXServer := TMIMSXServer.Create;
           MIMSXServer.Connect;

           FCurrentLoadStep := 1;
           ShowConnectionActivity(Self);
           FCurrentUserID    := MIMSXServer.MimsUser;
           FMimsPosition     := MIMSXServer.MimsPosition;
           FCurrentDistrict  := MIMSXServer.MimsDistrict;
           FCurrentPassword  := MIMSXServer.MimsPassword;
           FCurrentHost      := MIMSXServer.Host;
           FCurrentEnv       := MIMSXServer.Enviroment;
           SsnActPaid.Active := True;
           dbActPaid.Params.Values['USER NAME'] := MIMSXServer.OracleUser;
           dbActPaid.Params.Values['PASSWORD']  := MIMSXServer.OraclePassword;
           //dbActPaid.Params.Values['USER NAME'] := 'sigcon';
           //dbActPaid.Params.Values['PASSWORD']  := 'ventyx';
        //Except
        //   On E: Exception do begin
        //       Application.Terminate;
        //   end;
        //Finally
         //  MIMSXServer.Free;
        //End;
        FCurrentLoadStep := 2;
        { Second, connect to the MIMS database }
        If Not dbActPaid.IsSQLBased Then Begin
           dbActPaid.TransIsolation := tiDirtyRead;
        End;
        dbActPaid.Connected := True;

        //FUserRights := TUserRights(Ord(StrToInt(MIMSXServer.LevelAccess)));
        {FUserRights := TUserRights(Ord(StrToInt(GetLevelAccess(MIMSXServer.MimsPosition))));  }
        FUserRights := TUserRights(Ord(StrToInt(GetLevelAccessReal(MIMSXServer.MimsPosition))));
        {If Not (FUserRights in [urReview,urFullAccess]) Then Begin
          raise Exception.Create(ME_138);
        End;}
        FUserRights := urFullAccess;
        FCurrentLoadStep    := 3;
        { Now, init the data structures for the Act Paid module }
        InitActStructures;
        { Finally, close the form used to show the connection activity }
        EndOfConnectionActivity;
        ConnectToDBMIMS := true;
     Except
        On E:Exception Do Begin
           Try
              ShowMessageFmt(ME_028,[FCurrentLoadStep,E.Message]);
           Finally
              Application.Terminate;
           End;
           ConnectToDBMIMS := false;
        End;
     End;
end;
procedure TdmActs.DeleteTemporalTables;
Begin
     DeleteTemporalTable(tblDetail);
     DeleteTemporalTable(tblSearch);
     DeleteTemporalTable(tblApprove);
End;
procedure TdmActs.dmActsDestroy(Sender: TObject);
begin
   {  CloseFile(ArcLog);  }
     FElementActs.Free;
     FEleXPercent.Free;
     FOldEleXPrc.Free;
     FElements.Free;
     FElementNoDefs.Free;
     FCrrEleNoDef.Free;
     FEleNoEleCodes.Free;
     FCurrentActPaid.Free;
     FSuppliers.Free;
     FCategoryNames.Free;
     FCCCList.Free;
     FCCClipboard.Free;
     FCurrencyList.Free;
     { Before to free FDetails, it's necessary to free its Items }
     If Assigned(FDetails) Then Begin
        FDetails.FreeItems;
     End;
     FDetails.Free;
     FUserConfig.Free;
end;

{ Calculate the category value for the current record in the auxiliar
  Paradox table. }
procedure TdmActs.tblDetailCalcFields(DataSet: TDataSet);
Var
   IsByPercent:         Boolean;
   TheElementNo:        String;
   TheElementCode:      String;
begin
     IsByPercent := CrrEleNoDef.IsPercent[tblDetailELEMENT_NO.AsString + tblDetailELEMENT_CODE.AsString];
     If tblDetailBY_GLOBAL.AsBoolean Or IsByPercent Then Begin
        tblDetailVALUE.Value := tblDetailGLOBAL_VALUE.Value;End
     Else Begin
        If tblDetailQUANTITY.IsNull Then Begin
           tblDetailVALUE.Value := 0;End
        Else Begin
        {De Moya: 2002-08-12.  Program is using the input given by user, but
        it has more decimal digits that DB definition, making that the
        DetailValue is not equal to multiply two values (quantity by unitarian
        value) after values are saved.
        To avoid this, a roundto function is added}
           tblDetailVALUE.Value := Roundto(tblDetailQUANTITY.Value,-4)*
                                   tblDetailUNITARIAN_VALUE.Value;
        End;
     End;

     TheElementNo := tblDetailELEMENT_NO.AsString;
     TheElementCode := tblDetailELEMENT_CODE.AsString;

     If Not FElementNoDefs.PreserveSign[TheElementNo + TheElementCode] Then Begin
        If FElementNoDefs.IsCost[TheElementNo + TheElementCode] Then Begin
           { The Cost element are ever positives }
           tblDetailVALUE.Value := Abs(tblDetailVALUE.Value);
        End;
        If FElementNoDefs.IsDiscount[TheElementNo + TheElementCode] Then Begin
           { The Cost element are ever negatives }
           tblDetailVALUE.Value := -Abs(tblDetailVALUE.Value);
        End;
     End;
end;

procedure TdmActs.tblDetailQUANTITYValidate(Sender: TField);
begin
     If tblDetailBY_GLOBAL.AsBoolean Then Begin
        If tblDetailQUANTITY.AsString<>'' Then Begin
           raise Exception.CreateFmt(ME_041,[tblDetailCATEGORY_DESC.AsString]);
        End;
     End;
end;

procedure TdmActs.tblDetailGLOBAL_VALUEValidate(Sender: TField);
begin
     If Not tblDetailBY_GLOBAL.AsBoolean Then Begin
        If tblDetailGLOBAL_VALUE.AsString<>'' Then Begin
           {dbermudez}
           If Not CrrEleNoDef.IsPercent[tblDetailELEMENT_NO.AsString + tblDetailELEMENT_CODE.AsString] Then Begin
           //If Not( CrrEleNoDef.IsPercent[Trim(tblDetailELEMENT_NO.AsString)] Or
           //        CrrEleNoDef.IsPercent[Trim(tblDetailELEMENT_CODE.AsString)] ) Then Begin
              raise Exception.CreateFmt(ME_042,[tblDetailCATEGORY_DESC.AsString]);
           End;
        End;
     End;
end;

procedure TdmActs.tblSearchSTATUSGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
Var
   Status:              TActStatus; { Act Status }
begin
     Try
        Status := TActStatus(Ord(Sender.AsInteger));
        Text   := StatusNames[Status];
     Except
        On Exception Do Text := '';
     End;
end;

procedure TdmActs.tblCostsDOCUMENT_TYPEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
     Try
        Text := DocumentNames[TDocument(Ord(Sender.AsInteger))];
     Except
        On Exception Do Text := DocumentNames[tdNone];
     End;
end;

procedure TdmActs.tblCostsPERCENTGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
Var
   IntegerDigits:       Integer;
   DecimalDigits:       Integer;
begin
     Try
        IntegerDigits := Sender.AsInteger Div 100;
        DecimalDigits := Sender.AsInteger Mod 100;
        Text := IntToStr(IntegerDigits) + '.' + Format('%2.2d',[DecimalDigits]);
        If DisplayText Then Begin
           Text := Text + '%';
        End;
     Except
        On Exception Do Text := '0.00%';
     End;
end;

procedure TdmActs.tblCostsPERCENTSetText(Sender: TField;
  const Text: String);
Var
   Percent:             Double;   { Percent in real format }
   NewValue:            String;   { Percent in internal string format }
   IsValidPercent:      Integer;  { 0 = Valid Percent }
   LastPosition:        Integer;  { Position of the last character }
begin
     NewValue := Text;
     LastPosition := Length(Text);
     If LastPosition > 0 Then Begin
        If Text[LastPosition]= '%' Then Begin
           NewValue := Copy(Text,1,LastPosition-1);
        End;
     End;
     Val(Text,Percent,IsValidPercent);
     If IsValidPercent <> 0 Then Begin
        raise Exception.CreateFmt(ME_044,[Text]);
     End;
     NewValue := Format('%5.5d',[Round(100*Percent)]);
     If ('00000'<=NewValue) And (NewValue<='10000') Then Begin
        Sender.AsString := NewValue; End
     Else Begin
        raise Exception.CreateFmt(ME_045,[Text]);
     End;
end;
{ Use this method to get the current value of all the elements in
  the act differents to elements calculated by percent. These values
  will be used to calculate the values for the elements "calculated
  by percent" . IMPORTANT : Before to use this routine set the tblDetail
  range to include all the records in the the table }
Procedure TdmActs.GetEditValueOfTheElements;
Var
   CurrentElement:      TElementVal;
   TheElementNo:        String;
   NewElementNo:        String;
Begin
     ElementValues.ClearTotalElementValues;
     TheElementNo := '';
     With tblDetail Do Begin
          First;
          While Not EoF Do Begin
                { We ever need the container object for the definition of the
                  current Element No for the Detail line (tblDetailELEMENT_NO) ;
                  but, because performance, as the list is usually sorted,
                  we use TheElementNo as a "cache id" for CurrentElement;
                  therefore, we calculate a new CurrentElement only when we
                  really have a new Element No }
                NewElementNo := tblDetailELEMENT_NO.AsString;
                If TheElementNo <> NewElementNo Then Begin
                   TheElementNo   := NewElementNo;
                   CurrentElement := ElementValues.ElementDef[NewElementNo];
                End;
                If Not Assigned(CurrentElement) Then Begin
                   raise Exception.CreateFmt(ME_157,[NewElementNo]);
                End;
                { The sum doesn't make sense if the element is "calculated by
                  percent"; but, it's more expensive to verify if the element
                  has this attribute }
                With CurrentElement Do Begin
                     ElementEdtAct := ElementEdtAct + tblDetailVALUE.AsCurrency;
                End;
                Next;
          End;
     End;
End;

Function TdmActs.GetEditValueOfTheElementsJuvinao(ElementNo:String):Boolean;
Var
   CurrentElement:      TElementVal;
   TheElementNo:        String;
   NewElementNo:        String;
   swNoSalir:             boolean;
//   CCValue:             Currency;
  CCValue:             Double;
  CCValue_Currency:    Currency;
  I:                   Integer;
  value: String;

  tbl_Element:String ;
  tbl_CategNo:String;
  tbl_CategDesc:String;
  tbl_Quantity:Double;
  tbl_UnitarianValue:Double;
  tbl_ByGlobal:Boolean  ;
  tbl_ElementCode:String;
  IsByPercent:Boolean;
Begin
      ElementValues.ClearTotalElementValues;
      CCValue :=0;
      CCValue_Currency :=0;
       TheElementNo:='';

       dmActs.tblDetail.CancelRange;

      //CCValue := FDetails.ValueOfElementNo[ElementNo];

   {  I:=0;
     While I<FDetails.Count Do Begin
       //    tblDetail.Append;
           With TCategoryDef(FDetails.Items[I]) Do Begin   }

                With tblDetail  Do Begin
                   First;
                   While ((Not EoF) And (CCValue=0) And (CCValue_Currency=0)) Do Begin
                        tbl_Element:= tblDetailELEMENT_NO.Value ;

                        if (AnsiCompareStr(tbl_Element, ElementNo)=0) then  Begin
                                tbl_CategNo        := tblDetailCATEGORY_NO.Value ;
                                tbl_CategDesc      := tblDetailCATEGORY_DESC.Value;
                                tbl_ByGlobal       := tblDetailBY_GLOBAL.AsBoolean;
                                tbl_ElementCode    := tblDetailELEMENT_CODE.AsString;

                                IsByPercent        := CrrEleNoDef.IsPercent[tbl_Element + tbl_ElementCode];

                                If (tbl_ByGlobal) Or (IsByPercent) Then Begin
                                     //CCValue := CCValue +  tblDetailGLOBAL_VALUE.AsFloat;
                                     CCValue_Currency := CCValue_Currency + tblDetailGLOBAL_VALUE.AsCurrency ;
                                End
                                Else Begin

                                     If tblDetailQUANTITY.IsNull Then Begin
                                        tbl_Quantity        := 0;
                                     End
                                     Else Begin
                                         tbl_Quantity       := tblDetailQUANTITY.Value       ;
                                     End;

                                     tbl_UnitarianValue := tblDetailUNITARIAN_VALUE.Value;

                                     CCValue := CCValue + (tbl_Quantity * tbl_UnitarianValue)     ;
                                End;


                        End ;

                       Next;
                   End;   {End While}
                End;



               // CategoryValue := GettblDetailVALUE;
              // tblDetail.Post;
          // End;
      {     Inc(I);
     End; }

      if (CCValue<>0) Or (CCValue_Currency<>0) then begin
             GetEditValueOfTheElementsJuvinao := true;
      end else begin
             GetEditValueOfTheElementsJuvinao := false;
      end;


End;


Function TdmActs.GetCurrentElementValue:Currency;
Var
   Actual:              TBookmarkStr;
   Sum:                 Currency;
Begin
     Sum :=  0;
     With tblDetail Do Begin
          Try
             Actual := BookMark;
             DisableControls;
             First;
             While Not EoF Do Begin
                   If CurrentActPaid.ActPaidElement <>
                      tblDetailELEMENT_NO.AsString Then Begin
                      raise Exception.Create(ME_127);
                   End;
                   Sum := Sum + tblDetailVALUE.AsCurrency;
                   Next;
             End;
             GetCurrentElementValue := Sum;
          Finally
             BookMark := Actual;
             EnableControls;
          End;
     End;
End;
{ Use this function to get the total percent assigned to the cost centers
  of the current element in the Act. Before to call this function, the
  range for the tblCosts MUST be set to include only cost centers in the
  current element by calling SetCostCentersRangeForDisplay. The percent
  is scaled by 100 in the table. }
Function TdmActs.GetTotalPercentAssigned:Integer;
Var
   Sum:                 Integer;    { Percent already assigned 0 - 10000 }
   CostCentreArray : array[1..100] of string;
   i, max : integer;
begin
     {De Moya 2006-09-11. IC844 - Incluyo validación para detectar un centro de costos
      duplicado en el momento de la digitación.}
     {De Moya 2006-09-12. IC844 - Adicionalmente incluyo en la validacion el tipo de
     documento y el número de documento para que pueda haber el mismo centro de
     costos para diferentes proyectos.}

     for i:=1 to 100 do
     begin
       CostcentreArray[i]:='';
     end;
     Sum := 0;
     With tblCosts Do Begin
          First;
          max:=1;
          While Not EoF Do Begin
                Sum := Sum + tblCostsPERCENT.AsInteger;
                CostCentreArray[max]:=tblCostsGL_ACCOUNT.AsString + '$$' +
                                      tblCostsDOCUMENT_TYPE.AsString +
                                      tblCostsDOCUMENT_NO.AsString;
                i:=1;
                while i < max do
                begin
                  if CostCentreArray[max] = CostCentreArray[i] then
                  begin
                    raise Exception.CreateFmt(ME_220,[copy(CostCentreArray[max],1,pos('$$',CostCentreArray[max])-1)]);
                  end;
                  i:=i+1;
                end;
                max:=max+1;
                Next;
          End;
     End;
     GetTotalPercentAssigned := Sum;
End;
{ Use this function to get the total values assigned to the cost centers
  of the current element in the Act. Before to call this function, the
  range for the tblCosts MUST be set to include only cost centers in the
  current element by calling SetCostCentersRangeForDisplay.  }
Function TdmActs.GetCCValuesAssignedByElement:Currency;
Var
   Sum:                 Currency;   { Sum of values assigned to CC in the Element }
begin
     Sum := 0;
     With tblCosts Do Begin
          First;
          While Not EoF Do Begin
                Sum := Sum + tblCostsVALUE.AsCurrency;
                Next;
          End;
     End;
     GetCCValuesAssignedByElement := Sum;
End;
{ Use this routine to get the total value approved in the temporal table
  tblApprove. This value won't be really approved until the user commit
  the changes }
Function TdmActs.GetTotalApproved:Currency;
Var
   Sum:                 Currency;   { Total approved }
   CurrentPosition:     TBookmark;
begin
     Sum := 0;
     With tblApprove Do Begin
          Try
             CurrentPosition := GetBookMark;;
             DisableControls;
             First;
             While Not EoF Do Begin
                   If tblApproveSTATUS.AsString = IntToStr(Ord(asApproved)) Then Begin
                      Sum := Sum + tblApproveBUDGET_VALUE.AsCurrency;
                   End;
                   Next;
             End;
          Finally
             EnableControls;
          End;
     End;
     GetTotalApproved := Sum;
End;
{ This event is used to calculate the percent already assigned to cost centers
  of an element. The result is used to get the default value for the PERCENT
  field in the new record. A range including only one element must be set
  before any Append action by calling SetCostCentersRangeForDisplay. }
procedure TdmActs.tblCostsBeforeInsert(DataSet: TDataSet);
begin
     FDefaultPercent := Format('%5.5d',[10000 - GetTotalPercentAssigned]);
end;
procedure TdmActs.tblCostsNewRecord(DataSet: TDataSet);
begin
     tblCostsCONTRACT_NO.AsString   := CurrentActPaid.ActPaidContract;
     tblCostsACT_PAID_NO.AsString   := CurrentActPaid.ActPaidCode;
     tblCostsELEMENT_NO.AsString    := CurrentActPaid.ActPaidElement;
     tblCostsGL_ACCOUNT.AsString    := ' ';
     tblCostsDOCUMENT_TYPE.AsString := IntToStr(Ord(tdNone));
     tblCostsDOCUMENT_NO.AsString   := ' ';
     tblCostsEQUIP_NO.AsString      := ' ';
     tblCostsPERCENT.AsString       := FDefaultPercent;
     tblCostsVALUE.AsCurrency       := 0;
end;
procedure TdmActs.ValidateCostCenter;
Var
   GLAccount:           String;
   V_des              : array [1..100] of string[24];
   i, imax, pos_pr    : integer;
   supplier_sublg     : string;
   sw_des, sw_sublg   : boolean;
   Hallado:             Boolean;
   Estado:              String;
Begin
     GLAccount := '??';
     for i:=1 to 100 do
       v_des[i]:='';
     i:=1;
{De Moya - IC437 2002/11/29 - Valida que el string corresponda a:
1. Un centro de costos y elemento de gasto
2. Cuenta de GL y subledger (PR Supplier)
3. Cuenta de GL.

Agrego el query SQLElementPlus para la tabla MSF010 type +ELE}
     With SQLElementPlus do
     begin
       active := true;
       while not EOF do
       begin
         v_des[i]:=SQLElementPlus.FieldValues['ASSOC_REC'];
         i:=i+1;
         next;
       end;
       active := false;
     end;
     sw_des := true;
     imax:=i;

{Lee la msf920 para determinar si es un centro de costos.  De ser así
lo rechaza, pues debe tener un elemento de gasto asociado}
     //With SQLValGLMims Do Begin
     With SQLValCCMims Do Begin
          Try
             GLAccount := uppercase(tblCostsGL_ACCOUNT.AsString);
             GLAccount := Trim(GLAccount);
            // GLAccount := Copy(GLAccount,1,8);
             Active := False;
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := CurrentDistrict;
             Params[1].AsString := GLAccount;
             Try
                Active  := True;
                Hallado := not Fields[0].IsNull;
                Estado  := Fields[1].AsString;
                {Si no encuentra el centro de costos}
              {  If Not Hallado then begin
                   raise Exception.Create(ME_209);
                End;  }
                {Si encuentra el centro de costos y está inactivo}
                If Estado <> 'A' then begin
                   raise Exception.Create(ME_208);
                End;
                {Si encuentra el Centro de Costos lo rechaza}
               { If Hallado Then Begin
                   sw_des:=false;
                End;
                if not sw_des then begin
                   raise Exception.CreateFmt(ME_206,[GLAccount]);
                End;   }
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_207,[GLAccount, E.Message]);
             End;
          End;
     End;

{Lee la msf966 para determinar si el tipo de cuenta es:
a) '3' para una cuenta GL o cuenta GL con subleger
b) '2' para un centro de costo con elemento de gasto}
     With SQLValCCMims Do Begin
          Try
             GLAccount := uppercase(tblCostsGL_ACCOUNT.AsString);
             GLAccount := Trim(GLAccount);
             pos_pr := pos(';PR',GLAccount);
             Supplier_Sublg := '';
             sw_sublg := false;
             if pos_pr > 0 then
             begin
               Supplier_Sublg := copy(GLAccount,pos_pr+3,6);
               GLAccount := copy(GLAccount,1,pos_pr -1);
               sw_sublg := true;
             end;
             Active := False;
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := CurrentDistrict;
             Params[1].AsString := Trim(GLAccount);
             Try
                Active  := True;
                Hallado := not Fields[0].IsNull;
                Estado  := Fields[1].AsString;
                FProjEntryInd := Fields[3].AsString;
                If Hallado and (Estado = 'I') then Begin
                   If LoadingActPaid Then Begin
                      If MustShowWarning Then Begin
                         ShowMessageFmt(ME_048,[GLAccount,CurrentDistrict,ME_208]);
                         MustShowWarning := OperationOk(MC_005);
                      End; End
                   Else Begin
                      raise Exception.Create(ME_208);
                   End;
                End
                Else begin
                  If sw_sublg then
                  begin
                    If (Not Hallado) or
                       (Fields[0].AsString <> '3') Then Begin
                          sw_des:=false;
                    End
                    Else
                      ValidateSupplierStatus(Supplier_Sublg);
                  End
                  Else
                  begin
                    If (Not Hallado) or
                       ((Fields[0].AsString <> '2') and
                        (Fields[0].AsString <> '3')) Then Begin
                          sw_des:=false;
                    End
                  End;
                End;
                i:=1;
                while (i < imax) and (not sw_des) do
                begin
                  //if trim(v_des[i])=trim(Fields[0].AsString) then
                  if v_des[i] = Fields[0].AsString then
                     sw_des:=true;
                  i:=i+1;
                end;
                if not sw_des then
                begin
                  raise Exception.CreateFmt(ME_047,[GLAccount]);
                End;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_048,[GLAccount,CurrentDistrict,
                                                  E.Message]);
             End;
          End;
     End;
End;
Function TdmActs.GetLevelAccess(MimsPosition:String):String;
VAR
   GlobalPosition : String;
Begin
     With SQLLevelAccess Do Begin
          Try
             Active := False;
             Params[0].AsString := MimsPosition;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             GlobalPosition := Trim(Fields[0].AsString);
             Try
                if (GlobalPosition = 'CTRPAGOSA') Or
                   (GlobalPosition = 'CTRPAGOSN') Or
                   (GlobalPosition = 'CTRVERIFB') Or
                   (GlobalPosition = 'REVACTA') then begin
                  GetLevelAccess := '1';
                End
                Else Begin
                   GetLevelAccess := '2';
                End;
             Except
                On E:Exception do begin
                   GetLevelAccess := '2';
                End;
             End;
          Except
             On E:Exception Do Begin
                GetLevelAccess := '1';
             End;
          End;
     End;
End;

Function TdmActs.GetLevelAccessReal(MimsPosition:String):String;
VAR
   {GlobalPosition : String; }
   ProgramName : String;
   accessLevel : String;
Begin
     With SQLLevelAccessReal Do Begin

          Try
             Active := False;
             Params[0].AsString := MimsPosition;

             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             accessLevel := Trim(Fields[0].AsString);

             if accessLevel = '' Then Begin
                accessLevel := '0';
             End;

             GetLevelAccessReal :=  accessLevel;

          Except
             On E:Exception Do Begin
                {ProgramName := E.Message; }
                GetLevelAccessReal := '0';
             End;
          End;
     End;
End;
Function TdmActs.GetCostCenterForEquip(AnEquip:String):String;
Begin
     With SQLCC_Equip Do Begin
          Try
             Active := False;
             Params[0].AsString := AnEquip;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].AsString = AnEquip Then Begin
                GetCostCenterForEquip := Trim(Fields[1].AsString); End
             Else Begin
                GetCostCenterForEquip := '';
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_095,[AnEquip,E.Message]);
             End;
          End;
     End;
End;
Function TdmActs.GetCostCenterForWO(AnOrder:String):String;
Var
   GeneralAccount:      String;
Begin
     With SQLCC_WO Do Begin
          Try
             Active := False;
             Params[0].AsString := CurrentDistrict;
             Params[1].AsString := AnOrder;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[1].IsNull Then Begin
                GetCostCenterForWO := ''; End
             Else Begin
                { Because the characters 1 to 4 of Fields[0] (DSTRCT_ACCT_CODE)
                  are a district code }
                GeneralAccount := Fields[1].AsString;
                GeneralAccount := Copy(GeneralAccount,5,Length(GeneralAccount)-4);
                GetCostCenterForWO := GeneralAccount;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_096,[AnOrder,E.Message]);
             End;
          End;
     End;
End;
Function TdmActs.GetCostCenterForProject(AProject:String):String;
Var
   GeneralAccount:      String;
Begin
      while length(AProject) < 8 do
      begin
        AProject:=AProject+' ';
      end;

     With SQLCC_Project Do Begin
          Try
             Active := False;
             Params[0].AsString := CurrentDistrict;
             Params[1].AsString := AProject;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[1].IsNull Then Begin
                GetCostCenterForProject := ''; End
             Else Begin
                GetCostCenterForProject := Fields[1].AsString;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_097,[AProject,E.Message]);
             End;
          End;
     End;
End;
Function TdmActs.GetOriginalContractCode(AContract:String):String;
Begin
     With SQLCntOriCod Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active := True;
                GetOriginalContractCode := Copy(Fields[0].AsString,2,19);
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                GetOriginalContractCode := '';
                ShowMessageFmt(ME_192,[AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.ValidateEquip(AnEquip:String);
Begin
     With SQLCC_Equip Do Begin
          Try
             Active := False;
             Params[0].AsString := AnEquip;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].IsNull Then Begin
                raise Exception.CreateFmt(ME_177,['MSF600']);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_174,[AnEquip,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.ValidateWorkOrder(AnOrder:String);
Var
   GeneralAccount:      String;
Begin
     With SQLCC_WO Do Begin
          Try
             Active := False;
             Params[0].AsString := CurrentDistrict;
             Params[1].AsString := AnOrder;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].IsNull Then Begin
                raise Exception.CreateFmt(ME_177,['MSF620']);
             End;
             //dbermudez
             If (not Fields[2].IsNull) and ( Trim(Fields[2].AsString) <> '') Then Begin
                ValidateEquip(Fields[2].AsString);
             End;

          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_175,[AnOrder,E.Message]);
             End;
          End;
     End;
End;
{dbermudez 05/02/2017 - begin}
Procedure TdmActs.ValidateZeroPaidValue(ContractNo,ActPaidNo:String);
Var
   GeneralAccount:      String;
Begin
     With SQLDeleteZeroPaidValue Do Begin
          Try
             Active := False;
             Params[0].AsString := ContractNo;
             Params[1].AsString := ActPaidNo;
             If Not Prepared Then Begin
                Prepare;
             End;
             ExecSQL;
          Except
             On E:Exception Do Begin

             End;
          End;
     End;
End;
{dbermudez 05/02/2017 - end}
Procedure TdmActs.ValidateProject(AProject,AccountCode:String);
Begin
     With SQLCC_Project Do Begin
          Try
             Active := False;
             Params[0].AsString := CurrentDistrict;
             Params[1].AsString := AProject;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].IsNull Then Begin
                raise Exception.CreateFmt(ME_177,['MSF660']);
             End;
             {01-Abr-05 WVIDELA IC658}
             If Trim(Fields[1].AsString) <> Trim(AccountCode) Then Begin
                raise Exception.CreateFmt(ME_214,[AccountCode]);
             End;
             {01-Abr-05 WVIDELA IC658}

             If not (Fields[2].IsNull) and (Trim(Fields[2].AsString) <> '') Then Begin
                ValidateEquip(Fields[2].AsString);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_176,[AProject,E.Message]);
             End;
          End;
     End;
End;
{Function TdmActs.SQLGetValnNo(AContract,AActPaidNo:String) : String;
Begin
     With SQLValnNo Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             Params[1].AsString := AActPaidNo;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].IsNull Then
                SQLGetValnNo := ' '
             else
                SQLGetValnNo := Fields[0].AsString;
          Except
             On E:Exception Do Begin

             End;
          End;
     End;
End;}
Procedure TdmActs.ValidateThirdPartyInv(AThirdPartyInv:String);
Begin
     With SQLThrdPrtyInv Do Begin
          Try
             Active := False;
             Params[0].AsString := CurrentDistrict;
             Params[1].AsString := AThirdPartyInv;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].IsNull Then Begin
                raise Exception.CreateFmt(ME_177,['MSF560']);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_186,[AThirdPartyInv,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmActs.ValidateDocumentType(ADocumentType:TDocument);
Begin
     If IsElementNoThirdPartyInv(tblCostsELEMENT_NO.AsString + tblDetailELEMENT_CODE.AsString) Then Begin
        If ADocumentType <> tdThirdPartyInv Then Begin
           raise Exception.Create(ME_184);
        End; End
     Else Begin
        If ADocumentType = tdThirdPartyInv Then Begin
           raise Exception.Create(ME_185);
        End;
     End;
End;
procedure TdmActs.ValidateCCDataField(AField:TField);
Var
   HasData:             Boolean;
Const
     Epsilon = 0.00009;
Begin
     HasData := Not IsEmptyField(AField);
     { Rolando Celedón 2003/04/30. Only must validate zero (0) values if it's
       not loading default values }
     If Not FDefaultLoading Then Begin
        HasData := HasData And (Abs(AField.AsFloat) > Epsilon);
     End;
     {De Moya 2004-03-11 Elimino la excepción generada y la reemplazo por
     un borrado a posteriori de los centros de costos que van en cero tanto
     en porcentaje como valor.}
     {If Not HasData Then Begin
        raise Exception.Create(ME_201);
     End;}
End;
procedure TdmActs.tblCostsBeforePost(DataSet: TDataSet);
Var
   DocumentType:        TDocument;
   CCDefault:           String;
   MustToCheckMSF966: Boolean;
begin
     Case UserConfig.DCCTypeDstrb Of
     cctdPercent : ValidateCCDataField(tblCostsPERCENT);
     cctdValue   : ValidateCCDataField(tblCostsVALUE);
     End;
     MustToCheckMSF966 := True;

     If IsEmptyField(tblCostsGL_ACCOUNT) Then Begin
        CCDefault := '';
        MustToCheckMSF966 := False;
        If Not IsEmptyField(tblCostsEQUIP_NO) Then Begin
           { Try to get a default COST CENTER from the equipment }
           CCDefault := GetCostCenterForEquip(tblCostsEQUIP_NO.AsString);
        End;
        If CCDefault = '' Then Begin
           { If still empty, look up for a default Cost Center from WO or Project}
           DocumentType := TDocument(Ord(tblCostsDOCUMENT_TYPE.AsInteger));
           Case DocumentType Of
           tdWorkOrder : CCDefault := GetCostCenterForWO(tblCostsDOCUMENT_NO.AsString);
           tdProject   : CCDefault := GetCostCenterForProject(tblCostsDOCUMENT_NO.AsString);
           End;
        End;
        tblCostsGL_ACCOUNT.Value := Trim(CCDefault);
     End;
     ValidateCostCenter;
     {21-Feb-05 WVIDELA IC633}

     if MustToCheckMSF966 then
        if (ProjEntryInd = 'M')
        and ( (tblCostsDOCUMENT_TYPE.AsInteger <> 2) or (IsEmptyField(tblCostsDOCUMENT_NO)) ) then
            if frmSAQ301001Main.Opening = 'N' then
                raise Exception.Create('Debe ingresar un Número de Proyecto Válido')
            else
                ShowMessage('Debe ingresar un Número de Proyecto Válido');
     {21-Feb-05 WVIDELA IC633}

     If Not IsEmptyField(tblCostsEQUIP_NO) Then Begin
        ValidateEquip(tblCostsEQUIP_NO.AsString);
     End;
     DocumentType := TDocument(Ord(tblCostsDOCUMENT_TYPE.AsInteger));
    { ValidateDocumentType(DocumentType);  }
     Case DocumentType Of
     tdWorkOrder     : Begin
                            If Not IsEmptyField(tblCostsDOCUMENT_NO) Then Begin
                               ValidateWorkOrder(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8));
                            End;
                       End;
     tdProject       : Begin
                            If Not IsEmptyField(tblCostsDOCUMENT_NO) Then Begin
                              {01-Abr-05 WVIDELA IC658}
                               ValidateProject(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8),
                                               copy(tblCostsGL_ACCOUNT.AsString,1,8));
                              {01-Abr-05 WVIDELA IC658}
                            End;
                       End;
   {  tdThirdPartyInv : Begin
                            If IsElementNoThirdPartyInv(tblCostsELEMENT_NO.AsString) Then Begin
                               ValidateThirdPartyInv(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8));
                            End;
                       End; }
     End;
end;
procedure TdmActs.tblCostsBeforePost2(DataSet: TDataSet);
Var
   DocumentType:        TDocument;
   CCDefault:           String;
   MustToCheckMSF966: Boolean;
begin
     Case UserConfig.DCCTypeDstrb Of
     cctdPercent : ValidateCCDataField(tblCostsPERCENT);
     cctdValue   : ValidateCCDataField(tblCostsVALUE);
     End;
     MustToCheckMSF966 := True;
     If IsEmptyField(tblCostsGL_ACCOUNT) Then Begin
        CCDefault := '';
        MustToCheckMSF966 := False;
        If Not IsEmptyField(tblCostsEQUIP_NO) Then Begin
           { Try to get a default COST CENTER from the equipment }
           CCDefault := GetCostCenterForEquip(tblCostsEQUIP_NO.AsString);
        End;
        If CCDefault = '' Then Begin
           { If still empty, look up for a default Cost Center from WO or Project}
           DocumentType := TDocument(Ord(tblCostsDOCUMENT_TYPE.AsInteger));
           Case DocumentType Of
           tdWorkOrder : CCDefault := GetCostCenterForWO(tblCostsDOCUMENT_NO.AsString);
           tdProject   : CCDefault := GetCostCenterForProject(tblCostsDOCUMENT_NO.AsString);
           End;
        End;
        tblCostsGL_ACCOUNT.Value := CCDefault;
     End;
     //ValidateCostCenter;
     {21-Feb-05 WVIDELA IC633}
     if MustToCheckMSF966 then
        if (ProjEntryInd = 'M')
        and ( (tblCostsDOCUMENT_TYPE.AsInteger <> 2) or (IsEmptyField(tblCostsDOCUMENT_NO)) ) then
            {raise Exception.Create('Debe ingresar un Número de Proyecto Válido');  }
     {21-Feb-05 WVIDELA IC633}

     If Not IsEmptyField(tblCostsEQUIP_NO) Then Begin
      {  ValidateEquip(tblCostsEQUIP_NO.AsString);  }
     End;
     DocumentType := TDocument(Ord(tblCostsDOCUMENT_TYPE.AsInteger));
    { ValidateDocumentType(DocumentType);  }
     Case DocumentType Of
     tdWorkOrder     : Begin
                            If Not IsEmptyField(tblCostsDOCUMENT_NO) Then Begin
                              { ValidateWorkOrder(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8));   }
                            End;
                       End;
     tdProject       : Begin
                            If Not IsEmptyField(tblCostsDOCUMENT_NO) Then Begin
                              {01-Abr-05 WVIDELA IC658}
                               {ValidateProject(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8),
                                               copy(tblCostsGL_ACCOUNT.AsString,1,8));   }
                              {01-Abr-05 WVIDELA IC658}
                            End;
                       End;
   {  tdThirdPartyInv : Begin
                            If IsElementNoThirdPartyInv(tblCostsELEMENT_NO.AsString) Then Begin
                               ValidateThirdPartyInv(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8));
                            End;
                       End; }
     End;
end;
procedure TdmActs.tblCostsBeforePostJuvinao();
Var
   DocumentType:        TDocument;
   CCDefault:           String;
   MustToCheckMSF966: Boolean;
begin
     Case UserConfig.DCCTypeDstrb Of
     cctdPercent : ValidateCCDataField(tblCostsPERCENT);
     cctdValue   : ValidateCCDataField(tblCostsVALUE);
     End;
     MustToCheckMSF966 := True;

     If IsEmptyField(tblCostsGL_ACCOUNT) Then Begin
        CCDefault := '';
        MustToCheckMSF966 := False;
        If Not IsEmptyField(tblCostsEQUIP_NO) Then Begin
           { Try to get a default COST CENTER from the equipment }
           CCDefault := GetCostCenterForEquip(tblCostsEQUIP_NO.AsString);
        End;
        If CCDefault = '' Then Begin
           { If still empty, look up for a default Cost Center from WO or Project}
           DocumentType := TDocument(Ord(tblCostsDOCUMENT_TYPE.AsInteger));
           Case DocumentType Of
           tdWorkOrder : CCDefault := GetCostCenterForWO(tblCostsDOCUMENT_NO.AsString);
           tdProject   : CCDefault := GetCostCenterForProject(tblCostsDOCUMENT_NO.AsString);
           End;
        End;
        tblCostsGL_ACCOUNT.Value := CCDefault;
     End;
     ValidateCostCenter;
     {21-Feb-05 WVIDELA IC633}

     if MustToCheckMSF966 then
        if (ProjEntryInd = 'M')
        and ( (tblCostsDOCUMENT_TYPE.AsInteger <> 2) or (IsEmptyField(tblCostsDOCUMENT_NO)) ) then
            if frmSAQ301001Main.Opening = 'N' then
                raise Exception.Create('Debe ingresar un Número de Proyecto Válido')
            else
                ShowMessage('Debe ingresar un Número de Proyecto Válido');
     {21-Feb-05 WVIDELA IC633}

     If Not IsEmptyField(tblCostsEQUIP_NO) Then Begin
        ValidateEquip(tblCostsEQUIP_NO.AsString);
     End;
     DocumentType := TDocument(Ord(tblCostsDOCUMENT_TYPE.AsInteger));
    { ValidateDocumentType(DocumentType);  }
     Case DocumentType Of
     tdWorkOrder     : Begin
                            If Not IsEmptyField(tblCostsDOCUMENT_NO) Then Begin
                               ValidateWorkOrder(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8));
                            End;
                       End;
     tdProject       : Begin
                            If Not IsEmptyField(tblCostsDOCUMENT_NO) Then Begin
                              {01-Abr-05 WVIDELA IC658}
                               ValidateProject(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8),
                                               copy(tblCostsGL_ACCOUNT.AsString,1,8));
                              {01-Abr-05 WVIDELA IC658}
                            End;
                       End;
   {  tdThirdPartyInv : Begin
                            If IsElementNoThirdPartyInv(tblCostsELEMENT_NO.AsString) Then Begin
                               ValidateThirdPartyInv(GetMIMSKey(tblCostsDOCUMENT_NO.AsString,8));
                            End;
                       End; }
     End;
end;

procedure TdmActs.tblApproveSTATUSSetText(Sender: TField;
  const Text: String);
Var
   NewStatus:           TActStatus;
   StatusOk:            Boolean;
begin
     NewStatus := asPendent;
     StatusOk  := False;
     While (Not StatusOk) And (NewStatus < asCounted) Do Begin
           If StatusNames[NewStatus] = Text Then Begin
              StatusOk := True; End
           Else Begin
              NewStatus := Succ(NewStatus);
           End;
     End;
     If StatusOk Then Begin
        Sender.AsString := IntToStr(Ord(NewStatus)); End
     Else Begin
        raise Exception.CreateFmt(ME_051,[Text]);
     End;
end;

procedure TdmActs.tblApproveAfterPost(DataSet: TDataSet);
begin
     { Show stadistics }
     DoOnFeedBack(Self);
end;

procedure TdmActs.tblApproveBeforeInsert(DataSet: TDataSet);
begin
     If Not EnabledInsert Then Begin
        Abort;
     End;
end;

procedure TdmActs.tblDetailAfterPost(DataSet: TDataSet);
Var
   Node:                TCategoryDef;
begin
     Try
        Node := FDetails.FindNode(tblDetailELEMENT_NO.AsString,
                                  tblDetailCATEGORY_NO.AsString);
        If Assigned(Node) Then Begin
           { Update Category Edited Value in memory }
           Node.CategoryValue := tblDetailVALUE.AsCurrency;
           { Show stadistics }
           DoOnFeedBack(Self); End
        Else Begin
           raise Exception.CreateFmt(ME_072,[tblDetailELEMENT_NO.AsString,
                                             tblDetailCATEGORY_NO.AsString]);
        End;
     Except
        On E:Exception Do ShowMessage(Format(ME_071,[E.Message]));
     End;
end;

procedure TdmActs.tblApproveBeforePost(DataSet: TDataSet);
Var
   NewStatus:           Byte;
   ValAsLocalCrr:       Currency;   { Approved value as a local currency value }
Begin
     If tblApprove.State = dsEdit Then Begin
        NewStatus := Ord(tblApproveSTATUS.AsInteger);
        If (TActStatus(NewStatus) = asApproved) And
           (Abs(tblApproveVALUE.AsCurrency)<0.01) Then Begin
           raise Exception.CreateFmt(ME_074,[tblApproveACT_PAID_NO.AsString,
                                             tblApproveCONTRACT_NO.AsString]);
        End;
        If TActStatus(NewStatus) = asApproved Then Begin
           { Compare values using the local currency }
           ValAsLocalCrr := ToLocalCurrency(tblApproveCURRENCY.AsString,
                                            tblApproveBUDGET_VALUE.AsCurrency);
           If ValAsLocalCrr > MaxToApprove Then Begin
              raise Exception.CreateFmt(ME_120,[tblApproveACT_PAID_NO.AsString,
                                                tblApproveCONTRACT_NO.AsString,
                                                MaxToApprove,ValAsLocalCrr,
                                                LocalCurrency,
                                                FMimsPosition,FCurrentDistrict]);
           End;
        End;
     End;
end;

procedure TdmActs.tblCostsDOCUMENT_TYPESetText(Sender: TField;
  const Text: String);
Var
   Index1:              TDocument;
begin
     Index1 := Low(TDocument);
     While Index1 <= High(TDocument) Do Begin
           If DocumentNames[Index1] = Text Then Begin
              tblCostsDOCUMENT_TYPE.AsString := IntToStr(Ord(Index1));
              Index1 := High(TDocument);
           End;
           Inc(Index1);
     End;
end;

procedure TdmActs.tblInfoAtaxNewRecord(DataSet: TDataSet);
begin
     tblInfoAtaxATAX_BASE.AsCurrency  := 0;
     tblInfoAtaxATAX_VALUE.AsCurrency := 0;
end;

procedure TdmActs.SsnActPaidStartup(Sender: TObject);
begin
     FPrivateDirectory     := GetWorkingDirectory(ME_169);
     SsnActPaid.PrivateDir := FPrivateDirectory;
end;
Destructor TdmActs.Destroy;
Begin
     Try
        Inherited Destroy;
     Finally
        Try
           DeleteDirectory(FPrivateDirectory);
        Except
           On E:Exception Do Begin
              raise Exception.CreateFmt(ME_170,[FPrivateDirectory,E.Message]);
           End;
        End;
     End;
End;
procedure TdmActs.tblInfoAtaxBeforePost(DataSet: TDataSet);
begin
     { Calculate a default value for ATAX_VALUE if It's necessary }
     If tblInfoAtax.State in [dsEdit,dsInsert] Then Begin
     {De Moya : 2002-08-20.  Agrego valor de la tolerancia. Inicialmente
     hardcode y luego como parametro}
        If Abs(tblInfoAtaxATAX_BASE.AsCurrency) - Abs(ActPaidNewNetValue) > 25000 Then Begin
           If OnlyAlertOnError Then Begin
              ShowMessageFmt(ME_200,[tblInfoAtaxATAX_BASE.AsCurrency]); End
           Else Begin
              raise Exception.CreateFmt(ME_200,[tblInfoAtaxATAX_BASE.AsCurrency]);
           End;
        End;
        If tblInfoAtaxATAX_VALUE.IsNull Or
           (tblInfoAtaxATAX_VALUE.AsCurrency=0) Then Begin
           If (Not tblInfoAtaxATAX_BASE.IsNull)
              And (Not tblInfoAtaxATAX_RATE.IsNull) Then Begin
              tblInfoAtaxATAX_VALUE.AsCurrency := tblInfoAtaxATAX_BASE.AsCurrency *
                                                  (tblInfoAtaxATAX_RATE.AsFloat/100);
           End;
        End;

        tblInfoAtaxATAX_LK_DESC.AsString := GetAtaxDesc(tblInfoAtaxATAX_CODE.AsString);
     End;
end;

procedure TdmActs.tblCostsDOCUMENT_NOSetText(Sender: TField;
  const Text: String);
begin
     Sender.AsString := UpperCase(Text);
end;

procedure TdmActs.tblCostsDOCUMENT_NOGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
     Text := UpperCase(Sender.AsString);
end;

procedure TdmActs.tblCostsGL_ACCOUNTSetText(Sender: TField;
  const Text: String);
begin
     tblCostsGL_ACCOUNT.AsString := Uppercase(Text);
end;
Procedure TdmActs.ValidateNegativeValue(AnElement,AType:String;AValue:Double);
Begin
     If AValue < 0 Then Begin
        raise Exception.CreateFmt(ME_203,[AnElement,AType]);
     End;
End;
procedure TdmActs.tblDetailBeforePost(DataSet: TDataSet);
Var
   TheElementNo:        String;
   TheElementCode:      String;
begin
     TheElementNo := tblDetailELEMENT_NO.AsString;
     TheElementCode := tblDetailELEMENT_CODE.AsString;

     If Not FElementNoDefs.PreserveSign[TheElementNo + TheElementCode] Then Begin
        If FElementNoDefs.IsCost[TheElementNo + TheElementCode] Then Begin
           { The Cost element are ever positives }
           If tblDetailBY_GLOBAL.AsBoolean Then Begin
              tblDetailGLOBAL_VALUE.AsCurrency := Abs(tblDetailGLOBAL_VALUE.AsCurrency); End
           Else Begin
              tblDetailQUANTITY.AsCurrency := Abs(tblDetailQUANTITY.AsCurrency);
           End;
        End;
        If FElementNoDefs.IsDiscount[TheElementNo + TheElementCode] Then Begin
           { The Cost element are ever negatives }
           If tblDetailBY_GLOBAL.AsBoolean Then Begin
              tblDetailGLOBAL_VALUE.AsCurrency := -Abs(tblDetailGLOBAL_VALUE.AsCurrency); End
           Else Begin
              tblDetailQUANTITY.AsCurrency := -Abs(tblDetailQUANTITY.AsCurrency);
           End;
        End;
     End;
end;

procedure TdmActs.tblInfoAtaxCalcFields(DataSet: TDataSet);
begin
     tblInfoAtaxATAX_CALC_VALUE.AsCurrency := 0;
     If (Not tblInfoAtaxATAX_BASE.IsNull)
        And (Not tblInfoAtaxATAX_RATE.IsNull) Then Begin
        tblInfoAtaxATAX_CALC_VALUE.AsCurrency := tblInfoAtaxATAX_BASE.AsCurrency *
                                                 (tblInfoAtaxATAX_RATE.AsFloat/100);
     End;
     tblInfoAtaxATAX_LK_DESC.AsString := GetAtaxDesc(tblInfoAtaxATAX_CODE.AsString);
end;

procedure TdmActs.tblInfoAtaxATAX_RATEChange(Sender: TField);
begin
     If (Not tblInfoAtaxATAX_BASE.IsNull)
        And (Not tblInfoAtaxATAX_RATE.IsNull) Then Begin
        tblInfoAtaxATAX_VALUE.AsCurrency := tblInfoAtaxATAX_BASE.AsCurrency *
                                            (tblInfoAtaxATAX_RATE.AsFloat/100);
     End;
end;

procedure TdmActs.tblDetailQUANTITYGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
Var
   TheElementNo:        String;
   TheElementCode:      String;
begin
     If Sender.IsNull Or (Trim(Sender.AsString) = '') Then Begin
        Text := ''; End
     Else Begin
        TheElementNo := tblDetailELEMENT_NO.AsString;
        TheElementCode := tblDetailELEMENT_CODE.AsString;

        If FElementNoDefs.PreserveSign[TheElementNo + TheElementCode] Then Begin
           Text := Sender.AsString ; End
        Else Begin
           { If not preserve the sign, the value must be ever positive }
           Text := FloatToStr(Abs(Sender.AsFloat));
        End;
     End;
end;

procedure TdmActs.tblDetailGLOBAL_VALUEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
Var
   TheElementNo:        String;
   TheElementCode:      String;
begin
     If Sender.IsNull Or (Trim(Sender.AsString) = '') Then Begin
        Text := ''; End
     Else Begin
        TheElementNo := tblDetailELEMENT_NO.AsString;
        TheElementCode := tblDetailELEMENT_CODE.AsString;

        If FElementNoDefs.PreserveSign[TheElementNo + TheElementCode] Then Begin
           Text := Format('%m',[Sender.AsFloat]) ; End
        Else Begin
           { If not preserve the sign, the value must be ever positive }
           Text := Format('%m',[Abs(Sender.AsFloat)]) ;
        End;
     End;
end;

procedure TdmActs.DataModuleCreate(Sender: TObject);
begin
     FOnlyAlertOnError := False;
     FEditMode         := False;
     FDefaultLoading   := False;
     FLoadingActPaid   := True;
     {    AbrirLog; }
end;

function TdmActs.GetContractAdministrator(Contract_no, Portion_no: string):string;
var
  i:integer;
begin
  with SQLGetContractAdministrator do begin
    Active := False;
    Params[0].AsString := Contract_no;
    Params[1].AsString := Portion_no;
    if not Prepared then
       Prepare;
    Active := True;
    for i := 1 to 4 do begin
      If FieldByName('EMPLOY_TYPE_' + IntToStr(i)).AsString = 'AG' then
         Result := FieldByName('RESPONS_CODE_' + IntToStr(i)).AsString;
    end;
  end;

end;

function TdmActs.GetAtaxDesc(AtaxCode : String) : String;
Var
   AssocRec:            String;
   AtaxRate:            Double;
Begin
  With SQLGetAtaxDesc010 Do Begin
    Active := False;
    Params[0].AsString := AtaxCode;
    if not Prepared then
       Prepare;
    Active := True;
    If Not Fields[1].IsNull Then
      Result := Fields[1].AsString
    else
      Result := '';
  end;
End;

procedure TdmActs.tblInfoAtaxATAX_CODEChange(Sender: TField);
begin
  try
    tblInfoAtax.Edit;
    tblInfoAtaxATAX_LK_DESC.AsString := GetAtaxDesc(Sender.Text);

  Except
    On E: Exception do begin
    end;
  End;
end;

end.
