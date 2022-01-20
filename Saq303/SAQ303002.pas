{ This module is intended to manage the received invoices for the corresponding
  approved Acts. The process is the following :
  1. In SAQ303001, the system connect to the MIMS Database (routine
     ConnectToBDMIMS); then connect to MIMS by using the interface COM with
     MSQMUI (technology MIMSX, routine ConnectToMSQMUI ) and init the basic
     structures as Element names, Atax codes, etc (routine InitStructures)
  2. The system create a temporal table (tblPays) with all the acts in the
     asCounted state by using the routine CreateTablePays, defined here
  3. SAQ303001 list the table; then, the user can create the invoice in MIMS
     by doubleclicking on the Act Paid selected; this operation call the form
     in SAQ303004, then, on this form, the user enter the data fields values
     for the invoices
  4. The new information is send to MIMS, saved to the Database table SAF3A4
     and the Act state changes to asInvoiced by calling since BtnSave in
     SAQ303004 the routine UpdateDataBase, defined here }

unit SAQ303002;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ComObj, MCObjcts, Variants ;

type
  TFB303Event = Procedure(ACount:Integer;AMessage1,AMessage2:String) Of Object;
  TdmSAQ303002DataModule = class(TDataModule)
    SsnInvoice: TSession;
    dbActPaid: TDatabase;
    SQLPendents: TQuery;
    tblPays: TTable;
    StblPays: TDataSource;
    dbLocal: TDatabase;
    tblPaysCONTRACT_NO: TStringField;
    tblPaysPORTION_NO: TStringField;
    tblPaysACT_PAID_NO: TStringField;
    tblPaysACT_PAID_CRR: TStringField;
    tblPaysACT_PAID_DATE: TStringField;
    tblPaysACT_PAID_VALUE: TCurrencyField;
    tblPaysSUPPLIER_NO: TStringField;
    tblPaysSUPPLIER_NAME: TStringField;
    tblPaysAPPROVER_NAME: TStringField;
    tblPaysINVOICE_NO: TStringField;
    tblPaysINVOICE_DATE: TStringField;
    tblPaysINVOICE_RCV_DT: TStringField;
    tblPaysINVOICE_DUE_DT: TStringField;
    tblPaysINVOICE_BANK: TStringField;
    tblPaysINVOICE_BANK_ACCT: TStringField;
    tblPaysINVOICE_CRR: TStringField;
    tblPaysINVOICE_RT_CRR: TFloatField;
    tblPaysINVOICE_TYPING_VALUE: TCurrencyField;
    tblPaysINVOICE_VALUE: TCurrencyField;
    tblPaysINVOICE_ATAX_CODE: TStringField;
    tblPaysINVOICE_VOUCHER: TStringField;
    tblPaysINVOICE_HANDLE_CODE: TStringField;
    tblPaysINVOICE_ATAX_VALUE: TCurrencyField;
    SQLActValue: TQuery;
    SQLSupplier: TQuery;
    SQLSupplierSUPPLIER_NAME: TStringField;
    SQLPendentsCONTRACT_NO: TStringField;
    SQLPendentsPORTION_NO: TStringField;
    SQLPendentsACT_PAID_NO: TStringField;
    SQLPendentsACT_PAID_DATE: TStringField;
    SQLPendentsAPPROVED_BY: TStringField;
    SQLPendentsSUPPLIER_NO: TStringField;
    SQLPendentsCURRENCY_TYPE: TStringField;
    SQLEmployee: TQuery;
    SQLEmployeeSURNAME: TStringField;
    SQLEmployeeFIRST_NAME: TStringField;
    SQLEmployeeSECOND_NAME: TStringField;
    SQLEmployeeTHIRD_NAME: TStringField;
    SQLSetActStatus: TQuery;
    SQLInsNewInv: TQuery;
    SQLInfoUser: TQuery;
    SQLGetCrrRt: TQuery;
    SQLItmXEle: TQuery;
    SQLItmXEleELEMENT_NO: TStringField;
    SQLItmXElePAID_VALUE: TFloatField;
    SQLCosts: TQuery;
    SQLCostsELEMENT_NO: TStringField;
    SQLCostsGL_ACCOUNT: TStringField;
    SQLCostsDOCUMENT_TYPE: TStringField;
    SQLCostsDOCUMENT_NO: TStringField;
    SQLCostsEQUIP_NO: TStringField;
    SQLCostsPERCENT: TStringField;
    SQLUserConfig: TQuery;
    SQLUserConfigDSTRCT_CODE: TStringField;
    SQLUserConfigEMPLOYEE_ID: TStringField;
    SQLUserConfigCC_TYPE_DSTRB: TStringField;
    SQLUserConfigCC_DEFAULT_DSTRB: TStringField;
    SQLUserConfigTYPE_COMMENTS: TStringField;
    SQLUserConfigTYPE_CNTRCT_EXT: TStringField;
    SQLUserConfigLOAD_INV_TYPE: TStringField;
    SQLUserConfigACT_VALIDATION: TStringField;
    SQLItmXCat: TQuery;
    SQLItmXCatELEMENT_NO: TStringField;
    SQLItmXCatCATEGORY_NO: TStringField;
    SQLItmXCatPAID_VALUE: TFloatField;
    SQLUserConfigINV_VALIDATION: TStringField;
    SQLAtaxCodes: TQuery;
    SQLAtaxCodesATAX_CODE: TStringField;
    SQLAtaxCodesDESCRIPTION: TStringField;
    SQLAtaxCodesATAX_RATE_9: TFloatField;
    SQLAtaxCodesGRP_LEVEL_IND: TStringField;
    SQLAtaxCodesEFFECTIVE_DATE: TStringField;
    SQLAtaxGrps: TQuery;
    SQLAtaxGrpsATAX_CODE: TStringField;
    SQLAtaxGrpsREL_ATAX_CODE: TStringField;
    tblItems: TTable;
    StblItems: TDataSource;
    tblItemsELEMENT_DESC: TStringField;
    tblItemsCATEGORY_DESC: TStringField;
    tblItemsELEMENT_NO: TStringField;
    tblItemsCATEGORY_NO: TStringField;
    tblItemsITEM_VALUE: TCurrencyField;
    tblItemsATAX_CODE: TStringField;
    tblItemsATAX_VIEW: TStringField;
    SQLElements: TQuery;
    SQLCntPrtEle: TQuery;
    SQLElementsTABLE_CODE: TStringField;
    SQLElementsTABLE_DESC: TStringField;
    SQLCntPrtEleELEMENT_NO: TStringField;
    SQLCntPrtEleELEMENT_CODE: TStringField;
    SQLCntPrtEleELEMENT_VAL: TFloatField;
    SQLCntPrtEleCat: TQuery;
    SQLCntPrtEleCatELEMENT_NO: TStringField;
    SQLCntPrtEleCatCATEGORY_NO: TStringField;
    SQLCntPrtEleCatCATEG_CODE: TStringField;
    SQLCntPrtEleCatTABLE_DESC: TStringField;
    SQLCstmCtg: TQuery;
    SQLCstmCtgTABLE_CODE: TStringField;
    SQLCstmCtgTABLE_DESC: TStringField;
    SQLEmployeeEMPLOYEE_ID: TStringField;
    tblAtax: TTable;
    StblAtax: TDataSource;
    tblAtaxATAX_CODE: TStringField;
    tblAtaxATAX_RATE: TStringField;
    tblAtaxATAX_DESC: TStringField;
    tblAtaxTAX_VALUE: TCurrencyField;
    SQLHandleCodes: TQuery;
    SQLVoucherStyle: TQuery;
    procedure tblPaysCalcFields(DataSet: TDataSet);
    procedure tblPaysACT_PAID_DATEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dmSAQ303002DataModuleDestroy(Sender: TObject);
    procedure tblPaysBeforePost(DataSet: TDataSet);
    procedure dmSAQ303002DataModuleCreate(Sender: TObject);
    procedure tblItemsBeforeInsert(DataSet: TDataSet);
    procedure tblAtaxBeforeInsert(DataSet: TDataSet);
    procedure tblItemsNewRecord(DataSet: TDataSet);
    procedure tblPaysINVOICE_HANDLE_CODESetText(Sender: TField;
      const Text: String);
    procedure tblAtaxATAX_RATEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure tblPaysINVOICE_DATESetText(Sender: TField;
      const Text: String);
    procedure tblPaysINVOICE_HANDLE_CODEGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure tblItemsBeforePost(DataSet: TDataSet);
    procedure tblItemsBeforeEdit(DataSet: TDataSet);
    procedure tblAtaxATAX_CODEChange(Sender: TField);
  private
    { Private declarations }
    FCurrentDate:       String;     { Current Date (format yyyymmdd) }
    FCurrentUserID:     String;     { User Id of the Current User }
    FCurrentUser:       String;     { Employee Id of the Current User }
    FCurrentDistrict:   String;     { District of the Current User }
    FHost:              String;     { Host machine }
    FPort:              String;     { Port }
    FHostUserName:      String;     { Name of the user logged on the host }
    FHostPassword:      String;     { Password of the user logged on the host }
    FOracleUser:        String;     { Oracle User }
    FOraclePassword:    String;     { Oracle Password }
    FMimsPassword:      String;     { Password to connect MIMS }
    FMimsPosition:      String;     { User position in MIMS }
    FCurrentContract:   String;     { Current Contract saving the Acts }
    FCurrentPortion:    String;     { Current Portion saving the Acts }
    FCurrentActPaid:    String;     { Current Act Paid saving the Acts }
    FCurrentInvoice:    String;     { Invoice No for the current Act Paid }
    FCurrentRate:       Double;     { Convertion rate for the Invoice Monetary unit }
    FLoadInvAccount:    String;     { Account number to load the invoice }
    FLogFile:           TextFile;   { File for errors log }
    FItemCount:         Integer;    { Count of items in the current invoice }
    FCCCount:           Integer;    { Count of Cost Centers in the current invoice }
    FErrorCount:        Integer;    { Count of error messages }
    FRecordsOk:         Integer;    { Count of Invoice successful saved }
    FStbLine:           String;     { Current Text for Panel 2 on StatusBar }
    FEnabledInsert:     Boolean;    { Flag to disable insert from the user in tblItems }
    FUserConfig:        TUserConfig;{ User Preferences Configuration }
    FElements:          TElementList;{ Cache list for Elements }
    FCategoryNames:     TCstmCtgNms;{ Custom Category Names }
    FHandleCodes:       TStringList;{ Handle codes for the invoices } 
    FAtaxDefs:          TStringList;{ List of Atax General Definitions }
    FMapItem389:        TStringList;{ Mapping Item No in MSM389A to Category - Category }
    FSentOk:            Boolean;    { True = Invoice Sent successful to MIMS }
    FCurrentLoadStep:   Integer;    { Number of the current step loading the program }
    FEditGlobalAtax:    Boolean;    { True = Edit Atax Values for the full invoice }
    FDefBankCode:       String;     { Default Bank Code }
    FDefBankAccount:    String;     { Default Bank Account }
    FOldElementNo:      String;     { Original Element No for an item in tblItems }
    FOldCategoryNo:     String;     { Original Category No for an item in tblItems }
    FOnFeedBack:        TFB303Event;
    { Param Objects for SQLInsNewInv }
    FPINIContracNo:     TParam;
    FPINIActPaidNo:     TParam;
    FPINIPortionNo:     TParam;
    FPINIStatus:        TParam;
    FPINISupplierNo:    TParam;
    FPINIAuthsdBy:      TParam;
    FPINIAuthDate:      TParam;
    FPINIInvoiceNo:     TParam;
    FPINIInvoiceDate:   TParam;
    FPINIInvoiceRcvDt:  TParam;
    FPINIInvoiceCrr:    TParam;
    FPINIInvoiceRtCrr:  TParam;
    FPINIInvoiceValue:  TParam;
    Function IsValidAtax:Boolean;
    Function GetCanModify:Boolean;
    Function GetCanInsert:Boolean;
    Function GetItemCount:Integer;
    Function GetCurrencyRate(AnInvoiceCrr,AContractCrr,AnInvoiceDate:String):Double;
    Function GetEmployeeName(AnEmployee:String;MustExists:Boolean):String;
    Function GetSupplierName(ASupplier:String):String;
    Function GetEmployeeID(AUser:String):String;
    Function GetUserEmployeeID(AUser:String):String;
    Function GetActPaidValue(AContract,AnActPaid:String):Currency;
    Function GetElementNameFor(ElementNo:String):String;
    Function GetCategoryNameFor(ElementNo,CategoryNo:String):String;
    Procedure GetHandleCodes;
    Procedure AddAtaxDefiniton;
    Procedure CreateTemporalTable(ATable:TTable);
    Procedure DoOnFeedBack(ACount:Integer;AMessage1,AMessage2:String);
    Procedure SetActPaidStatus(AContract,AnActPaid:String);
    Procedure SetEditItemAtax(AValue:Boolean);
    Procedure CreatePayRecord;
    Procedure GetActPaidItems(AContract,AnActPaid:String);
    Procedure GetActPaidCategories(AContract,AnActPaid:String);
    Procedure GetActPaidCostCenters(AContract,AnActPaid:String);
    Procedure GetActCategoriesFor(AContract,APortion:String);
    Procedure GetActElementsFor(AContract,APortion:String);
    Procedure LoadCustomCategoryNames(AContract,APortion:String);
    Procedure RefreshCustomCategoryNames(AContract,APortion:String);
    Procedure ActiveInfoCatNamesForCurrentAct;
    Procedure TableForLoadByCategory;
    Procedure TableForLoadByElement(EnableEditing:Boolean);
    Procedure InsertNewInvoice;
    procedure tblPaysValidateData;
    Procedure SaveInvoiceInActPaid;
    Procedure CloseTemporalTable(ATable:TTable);
  public
    { Public declarations }
    Function CrrValue(AField:TFloatField):String;
    Function GetVoucherStyle(ADistrict:String):String;
    Procedure GetParamObjectsForSQLInsNewInv;
    Procedure GetAtaxCodes;
    Procedure AtaxCodesToDisplayList(AnAtaxList:TStrings);
    Procedure LoadElements;
    procedure LoadRegistryInformation;
    Procedure LoadUserConfiguration;
    Procedure CreateTemporalInvoice;
    Procedure ConnectToBDMIMS;
    Procedure CreateTableItems;
    Procedure CreateTableAtax;
    Procedure CreateTablePays;
    Procedure InitStructures;
    Procedure SearchActPaidsPendents;
    Procedure SetCurrentSaveParams;
    Procedure ClearEditAtaxFlags;
    Procedure ProcessMIMSResults;
    Property CategoryNames:TCstmCtgNms Read FCategoryNames;
    Property HandleCodes:TStringList Read FHandleCodes;
    Property OracleUser:String      Read FOracleUser Write FOracleUser;
    Property OraclePassword:String  Read FOraclePassword Write FOraclePassword;
    Property LoadInvAccount:String  Read FLoadInvAccount Write FLoadInvAccount;
    Property ItemCount:Integer      Read GetItemCount;
    Property CCCount:Integer        Read FCCCount;
    Property EnabledInsert:Boolean  Read FEnabledInsert Write FEnabledInsert;
    Property CanModify:Boolean      Read GetCanModify;
    Property CanInsert:Boolean      Read GetCanInsert;
    Property CurrentDate:String     Read FCurrentDate Write FCurrentDate;
    Property CurrentUserID:String   Read FCurrentUserID Write FCurrentUserID;
    Property CurrentUser:String     Read FCurrentUser;
    Property CurrentContract:String Read FCurrentContract;
    Property CurrentActPaid:String  Read FCurrentActPaid;
    Property CurrentDistrict:String Read FCurrentDistrict Write FCurrentDistrict;
    Property MimsPosition:String    Read FMimsPosition Write FMimsPosition;
    Property UserConfig:TUserConfig Read FUserConfig;
    Property StbLine:String         Read FStbLine Write FStbLine;
    Property SentOk:Boolean         Read FSentOk Write FSentOk;
    Property DefBankCode:String     Read FDefBankCode Write FDefBankCode;
    Property DefBankAccount:String  Read FDefBankAccount Write FDefBankAccount;
    Property Elements:TElementList  Read FElements;
    Property AtaxDefs: TStringList  Read FAtaxDefs;
    Property MapItem389:TStringList Read FMapItem389;
    Property OnFeedBack:TFB303Event Read FOnFeedBack Write FOnFeedBack;
    Property EditItemAtax:Boolean   Write SetEditItemAtax;
    Property EditGlobalAtax:Boolean Read FEditGlobalAtax Write FEditGlobalAtax;
  end;

var
  dmSAQ303002DataModule: TdmSAQ303002DataModule;

implementation

uses MCTypes, MCUtils, MCConnct, SAQ300003;

{$R *.DFM}

{ Use this routine to call the OnFeedBack event. We use the standard methodology,
  in spite of it's unnecessary, because maybe other applications will use this
  data module }
Procedure TdmSAQ303002DataModule.DoOnFeedBack(ACount:Integer;AMessage1,AMessage2:String);
Begin
     If Assigned(FOnFeedBack) Then Begin
        FOnFeedBack(ACount,AMessage1,AMessage2);
     End;
End;
procedure TdmSAQ303002DataModule.tblPaysCalcFields(DataSet: TDataSet);
begin
     Try
        tblPaysINVOICE_VALUE.AsCurrency := tblPaysACT_PAID_VALUE.AsCurrency /
                                           tblPaysINVOICE_RT_CRR.AsFloat;
     Except
        On E:Exception Do tblPaysINVOICE_VALUE.AsCurrency := 0;
     End;
end;
Function TdmSAQ303002DataModule.CrrValue(AField:TFloatField):String;
Var
   ValueInCrrUnit:      Double;
Begin
     ValueInCrrUnit := AField.AsFloat / FCurrentRate;
     CrrValue       := FloatToStr(ValueInCrrUnit);
End;
Function TdmSAQ303002DataModule.GetCurrencyRate(AnInvoiceCrr,
                                                AContractCrr,
                                                AnInvoiceDate:String):Double;
Begin
     With SQLGetCrrRt Do Begin
          Try
             Active := False;
             Params[0].AsString := AnInvoiceCrr;
             Params[1].AsString := AContractCrr;
             Params[2].AsString := AnInvoiceDate;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_077);
             End;
             GetCurrencyRate := Fields[0].AsFloat;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_078,[AnInvoiceCrr,
                                                  AContractCrr,
                                                  E.Message]);
             End;
          End;
     End;
End;
Function TdmSAQ303002DataModule.GetActPaidValue(AContract,AnActPaid:String):Currency;
Begin
     GetActPaidValue := 0;
     With SQLActValue Do Begin
          Try
             Active := False;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active := True;
             GetActPaidValue := Fields[0].AsCurrency;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_039,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
{ Use this function to get the name of the employee with EMPLOYEE_ID = AnEmployee.
  The parameter MustExists force to validate that MSF810 has an Employee
  with EMPLOYEE_ID = AnEmployee. The validation require this EMPLOYEE_ID
  has a valid name defined in MSF810; it's not enough that MSF810 has
  a record for this EMPLOYEE_ID }

Function TdmSAQ303002DataModule.GetEmployeeName(AnEmployee:String;MustExists:Boolean):String;
Var
   NotName:             Boolean;    { True = User doesn't have a name }
Begin
     GetEmployeeName := '';
     With SQLEmployee Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AnEmployee;
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
                   GetEmployeeName := SQLEmployeeSURNAME.AsString + ' '+
                                      SQLEmployeeTHIRD_NAME.AsString + ', '+
                                      SQLEmployeeFIRST_NAME.AsString + ' '+
                                      SQLEmployeeSECOND_NAME.AsString;
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
Function TdmSAQ303002DataModule.GetSupplierName(ASupplier:String):String;
Begin
     With SQLSupplier Do Begin
          Try
             Close;
             Params[0].AsString:=ASupplier;
             If Not Prepared Then Begin
                Prepare;
             End;
             Open;
             If SQLSupplierSUPPLIER_NAME.IsNull Then Begin
                GetSupplierName := ME_003;End
             Else Begin
                GetSupplierName := SQLSupplierSUPPLIER_NAME.AsString;
             End;
          Except
             On E:Exception Do Begin
                GetSupplierName := ME_003;
                raise Exception.CreateFmt(ME_004,[ASupplier,E.Message]);
             End;
          End;
     End;
End;
{ Use this function to get the Employee ID of the user AUser. }

Function TdmSAQ303002DataModule.GetEmployeeID(AUser:String):String;
Begin
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
                raise Exception.CreateFmt(ME_024,[AUser,E.Message]);
             End;
          End;
     End;
End;
Function TdmSAQ303002DataModule.GetVoucherStyle(ADistrict:String):String;
Begin
     With SQLVoucherStyle Do Begin
          Try
             Params[0].AsString := ADistrict;
             Try
                Active := True;
                If Fields[0].IsNull Then Begin
                   raise Exception.Create(ME_158);
                End;
                GetVoucherStyle := Fields[0].AsString;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_159,[ADistrict,E.Message]);
             End;
          End;
     End;
End;
{ Use this function to get the Employee ID of the current user.
  There are two cases :
  If the current User ID is really the Employee ID, then the function
  GetEmployeeName must get a value; in other case, the current User ID
  is an independent MIMS ID and the Employee ID must be get from MSF020
  by using GetEmployeeID. }

Function TdmSAQ303002DataModule.GetUserEmployeeID(AUser:String):String;
Begin
     If GetEmployeeName(AUser,False) = '' Then Begin
        GetUserEmployeeID := GetEmployeeID(AUser); End
     Else Begin
        GetUserEmployeeID := AUser;
     End;  
End;
Function TdmSAQ303002DataModule.IsValidAtax:Boolean;
Begin
     IsValidAtax := IsEmptyField(SQLAtaxCodesEFFECTIVE_DATE) Or
                    (SQLAtaxCodesEFFECTIVE_DATE.AsString<FCurrentDate);
End;
{ Use this function to know if the user can modify the invoice detail.}
Function TdmSAQ303002DataModule.GetCanModify:Boolean;
Begin
     GetCanModify := UserConfig.LoadInvType in [litEditCategory,litEditElement];
End;
{ Use this function to know if the system can insert new records in the
  invoice detail. CanInsert is True if the system is creating the list
  of invoice items (When EnabledInsert) or when the user is authorised
  to modify the invoice detail (the invoice items) }
Function TdmSAQ303002DataModule.GetCanInsert:Boolean;
Begin
     GetCanInsert := EnabledInsert Or CanModify;
End;
Function TdmSAQ303002DataModule.GetItemCount:Integer;
Begin
     Try
        FItemCount   := tblItems.RecordCount;
        GetItemCount := FItemCount;
     Except
        { If the table is closed, used the last number of items }
        GetItemCount := FItemCount;
     End;
End;
Procedure TdmSAQ303002DataModule.GetHandleCodes;
Var
   HCFormat:            String;
Begin
     With SQLHandleCodes Do Begin
          Try
             Try
                Active := True;
                HandleCodes.Clear;
                While Not EoF Do Begin
                      HCFormat := Format(ItemDescFmt,[Fields[0].AsString,
                                                      Fields[1].AsString]);
                      HandleCodes.Add(HCFormat);
                      Next;
                End;
             Finally
                Active := False;
             end;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_146,[E.Message]);
             End;
          End;
     End;

End;
Procedure TdmSAQ303002DataModule.AddAtaxDefiniton;
Var
   Node:                TAtaxDfntn;
Begin
     Node := TAtaxDfntn.Create;
     With Node Do Begin
          AtaxCode    := SQLAtaxCodesATAX_CODE.AsString;
          Description := SQLAtaxCodesDESCRIPTION.AsString;
          Group       := SQLAtaxCodesGRP_LEVEL_IND.AsBoolean;
          Percent     := SQLAtaxCodesATAX_RATE_9.AsFloat;
          FAtaxDefs.AddObject(AtaxCode,Node);
     End;
End;
{ Get the Atax codes defined in MIMS }
Procedure TdmSAQ303002DataModule.GetAtaxCodes;
Begin
     Try
        FCurrentDate := DateTimeToDate8(Date);
        FAtaxDefs.Clear;
        With SQLAtaxCodes Do Begin
             Try
                Active := True;
                While Not EoF Do Begin
                      If IsValidAtax Then Begin
                         AddAtaxDefiniton;
                      End;
                      Next;
                End;
             Finally
                Active := False;
             End;
        End;
        SQLAtaxGrps.Active := True;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_130,[E.Message]);
           Application.Terminate;
        End;
     End;
End;
Procedure TdmSAQ303002DataModule.AtaxCodesToDisplayList(AnAtaxList:TStrings);
Var
   AtaxIndex:           Integer;
   AtaxLine:            String;
Begin
     AtaxIndex := 0;
     With AtaxDefs Do Begin
          While AtaxIndex < Count Do Begin
                With Objects[AtaxIndex] As TAtaxDfntn Do Begin
                     If Group Then Begin
                        AtaxLine := MI_016; End
                     Else Begin
                        AtaxLine := Format('%5.2f',[Percent]);
                        AtaxLine := AtaxLine + '%';
                     End;
                     AtaxLine := Format(AtaxFmt,[AtaxCode,AtaxLine]);
                     AnAtaxList.Add(AtaxLine);
                End;
                Inc(AtaxIndex);
          End;
     End;
End;
{ Load all the elements defined in the system from MSF010 TABLE_TYPE = 'EN' }
Procedure TdmSAQ303002DataModule.LoadElements;
Var
   Node:                TElementDef;{ Data Definition for an Element }
Begin
     With SQLElements Do Begin
          Try
             Try
                Active := True;
                While Not EoF Do Begin
                      Node := TElementDef.Create;
                      Node.ElementCode := SQLElementsTABLE_CODE.AsString;
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
{ Get the element definitions for the couple Contract-Portion }
Procedure TdmSAQ303002DataModule.GetActElementsFor(AContract,APortion:String);
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
{ Get the category definitions for the couple Contract-Portion }
Procedure TdmSAQ303002DataModule.GetActCategoriesFor(AContract,APortion:String);
Begin
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
                raise Exception.CreateFmt(ME_136,[APortion,AContract,E.Message]);
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
Procedure TdmSAQ303002DataModule.LoadCustomCategoryNames(AContract,APortion:String);
Var
   LowRange:            String;
   HighRange:           String;
   LastChar:            Integer;
Begin
     With SQLCstmCtg Do Begin
          Try
             Active    := False;
             { Set Range for the Query. The range is intended to include all
               the custom names for AContract-APortion }
             LowRange  := GetMIMSKey(AContract,8) + GetMIMSKey(APortion,2);
             HighRange := LowRange;
             LastChar  := Length(HighRange);
             HighRange[LastChar] := Chr(Ord(HighRange[LastChar])+1);
             Params[0].AsString  := LowRange;
             Params[1].AsString  := HighRange;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                { Load the custom names }
                Active := True;
                While Not EoF Do Begin
                      FCategoryNames.AddCategoryName(
                                        SQLCstmCtgTABLE_CODE.AsString,
                                        SQLCstmCtgTABLE_DESC.AsString);
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
Procedure TdmSAQ303002DataModule.RefreshCustomCategoryNames(AContract,APortion:String);
Begin
     If Not FCategoryNames.IsPortionLoaded(AContract,APortion) Then Begin
        LoadCustomCategoryNames(AContract,APortion);
     End;
End;
Function TdmSAQ303002DataModule.GetElementNameFor(ElementNo:String):String;
Var
   ElementCode:         String;
   ElementIndex:        Integer;
   ItemDesc:            String;
Begin
     If Not SQLCntPrtEle.Locate('ELEMENT_NO',ElementNo,[]) Then Begin
        raise Exception.CreateFmt(ME_132,[ElementNo]);
     End;
     ElementCode := SQLCntPrtEleELEMENT_CODE.AsString;
     If Not FElements.Find(ElementCode,ElementIndex) Then Begin
        raise Exception.CreateFmt(ME_133,[ElementNo,ElementCode]);
     End;
     ItemDesc := FElements.ElementName[ElementCode];
     GetElementNameFor := Format(ItemDescFmt,[ElementNo,ItemDesc]);
End;
Function TdmSAQ303002DataModule.GetCategoryNameFor(ElementNo,CategoryNo:String):String;
Var
   CategoryCode:        String;
   CategoryIndex:       Integer;
   ItemDesc:            String;
   Key:                 Variant;
Begin
     Key := VarArrayOf([ElementNo,CategoryNo]);
     If Not SQLCntPrtEleCat.Locate('ELEMENT_NO;CATEGORY_NO',Key,[]) Then Begin
        raise Exception.CreateFmt(ME_132,[ElementNo,CategoryNo]);
     End;
     CategoryCode := SQLCntPrtEleCatCATEG_CODE.AsString;
     ItemDesc := SQLCntPrtEleCatTABLE_DESC.AsString;
     { Check if exist a custom name for the category; in that case, use this
       name over the global definition }
     With CategoryNames Do Begin
          Element  := ElementNo;
          Category := CategoryNo;
          If CategoryName <> '' Then Begin
             ItemDesc := CategoryName;
          End;
     End;
     GetCategoryNameFor := Format(ItemDescFmt,[CategoryNo,ItemDesc]);
End;
{ Active the information to get the category names for the current contract by
  loading the global names for these categories from the standard table "CE" in
  MSF010 (GetActCategoriesFor), then check if there is some custom names for
  these categories, loading then if it's necessary from the non-standard table
  "+CE", also in MSF010, (RefreshCustomCategoryNames) and selecting the
  corresponding Contract-Portion in the cache list of custom category names }

Procedure TdmSAQ303002DataModule.ActiveInfoCatNamesForCurrentAct;
Begin
     GetActCategoriesFor(FCurrentContract,FCurrentPortion);
     RefreshCustomCategoryNames(FCurrentContract,FCurrentPortion);
     CategoryNames.Contract := FCurrentContract;
     CategoryNames.Portion  := FCurrentPortion;
End;
Procedure TdmSAQ303002DataModule.TableForLoadByCategory;
Var
   ElementNo:           String;
   CategoryNo:          String;
   ElementName:         String;
   CategoryName:        String;
Begin
     GetActPaidCategories(FCurrentContract,FCurrentActPaid);
     ActiveInfoCatNamesForCurrentAct;
     With SQLItmXCat Do Begin
          While Not EoF Do Begin
                ElementNo    := SQLItmXCatELEMENT_NO.AsString;
                ElementName  := GetElementNameFor(ElementNo);
                CategoryNo   := SQLItmXCatCATEGORY_NO.AsString;
                CategoryName := GetCategoryNameFor(ElementNo,CategoryNo);
                tblItems.Append;
                tblItemsELEMENT_DESC.AsString  := ElementName;
                tblItemsCATEGORY_DESC.AsString := CategoryName;
                tblItemsELEMENT_NO.AsString    := ElementNo;
                tblItemsCATEGORY_NO.AsString   := CategoryNo;
                tblItemsITEM_VALUE.AsCurrency  := SQLItmXCatPAID_VALUE.AsCurrency;
                tblItemsATAX_CODE.AsString     := '';
                tblItems.Post;
                Next;
          End;
     End;
End;
{ If EnableEditing is True, the user is able to insert and modify new invoice
  items (i.e it can modify elements and categories) ; therefore we must load
  information about categories and to list the names of the categories }
Procedure TdmSAQ303002DataModule.TableForLoadByElement(EnableEditing:Boolean);
Var
   ElementNo:           String;
   CategoryNo:          String;
   ElementName:         String;
   CategoryName:        String;
Begin
     If EnableEditing Then Begin
        ActiveInfoCatNamesForCurrentAct;
     End;
     GetActPaidItems(FCurrentContract,FCurrentActPaid);
     With SQLItmXEle Do Begin
          While Not EoF Do Begin
                ElementNo   := SQLItmXEleELEMENT_NO.AsString;
                CategoryNo  := '01';
                ElementName := GetElementNameFor(ElementNo);
                If EnableEditing Then Begin
                   CategoryName := GetCategoryNameFor(ElementNo,CategoryNo); End
                Else Begin
                   CategoryName := CategoryNo;
                End;
                tblItems.Append;
                tblItemsELEMENT_DESC.AsString  := ElementName;
                tblItemsCATEGORY_DESC.AsString := CategoryName;
                tblItemsELEMENT_NO.AsString    := ElementNo;
                tblItemsCATEGORY_NO.AsString   := CategoryNo;
                tblItemsITEM_VALUE.AsCurrency  := SQLItmXElePAID_VALUE.AsCurrency;
                tblItemsATAX_CODE.AsString     := '';
                tblItems.Post;
                Next;
          End;
     End;
End;
Procedure TdmSAQ303002DataModule.CreateTemporalInvoice;
Begin
     FItemCount       := 0;
     FCCCount         := 0;
     FItemCount       := 0;
     FCurrentContract := tblPaysCONTRACT_NO.AsString;
     FCurrentPortion  := tblPaysPORTION_NO.AsString;
     FCurrentActPaid  := tblPaysACT_PAID_NO.AsString;
     GetActElementsFor(FCurrentContract,FCurrentPortion);
     Case UserConfig.LoadInvType Of
     litCategory,litEditCategory : TableForLoadByCategory;
     litElement                  : TableForLoadByElement(False);
     litEditElement              : TableForLoadByElement(True);
     End;
End;
{ Use this routine to load the User Preferences Configuration. This
  configuration is really for all the user in the current district;
  however, some options are only a default, the user is able to change
  them for each document }
Procedure TdmSAQ303002DataModule.LoadUserConfiguration;
Begin
     With SQLUserConfig,UserConfig Do Begin
          Try
             Active := False;
             Params[0].AsString := FCurrentDistrict;
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
             Active         := False;
          Except
             On E:Exception Do Begin
                ShowMessageFmt(ME_099,[FCurrentDistrict,E.Message]);
             End;
          End;
     End;
End;
{ Use this routine to get the Param Objects SQLInsNewInv }

Procedure TdmSAQ303002DataModule.GetParamObjectsForSQLInsNewInv;
Begin
     With SQLInsNewInv Do Begin
          FPINIContracNo    := ParamByName('AContractNo');
          FPINIActPaidNo    := ParamByName('AnActPaidNo');
          FPINIPortionNo    := ParamByName('APortionNo');
          FPINIStatus       := ParamByName('AnStatus');
          FPINISupplierNo   := ParamByName('ASupplierNo');
          FPINIAuthsdBy     := ParamByName('AnAuthsdBy');
          FPINIAuthDate     := ParamByName('AnAuthDate');
          FPINIInvoiceNo    := ParamByName('AnInvoiceNo');
          FPINIInvoiceDate  := ParamByName('AnInvoiceDate');
          FPINIInvoiceRcvDt := ParamByName('AnInvoiceRcvDt');
          FPINIInvoiceCrr   := ParamByName('AnInvoiceCrr');
          FPINIInvoiceRtCrr := ParamByName('AnInvoiceRtCrr');
          FPINIInvoiceValue := ParamByName('AnInvoiceValue');
     End;
End;
Procedure TdmSAQ303002DataModule.SetActPaidStatus(AContract,AnActPaid:String);
Begin
     With SQLSetActStatus Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := StrStatusOf(asInvoiced);
             Params[1].AsString := AContract;
             Params[2].AsString := AnActPaid;
             Params[3].AsString := StrStatusOf(asCounted);
             ExecSQL;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_021,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmSAQ303002DataModule.SetEditItemAtax(AValue:Boolean);
Begin
     tblItems.Edit;
     tblItemsATAX_VIEW.AsBoolean := AValue;
     tblItems.Post;
End;
Procedure TdmSAQ303002DataModule.ClearEditAtaxFlags;
Begin
     EditGlobalAtax := False;
     With tblItems Do Begin
          First;
          While Not EoF Do Begin
                EditItemAtax := False;
                Next;
          End;
     End;
End;
Procedure TdmSAQ303002DataModule.CreatePayRecord;
Begin
     tblPaysCONTRACT_NO.AsString       := SQLPendentsCONTRACT_NO.AsString;
     tblPaysPORTION_NO.AsString        := SQLPendentsPORTION_NO.AsString;
     tblPaysACT_PAID_NO.AsString       := SQLPendentsACT_PAID_NO.AsString;
     tblPaysACT_PAID_CRR.AsString      := SQLPendentsCURRENCY_TYPE.AsString;
     tblPaysACT_PAID_DATE.AsString     := SQLPendentsACT_PAID_DATE.AsString;
     tblPaysACT_PAID_VALUE.AsCurrency  := GetActPaidValue(SQLPendentsCONTRACT_NO.AsString,
                                                          SQLPendentsACT_PAID_NO.AsString);
     tblPaysSUPPLIER_NO.AsString       := SQLPendentsSUPPLIER_NO.AsString;
     tblPaysSUPPLIER_NAME.AsString     := GetSupplierName(SQLPendentsSUPPLIER_NO.AsString);
     tblPaysAPPROVER_NAME.AsString     := GetEmployeeName(SQLPendentsAPPROVED_BY.AsString,True);
     tblPaysINVOICE_NO.AsString        := '';
     tblPaysINVOICE_DATE.AsString      := '';
     tblPaysINVOICE_RCV_DT.AsString    := DateTimeToDate8(Date);
     tblPaysINVOICE_CRR.AsString       := SQLPendentsCURRENCY_TYPE.AsString;
     tblPaysINVOICE_RT_CRR.AsFloat     := 1;
     tblPaysINVOICE_BANK.AsString      := FDefBankCode;
     tblPaysINVOICE_BANK_ACCT.AsString := FDefBankAccount;
     { The field INVOICE_TYPING_VALUE is a "ghost" field used to input the
       Invoice Value when the method to validate this Value is ivTyping. In
       that case, the user must type the Invoice Value; therefore, the field
       must be initially zero (0). In other case the field is ignored }
     tblPaysINVOICE_TYPING_VALUE.AsCurrency := 0;
End;
Procedure TdmSAQ303002DataModule.GetActPaidItems(AContract,AnActPaid:String);
Begin
     With SQLItmXEle Do Begin
          Try
             Active := False;
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             Active := True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_058,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmSAQ303002DataModule.GetActPaidCategories(AContract,AnActPaid:String);
Begin
     With SQLItmXCat Do Begin
          Try
             Active := False;
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             Active := True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_058,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;
Procedure TdmSAQ303002DataModule.GetActPaidCostCenters(AContract,AnActPaid:String);
Begin
     With SQLCosts Do Begin
          Try
             Active := False;
             If Not Prepared Then Begin
                Prepare;
             End;
             Params[0].AsString := AContract;
             Params[1].AsString := AnActPaid;
             Active := True;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_059,[AnActPaid,AContract,E.Message]);
             End;
          End;
     End;
End;

{ Use this routine to Insert a new Invoice in the Invoice table (SAF3A4).
   Every new invoice corresponds to one Act Paid (and only one). }
Procedure TdmSAQ303002DataModule.InsertNewInvoice;
Begin
     With SQLInsNewInv Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             FPINIContracNo.AsString      := tblPaysCONTRACT_NO.AsString;
             FPINIActPaidNo.AsString      := tblPaysACT_PAID_NO.AsString;
             FPINIPortionNo.AsString      := tblPaysPORTION_NO.AsString;
             FPINIStatus.AsString         := StrStatusOf(asPendent);
             FPINISupplierNo.AsString     := tblPaysSUPPLIER_NO.AsString;
             FPINIAuthsdBy.AsString       := FCurrentUser;
             FPINIAuthDate.AsString       := FCurrentDate;
             FPINIInvoiceNo.AsString      := FCurrentInvoice;
             FPINIInvoiceDate.AsString    := tblPaysINVOICE_DATE.AsString;
             FPINIInvoiceRcvDt.AsString   := tblPaysINVOICE_RCV_DT.AsString;
             FPINIInvoiceCrr.AsString     := tblPaysINVOICE_CRR.AsString;
             FPINIInvoiceRtCrr.AsFloat    := tblPaysINVOICE_RT_CRR.AsFloat;
             FPINIInvoiceValue.AsCurrency := tblPaysINVOICE_VALUE.AsCurrency;
             ExecSQL;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_056,[tblPaysACT_PAID_NO.AsString,
                                                  tblPaysCONTRACT_NO.AsString,
                                                  E.Message]);
             End;
          End;
     End;
End;

Procedure TdmSAQ303002DataModule.SaveInvoiceInActPaid;
Begin
     Try
        dbActPaid.StartTransaction;
        SetActPaidStatus(FCurrentContract,FCurrentActPaid);
        InsertNewInvoice;
        dbActPaid.Commit;
     Except
        On E:Exception Do Begin
           If dbActPaid.InTransaction Then Begin
              dbActPaid.Rollback;
           End;                
           raise Exception.CreateFmt(ME_054,[E.Message]);
        End;
     End;
End;
Procedure TdmSAQ303002DataModule.SetCurrentSaveParams;
Begin
     FCurrentDate     := DateTimeToDate8(Date);
     FCurrentContract := tblPaysCONTRACT_NO.AsString;
     FCurrentActPaid  := tblPaysACT_PAID_NO.AsString;
     FCurrentInvoice  := tblPaysINVOICE_NO.AsString;
     FCurrentRate     := tblPaysINVOICE_RT_CRR.AsFloat;
     FSentOk          := False;
End;
Procedure TdmSAQ303002DataModule.ProcessMIMSResults;
Begin
     DoOnFeedBack(1,SAQ303Processing,FStbLine);
     If FSentOk Then Begin
        SaveInvoiceInActPaid;
     End;
     tblPays.Delete;
End;

{ Use this routine to load the information about MIMS avaliable in the
  registry. Actually, we are using only the path of the Help Directory }
procedure TdmSAQ303002DataModule.LoadRegistryInformation;
Var
   FMIMSRegistry:       TMIMSRegistry;
begin
     FMIMSRegistry := Nil;
     Try
        Try
           FMIMSRegistry        := TMIMSRegistry.Create;
           Application.HelpFile := FMIMSRegistry.HelpDirectory+'\SAQ303.hlp';
        Except
           On E:Exception Do Begin
              ShowMessageFmt(ME_070,[E.Message]);
           End;
        End;
     Finally
        FMIMSRegistry.Free;
     End;
End;

Procedure TdmSAQ303002DataModule.ConnectToBDMIMS;
Begin
     Try
        dbActPaid.Params.Values['USER NAME'] := FOracleUser;
        dbActPaid.Params.Values['PASSWORD']  := FOraclePassword;
        If Not dbActPaid.IsSQLBased Then Begin
           dbActPaid.TransIsolation := tiDirtyRead;
        End;
        dbActPaid.Connected := True;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_028,[0,E.Message]);
           Application.Terminate;
        End;
     End;
     FCurrentUserID := GetMIMSKey(FCurrentUserID,10);
     FCurrentUser   := GetUserEmployeeID(FCurrentUserID);
End;
Procedure TdmSAQ303002DataModule.CreateTemporalTable(ATable:TTable);
Begin
     { Create the table on disk. If already exists, delete it and
       create the table again. We need to use it to avoid "unknow
       field" errors because diferences between program versions }
     With ATable Do Begin
          If Exists Then Begin
             DeleteTable;
          End;
          CreateTable;
          Active := True;
     End;
End;
Procedure TdmSAQ303002DataModule.CreateTableItems;
Begin
     CreateTemporalTable(tblItems);
End;
Procedure TdmSAQ303002DataModule.CreateTableAtax;
Begin
     CreateTemporalTable(tblAtax);
End;
Procedure TdmSAQ303002DataModule.CreateTablePays;
Begin
     With SQLPendents Do Begin
          Try
             { First, Create the table on disk, if it's not exists yet }
             With tblPays Do Begin
                  If Not Exists Then Begin
                     CreateTable;
                  End;
                  { As tblPays is a temporal table using Cache Updates, we
                    guarantee tblPays is initially empty by setting Active
                    to False. This is necessary only if CreateTablePays was
                    called to refresh the list of Act Paids avalaibles }
                  Active := False;
                  { Now, we open tblPays to copy the new records }
                  Active := True;
             End;
             { Now, Copy the records from SQLPendents }
             Active := True;
             While Not EoF Do Begin
                   tblPays.Append;
                   CreatePayRecord;
                   tblPays.Post;
                   Next;
             End;
          Finally
             Active := False;
          End;
     End;
End;
{ Use this routine to init the internal structures used by the system }
Procedure TdmSAQ303002DataModule.InitStructures;
Begin
     LoadUserConfiguration;
     LoadElements;
     CreateTableItems;
     CreateTableAtax;
     GetParamObjectsForSQLInsNewInv;
     GetHandleCodes;
     { Load Atax information }
     GetAtaxCodes;
End;
{ Use this routine to copy in tblPays the list to Act Paids avalaibles
  to invoice }
Procedure TdmSAQ303002DataModule.SearchActPaidsPendents;
Begin
     tblPays.DisableControls;
     Try
        CreateTablePays;
        If tblPays.RecordCount < 1 Then Begin
           raise Exception.Create(MI_009);
        End;
        tblPays.First;
     Finally
        tblPays.EnableControls;
     End;
End;

procedure TdmSAQ303002DataModule.tblPaysACT_PAID_DATEGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
     Text := Date8ToDisplayFormat(Sender.AsString);
end;
Procedure TdmSAQ303002DataModule.CloseTemporalTable(ATable:TTable);
Begin
     With ATable Do Begin
          Try
             If UpdatesPending Then Begin
                CancelUpdates;
             End;
             Active := False;
             If Exists Then Begin
                DeleteTable;
             End;
          Except
             On E:Exception Do Begin
                ShowMessageFmt(ME_164,[Name,E.Message]);
             End;
          End;
     End;
End;
procedure TdmSAQ303002DataModule.dmSAQ303002DataModuleDestroy(
  Sender: TObject);
begin
     FUserConfig.Free;
     FElements.Free;
     FCategoryNames.Free;
     FHandleCodes.Free;
     FMapItem389.Free;
     FAtaxDefs.Free;
     CloseTemporalTable(tblAtax);
     CloseTemporalTable(tblItems);
     CloseTemporalTable(tblPays);
end;
procedure TdmSAQ303002DataModule.tblPaysValidateData;
Var
   InvInvoiceDate:      String;   { Invoice date in inverse format }
   InvoiceCrr:          String;   { Invoice kind of currency }
   ContractCrr:         String;   { Contract kind of currency }
   ChangeRate:          Double;   { Change rate InvoiceCrr - ContractCrr }
begin
     { Validate date fields }
     If Not IsValidDateField(tblPaysINVOICE_DATE) Then Begin
        raise Exception.Create(ME_080);
     End;
     If Not IsValidDateField(tblPaysINVOICE_RCV_DT) Then Begin
        raise Exception.Create(ME_087);
     End;
     If tblPaysINVOICE_RCV_DT.AsString > DateTimeToDate8(Date) Then Begin
        raise Exception.Create(ME_088);
     End;
     If tblPaysINVOICE_DATE.AsString > tblPaysINVOICE_RCV_DT.AsString Then Begin
        raise Exception.Create(ME_085);
     End;
     { Validate currency change }
     InvoiceCrr  := Trim(tblPaysINVOICE_CRR.AsString);
     ContractCrr := Trim(tblPaysACT_PAID_CRR.AsString);
     If InvoiceCrr = '' Then Begin
        raise Exception.Create(ME_086);
     End;
     If InvoiceCrr = ContractCrr Then Begin
        { Check the single case :
          Invoice and Contract have the same currency system }
        If tblPaysINVOICE_RT_CRR.IsNull Then Begin
           tblPaysINVOICE_RT_CRR.AsFloat := 1; End
        Else Begin
           If Abs(tblPaysINVOICE_RT_CRR.AsFloat-1) > Delta Then Begin
              raise Exception.Create(ME_079);
           End;
        End; End
     Else Begin
        { If the rate change is blank, get a value from MSF912 }
        If tblPaysINVOICE_RT_CRR.IsNull Then Begin
           InvInvoiceDate := GetInverseDate(tblPaysINVOICE_DATE.AsString);
           ChangeRate := GetCurrencyRate(InvoiceCrr,ContractCrr,InvInvoiceDate);
           tblPaysINVOICE_RT_CRR.AsFloat := ChangeRate; End
        Else Begin
           { Check if <= 0, Delta is a security factor to avoid precision errors }
           If tblPaysINVOICE_RT_CRR.AsFloat < Delta Then Begin
              raise Exception.Create(ME_089);
           End;
        End;
     End;
     { Validate Invoice Value }
     If UserConfig.InvValidation = ivTyping Then Begin
        If Abs(tblPaysINVOICE_TYPING_VALUE.AsCurrency -
               tblPaysINVOICE_VALUE.AsCurrency) > 0.01 Then Begin
           raise Exception.Create(ME_121);
        End;
     End;
End;
procedure TdmSAQ303002DataModule.tblPaysBeforePost(DataSet: TDataSet);
begin
     If tblPays.State = dsEdit Then Begin
        If Trim(tblPaysINVOICE_NO.AsString) = '' Then Begin
           tblPaysINVOICE_NO.AsString := ''; End
        Else Begin
           tblPaysValidateData;
        End;
     End;
end;

procedure TdmSAQ303002DataModule.dmSAQ303002DataModuleCreate(
  Sender: TObject);
begin
     FEnabledInsert := False;
     FUserConfig    := TUserConfig.Create;
     FElements      := TElementList.Create;
     FAtaxDefs      := TStringList.Create;
     FMapItem389    := TStringList.Create;
     FCategoryNames := TCstmCtgNms.Create;
     FHandleCodes   := TStringList.Create;
     FCategoryNames.Sorted := True;
     FHandleCodes.Sorted := True;
     LoadRegistryInformation;
end;

procedure TdmSAQ303002DataModule.tblItemsBeforeInsert(DataSet: TDataSet);
begin
     If Not CanInsert Then Begin
        Abort;
     End;
end;

procedure TdmSAQ303002DataModule.tblAtaxBeforeInsert(DataSet: TDataSet);
begin
     If tblAtax.RecordCount >= MSM26JALines Then Begin
        Abort;
     End;
end;

procedure TdmSAQ303002DataModule.tblItemsNewRecord(DataSet: TDataSet);
begin
     tblItemsATAX_VIEW.AsBoolean := False;
     FOldElementNo  := '';
     FOldCategoryNo := '';
end;

procedure TdmSAQ303002DataModule.tblPaysINVOICE_HANDLE_CODESetText(
  Sender: TField; const Text: String);
begin
     tblPaysINVOICE_HANDLE_CODE.AsString := Trim(Copy(Text,1,2));
end;

procedure TdmSAQ303002DataModule.tblAtaxATAX_RATEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
     Try
        Text := Format('%5.2f',[Sender.AsFloat]);
     Except
        Text := '0.0';
     End;
end;

procedure TdmSAQ303002DataModule.tblPaysINVOICE_DATESetText(Sender: TField;
  const Text: String);
begin
     Try
        { This is necessary because MIMS use its screen date fields in two ways:
          The user can typed directly the date in format 8; or he (or she) can
          use the local date format }
        If IsInFormat8(Text) Then Begin
           Sender.AsString := Text; End
        Else Begin
           Sender.AsString := DateTimeToDate8(StrToDate(Text));
        End;
     Except
        Sender.Clear;
     End;
end;

procedure TdmSAQ303002DataModule.tblPaysINVOICE_HANDLE_CODEGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
Var
   HCIndex:             Integer;
   HCValue:             String;
begin
     Text := '';
     Try
        HCValue := tblPaysINVOICE_HANDLE_CODE.AsString;
        HCIndex := 0;
        While HCIndex < HandleCodes.Count Do Begin
              If Copy(HandleCodes[HCIndex],1,2) = HCValue Then Begin
                 Text    := HandleCodes[HCIndex];
                 HCIndex := HandleCodes.Count;
              End;
              Inc(HCIndex);
        End;
     Except
        On Exception Do Text := '';
     End;
end;
{ Use this event to calculate ELEMENT_DESC-CATEGORY_DESC;but, only when the user
  is modifying items (EnabledInsert is Off) and there is a change in connection
  to the original ElementNo or CategoryNo. Note the following, the most logical
  action is to have ELEMENT_DESC and CATEGORY_DESC as calculate fields; we didn't
  use that solution because in the original version we didn't have the base for
  it: we had an unexpected change in the original specification for the application
  and because lack of time the current solution was the best; however, to the
  future, the best is to change this solution}
procedure TdmSAQ303002DataModule.tblItemsBeforePost(DataSet: TDataSet);
Var
   ElementNo:           String;
   CategoryNo:          String;
   ElementName:         String;
   CategoryName:        String;
begin
     If (Not EnabledInsert) And CanModify Then Begin
        ElementNo    := tblItemsELEMENT_NO.AsString;
        CategoryNo   := tblItemsCATEGORY_NO.AsString;
        If (ElementNo <> FOldElementNo) Or (CategoryNo <> FOldCategoryNo) Then Begin
           ElementName  := GetElementNameFor(ElementNo);
           CategoryName := GetCategoryNameFor(ElementNo,CategoryNo);
           tblItemsELEMENT_DESC.AsString  := ElementName;
           tblItemsCATEGORY_DESC.AsString := CategoryName;
        End;
     End;
end;

procedure TdmSAQ303002DataModule.tblItemsBeforeEdit(DataSet: TDataSet);
begin
     FOldElementNo  := '';
     FOldCategoryNo := '';
end;

procedure TdmSAQ303002DataModule.tblAtaxATAX_CODEChange(Sender: TField);
Var
   AtaxLine:            String;
   AtaxIndex:           Integer;
begin
     AtaxIndex := AtaxDefs.IndexOf(tblAtaxATAX_CODE.AsString);
     If AtaxIndex>=0 Then Begin
        With AtaxDefs.Objects[AtaxIndex] As TAtaxDfntn Do Begin
             tblAtaxATAX_RATE.AsString := FloatToStr(Percent);
             tblAtaxATAX_DESC.AsString := Description;
        End;
     End;
end;

End.

