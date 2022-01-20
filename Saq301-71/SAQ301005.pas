unit SAQ301005;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, Buttons, Grids, DBGrids, Db, DBCtrls, Gauges,
  ComCtrls, MCTypes,
  {ValuationsService, RefCodesService, ContractCostingService,
  SOAPHTTPClient,Rio,}
  MCObjcts;

type
  TfrmSAQ301005ActPaid = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnHelp: TSpeedButton;
    BtnCancel: TSpeedButton;
    BtnSave: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PnlGeneral: TPanel;
    Label6: TLabel;
    PnlSupplierCode: TPanel;
    PnlSupplierName: TPanel;
    Label7: TLabel;
    PnlContractDescription: TPanel;
    Label8: TLabel;
    PnlStatus: TPanel;
    Label9: TLabel;
    PnlDate: TPanel;
    LblCKindOfValue: TLabel;
    PnlContractValue: TPanel;
    Label11: TLabel;
    PnlContractPaid: TPanel;
    Label12: TLabel;
    PnlCntProgress: TPanel;
    Label13: TLabel;
    PnlContractTime: TPanel;
    Label14: TLabel;
    PnlCntWorkTime: TPanel;
    Label15: TLabel;
    PnlRemainTime: TPanel;
    Label16: TLabel;
    PnlSContractDate: TPanel;
    Label17: TLabel;
    PnlFContractDate: TPanel;
    Panel5: TPanel;
    navCategories: TDBNavigator;
    GrdDetail: TDBGrid;
    Label18: TLabel;
    CmbElements: TComboBox;
    BtnCostCenters: TSpeedButton;
    Label19: TLabel;
    PnlMonetaryUnit: TPanel;
    Label20: TLabel;
    PnlValue: TPanel;
    PnlActPaid: TPanel;
    PnlContract: TPanel;
    PnlPortion: TPanel;
    stbActPaid: TStatusBar;
    PgGeneral: TPageControl;
    TabContract: TTabSheet;
    TabPortion: TTabSheet;
    LblPKindOfValue: TLabel;
    Label5: TLabel;
    Label21: TLabel;
    PnlPortionValue: TPanel;
    PnlPortionTime: TPanel;
    PnlSPortionDate: TPanel;
    Label22: TLabel;
    PnlPortionPaid: TPanel;
    Label23: TLabel;
    PnlPrtWorkTime: TPanel;
    Label24: TLabel;
    PnlFPortionDate: TPanel;
    PnlPrtProgress: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    PnlPrtRemainTime: TPanel;
    TabComments: TTabSheet;
    PnlGauge: TPanel;
    GgeProgress: TGauge;
    MmComments: TMemo;
    TabInvInfoPaids: TTabSheet;
    Label4: TLabel;
    CmbCurrency: TComboBox;
    TabOptions: TTabSheet;
    LblComments: TLabel;
    CmbTypeComments: TComboBox;
    CbPrintExt01: TCheckBox;
    Label28: TLabel;
    dtpPeriodFrom: TDateTimePicker;
    Label29: TLabel;
    dtpPeriodTo: TDateTimePicker;
    PnlInvCurrency: TPanel;
    PnlPeriodFrom: TPanel;
    PnlPeriodTo: TPanel;
    TabElePercents: TTabSheet;
    PnlElePercents: TPanel;
    CmbElePercents: TComboBox;
    hdElePercents: THeaderControl;
    LbElePercents: TListBox;
    GrbChangeRate: TGroupBox;
    Label27: TLabel;
    EdtChangeRateDt: TEdit;
    dtpChangeRateDt: TDateTimePicker;
    Label30: TLabel;
    PnlChangeRate: TPanel;
    RbByDate: TRadioButton;
    RbByDeal: TRadioButton;
    Label10: TLabel;
    EdtChangeRate: TEdit;
    GrbTax: TGroupBox;
    CbAPInfoAtax: TCheckBox;
    BtnAPInfoAtax: TButton;
    PnlSearch: TPanel;
    LblSearch: TLabel;
    EdtSearchText: TEdit;
    BtnFindFirst: TSpeedButton;
    BtnFindNext: TSpeedButton;
    BtnAprobar: TSpeedButton;
    procedure BtnCostCentersClick(Sender: TObject);
    procedure ValidateAllCC;
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure CmbElementsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure CmbTypeCommentsChange(Sender: TObject);
    procedure CbPrintExt01Click(Sender: TObject);
    procedure CbAPInfoAtaxClick(Sender: TObject);
    procedure BtnAPInfoAtaxClick(Sender: TObject);
    procedure dtpChangeRateDtEnter(Sender: TObject);
    procedure dtpChangeRateDtCloseUp(Sender: TObject);
    procedure CmbCurrencyExit(Sender: TObject);
    procedure dtpPeriodFromEnter(Sender: TObject);
    procedure dtpPeriodToEnter(Sender: TObject);
    procedure dtpPeriodToCloseUp(Sender: TObject);
    procedure dtpPeriodFromCloseUp(Sender: TObject);
    procedure PnlElePercentsResize(Sender: TObject);
    procedure hdElePercentsSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure CmbElePercentsChange(Sender: TObject);
    procedure LbElePercentsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure TabElePercentsEnter(Sender: TObject);
    procedure PgGeneralChange(Sender: TObject);
    procedure RbByDealClick(Sender: TObject);
    procedure RbByDateClick(Sender: TObject);
    procedure PnlSearchResize(Sender: TObject);
    procedure BtnFindFirstClick(Sender: TObject);
    procedure BtnFindNextClick(Sender: TObject);
    procedure GrdDetailTitleClick(Column: TColumn);
    procedure EdtChangeRateExit(Sender: TObject);
    procedure BtnAprobarClick(Sender: TObject);
    //procedure btnCreateValnClick(Sender: TObject);
    //function CreateValuation: String;
    //function CreateRefCode(ValnNo : String): boolean;
    //function CreateValnItems(ValnNo, ElementNo : String): boolean;
    //function CreateCostingAllocation(ValnNo, ElementNo : String) : boolean;
    //function DeleteValn(AValnNo : String): boolean;
  private
    { Private declarations }
    FActPaidReadOnly:   Boolean;
    FPeriodFrom:        String;     { Initial Period Date in MIMS format }
    FPeriodTo:          String;     { Final Period Date in MIMS format }
    FFinalDate:         String;       {Final Portion Date}
    FCntCurrency:       String;   { Currency to be used in the Contract }
    FInvChangeRateDt:   String;     { Date used to calculate InvChangeRate }
    FInvCurrency:       String;     { Currency to be used in the Invoice }
    FInvChangeRate:     Double;     { Change rate to be used in the Invoice }
    FSavingDocument:    Boolean;    { Flag to check if the system started to save in BD }
    FDetailOrder:       TDetailOrder;{ Display Order for the Detail categories of the Element }
    FieldServiceList: TStringList;
    FCurrentXmlns: String;
    FCCPositives:       TCCSummaryList; { Cost Centers of Positive Elements }
    FCCNegatives:       TCCSummaryList; { Cost Centers of Negative Elements }
    TotalNegativeValue: Currency;
    TotalPositiveValue: Currency;    
    Function GetStandardChangeRate(ADate:TDate):Double;
    Procedure ShowProgress(Sender:TObject);
    Procedure ShowActPaidEditedValue(Sender:TObject);
    Procedure SetActPaidReadOnly(AValue:Boolean);
    procedure SetDetailOrder(ADetailOrder:TDetailOrder);
    Procedure SetDetailIndex(AValue:String);
    procedure LoadCostCenterDistribution;
    procedure FillCmbElements;
    procedure FillCmbElePercents;
    procedure ChngRtDisable;
    procedure ChngRtByDeal;
    procedure ChngRtByDate;
    procedure LoadActPaidData;
    Procedure GetCurrencyInformation;
    procedure ValidateActPaidPeriod;
    procedure ValidateJuvinao;
    procedure SaveEditions;
    Procedure SetPeriodDate(AControl:TDateTimePicker;APanel:TPanel;AMIMSDate:String);
    procedure GetDrawZone(AnIndex:Integer;Var ADrawZone:TRect);
    procedure ClearObjectsOf(AList:TStrings);
    procedure DisplayElementsByPercent;
    procedure HTTPRIO1BeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    Function SetAuthenticationHeader(var SOAPRequest : WideString):String;
    Function SetFormatDateMMDDYYYY(actualDate : String) : String;
    //procedure GetPositivesAndNegativeValues;
  public
    { Public declarations }
    Property DetailOrder:TDetailOrder Read FDetailOrder     Write SetDetailOrder;
    Property DetailIndex:String                             Write SetDetailIndex;
    Property ActPaidReadOnly:Boolean  Read FActPaidReadOnly Write SetActPaidReadOnly;
  end;

var
  frmSAQ301005ActPaid: TfrmSAQ301005ActPaid;
  DebeEndosarSW : boolean;

Procedure EditActPaid(AOwner:TComponent);
implementation

uses SAQ301003, MCDMActs, MCUtils, SAQ301006, SAQ301001,
  SAQ301015;

{$R *.DFM}

Procedure EditActPaid(AOwner:TComponent);
Begin
     frmSAQ301005ActPaid := Nil;
     Try
        frmSAQ301005ActPaid := TfrmSAQ301005ActPaid.Create(AOwner);
        if Not dmActs.ApproveAct then
          frmSAQ301005ActPaid.ShowModal;
     Finally
        frmSAQ301005ActPaid.Free;
     End;
End;
Procedure TfrmSAQ301005ActPaid.ShowProgress(Sender:TObject);
Begin
     GgeProgress.AddProgress(1);
End;
Procedure TfrmSAQ301005ActPaid.ShowActPaidEditedValue(Sender:TObject);
begin
     stbActPaid.Panels[2].Text := Format(MI_011,[dmActs.ActPaidNewValue]);
End;

{ Set required controls to enable/disable modifications to the Act }
Procedure TfrmSAQ301005ActPaid.SetActPaidReadOnly(AValue:Boolean);
Begin
     FActPaidReadOnly := AValue;
     If AValue Then Begin
        navCategories.VisibleButtons := BtnReadOnly;
        GrdDetail.Options := GrdDetail.Options + [dgRowSelect]; End
     Else Begin
        navCategories.VisibleButtons := BtnOnlyEdition;
        GrdDetail.Options := GrdDetail.Options - [dgRowSelect];
     End;
     BtnSave.Enabled         := Not AValue;
     CmbTypeComments.Enabled := BtnSave.Enabled;
     CbPrintExt01.Enabled    := BtnSave.Enabled;
End;
{ Set the display order for the details categories of the selected element }
procedure  TfrmSAQ301005ActPaid.SetDetailOrder(ADetailOrder:TDetailOrder);
Begin
     If FDetailOrder <> ADetailOrder Then Begin
        FDetailOrder := ADetailOrder;
        CmbElementsClick(Nil);
     End;
End;
{dbermudez - validate Percent after save an act}
procedure TfrmSAQ301005ActPaid.ValidateAllCC;
Var
   Node:                TEleNoEleCode;{ Definition of the current element }
   ElementCode:         String;
   ElementName:         String;
   ByGroup:             Boolean;
   Percent:             Integer;
   i:                   Integer;
begin
     If CmbElements.ItemIndex >= 0 Then Begin
        For i := 0 to CmbElements.Items.Count - 1 do begin
          Node := CmbElements.Items.Objects[i] As TEleNoEleCode;
          ElementCode := Node.Element.ElementCode;
          ElementName := Node.Element.ElementName;
          ByGroup     := dmActs.EleNoEleCodes.HasGroup(ElementCode);
          With dmActs,CurrentActPaid Do Begin
               ActPaidElement := Node.ElementNo;
               SetCostCentersRangeForDisplay(ActPaidContract,
                                             ActPaidCode,
                                             ActPaidElement);
               Percent  := dmActs.GetTotalPercentAssigned;
               If Percent < 10000 Then Begin
                  raise Exception.CreateFmt('AE046: Se debe asignar exactamente el 100 por ciento. Los '+
                      'porcentajes asignados suman %d.%2.2d en el elemento %s - %s',
                      [Percent Div 100,Percent Mod 100,ElementCode,ElementName]);
               End;
          End;
        End;
     End;
end;

 {
procedure TfrmSAQ301005ActPaid.SetCCDistributionForAllTheGroup;
Begin
End;     }
{ Edit the Cost Centers distribution for the current element (the one selected
  in the Combo Box CmbElements ).
  Before the edition, check if the ElementNo is a member of a group associated
  to one only Element Code, if so, then edit not the distribution of the
  element but the distribution of the group, the one corresponding to
  element base in the group (the element with the less Element No) by
  setting ActPaidElement to this Element No.
  After the edition, in the "group" case, copy the distribution of the
  element base to the other elements in the group. ( The implementation
  is stopped and probably won't be do because it's necessary only for
  a temporal trouble of client)  }
procedure TfrmSAQ301005ActPaid.BtnCostCentersClick(Sender: TObject);
Var
   Node:                TEleNoEleCode;{ Definition of the current element }
   ElementCode:         String;
   ByGroup:             Boolean;
begin
     If CmbElements.ItemIndex >= 0 Then Begin
        Node := CmbElements.Items.Objects[CmbElements.ItemIndex] As TEleNoEleCode;
        ElementCode := Node.Element.ElementCode;
        ByGroup     := dmActs.EleNoEleCodes.HasGroup(ElementCode);
        With dmActs,CurrentActPaid Do Begin
            { If ByGroup Then Begin
                ActPaidElement := EleNoEleCodes.ElementNoBase[ElementCode]; End
             Else Begin
                ActPaidElement := Node.ElementNo;
             End;    }
             ActPaidElement := Node.ElementNo;
             SetCostCentersRangeForDisplay(ActPaidContract,
                                           ActPaidCode,
                                           ActPaidElement);
        End;
        dmActs.EditMode := BtnSave.Enabled;
        Try
           dmActs.LoadingActPaid := False;
           EditCostCenters(Self,ActPaidReadOnly);
        Finally
           dmActs.LoadingActPaid := True;
        End;
        {If ByGroup Then Begin
           SetCCDistributionForAllTheGroup;
        End; }
     End;
end;
{ Use this routine to load the default cost center distribution for the
  current element }
procedure TfrmSAQ301005ActPaid.LoadCostCenterDistribution;
Begin
     With dmActs,CurrentActPaid Do Begin
          { Set the range in tblCosts to include only Cost Centers for the
            current element }
            SetCostCentersRangeForDisplay2(ActPaidContract,ActPaidCode,ActPaidElement);
          { Use a default distribution ONLY if the distribution is by percent.
            Rolando Celedón 2003-06-19
            Also check if it's the first time that we are editing because
            it's now required for the distribution by value }
          If (UserConfig.DCCTypeDstrb = cctdPercent) Or NewAct Then Begin
             { Check if there is, at least, a cost center assigned to the element,
               if don't exist, then load the default cost centers }
             tblCosts.First;
             If tblCostsELEMENT_NO.IsNull Or
                (tblCostsELEMENT_NO.AsString <> ActPaidElement) Then Begin
                { Get the Cost Center default distribution, according to the
                  user preference. The flag DefaultLoading is turn on to
                  disable some usual validations because they don't apply
                  when we are loading default values }
                Try
                   DefaultLoading := True;
                   Case UserConfig.DCCDefaultDstrb Of
                   ccddContract : DefaultCostCenterFromContract;
                   ccddCurrent  : DefaultCostCenterFromCurrent;
                   End;
                Finally
                   DefaultLoading := False;
                End;
             End;
          End;
     End;
End;
{ Use this routine to Fill CmbElements with the elements of the current Act.
  The routine has an additional function : To load the default cost center
  for each element, if it doesn't has cost centers assigned }
procedure TfrmSAQ301005ActPaid.FillCmbElements;
Var
   Node:                TElementDef;{ Definition of the current element }
   EleNoEleCode:        TEleNoEleCode; { Link from Element No to its Element Code }
   CrrEleVal:           TElementVal;{ Values of the current element }
   ElementPercent:      TElementPercent; { Definition for Elements calcualted by percents }
   TheElementNo:        String;
   TheElementCode:      String;
   j: integer;
Begin
     With dmActs,SQLCntPrtEle Do Begin
          Try
             MustShowWarning := True;
             ElementValues.ClearAndFree;
             EleNoEleCodes.Clear;
             While Not EoF Do Begin
                   Node := Elements.DefinitionOf[(trim(SQLCntPrtEleELEMENT_CODE.AsString))];
                   If Not Assigned(Node) Then Begin
                      raise Exception.CreateFmt(ME_017,[SQLCntPrtEleELEMENT_NO.AsString,
                                                        SQLCntPrtEleELEMENT_CODE.AsString]);
                   End;
                   { Add the element and its definitions to the Act }
                   TheElementNo := SQLCntPrtEleELEMENT_NO.AsString;
                   TheElementCode := SQLCntPrtEleELEMENT_CODE.AsString;
                   CrrEleVal               := TElementVal.Create;
                   CrrEleVal.ElementNo     := TheElementNo;
                   CrrEleVal.ElementValCnt := SQLCntPrtEleELEMENT_VAL.AsCurrency;
                   EleNoEleCode            := TEleNoEleCode.Create;
                   EleNoEleCode.ElementNo  := TheElementNo;
                   EleNoEleCode.Element    := Node;
                   ElementValues.AddObject(TheElementNo,CrrEleVal);
                   EleNoEleCodes.AddObject(TheElementNo,EleNoEleCode);
                   {dbermudez - begin new code 10/10/2016}                   
                   If Not CrrEleNoDef.IsPercent[TheElementNo + TheElementCode] Then Begin
                   {dbermudez - end new code 10/10/2016}
                   {dbermudez - begin old code 10/10/2016}
                   //If Not ( CrrEleNoDef.IsPercent[Trim(TheElementNo)] Or
                   //         CrrEleNoDef.IsPercent[Trim(TheElementCode)]
                   //)Then Begin
                   {dbermudez - end old code 10/10/2016}
                      { Insert in the combo box of elements  }
                      With CurrentActPaid,EleNoEleCode Do Begin
                           ActPaidElement := TheElementNo;
                           CmbElements.Items.AddObject(ElementNoName,EleNoEleCode);
                      End;
                      { Now, if it's necessary, load the default cost centers }
                      LoadCostCenterDistribution;
                   End;
                   Next;
             End;
          Finally
             Active := False;
          End;
     End;
End;
{ Use this routine to Fill CmbElePercents with the elements "calculated by
  percent" of the current Act. }
procedure TfrmSAQ301005ActPaid.FillCmbElePercents;
Var
   ElementPercent:      TElementPercent; { Definition for Elements calcualted by percents }
   ListIndex:           Integer;
Begin
     ListIndex := 0;
     While ListIndex < dmActs.EleXPercent.Count Do Begin
           ElementPercent := dmActs.EleXPercent.ElementAt[ListIndex];
           CmbElePercents.Items.AddObject(ElementPercent.ElementName,
                                          ElementPercent);
           Inc(ListIndex);
     End;
     If dmActs.EleXPercent.Count > 0 Then Begin
        CmbElePercents.ItemIndex := 0;
        CmbElePercentsChange(Nil);
     End;
End;
procedure TfrmSAQ301005ActPaid.ChngRtDisable;
Begin
     EdtChangeRateDt.Enabled := False;
     dtpChangeRateDt.Enabled := False;
     EdtChangeRate.Enabled   := False;
     RbByDate.Enabled        := False;
     RbByDeal.Enabled        := False;
     EdtChangeRate.Text      := '';
     EdtChangeRateDt.Text    := '';
     PnlChangeRate.Caption   := '';
End;
procedure TfrmSAQ301005ActPaid.ChngRtByDeal;
Begin
     EdtChangeRateDt.Enabled := False;
     dtpChangeRateDt.Enabled := False;
     EdtChangeRate.Enabled   := True;
     RbByDate.Enabled        := True;
     RbByDeal.Enabled        := True;
     RbByDeal.Checked        := True;
     EdtChangeRate.Text      := FloatToStr(FInvChangeRate);
     EdtChangeRateDt.Text    := '';
     PnlChangeRate.Caption   := '';
End;
procedure TfrmSAQ301005ActPaid.ChngRtByDate;
Var
   OriInvChangeRateDt:  String;
Begin
     OriInvChangeRateDt      := FInvChangeRateDt;
     EdtChangeRateDt.Enabled := True;
     dtpChangeRateDt.Enabled := True;
     EdtChangeRate.Enabled   := False;
     RbByDate.Enabled        := True;
     RbByDeal.Enabled        := True;
     RbByDate.Checked        := True;
     dtpChangeRateDt.Date    := Date8ToDateTime(OriInvChangeRateDt);
     dtpChangeRateDtCloseUp(Self);
End;
procedure TfrmSAQ301005ActPaid.LoadActPaidData;
Var
   Node:                TEleNoEleCode;{ Definition of the current element }
   Administrator:       String;     { Employee ID of the main ADC }
   Approver:            String;     { Employee ID of the user approver }
   ApproveDate:         String;     { Approve date of the Act }
   CntStartDate:        String;     { Date of the contract start (format 8) }
   CntFinalDate:        String;     { Date of the contract finalization (format 8) }
   ContractPaid:        Currency;   { Total Acts Paid for the contract }
   ContractPercent:     Double;     { ContractPaid Percent }
   PrtStartDate:        String;     { Date of the portion start (format 8) }
   PrtFinalDate:        String;     { Date of the portion finalization (format 8) }
   PortionPaid:         Currency;   { Total Acts Paid for the portion }
   PortionPercent:      Double;     { PortionPaid Percent }
   ValorRaro:           Currency;
   CanCreateValn:       boolean;
   errorMessage:       String;
begin
     With dmActs,CurrentActPaid Do Begin
          GetActPaidExt(ActPaidContract,ActPaidCode,
                        Administrator,Approver,ApproveDate,
                        PortionPaid,ContractPaid,
                        FInvCurrency,FInvChangeRateDt,FInvChangeRate,
                        FPeriodFrom,FPeriodTo);
          { Set the user preferences for the document }
          CmbTypeComments.ItemIndex := Ord(UserConfig.DTypeComments);
          CbAPInfoAtax.Checked      := UserConfig.DAPInfoAtax = apiaYes;
          CbPrintExt01.Checked      := UserConfig.DTypeCntrctExt = tcePrintExt;
          TabComments.TabVisible    := UserConfig.DTypeComments <> tcNone;
          If TabComments.TabVisible Then Begin
             OpenComments;
             MmComments.Lines.Assign(SQLCommentsACT_COMMENTS);
          End;
          PgGeneral.ActivePage := TabContract;
          {2004-04-20 Cambio TabContract por TabPortion}
          PgGeneral.ActivePage := TabPortion;
          { Get the contract currency type. This is an special case :
            The contracts use ONE only kind of currency, this kind is stored
            in the LIQ_DAM_BASE field in MSF385 (i.e it's repeated for each
            Portion). This strange scheme is because MIMS don't have an avalaible
            field in MSF384 for a second currency type. The original MIMS
            CURRENCY_TYPE field in MSF384 was intended to be the contract
            currency type; but, It's really used to store the invoice currency
            type }
          FCntCurrency := SQLPortionLIQ_DAM_BASE.AsString;
          { Set fields on the tab sheet TabInvInfoPaids }
          CmbCurrency.Text       := FInvCurrency;
          PnlInvCurrency.Caption := FInvCurrency;
          If FCntCurrency = FInvCurrency Then Begin
             { Same currency, Not Change Rate }
             ChngRtDisable;End
          Else Begin
             If StrToIntDef(FInvChangeRateDt,0) < 1 Then Begin
                { Change Rate Date = 0, then Change Rate is by Deal }
                ChngRtByDeal; End
             Else Begin
                { Exist Change Rate Date, then Change Rate is by Date }
                ChngRtByDate;
             End;
          End;
          if Not BtnSave.Enabled then begin
             RbByDate.Enabled      := False;
             RbByDeal.Enabled      := False;
             EdtChangeRate.Enabled := False;
          end;

          { Set fields of the Act Paid Period }
          SetPeriodDate(dtpPeriodFrom,PnlPeriodFrom,FPeriodFrom);
          SetPeriodDate(dtpPeriodTo,PnlPeriodTo,FPeriodTo);
          { Get the Contract Values }
          If Not (ActPaidStatus In [asNull,asApproved,asCounted,asInvoiced,asClosed]) Then Begin
             ContractPaid := GetPaidsToContract(ActPaidContract);
             PortionPaid  := GetPaidsToPortion(ActPaidContract,ActPaidPortion);
          End;

          {David Bermudez}
          {CanCreateValn := dmActs.GetValuationAuth('APCV');
          If (ActPaidStatus In [asApproved]) Then begin
             btnCreateValn.Enabled := CanCreateValn;
          end
          else begin
             btnCreateValn.Enabled := False;
          End;}

          {2004-04-01 De Moya Recalculo el ContractPaid de acuerdo con lo sugerido
          por el cliente}
          With dmacts.SQLRestaValor Do Begin
              Try
                  Active:=False;
                  Params[0].AsString:=ActPaidContract;
                  Params[1].AsString:=ActPaidCode;
                  Params[2].AsString:=ActPaidPortion;
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
             ContractPaid := 0
          else
             ContractPaid:=dmacts.SQLRestaValor.Fields[0].AsFloat;
          {De Moya 2004-04-23 Si el valor del acta es negativo el valor del
          ContractPaid será disminuido en el valor del acta}

          {2004-03-30 De Moya. Incluyo lectura de la PortionPaid independiente
          del estado.  El cliente indica que antes no salia este error, pero el
          código inmediatamente anterior indica que leía la variable sólo en
          algunos estados}
          {ContractPaid := GetPaidsToContract(ActPaidContract);
          PortionPaid := GetPaidsToPortion(ActPaidContract,ActPaidPortion);}
          GetContractRange(CntStartDate,CntFinalDate);
          { Get the Portion Values }
          GetPortionRange(PrtStartDate,PrtFinalDate);
          {2004-03-31 De Moya.  Cambio en la forma de calcular el porcentaje de
          avance}
          {PortionPercent := 100*(PortionPaid/SQLPortionPORTION_VAL.AsCurrency);}
          if (SQLPortionLIQ_DAM_LIMIT.AsFloat > 0) then
            PortionPercent := 100*(PortionPaid/SQLPortionLIQ_DAM_LIMIT.AsCurrency)
          else
            PortionPercent := 0;
          { Act Paid definition }
          PnlActPaid.Caption  := ActPaidCode;
          PnlContract.Caption := ActPaidContract;
          PnlPortion.Caption  := ActPaidPortion;
          //PnlValnNo.Caption := ActPaidValnNo;
          { Act Paid Values }
          PnlDate.Caption     := Date8ToDisplayFormat(ActPaidDate);
          ActPaidValue        := GetActPaidValue(ActPaidContract,ActPaidCode);
          PnlValue.Caption    := Format('%m',[ActPaidValue]);
          PnlStatus.Caption   := StatusNames[ActPaidStatus];
          PnlSupplierCode.Caption := SQLContractSUPPLIER_NO.AsString;
          PnlSupplierName.Caption := GetSupplierName(PnlSupplierCode.Caption);
          PnlMonetaryUnit.Caption := SQLPortionLIQ_DAM_BASE.AsString;
          PnlContractDescription.Caption := SQLContractCONTRACT_DESC.AsString;
          { Display Contract Values }
          {De Moya 2002-12-06 Cambio temporal "=" por "<>", dado que todos los
          PERF_GTEE son cero y producen invalid float operation}
          If UserConfig.ActValidation <> AVnone Then Begin
             { If there is not budget control, take the signed contract value }
             ContractPercent          := 100*(ContractPaid/SQLContractPERF_GTEE_VAL.AsCurrency);
             PnlContractValue.Caption := Format('%m',[SQLContractPERF_GTEE_VAL.AsCurrency]);
             LblCKindOfValue.Caption  := MI_019 + MI_018; End
          Else Begin
             { In other case, take the contract budget value }
             ContractPercent          := 100*(ContractPaid/SQLContractCONTRACT_VAL.AsCurrency);
             PnlContractValue.Caption := Format('%m',[SQLContractCONTRACT_VAL.AsCurrency]);
             LblCKindOfValue.Caption  := MI_019 + MI_017;
          End;
          PnlContractPaid.Caption  := Format('%m',[ContractPaid]);
          PnlCntProgress.Caption   := Format('%5.2f',[ContractPercent])+' %';
          PnlContractTime.Caption  := GetMDTimeElapsed(CntStartDate,CntFinalDate);
          PnlCntWorkTime.Caption   := GetMDTimeElapsed(CntStartDate,ActPaidDate);
          PnlRemainTime.Caption    := GetMDTimeElapsed(ActPaidDate,CntFinalDate);
          PnlSContractDate.Caption := Date8ToDisplayFormat(CntStartDate);
          PnlFContractDate.Caption := Date8ToDisplayFormat(CntFinalDate);
          { Display Portion Values }
          If UserConfig.ActValidation = avNone Then Begin
             { If there is not budget control, take the signed contract value }
             PnlPortionValue.Caption  := Format('%m',[SQLPortionLIQ_DAM_LIMIT.AsCurrency]); End
          Else Begin
             { In other case, take the contract budget value }
             PnlPortionValue.Caption  := Format('%m',[SQLPortionPORTION_VAL.AsCurrency]);
          End;
          LblPKindOfValue.Caption  := LblCKindOfValue.Caption;
          {2004-04-01 De Moya Recalculo el PortionPaid de acuerdo con lo sugerido
          por el cliente}
          With dmacts.SQLRestaValor Do Begin
              Try
                  Active:=False;
                  Params[0].AsString:=ActPaidContract;
                  Params[1].AsString:=ActPaidCode;
                  Params[2].AsString:=ActPaidPortion;
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
             PortionPaid := 0
          else
             PortionPaid:=dmacts.SQLRestaValor.Fields[0].AsFloat;

          PnlPortionPaid.Caption   := Format('%m',[PortionPaid]);
          //PortionPercent := 100*(PortionPaid/SQLPortionLIQ_DAM_LIMIT.AsCurrency);
          if (SQLPortionLIQ_DAM_LIMIT.AsFloat > 0) then
            PortionPercent := 100*(PortionPaid/SQLPortionLIQ_DAM_LIMIT.AsCurrency)
          else
            PortionPercent := 0;
          PnlPrtProgress.Caption   := Format('%5.2f',[PortionPercent])+' %';
          PnlPortionTime.Caption   := GetMDTimeElapsed(PrtStartDate,PrtFinalDate);
          PnlPrtWorkTime.Caption   := GetMDTimeElapsed(PrtStartDate,ActPaidDate);
          PnlPrtRemainTime.Caption := GetMDTimeElapsed(ActPaidDate,PrtFinalDate);
          PnlSPortionDate.Caption  := Date8ToDisplayFormat(PrtStartDate);
          PnlFPortionDate.Caption  := Date8ToDisplayFormat(PrtFinalDate);
          FFinalDate := PrtFinalDate;
          { Clear temporal tables }
          ClearTemporalTable(tblDetail);
          With tblCosts Do Begin
               If UpdatesPending Then Begin
                  CancelUpdates;
               End;
          End;
          ClearTemporalTable(tblInfoAtax);
          { Load Details }
          stbActPaid.Panels[2].Text := Format(MI_011,[ActPaidValue]);
          GetActElementsFor(ActPaidContract,ActPaidPortion);
          GetCurrentCostCenters(ActPaidContract,ActPaidPortion);
          { Load Categories }
          GetContractCategories(ActPaidContract,ActPaidPortion);
          SaveCategoriesInMemory;
          GetActCategories(ActPaidContract,ActPaidCode);
          CombineCategories;
          CompleteLoadOfCrrEleNoDef;
          { Fill Combo Box of Elements }
          try
                FillCmbElements;

          Except
                  On E:Exception Do Begin
                     {raise Exception.CreateFmt(ME_011,[' ',E.Message]); }
                     errorMessage := E.Message;
                  End;
          End;
          { Process Elements "calculated by percent". The process has the
            following step :
            1. Create and Init the list of element "calculated by percent"
               (dmActs.EleXPercent)
            2. Make a copy of this list into dmActs.OldEleXPrc, this is the
               list of old elements (elements and its categories when the act
               is going to be edited)
            3. Init CmbElePercents with links to EleXPercent
            4. Create into OldEleXPrc a sublist with CC used originally by the
               elements "calculated by percent" }
          CreateListOfElementsByPercent;
          CreateListOfOldElementsByPercent;
          FillCmbElePercents;
          tblCosts.CancelRange;
          dmActs.SetCostCentersRangeForSave(dmActs.CurrentActPaid.ActPaidContract,
                                            dmActs.CurrentActPaid.ActPaidCode);
          CalcCCByPercents(OldEleXPrc);
          { Manage the normal elements }
          ElementsCategoriesToAuxiliaryTable;
          If CmbElements.Items.Count < 1 Then Begin
             raise Exception.Create(ME_018);
          End;
          CmbElements.ItemIndex := 0;
          Node := CmbElements.Items.Objects[0] As TEleNoEleCode;
          tblDetail.CancelRange;
          { Now, calculate the elements by percent }
          GetEditValueOfTheElements;
          CalcElementsByPercent;
          SetDetailValuesForElementsByPercent;
          SetCategoryRangeForDisplay(Node.ElementNo);
          { Load Atax informations }
          GetActPaidInfoAtax(ActPaidContract,ActPaidCode);
          Try
             OnlyAlertOnError := True;
             CreateTemporalAtaxTable;
          Finally
             OnlyAlertOnError := False;
          End;
          { Active optional pages }
          PgGeneral.ActivePage := TabContract;
          {2004-04-20 Cambio TabContract por TabPortion}
          PgGeneral.ActivePage := TabPortion;
          PgGeneral.Refresh;
     End;
end;
procedure TfrmSAQ301005ActPaid.FormCreate(Sender: TObject);
Var
   Index1:              TTypeComments;
   PosAEvaluar, PosEncontrada, Administrator_Id : String;
   //(Jafeth:Creacion de nuevas variables)
   Adm_Id, EnviadoPor, MimsPos:String;
   FStdInvChangeRateDt, InverseCurrentDate : String;
   ValorAVerificar,GetStandarChangeRate            : Real;
   sw_sin_subordinados: boolean;
Begin
     Try
        Try
           FCCPositives := TCCSummaryList.Create;
           FCCNegatives := TCCSummaryList.Create;

           FieldServiceList := TStringList.Create;
           FDetailOrder := doCategoryNo;
           dmActs.CCCList.ClearAndFree;
           stbActPaid.Panels[0].Text := '';
           TabComments.TabVisible := dmActs.UserConfig.TypeComments <> tcNone;
           PgGeneral.ActivePage := TabContract;
          {2004-04-20 Cambio TabContract por TabPortion}
           PgGeneral.ActivePage := TabPortion;
           CmbTypeComments.Clear;
           For Index1 := Low(TTypeComments) To High(TTypeComments) Do Begin
               CmbTypeComments.Items.Add(Prf03Names[Index1]);
           End;
           dmActs.tblDetail.DisableControls;
           dmActs.tblDetail.AfterPost := Nil;
           CmbCurrency.Items.AddStrings(dmActs.CurrencyList);
           ActPaidReadOnly := (dmActs.CurrentActPaid.ActPaidStatus in StatusReadOnly)
                              Or (Not dmActs.CanCreateAct);
           LoadActPaidData;
           TabElePercents.TabVisible := (dmActs.UserConfig.DCCTypeDstrb = cctdPercent) And
                                        (CmbElePercents.Items.Count > 0);
        Finally
           dmActs.tblDetail.EnableControls;
           dmActs.tblDetail.AfterPost := dmActs.tblDetailAfterPost;
           dmActs.OnFeedBack          := ShowActPaidEditedValue;
           ShowActPaidEditedValue(Self);
           dmActs.EnabledInsert       := False;
           {Busca la jerarquía actual en Mims}
           BtnAprobar.Enabled:= False;
           DebeEndosarSw:=False;
           With dmActs.SQLCurrentHier Do Begin
                Try
                   Active:=False;
                   If Not Prepared Then Begin
                      Prepare;
                   End;
                   Active:=True;
                   If Fields[0].IsNull Then Begin
                      raise Exception.Create(ME_010);
                   End;
                Except
                   On E:Exception Do Begin
                      raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                   End;
                End;
           End;
           //showmessage('Jerarquia: '+dmActs.SQLCurrentHier.Fields[0].AsString);
           {Busca la posición del usuario que envía el acta}
           With dmacts.SQLActEnviadoPor Do Begin
                Try
                   Active:=False;
                   Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
                   Params[1].AsString:=dmacts.CurrentActPaid.ActPaidCode;
                   If Not Prepared Then Begin
                      Prepare;
                   End;
                   Active:=True;
                   If Fields[0].IsNull Then Begin
                      raise Exception.Create(ME_010);
                   End;
                Except
                   On E:Exception Do Begin
                      raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                   End;
                End;
           End;
           //showmessage('Enviado Por: '+dmActs.SQLActEnviadoPor.Fields[0].AsString);
           {Aquí debe calcular el valor del acta en dólares}
           //showmessage('Moneda local MSF000_DC001: '+dmActs.SQLGetLocCrr.Fields[0].AsString);
           //showmessage('Moneda de la porcion MSF385: '+dmActs.SQLPortion.Fields[13].AsString);
           //showmessage('Valor del acta: '+dmActs.SQLActValue.Fields[0].AsString);
           {Busca la moneda secundaria del distrito MSF000_DC001.second_currency}
           With dmacts.SQLGetSecCurr Do Begin
                Try
                   Active:=False;
                   Params[0].AsString:=dmActs.CurrentDistrict;
                   If Not Prepared Then Begin
                      Prepare;
                   End;
                   Active:=True;
                   If Fields[0].IsNull Then Begin
                      raise Exception.Create(ME_010);
                   End;
                Except
                   On E:Exception Do Begin
                      raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                   End;
                End;
           End;
           //showmessage('Segunda moneda distrito: '+ dmActs.SQLGetSecCurr.Fields[0].AsString);
           {Busca el tipo tipo de moneda del contrato CURRENCY_TYPE del msf384}
           With dmacts.SQLGetCurrType Do Begin
                Try
                   Active:=False;
                   Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
                   If Not Prepared Then Begin
                      Prepare;
                   End;
                   Active:=True;
                   If Fields[0].IsNull Then Begin
                      raise Exception.Create(ME_010);
                   End;
                Except
                   On E:Exception Do Begin
                      raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                   End;
                End;
           End;
           //showmessage('CURRENCY TYPE msf384: '+ dmActs.SQLGetCurrType.Fields[0].AsString);
           {Busca la tasa de cambio utilizada para el acta en la saf3a0}
           With dmacts.SQLActPaidExt Do Begin
                Try
                   Active:=False;
                   Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
                   Params[1].AsString:=dmacts.CurrentActPaid.ActPaidCode;
                   If Not Prepared Then Begin
                      Prepare;
                   End;
                   Active:=True;
                   If Fields[0].IsNull Then Begin
                      raise Exception.Create(ME_010);
                   End;
                Except
                   On E:Exception Do Begin
                      raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                   End;
                End;
           End;
           {De Moya 2004-02-16 Si la posición del usuario no tiene subordinados
           sale de todo el ciclo}
           sw_sin_subordinados:=false;
           With dmacts.SQLBuscaSub Do Begin
             Try
               Active:=False;
               {Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;}
               Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;
               Params[1].AsString:=dmActs.MimsPosition;
               If Not Prepared Then Begin
                  Prepare;
               End;
               Active:=True;
               If Fields[0].IsNull Then Begin
                  sw_sin_subordinados:=true;
               End;
             Except
                On E:Exception Do Begin
                     {showmessage('excp: '+E.Message);}
                     raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                   End;
             End;
           End;
             //jafeth
            //Administrator_Id:=dmacts.SQLActPaidExt.Fields[0].AsString;
            Administrator_Id:=uppercase(Trim(dmacts.SQLActPaidExt.Fields[0].AsString));
            Adm_Id:=uppercase(Trim(dmActs.CurrentUserId));
            EnviadoPor:=uppercase(Trim(dmacts.SQLActEnviadoPor.Fields[0].AsString));
            MimsPos:= uppercase(Trim( dmActs.MimsPosition));

       //    if (Administrator_Id <> uppercase(dmActs.CurrentUserId)) or
       //       (uppercase(dmacts.SQLActEnviadoPor.Fields[0].AsString)
       //        <> uppercase(dmActs.MimsPosition)) and
       //        (not sw_sin_subordinados) then

           if (Administrator_Id <> Adm_Id) or
              (EnviadoPor <> MimsPos) and
              (not sw_sin_subordinados) then

           begin
           //showmessage('Tasa de cambio saf3a0: '+ dmActs.SQLActPaidExt.Fields[9].AsString);
           {Verifica si la moneda de la porcion es la moneda local del distrito}
           {Hoy}
             if dmActs.SQLPortion.Fields[13].AsString = dmActs.SQLGetLocCrr.Fields[0].AsString then
             begin
               ValorAVerificar:=dmActs.SQLActValue.Fields[0].AsFloat;
               {showmessage('Valor acta en moneda local: '+floattostr(ValoraVerificar));}
             end
             else
             begin
               {Verifica si la moneda de la porcion es la secundaria del distrito}
               if dmActs.SQLPortion.Fields[13].AsString = dmacts.SQLGetSecCurr.Fields[0].AsString then
               begin
                 {showmessage('La moneda de la porcion: '+ dmActs.SQLPortion.Fields[13].AsString +
                 ' es igual a la secundaria: ' + dmacts.SQLGetSecCurr.Fields[0].AsString);}
                 if dmacts.SQLGetCurrType.Fields[0].AsString = dmActs.SQLGetLocCrr.Fields[0].AsString then
                 begin
                   {showmessage('La moneda del contrato: '+ dmActs.SQLGetCurrType.Fields[0].AsString +
                   ' es igual a la primaria: ' + dmacts.SQLGetLocCrr.Fields[0].AsString);}
                   ValorAVerificar:=dmActs.SQLActValue.Fields[0].AsFloat *  dmActs.SQLActPaidExt.Fields[9].AsFloat;
                   {showmessage('Valor acta en moneda secundaria: '+floattostr(ValoraVerificar));}
                 end
                 else
                 begin
                   FStdInvChangeRateDt   := DateTimeToDate8(Date);
                   InverseCurrentDate    := GetInverseDate(FStdInvChangeRateDt);
                   GetStandarChangeRate  := dmActs.GetCurrencyRate
                                        (dmActs.SQLGetLocCrr.Fields[0].AsString,
                                         dmacts.SQLGetCurrType.Fields[0].AsString,
                                         InverseCurrentDate);
                   ValorAVerificar:=dmActs.SQLActValue.Fields[0].AsFloat / GetStandarChangeRate;
                 end;
               end;
             end;
             {Determina los valores mínimo y máximo para el tipo de autoridad
             ACCP en la tabla msf870}
             //showmessage('Distrito: '+dmActs.CurrentDistrict);
             //showmessage('sqlactenviadopor.Fields0: '+ dmActs.sqlactenviadopor.Fields[0].AsString);
             //showmessage('dmActs.MimsPosition: ' + dmActs.MimsPosition);
             if trim(dmActs.sqlactenviadopor.Fields[0].AsString) > ' ' then
             begin
               if (dmActs.sqlactenviadopor.Fields[0].AsString = dmActs.MimsPosition) then
               begin
                  With dmacts.SQLValMinMaxACCP Do Begin
                       Try
                          Active:=False;
                          Params[0].AsString:=dmActs.sqlactenviadopor.Fields[0].AsString;
                          Params[1].AsString:=dmActs.CurrentDistrict;
                          If Not Prepared Then Begin
                             Prepare;
                          End;
                          Active:=True;
                          {De Moya 2006-Jul-06 Comento esta linea para que no aparezca
                          mensaje de error}
                          {If Fields[0].IsNull Then Begin
                             raise Exception.Create(ME_010);
                          End;}
                       Except
                          On E:Exception Do Begin
                             raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                          End;
                       End;
                  End;
               end;
               //Showmessage('Minimo: '+dmacts.SQLValMinMaxACCP.Fields[0].AsString+
               //'Maximo: '+dmacts.SQLValMinMaxACCP.Fields[1].AsString);
               {Verifica si el aprobador es el mismo usuario que la envió y si tiene
               definido en la autoridad ACCP el monto suficiente para aprobar el acta}
               if dmActs.sqlactenviadopor.Fields[0].AsString = dmActs.MimsPosition then
               begin
                  if (dmacts.SQLValMinMaxACCP.Fields[0].AsFloat <= ValorAVerificar) and
                     (dmacts.SQLValMinMaxACCP.Fields[1].AsFloat >= ValorAVerificar) then
                  begin
                    BtnAprobar.Enabled:= True;
                  end;
               end;
               {Si el acta no fue aprobada en el bloque anterior busca en el árbol
               de jerarquías si el usuario está en la línea de aprobación de quien
               envió el acta}
               if (not BtnAprobar.Enabled) and
                  (Trim(dmActs.sqlactenviadopor.Fields[0].AsString) <> Trim(dmActs.MimsPosition)) then
               begin
                  PosEncontrada:='';
                  PosAEvaluar:=dmActs.SQLActEnviadoPor.Fields[0].AsString;
                  while (Trim(dmActs.MimsPosition) <> Trim(PosEncontrada)) and
                        (trim(PosEncontrada) <> 'TOP') do
                  begin
                     With dmacts.SQLBuscaSup Do Begin
                          Try
                             Active:=False;
                             Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;
     {De Moya 2006-08-17 IC794 Coloco trim para que la variable
      PosAEvaluar no tenga espacios en blanco}
                             Params[1].AsString:=trim(PosAEvaluar);
                             If Not Prepared Then Begin
                                Prepare;
                             End;
                             Active:=True;
                             If Fields[0].IsNull Then Begin
                                 break;
                                //dbermudez fix
                                //raise Exception.Create(ME_010);
                             End;
                          Except
                             On E:Exception Do Begin
                                raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                             End;
                          End;
                     End;
                     PosAEvaluar:= dmActs.SQLBuscaSup.Fields[0].AsString;
                     PosEncontrada:= dmActs.SQLBuscaSup.Fields[0].AsString;
                  End;
               end;
               if dmActs.sqlactenviadopor.Fields[0].AsString = dmActs.MimsPosition then
               begin
                 PosEncontrada:=Trim(dmActs.MimsPosition);
               end;
               If (Trim(PosEncontrada) <> 'TOP') and
                  (not BtnAprobar.Enabled) then
               begin
                  {Determina los valores mínimo y máximo para la posicion
                  encontrada y con eltipo de autoridad ACCP en la tabla msf872}
                  //showmessage('Distrito: '+dmActs.CurrentDistrict);
                  //showmessage('PosEncontrada: '+ PosEncontrada);

                  //showmessage('ValorAVerificar: ' + FloatToStr(ValorAVerificar));
                  With dmacts.SQLValMinMaxACCP Do Begin
                       Try
                          Active:=False;
                          Params[0].AsString:=Trim(PosEncontrada);
                          Params[1].AsString:=dmActs.CurrentDistrict;
                          If Not Prepared Then Begin
                             Prepare;
                          End;
                          Active:=True;
                          {De Moya 2006-Jul-06 Comento esta linea para que no aparezca
                          mensaje de error}
                          {If Fields[0].IsNull Then Begin
                             raise Exception.Create(ME_010);
                          End;}
                       Except
                          On E:Exception Do Begin
                             raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                          End;
                       End;
                  End;
                  //if (dmacts.SQLValMinMaxACCP.Fields[0].AsVariant <= ValorAVerificar) and
                  //   (dmacts.SQLValMinMaxACCP.Fields[1].AsVariant >= ValorAVerificar) then
                  if (dmacts.SQLValMinMaxACCP.Fields[0].AsFloat <= ValorAVerificar) and
                     (dmacts.SQLValMinMaxACCP.Fields[1].AsFloat >= ValorAVerificar) then
                  begin
                    BtnAprobar.Enabled:= True;
                    BtnSave.Enabled:=False;
                  end
                  else
                  begin
                    if (dmacts.SQLValMinMaxACCP.Fields[1].AsFloat < ValorAVerificar) then
                    begin
                        //showmessage('SQLBuscaSup SQLCurrentHier.Fields0: '+ dmActs.SQLCurrentHier.Fields[0].AsString);
                        //showmessage('SQLBuscaSup PosEncontrada: '+ PosEncontrada);

                        With dmacts.SQLBuscaSup Do Begin
                             Try
                                Active:=False;
                                Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;
                                Params[1].AsString:=Trim(PosEncontrada);
                                If Not Prepared Then Begin
                                   Prepare;
                                End;
                                Active:=True;
                                If Fields[0].IsNull Then Begin
                                   raise Exception.Create(ME_010);
                                End;
                             Except
                                On E:Exception Do Begin
                                   raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                                End;
                             End;
                        End;
                        BtnAprobar.Enabled:= True;
                        BtnSave.Enabled:=False;
                        DebeEndosarSw:=True;
                    end;
                  end;
               end;
               //showmessage('SQLGetCurrStatus dmacts.CurrentActPaid.ActPaidContract: '+ dmacts.CurrentActPaid.ActPaidContract);
               //showmessage('SQLGetCurrStatus CurrentActPaid.ActPaidCode: '+ dmacts.CurrentActPaid.ActPaidCode);
                 With dmacts.SQLGetCurrStatus Do Begin
                    Try
                       Active:=False;
                       Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
                       Params[1].AsString:=dmacts.CurrentActPaid.ActPaidCode;
                       If Not Prepared Then Begin
                          Prepare;
                       End;
                       Active:=True;
                       If Fields[0].IsNull Then Begin
                          raise Exception.Create(ME_010);
                       End;
                    Except
                       On E:Exception Do Begin
                          raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                       End;
                    End;
               End;
               if dmActs.SQLGetCurrStatus.Fields[0].AsString <> '2' then
               begin
                 btnAprobar.Enabled:=False;
                 btnSave.Enabled:=False;
               end;
               if PosEncontrada = 'TOP' then
               begin
                 btnAprobar.Enabled:=False;
                 btnSave.Enabled:=False;
               end;
             end;

             //Jafeth
             if (Trim(Administrator_Id) = Trim(uppercase(dmActs.CurrentUserID))) and
                (Trim(uppercase(dmacts.SQLActEnviadoPor.Fields[0].AsString))
                 = Trim(uppercase(dmActs.MimsPosition))) then
             begin
               btnAprobar.Enabled:=False;
               btnSave.Enabled:=True;
             end;

             {De Moya 2004-03-04 Leo el estado del acta para validación
             inmediamente siguiente que venía en blanco y producia error}
            //showmessage('SQLGetCurrStatus2 dmacts.CurrentActPaid.ActPaidContract: '+ dmacts.CurrentActPaid.ActPaidContract);
            //showmessage('SQLGetCurrStatus2 CurrentActPaid.ActPaidCode: '+ dmacts.CurrentActPaid.ActPaidCode);

             With dmacts.SQLGetCurrStatus Do Begin
               Try
                  Active:=False;
                  Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
                  Params[1].AsString:=dmacts.CurrentActPaid.ActPaidCode;
                  If Not Prepared Then Begin
                     Prepare;
                  End;
                  Active:=True;
                  If Fields[0].IsNull Then Begin
                     raise Exception.Create(ME_010);
                  End;
               Except
                  On E:Exception Do Begin
                     raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                  End;
               End;
             End;

      //Jafeth1
             if (dmActs.SQLGetCurrStatus.Fields[0].AsString <> '1') and
                (uppercase(trim(dmacts.SQLActEnviadoPor.Fields[0].AsString))
                <> uppercase(trim(dmActs.MimsPosition))) and
                 (not btnAprobar.Enabled) then
             begin
               btnAprobar.Enabled:=False;
               btnSave.Enabled:=False;
             end;
           end;
           //showmessage('Posicion: '+dmActs.MimsPosition  +' UserID: '+dmActs.CurrentUserID);
           //showmessage('Current actpaid: '+dmacts.CurrentActPaid.ActPaidStatusS);
           //showmessage('Current Act paid: '+dmacts.CurrentActPaid.ActPaidCode);
           //showmessage('Current Contrato: '+dmacts.CurrentActPaid.ActPaidContract);
        End;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_019,[E.Message]);
           ActPaidReadOnly := True;
        End;
     End;
     {De Moya 2004-03-04 Si ea aprobador no puede modificar}
     if not dmacts.SQLValMinMaxACCP.Fields[0].IsNull then
     begin
        if (dmacts.SQLValMinMaxACCP.Fields[1].AsVariant > 0) then
        begin
          btnSave.Enabled:= False;
        end;
     end;
     {De Moya 2004-04-22 Si la posición es aprobadora y el valor del
      acta es negativo la puede aprobar}
     if not dmacts.SQLValMinMaxACCP.Fields[0].isnull then
     begin
       if (ValorAVerificar <=  0) and
          (dmacts.SQLValMinMaxACCP.Fields[1].AsVariant > 0) and
          (dmActs.SQLGetCurrStatus.Fields[0].AsString = '2') then
       begin
         btnAprobar.Enabled:=true;
       end;
     end;

     {De Moya - 2004-05-27}
     {Busca la posición del usuario que envía el acta para compararlo con el
     userid actual. Si son iguales no puede aprobar el acta}
     With dmacts.SQLGetLastChg Do Begin
          Try
             Active:=False;
             Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
             Params[1].AsString:=dmacts.CurrentActPaid.ActPaidCode;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_011,[' ',E.Message]);
             End;
          End;
     End;
     if dmacts.SQLGetLastChg.Fields[0].AsString = uppercase(dmActs.CurrentUserID) then
     begin
       btnAprobar.Enabled:=false;
     end;

     //dmActs.ValnNo := '';
     if dmActs.ApproveAct Then begin
       BtnSave.Enabled := false;
       //btnCreateValnClick(Self);
     end;
End;
{ Get the standard change rate (change rate calculate by the system as
  the MIMS change rate for the date) }
Function TfrmSAQ301005ActPaid.GetStandardChangeRate(ADate:TDate):Double;
Var
   FStdInvChangeRateDt: String;
   InverseCurrentDate:  String;     { Current Date in Inverse format }
Begin
     FStdInvChangeRateDt   := DateTimeToDate8(ADate);
     InverseCurrentDate    := GetInverseDate(FStdInvChangeRateDt);
     GetStandardChangeRate := dmActs.GetCurrencyRate(FCntCurrency,
                                                     FInvCurrency,
                                                     InverseCurrentDate);
End;
Procedure TfrmSAQ301005ActPaid.GetCurrencyInformation;
Var
   OrgStdChngRt:        Double;
   ConfirmAction:       String;
   TheDate:             TDate;
Begin
     Try
        If FCntCurrency = FInvCurrency Then Begin
           FInvChangeRate := 1; End
        Else Begin
           If RbByDate.Checked Then Begin
              TheDate        := dtpChangeRateDt.Date;
           End;
           If RbByDeal.Checked Then Begin
              FInvChangeRate := StrToFloat(Trim(EdtChangeRate.Text));
              TheDate        := Date;
           End;
           If FInvChangeRate < 0 Then Begin
              raise Exception.Create(ME_148);
           End;
           OrgStdChngRt := GetStandardChangeRate(TheDate);
           If Abs(FInvChangeRate - OrgStdChngRt) > 0.00001 Then Begin
              ConfirmAction := Format(MC_004,[OrgStdChngRt,EdtChangeRate.Text]);
              If Not OperationOk(ConfirmAction) Then Begin
                 raise Exception.Create(MI_027);
              End;
           End;
        End;
     Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_078,[CmbCurrency.Text,
                                             dmActs.SQLPortionLIQ_DAM_BASE.AsString,
                                             E.Message]);
        End;
     End;
     Try
        If RbByDate.Checked Then Begin
           If Trim(EdtChangeRateDt.Text) = '' Then Begin
              raise Exception.Create(ME_191); End
           Else Begin
              FInvChangeRateDt := DateTimeToDate8(dtpChangeRateDt.Date);
           End;
        End;
        If RbByDeal.Checked Then Begin
           FInvChangeRateDt := '00000000';
        End;
     Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_190,[E.Message]);
        End;
     End;
End;
procedure TfrmSAQ301005ActPaid.ValidateActPaidPeriod;
  Procedure ValidateDate0(ADate,ADateName:String);
  Begin
       If StrToIntDef(FPeriodFrom,0) = 0 Then Begin
          raise Exception.CreateFmt(ME_188,[ADateName]);
       End;
  End;
Begin
     ValidateDate0(FPeriodFrom,'Inicial');
     ValidateDate0(FPeriodTo,'Final');
     If FPeriodFrom > FPeriodTo Then Begin
        raise Exception.Create(ME_189);
     End;
     If (AnsiCompareStr(FPeriodFrom, FFinalDate)>0) Or
        (AnsiCompareStr(FPeriodTo, FFinalDate)>0)  Then Begin
        raise Exception.Create(ME_221);
     End;

End;
procedure TfrmSAQ301005ActPaid.ValidateJuvinao;
Var
   Node:                TEleNoEleCode;{ Definition of the current element }
   ElementCode:         String;
   ByGroup:             Boolean;
   cantidadItems:       Integer ;
   index:               Integer;
   itemSelected:        Integer;
   validar:             Boolean;
Begin
     cantidadItems :=  CmbElements.Items.Count;
     itemSelected  :=  CmbElements.ItemIndex;
     If cantidadItems > 0 Then Begin
    {If CmbElements.ItemIndex >= 0 Then Begin }
        index := 0;
        While  index < cantidadItems do Begin
                Node := CmbElements.Items.Objects[index] As TEleNoEleCode;
                ElementCode := Node.Element.ElementCode;
                ByGroup     := dmActs.EleNoEleCodes.HasGroup(ElementCode);

                With dmActs,CurrentActPaid Do Begin
                { If ByGroup Then Begin
                ActPaidElement := EleNoEleCodes.ElementNoBase[ElementCode]; End
                Else Begin
                ActPaidElement := Node.ElementNo;
                        End;    }
                validar:=GetEditValueOfTheElementsJuvinao(Node.ElementNo);

                 if validar then Begin
                        ActPaidElement := Node.ElementNo;
                        SetCostCentersRangeForDisplayJuvinao(ActPaidContract,
                                           ActPaidCode,
                                           ActPaidElement);
                 End;
             index := index + 1;
        End;

        {dmActs.EditMode := BtnSave.Enabled;
        Try
           dmActs.LoadingActPaid := False;
           EditCostCenters(Self,ActPaidReadOnly);
        Finally
           dmActs.LoadingActPaid := True;
        End;}
        {If ByGroup Then Begin
           SetCCDistributionForAllTheGroup;
        End; }
        End;


     End;

End;
{procedure TfrmSAQ301005ActPaid.ValidateJuvinao;
Var
   {Node:                TEleNoEleCode;{ Definition of the current element }
   {ElementCode:         String;
   ByGroup:             Boolean;
Begin
    If CmbElements.ItemIndex >= 0 Then Begin
        Node := CmbElements.Items.Objects[CmbElements.ItemIndex] As TEleNoEleCode;
        ElementCode := Node.Element.ElementCode;
        ByGroup     := dmActs.EleNoEleCodes.HasGroup(ElementCode);
        With dmActs,CurrentActPaid Do Begin   }
            { If ByGroup Then Begin
                ActPaidElement := EleNoEleCodes.ElementNoBase[ElementCode]; End
             Else Begin
                ActPaidElement := Node.ElementNo;
             End;    }
         {    ActPaidElement := Node.ElementNo;
             SetCostCentersRangeForDisplayJuvinao(ActPaidContract,
                                           ActPaidCode,
                                           ActPaidElement);

        End;

        {dmActs.EditMode := BtnSave.Enabled;
        Try
           dmActs.LoadingActPaid := False;
           EditCostCenters(Self,ActPaidReadOnly);
        Finally
           dmActs.LoadingActPaid := True;
        End;}
        {If ByGroup Then Begin
           SetCCDistributionForAllTheGroup;
        End; }
    { End;

End;}
procedure TfrmSAQ301005ActPaid.SaveEditions;
var Mns : string;
    valorprevioacta : real;
Begin
     ValidateActPaidPeriod;
     dmActs.ValidateSupplierStatus(dmActs.SQLContractSUPPLIER_NO.AsString);
     If CbAPInfoAtax.Checked Then Begin
        dmActs.UserConfig.DAPInfoAtax := apiaYes;
        If dmActs.tblInfoAtax.RecordCount < 1 Then Begin
           raise Exception.Create(ME_152);
        End; End
     Else Begin
        dmActs.UserConfig.DAPInfoAtax := apiaNot;
     End;
     GetCurrencyInformation;
     ValidateJuvinao;
     {dbermudez 29-01-2017}
     ValidateAllCC;
     dmActs.UseAsCCC := OperationOk(MC_003);
     dmActs.tblDetail.CancelRange;
     dmActs.tblCosts.CancelRange;
     dmActs.SetCostCentersRangeForSave(dmActs.CurrentActPaid.ActPaidContract,
                                dmActs.CurrentActPaid.ActPaidCode);
     stbActPaid.Panels[0].Text := 'Grabando';
     GgeProgress.Visible  := True;
     GgeProgress.MinValue := 0;
     GgeProgress.MaxValue := dmActs.tblDetail.RecordCount +
                             dmActs.tblCosts.RecordCount + 1;
     { If we must save the tblCosts as the new Cost Center distribution
       we must also count the old cost center distribution. }
     If dmActs.UseAsCCC Then Begin
        GgeProgress.MaxValue := GgeProgress.MaxValue + dmActs.CCCList.Count;
     End;
     GgeProgress.Progress := 0;
     dmActs.OnFeedBack    := ShowProgress;
     FSavingDocument      := True;
     dmActs.SaveActPaidDocument(MmComments,CmbCurrency.Text,
                                FInvChangeRateDt,FInvChangeRate,
                                FPeriodFrom,FPeriodTo);
     GgeProgress.Progress := GgeProgress.MaxValue;
     {De Moya 2003-10-14 Coding added in order to ensure that all act
     modified will be in status pending (0).}
     With dmacts.SQLGetCurrStatus Do Begin
          Try
             Active:=False;
             Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
             Params[1].AsString:=dmacts.CurrentActPaid.ActPaidCode;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_011,[' ',E.Message]);
             End;
          End;
     End;
     dmActs.SetActPaidStatus(dmActs.CurrentActPaid.ActPaidContract,
                                dmActs.CurrentActPaid.ActPaidCode,
                                '1',dmActs.SQLGetCurrStatus.Fields[0].AsString);
     {De Moya 2004-03-11 Borro los centros de costos con porcentaje y valor
     cero en la tabla saf3a3 y los que tienen porcentaje cero en la tabla
     saf3a6}
     With dmacts.SQLDelCCA3Zero Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             ParamByName('Contract_No').AsString := dmActs.CurrentActPaid.ActPaidContract;
             ParamByName('Act_Paid_No').AsString := dmActs.CurrentActPaid.ActPaidCode;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_106,[dmActs.CurrentActPaid.ActPaidContract,
                                    dmActs.CurrentActPaid.ActPaidCode,
                                    E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;

     With dmacts.SQLDelCCA6Zero Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
             ParamByName('Contract_No').AsString := dmActs.CurrentActPaid.ActPaidContract;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns:=Format(ME_106,[dmActs.CurrentActPaid.ActPaidContract,
                                    E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;

     {2004-03-31 De Moya.  Actualizo el valor previo de las actas}
     With dmacts.SQLValorPrevio do Begin
          Try
             Active:=False;
             Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
             Params[1].AsString:=dmacts.CurrentActPaid.ActPaidContract;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             {If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_210);
             End;}
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_211,[' ',E.Message]);
             End;
          End;
     End;

     if dmacts.SQLValorPrevio.Fields[0].IsNull Then
       valorprevioacta:=0
     else
       valorprevioacta:=dmActs.SQLValorPrevio.Fields[0].AsVariant;
     With dmacts.SQLValorActa do Begin
          Try
             Active:=False;
             Params[0].AsString:=dmacts.CurrentActPaid.ActPaidContract;
             Params[1].AsString:=dmacts.CurrentActPaid.ActPaidCode;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_011,[' ',E.Message]);
             End;
          End;
     End;
     With dmacts.UpdValorPevio Do Begin
          Try
             If Not Prepared Then Begin
                Prepare;
             End;
//             ParamByName('AValue').asString := '381044,12';
             ParamByName('AValue').asString := dmacts.SQLValorActa.Fields[0].AsVariant + valorprevioacta;
             ParamByName('AContract').AsString := dmActs.CurrentActPaid.ActPaidContract;
             ParamByName('AnActPaid').AsString := dmActs.CurrentActPaid.ActPaidCode;
             ExecSQL;
          Except
             On E:Exception Do Begin
                Mns := Format(ME_021,[dmActs.CurrentActPaid.ActPaidContract,E.Message]);
                raise Exception.Create(Mns);
             End;
          End;
     End;
     dmActs.ValidateZeroPaidValue(dmActs.CurrentActPaid.ActPaidContract,
             dmActs.CurrentActPaid.ActPaidCode);

     ShowMessage(MI_007);
End;
procedure TfrmSAQ301005ActPaid.BtnSaveClick(Sender: TObject);
begin
     Try
        dmActs.tblDetail.DisableControls;
        Try
           FSavingDocument := False;
           frmSAQ301001Main.Opening := 'N';
           SaveEditions; {Validaciones del acta}
           Close;
        Except
           On E:Exception Do Begin
              If dmActs.dbActPaid.InTransaction Then Begin
                 dmActs.dbActPaid.Rollback;End
              Else Begin
                 If FSavingDocument Then Begin
                    ShowMessageFmt(ME_049,[E.Message]);
                    Close;
                 End;
              End;
              ShowMessageFmt(ME_036,[E.Message]);
              CmbElementsClick(Self);
           End;
        End;
     Finally
        dmActs.tblDetail.EnableControls;
        stbActPaid.Panels[0].Text := '';
        GgeProgress.Visible := False;
        dmActs.OnFeedBack   := ShowActPaidEditedValue;
     End;
end;
Procedure TfrmSAQ301005ActPaid.SetDetailIndex(AValue:String);
Begin
     dmActs.tblDetail.IndexFieldNames := AValue;
End;
procedure TfrmSAQ301005ActPaid.CmbElementsClick(Sender: TObject);
Var
   Node:                TEleNoEleCode;{ Definition of the current element }
   sw_despliega_categorias : boolean;
begin
     {De Moya 2004-05-26 Lee en la tabla saf3a1 si ya hay un acta de pago
     anterior utilizando el elemento AI}
     With dmacts.SQLGetElemAI Do Begin
         Try
             Active:=False;
             Params[0].AsString:=dmActs.CurrentActPaid.ActPaidContract;
             Params[1].AsString:=dmActs.CurrentActPaid.ActPaidCode;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             {If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;}
          Except
             On E:Exception Do Begin
                raise Exception.CreateFmt(ME_011,[' ',E.Message]);
             End;
          End;
     End;

     With CmbElements Do Begin
          If ItemIndex >= 0 Then Begin
             Node := Items.Objects[ItemIndex] As TEleNoEleCode;
             {De Moya 2004-05-27 Adiciono el siguiente código para que no
             pueda reutilizar el elemento AI}
             {De Moya 2004-09-16 Debido a que el cambio de abril 27 funciona
             correctamente para contratos antiguos pero no para los nuevos
             (porque se salia si el resultado del SQLGetElemAI era nulo),
             defino la variable sw_despliega_categorias para permitir que
             para nuevos contratos pueda funcionar}

             sw_despliega_categorias:=true;
             if not dmacts.SQLGetElemAI.Fields[0].IsNull then
             begin
               if (Node.ElementNo = 'AI') and
                  (dmacts.SQLGetElemAI.Fields[0].AsString = 'AI') then
               begin
                  CmbElements.ItemIndex := -1;
                  sw_despliega_categorias:=false;
                  raise Exception.CreateFmt(ME_212,[' ',
                              'Por favor seleccione otro elemento'+chr(10)+
                              'Tenga en cuenta que su selección fue cambiada']);
               end;
             end;

             if sw_despliega_categorias then
             begin
               Try
                  dmActs.tblDetail.DisableControls;
                  If Not Assigned(Sender) Then Begin
                     { If Sender is Nil, then the caller is the routine
                       SetDetailOrder, in that case, It's necessary to
                       set the IndexFieldName to the right order }
                     Case DetailOrder Of
                     doCategoryNo          : DetailIndex := DI_Category_NO;
                     doCategoryDescription : DetailIndex := DI_Category_DESC;
                     End;
                  End;
                  dmActs.SetCategoryRangeForDisplay(Node.ElementNo);
               Finally
                  dmActs.tblDetail.EnableControls;
               End;
             end;
          End;
     End;
end;

procedure TfrmSAQ301005ActPaid.FormDestroy(Sender: TObject);
begin
     ClearObjectsOf(LbElePercents.Items);
     ClearObjectsOf(CmbElePercents.Items);
     ClearObjectsOf(CmbElements.Items);
     dmActs.OnFeedBack := Nil;
     dmActs.EnabledInsert := True;
     If dmActs.tblDetail.UpdatesPending Then Begin
        dmActs.tblDetail.CancelUpdates;
     End;
end;

procedure TfrmSAQ301005ActPaid.BtnCancelClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmSAQ301005ActPaid.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3011320);
end;

procedure TfrmSAQ301005ActPaid.CmbTypeCommentsChange(Sender: TObject);
begin
     With dmActs.UserConfig Do Begin
          DTypeComments          := TTypeComments(Ord(CmbTypeComments.ItemIndex));
          TabComments.TabVisible := DTypeComments <> tcNone;
          If DTypeComments <> tcNone Then Begin
             PgGeneral.ActivePage := TabComments; End
          Else Begin
             PgGeneral.ActivePage := TabContract;
          {2004-04-20 Cambio TabContract por TabPortion}
          PgGeneral.ActivePage := TabPortion;
          End;
     End;

end;

procedure TfrmSAQ301005ActPaid.CbPrintExt01Click(Sender: TObject);
begin
     If CbPrintExt01.Checked Then Begin
        dmActs.UserConfig.DTypeCntrctExt := tcePrintExt; End
     Else Begin
        dmActs.UserConfig.DTypeCntrctExt := tceNone;
     End;
end;

procedure TfrmSAQ301005ActPaid.CbAPInfoAtaxClick(Sender: TObject);
begin
     BtnAPInfoAtax.Enabled := CbAPInfoAtax.Checked;
end;

procedure TfrmSAQ301005ActPaid.BtnAPInfoAtaxClick(Sender: TObject);
begin
     EditAPInfoAtax(Self);
end;

procedure TfrmSAQ301005ActPaid.dtpChangeRateDtEnter(Sender: TObject);
Var
   NewDate:             TDateTime;
begin
     Try
        NewDate := Date8ToDateTime(FInvChangeRateDt);
        dtpChangeRateDt.Date := NewDate;
     Except
        On E:Exception Do dtpChangeRateDt.Date := Date;
     End;
end;

procedure TfrmSAQ301005ActPaid.dtpChangeRateDtCloseUp(Sender: TObject);
Var
   InvCurrentDate:      String;     { Current Date in Inverse format }
   ChangeRate:          Double;     { Current Change Rate from Local to Foreign }
Begin
     FInvChangeRateDt := DateTimeToDate8(dtpChangeRateDt.Date);
     InvCurrentDate   := GetInverseDate(FInvChangeRateDt);
     FInvChangeRate   := dmActs.GetCurrencyRate(FCntCurrency,
                                                FInvCurrency,
                                                InvCurrentDate);
     EdtChangeRate.Text    := '';
     EdtChangeRateDt.Text  := DateToStr(dtpChangeRateDt.Date);
     PnlChangeRate.Caption := FloatToStr(FInvChangeRate);
     PnlChangeRate.Caption := FloatToStr(FInvChangeRate);
end;

procedure TfrmSAQ301005ActPaid.CmbCurrencyExit(Sender: TObject);
Var
   CurrencyIndex:       Integer;
begin
     If dmActs.CurrencyList.Find(CmbCurrency.Text,CurrencyIndex) Then Begin
        FInvCurrency := CmbCurrency.Text; End
     Else Begin
        ShowMessageFmt(ME_154,[CmbCurrency.Text]);
        CmbCurrency.SetFocus;
     End;
end;
Procedure TfrmSAQ301005ActPaid.SetPeriodDate(AControl:TDateTimePicker;
                                             APanel:TPanel;AMIMSDate:String);
Var
   NewDate:             TDateTime;
begin
     Try
        NewDate        := Date8ToDateTime(AMIMSDate);
        AControl.Date  := NewDate;
        APanel.Caption := DateToStr(NewDate);
     Except
        On E:Exception Do Begin
           AControl.Date  := Date;
           APanel.Caption := DateToStr(Date);
        End;
     End;
End;
procedure TfrmSAQ301005ActPaid.dtpPeriodFromEnter(Sender: TObject);
begin
     SetPeriodDate(dtpPeriodFrom,PnlPeriodFrom,FPeriodFrom);
end;

procedure TfrmSAQ301005ActPaid.dtpPeriodToEnter(Sender: TObject);
begin
     SetPeriodDate(dtpPeriodTo,PnlPeriodTo,FPeriodTo);
end;

procedure TfrmSAQ301005ActPaid.dtpPeriodToCloseUp(Sender: TObject);
begin
     FPeriodTo := DateTimeToDate8(dtpPeriodTo.Date);
     PnlPeriodTo.Caption := DateToStr(dtpPeriodTo.Date);
end;

procedure TfrmSAQ301005ActPaid.dtpPeriodFromCloseUp(Sender: TObject);
begin
     FPeriodFrom := DateTimeToDate8(dtpPeriodFrom.Date);
     PnlPeriodFrom.Caption := DateToStr(dtpPeriodFrom.Date);
end;

procedure TfrmSAQ301005ActPaid.PnlElePercentsResize(Sender: TObject);
begin
     CmbElePercents.Width := PnlElePercents.ClientWidth;
end;

procedure TfrmSAQ301005ActPaid.hdElePercentsSectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
     LbElePercents.Invalidate;
end;
procedure TfrmSAQ301005ActPaid.ClearObjectsOf(AList:TStrings);
Var
   ListIndex:           Integer;
Begin
     ListIndex := 0;
     While ListIndex < AList.Count Do Begin
           AList.Objects[ListIndex] := Nil;
           Inc(ListIndex);
     End;
     AList.Clear;
End;
procedure TfrmSAQ301005ActPaid.CmbElePercentsChange(Sender: TObject);
Var
   FElePercent:         TElementPercent;
   ListIndex:           Integer;
   Category:            TPercentRange;
Const
     Epsilon0 = 0.00009;
begin
     With CmbElePercents Do Begin
          FElePercent := Items.Objects[ItemIndex] As TElementPercent;
     End;
     ClearObjectsOf(LbElePercents.Items);
     ListIndex := 0;
     With FElePercent Do Begin
          While ListIndex < Categories.Count Do Begin
                Category := TPercentRange(Categories[ListIndex]);
                If Abs(Category.Total) > Epsilon0 Then Begin
                   LbElePercents.Items.AddObject(Category.CategoryNo,Category);
                End;
                Inc(ListIndex);
          End;
     End;
end;
procedure TfrmSAQ301005ActPaid.GetDrawZone(AnIndex:Integer;Var ADrawZone:TRect);
Begin
     With ADrawZone Do Begin
          Left  := Right + 2;
          Right := Left + hdElePercents.Sections[AnIndex].Width - 2;
     End;
End;
procedure TfrmSAQ301005ActPaid.LbElePercentsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var
   Category:            TPercentRange;
   DrawZone:            TRect;
Const
     DRAW_LEFT_FLAGS  = DT_LEFT Or DT_VCENTER Or DT_SINGLELINE;
     DRAW_RIGHT_FLAGS = DT_RIGHT Or DT_VCENTER Or DT_SINGLELINE;
begin
     Category   := LbElePercents.Items.Objects[Index] As TPercentRange;
     With Category,LbElePercents.Canvas Do Begin
          FillRect(Rect);
          DrawZone := Rect;
          DrawZone.Right := -1; { Trickly to use GetDrawZone }
          GetDrawZone(0,DrawZone);
          DrawText(Handle,PChar(CategoryNo),-1,DrawZone,DRAW_LEFT_FLAGS);
          GetDrawZone(1,DrawZone);
          DrawText(Handle,PChar(CategoryName),-1,DrawZone,DRAW_LEFT_FLAGS);
          GetDrawZone(2,DrawZone);
          DrawText(Handle,PChar(AsPercent(Percent)),-1,DrawZone,DRAW_RIGHT_FLAGS);
          GetDrawZone(3,DrawZone);
          DrawText(Handle,PChar(AsMoney(Total)),-1,DrawZone,DRAW_RIGHT_FLAGS);
          GetDrawZone(4,DrawZone);
          DrawText(Handle,PChar(AsMoney(Value)),-1,DrawZone,DRAW_RIGHT_FLAGS);
     End;
end;

procedure TfrmSAQ301005ActPaid.DisplayElementsByPercent;
Var
   Actual:              TBookmarkStr;
   Node:                TEleNoEleCode;
begin
     With CmbElements Do Begin
          if Items.Count < 1 Then Begin
             raise Exception.Create(ME_199);
          end;
          If ItemIndex < 0 Then Begin
             ItemIndex := 0;
          End;
          Node := Items.Objects[ItemIndex] As TEleNoEleCode;
     End;
     With dmActs,tblDetail Do Begin
          Try
             Actual := BookMark;
             DisableControls;
             CancelRange;
             GetEditValueOfTheElements;
             CalcElementsByPercent;
             SetCategoryRangeForDisplay(Node.ElementNo);
             If dmActs.EleXPercent.Count > 0 Then Begin
                CmbElePercents.ItemIndex := 0;
                CmbElePercentsChange(Nil);
             End;
          Finally
             BookMark := Actual;
             EnableControls;
          End;
     End;
end;
procedure TfrmSAQ301005ActPaid.TabElePercentsEnter(Sender: TObject);
Begin
     try
        DisplayElementsByPercent;
     except
        On E:Exception Do ShowMessage(E.Message);
     end;
End;
procedure TfrmSAQ301005ActPaid.PgGeneralChange(Sender: TObject);
begin
     If PgGeneral.ActivePage = TabElePercents Then Begin
        TabElePercentsEnter(Nil);
     End;
end;

procedure TfrmSAQ301005ActPaid.RbByDealClick(Sender: TObject);
begin
     EdtChangeRate.Enabled   := True;
     dtpChangeRateDt.Enabled := False;
     EdtChangeRateDt.Text    := '';
     PnlChangeRate.Caption   := '';
end;

procedure TfrmSAQ301005ActPaid.RbByDateClick(Sender: TObject);
begin
     EdtChangeRate.Enabled   := False;
     dtpChangeRateDt.Enabled := True;
     dtpChangeRateDt.Date    := Date;
     dtpChangeRateDtCloseUp(Sender);
end;

procedure TfrmSAQ301005ActPaid.PnlSearchResize(Sender: TObject);
Var
   Margen:              Integer;
begin
     Margen := LblSearch.Left;
     BtnFindNext.Left    := PnlSearch.ClientWidth - BtnFindNext.Width - Margen;
     BtnFindFirst.Left   := BtnFindNext.Left - BtnFindFirst.Width;
     EdtSearchText.Width := BtnFindFirst.Left - EdtSearchText.Left;
end;

procedure TfrmSAQ301005ActPaid.BtnFindFirstClick(Sender: TObject);
Var
   TheText:             String;
   CurrentPosition:     TBookmarkStr;
begin
     TheText := AnsiUpperCase(Trim(EdtSearchText.Text));
     If TheText <> '' Then Begin
        Try
           dmActs.tblDetail.DisableControls;
           CurrentPosition := dmActs.tblDetail.BookMark;
           dmActs.tblDetail.First;
           If Not dmActs.FindCategoryWithText(TheText) Then Begin
              ShowMessageFmt(MI_031,[TheText]);
              dmActs.tblDetail.BookMark := CurrentPosition;
           End;
        Finally
           dmActs.tblDetail.EnableControls;
        End;
     End;
end;

procedure TfrmSAQ301005ActPaid.BtnFindNextClick(Sender: TObject);
Var
   TheText:             String;
   CurrentPosition:     TBookmarkStr;
begin
     TheText := AnsiUpperCase(Trim(EdtSearchText.Text));
     If TheText <> '' Then Begin
        Try
           dmActs.tblDetail.DisableControls;
           CurrentPosition := dmActs.tblDetail.BookMark;
           dmActs.tblDetail.Next;
           If Not dmActs.FindCategoryWithText(TheText) Then Begin
              ShowMessageFmt(MI_031,[TheText]);
              dmActs.tblDetail.BookMark := CurrentPosition;
           End;
        Finally
           dmActs.tblDetail.EnableControls;
        End;
     End;
end;

procedure TfrmSAQ301005ActPaid.GrdDetailTitleClick(Column: TColumn);
begin
    { Inactive. Waiting to ask about a possible Delphi limitation. it looks
      as Delphi doesn't support to change the table index when the table
      is Cache updated 
     If Column.FieldName = 'CATEGORY_NO' Then Begin
        DetailOrder := doCategoryNo;
     End;
     If Column.FieldName = 'CATEGORY_DESC' Then Begin
        DetailOrder := doCategoryDescription;
     End;   }
end;

procedure TfrmSAQ301005ActPaid.EdtChangeRateExit(Sender: TObject);
{Var
   ChangeRateAsText:    String;
   ConfirmAction:       String;
   OrgStdChngRt:        Double;}
begin {
     Try
        ChangeRateAsText := Trim(EdtChangeRate.Text);
        If ChangeRateAsText <> '' Then Begin
           FInvChangeRate := StrToFloat(ChangeRateAsText);
           If FInvChangeRate < 0 Then Begin
              raise Exception.Create(ME_148);
           End;
           OrgStdChngRt := GetStandardChangeRate(Date);
           If Abs(FInvChangeRate - OrgStdChngRt) > 0.00001 Then Begin
              ConfirmAction := Format(MC_004,[OrgStdChngRt,EdtChangeRate.Text]);
              If OperationOk(ConfirmAction) Then Begin
                 Screen.Cursor := crDefault; End
              Else Begin
                 EdtChangeRate.SetFocus;
              End;
           End;
        End;
     Except
        On E:Exception Do Begin
           ShowMessage(E.Message);
           EdtChangeRate.SetFocus;
        End;
     End; }
end;
{De Moya 2003-12-12 Agrego esta funcion necesario para ordenar descuentos}
Function SortDetailsByElementKind(Item1, Item2: Pointer): Integer;
Begin
     SortDetailsByElementKind := dmActs.SortByElementKind(Item1, Item2);
End;
procedure TfrmSAQ301005ActPaid.BtnAprobarClick(Sender: TObject);
var
  mns : string;
  ValnCreated : string;
begin
   {if (Length(PnlValnNo.Caption) > 0 ) then begin
     ShowMessage('Acta de Pago ya tiene una Valuacion asociada');
     Exit;
   end;}

   {De Moya 2004-10-11}

   {showmessage(dmacts.CurrentActPaid.ActPaidContract+ ' ' +
               dmacts.CurrentActPaid.ActPaidCode +
               dmActs.MimsPosition);}
   {De Moya 2003-11-24 Muestra el reporte de Acta Resumida}
   With dmActs,CurrentActPaid Do Begin
        GetContractDefinition(ActPaidContract);
        GetPortionDefinition(ActPaidContract,ActPaidPortion);
        GetContractCategories(ActPaidContract,ActPaidPortion);
        SaveCategoriesInMemory;
        GetActCategories(ActPaidContract,ActPaidCode);
        CombineCategories;
        LoadElementsIn(ActPaidContract,ActPaidPortion);
        Details.Sort(SortDetailsByElementKind);
   End;

   PrintActPaidSummary(Self);

   If Not OperationOk(MC_006) Then
     Exit;

   if not DebeEndosarSw then
   begin
      {ValnCreated := CreateValuation;
      if Length( ValnCreated ) = 0 Then begin
        Exit;
      end;}
      With dmActs.SQLUpdAppr Do Begin
         Try
            If Not Prepared Then Begin
               Prepare;
            End;
            ParamByName('AContract').AsString   := dmacts.CurrentActPaid.ActPaidContract;
            ParamByName('AnActPaid').AsString   := dmacts.CurrentActPaid.ActPaidCode;
            ParamByName('AnApprover').AsString  := uppercase(dmActs.CurrentUserID);
            ParamByName('APosApprover').AsString := uppercase(dmActs.MimsPosition);
            ParamByName('AnApproverBy').AsString  := uppercase(dmActs.CurrentUserID);
            ParamByName('ADate').AsString  := datetimetodate8(Date);
            ParamByName('AStatus').AsString     := '4';
            ExecSQL;
            ShowMessage('Acta Aprobada');
            btnAprobar.Enabled:=False;
            btnSave.Enabled:=False;
         Except
            On E:Exception Do Begin
               Mns:=Format(ME_116,[dmacts.CurrentActPaid.ActPaidContract,dmacts.CurrentActPaid.ActPaidCode,E.Message]);
               raise Exception.Create(Mns);
            End;
         End;
      End;
   end
   else
   begin
     {2004-03-29 De Moya.  Incluyo query para colocar el apellido (surname)
     y el nombre (firs_name) del empleado a quien se le redirecciona.  Me
     baso en la posición superior del usuario actual}
     {2005-09-14 De Moya.  Incluyo valor para el parámetro AValidDate del
     query SQLGetEmpNames}
     With dmacts.SQLGetEmpNames Do Begin
         Try
             Active:=False;
             Params[0].AsString:=Trim(dmacts.SQLBuscaSup.Fields[0].AsString);
             Params[1].Asstring:=datetimetodate8(Date);
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             If Fields[0].IsNull Then Begin
                //raise Exception.Create(ME_010);
                raise Exception.Create('Acta no puede ser redireccionada. Posicion superior para aprobar no existe');
             End;
          Except
             On E:Exception Do Begin
                //raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                raise Exception.Create(E.Message);
             End;
          End;
     End;
     showmessage('Acta Redireccionada para ser aprobada por '+chr(10)+
                 dmacts.SQLGetEmpNames.Fields[1].AsString + ' ' +
                 dmacts.SQLGetEmpNames.Fields[0].AsString + ' ' + chr(10)+
                 'con posición '+dmacts.SQLBuscaSup.Fields[0].AsString);
     btnAprobar.Enabled:=False;
     btnSave.Enabled:=False;
     {De Moya 2004-02-13 Actualizo la posición del enviador IC537}
     {De Moya 2005-09-14 Incluyo el valor para el parámetro ASentDate}
     With dmActs.SQLUpdEnviador Do Begin
       Try
         If Not Prepared Then Begin
            Prepare;
         End;
         ParamByName('AContract').AsString   := dmacts.CurrentActPaid.ActPaidContract;
         ParamByName('AnActPaidNo').AsString   := dmacts.CurrentActPaid.ActPaidCode;
         ParamByName('APosSender').AsString  := dmActs.MimsPosition;
         ParamByName('ASentDate').AsString := datetimetodate8(Date);
         {De Moya 2006-Jul-06 Coloco la validación del CurrentDate para
         determinar y evitar que escriba fecha de envío en blanco}

         if (trim(datetimetodate8(Date)) = '') or
            (trim(dmacts.CurrentActPaid.ActPaidContract) = '') or
            (trim(dmacts.CurrentActPaid.ActPaidCode) = '') or
            (trim(dmActs.MimsPosition) = '')  then
         begin
           raise Exception.Create(ME_218);
         end
         else
         begin
           ExecSQL;
         end;
       Except
         On E:Exception Do Begin
            Mns:=Format(ME_116,[dmacts.CurrentActPaid.ActPaidContract,dmacts.CurrentActPaid.ActPaidCode,E.Message]);
            raise Exception.Create(Mns);
         End;
       End;
     End;
   end;

   close;
end;

////////////// Customization for Valuation Creation /////////////////////
{procedure TfrmSAQ301005ActPaid.btnCreateValnClick(Sender: TObject);
begin
  if (Length(PnlValnNo.Caption) > 0 ) then begin
    ShowMessage('Acta de Pago ya tiene una Valuacion asociada');
    Exit;
  end;

  CreateValuation;
End;}

{function TfrmSAQ301005ActPaid.CreateRefCode(ValnNo : String) : boolean;
var
   HTTPRIO1 : THTTPRIO;
   Context : RefCodesService.OperationContext;
   RequestModify : RefCodesServiceModifyRequestDTO;
   ReplyModify   : RefCodesServiceModifyReplyDTO;

Begin
   HTTPRIO1 := THTTPRIO.Create(nil);

   Context := RefCodesService.OperationContext.Create;
   Context.position := dmActs.MimsPosition;
   Context.district := dmActs.CurrentDistrict;

   RequestModify := RefCodesServiceModifyRequestDTO.Create;
   RequestModify.entityType := 'EV2';
   RequestModify.entityValue := PnlContract.Caption + ValnNo;
   RequestModify.refCode := PnlActPaid.Caption;
   RequestModify.refNo := '001';
   RequestModify.seqNum := '001';

   HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecute;
   HTTPRIO1.Port := 'RefCodesServiceHttpPort';
   HTTPRIO1.Service := 'RefCodesService';
   HTTPRIO1.Tag := 0;

   try
     HTTPRIO1.WSDLLocation := dmActs.CurrentHost + '/ews/services/vba/RefCodesService?WSDL';
     ReplyModify := (HTTPRIO1 as RefCodes).modify(Context,RequestModify);
     CreateRefCode := true;
   except
    on E : Exception do begin
      ShowMessage(E.Message);
      CreateRefCode := false;
    end;
   end;
end;}

{procedure TfrmSAQ301005ActPaid.GetPositivesAndNegativeValues;
var
   TheValue:            Currency;
   TheElement:          String;
   TheElementCode:      String;
   TheCC:               String;
   ThePercent:          Double;
   IsNegative:          Boolean;
   TheDocumentType:     String;
   TheDocumentNo:       String;
begin
     With dmActs,tblCosts Do Begin
          First;
          While Not Eof Do Begin
                TheElement := tblCostsELEMENT_NO.AsString;
                TheElementCode := tblDetailELEMENT_CODE.AsString;
                TheValue   := Details.ValueOfElementNo[TheElement];
                If Abs(TheValue) > Delta Then Begin
                   { Only Add values No Zero. Use Delta to avoid precision errors}
                   {ThePercent := tblCostsPERCENT.AsInteger / 10000.0;
                   TheValue   := ThePercent * TheValue;
                   //TheValue   := TheValue;
                   TheCC      := tblCostsGL_ACCOUNT.AsString;
                   IsNegative := CrrEleNoDef.IsDiscount[TheElement + TheElementCode];
                   TheDocumentType := tblCostsDOCUMENT_TYPE.AsString;
                   TheDocumentNo   := tblCostsDOCUMENT_NO.AsString;
                   //If IsNegative Then Begin
                   If TheValue < 0 Then Begin
                      TotalNegativeValue := TotalNegativeValue + TheValue;
                      FCCNegatives.AddCC(TheCC,TheValue,TheDocumentType,TheDocumentNo); End
                   Else Begin
                      TotalpositiveValue := TotalpositiveValue + TheValue;
                      FCCPositives.AddCC(TheCC,TheValue,TheDocumentType,TheDocumentNo);
                   End;
                End;
                Next;
          End;
     End;
End;}

{function TfrmSAQ301005ActPaid.CreateValnItems(ValnNo, ElementNo : String): boolean;
var
   HTTPRIO1 : THTTPRIO;
   Context : ValuationsService.OperationContext;
   RequestMultiModItems : ArrayOfValuationsServiceModItemsRequestDTO;
   ReplyMultiModItems   : ValuationsServiceModItemsReplyCollectionDTO;
   ActPaidValue         : Currency;
Begin

   //GetPositivesAndNegativeValues;

   HTTPRIO1 := THTTPRIO.Create(nil);
   ActPaidValue := dmActs.GetActPaidValue(
       dmActs.CurrentActPaid.ActPaidContract,dmActs.CurrentActPaid.ActPaidCode);
   Context := ValuationsService.OperationContext.Create;
   Context.position := dmActs.MimsPosition;
   Context.district := dmActs.CurrentDistrict;
   //Valor Porcion = Valor Acta de Pago
   SetLength(RequestMultiModItems,1);

   RequestMultiModItems[0] := ValuationsServiceModItemsRequestDTO.Create;
   RequestMultiModItems[0].valnTypeFlag := 'N';

   if trim(PnlChangeRate.Caption) <> '' then begin
       ActPaidValue := ActPaidValue * StrToFloat(PnlChangeRate.Caption);
       TotalPositiveValue := TotalPositiveValue * StrToFloat(PnlChangeRate.Caption);
       TotalNegativeValue := TotalNegativeValue * StrToFloat(PnlChangeRate.Caption);
   end
   else if (trim(EdtChangeRate.Text) <> '') then begin
       ActPaidValue := ActPaidValue * StrToFloat(EdtChangeRate.Text);
       TotalPositiveValue := TotalPositiveValue * StrToFloat(EdtChangeRate.Text);
       TotalNegativeValue := TotalNegativeValue * StrToFloat(EdtChangeRate.Text);
   end
   else begin
       ActPaidValue := ActPaidValue * 1;
       TotalPositiveValue := TotalPositiveValue * 1;
       TotalNegativeValue := TotalNegativeValue * 1;
   end;

   TotalPositiveValue := Abs(TotalPositiveValue);
   TotalNegativeValue := Abs(TotalNegativeValue) * -1;

   RequestMultiModItems[0].actualValue := '0';
   RequestMultiModItems[0].portionNo := PnlPortion.Caption;
   RequestMultiModItems[0].calculatedMethod := 'V';
   RequestMultiModItems[0].contractNo := PnlContract.Caption;
   RequestMultiModItems[0].categoryNo := '01';
   RequestMultiModItems[0].elementNo := ElementNo;
   RequestMultiModItems[0].valuationNo := ValnNo;
   RequestMultiModItems[0].calculatedType := 'A';

   RequestMultiModItems[0].cumPcQuantity := '0.0';
   RequestMultiModItems[0].actualPcQuantity := '0.0';

   //Valor Positivo
   SetLength(RequestMultiModItems, Length(RequestMultiModItems) + 1 );
   RequestMultiModItems[1] := ValuationsServiceModItemsRequestDTO.Create;
   RequestMultiModItems[1].valnTypeFlag := 'N';
   RequestMultiModItems[1].actualValue := StringReplace(CurrToStr(TotalPositiveValue),',','.',[RfReplaceAll]);
   RequestMultiModItems[1].portionNo := PnlPortion.Caption;
   RequestMultiModItems[1].calculatedMethod := 'V';
   RequestMultiModItems[1].contractNo := PnlContract.Caption;
   RequestMultiModItems[1].categoryNo := '02';
   RequestMultiModItems[1].elementNo := ElementNo;
   RequestMultiModItems[1].valuationNo := ValnNo;
   RequestMultiModItems[1].calculatedType := 'A';
   RequestMultiModItems[1].cumPcQuantity := '0.0';
   RequestMultiModItems[1].actualPcQuantity := '0.0';


   //Valor Negativo
   SetLength(RequestMultiModItems, Length(RequestMultiModItems) + 1 );
   RequestMultiModItems[2] := ValuationsServiceModItemsRequestDTO.Create;
   RequestMultiModItems[2].valnTypeFlag := 'N';
   RequestMultiModItems[2].actualValue := StringReplace(CurrToStr(TotalNegativeValue),',','.',[RfReplaceAll]);
   RequestMultiModItems[2].portionNo := PnlPortion.Caption;
   RequestMultiModItems[2].calculatedMethod := 'V';
   RequestMultiModItems[2].contractNo := PnlContract.Caption;
   RequestMultiModItems[2].categoryNo := '03';
   RequestMultiModItems[2].elementNo := ElementNo;
   RequestMultiModItems[2].valuationNo := ValnNo;
   RequestMultiModItems[2].calculatedType := 'A';
   RequestMultiModItems[2].cumPcQuantity := '0.0';
   RequestMultiModItems[2].actualPcQuantity := '0.0';

   HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecute;
   HTTPRIO1.Port := 'ValuationsServiceHttpPort';
   HTTPRIO1.Service := 'ValuationsService';
   HTTPRIO1.Tag := 0;

   try
     HTTPRIO1.WSDLLocation := dmActs.CurrentHost + '/ews/services/vba/ValuationsService?WSDL';
     ReplyMultiModItems := (HTTPRIO1 as Valuations).multipleModItems(Context,RequestMultiModItems);
     CreateValnItems := true;
   except
    on E : Exception do begin
      ShowMessage(E.Message);
      CreateValnItems := false;
    end;
   end;
end;}

{function TfrmSAQ301005ActPaid.CreateCostingAllocation(ValnNo, ElementNo : String) : boolean;
var
   HTTPRIO1 : THTTPRIO;
   Context : ContractCostingService.OperationContext;
   RequestMultiCreate : ArrayOfContractCostingServiceCreateRequestDTO;
   ReplyMultiCreate   : ContractCostingServiceCreateReplyCollectionDTO;

   RequestMultiDelete : ArrayOfContractCostingServiceDeleteRequestDTO;
   ReplyMultiDelete   : ContractCostingServiceDeleteReplyCollectionDTO;

   Value : String;
   i : integer;
   TheCC:          TCCSummary;
   List: TStrings;
Begin
   HTTPRIO1 := THTTPRIO.Create(nil);
   List := TStringList.Create;

   Context := ContractCostingService.OperationContext.Create;
   Context.position := dmActs.MimsPosition;
   Context.district := dmActs.CurrentDistrict;

   //Borrar Distribucion Actual
   SetLength(RequestMultiDelete, 3);
   RequestMultiDelete[0] := ContractCostingServiceDeleteRequestDTO.Create;
   RequestMultiDelete[0].contractNo := PnlContract.Caption;
   RequestMultiDelete[0].valuationNo := ValnNo;
   RequestMultiDelete[0].portion := PnlPortion.Caption;
   RequestMultiDelete[0].element := ElementNo;
   RequestMultiDelete[0].categoryNo := '01';
   RequestMultiDelete[0].costingInd := 'V';
   RequestMultiDelete[0].allocCount := '1';

   RequestMultiDelete[1] := ContractCostingServiceDeleteRequestDTO.Create;
   RequestMultiDelete[1].contractNo := PnlContract.Caption;
   RequestMultiDelete[1].valuationNo := ValnNo;
   RequestMultiDelete[1].portion := PnlPortion.Caption;
   RequestMultiDelete[1].element := ElementNo;
   RequestMultiDelete[1].categoryNo := '02';
   RequestMultiDelete[1].costingInd := 'V';
   RequestMultiDelete[1].allocCount := '1';

   RequestMultiDelete[2] := ContractCostingServiceDeleteRequestDTO.Create;
   RequestMultiDelete[2].contractNo := PnlContract.Caption;
   RequestMultiDelete[2].valuationNo := ValnNo;
   RequestMultiDelete[2].portion := PnlPortion.Caption;
   RequestMultiDelete[2].element := ElementNo;
   RequestMultiDelete[2].categoryNo := '03';
   RequestMultiDelete[2].costingInd := 'V';
   RequestMultiDelete[2].allocCount := '1';

   FCCPositives.CalculatePercents;
   //Distribucion de Costos Positivos
   for i := 0 to FCCPositives.Count - 1 do begin
       TheCC := FCCPositives.CostCenterAt[i];
       //Create Operation
       If (TheCC.Value <> 0) Then begin
         SetLength(RequestMultiCreate, Length(RequestMultiCreate) + 1);
         RequestMultiCreate[Length(RequestMultiCreate) - 1] := ContractCostingServiceCreateRequestDTO.Create;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].portion     := PnlPortion.Caption;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].costingInd  := 'V';
         //if TheCC.DocumentType = '0' then
         //  RequestMultiCreate[Length(RequestMultiCreate) - 1].equipmentNo := TheCC.DocumentNo;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].contractNo  := PnlContract.Caption;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].element := ElementNo;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].categoryNo  := '02';
         RequestMultiCreate[Length(RequestMultiCreate) - 1].workOrder  := ContractCostingService.WorkOrderDTO.Create;
         if TheCC.DocumentType = '1' then begin
             RequestMultiCreate[Length(RequestMultiCreate) - 1].workOrder.prefix  := Copy(TheCC.DocumentNo,1,2);
             RequestMultiCreate[Length(RequestMultiCreate) - 1].workOrder.no  := Copy(TheCC.DocumentNo,2,6);
         end;
         if TheCC.DocumentType = '2' then begin
             RequestMultiCreate[Length(RequestMultiCreate) - 1].project := TheCC.DocumentNo;
         end;
         if TheCC.DocumentType = '3' then begin
             RequestMultiCreate[Length(RequestMultiCreate) - 1].equipmentRef := TheCC.DocumentNo;
         end;
         Value := TheCC.PercentAsText;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].allocatedPercent := StringReplace(TheCC.PercentAsText,'%','',[RfReplaceAll]);

         Value := FCCPositives[i];
         ExtractStrings(['%'], [], PChar(FCCPositives[i]), List);
         Value := List[0];

         RequestMultiCreate[Length(RequestMultiCreate) - 1].accountCode := Value;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].valuationNo := ValnNo;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].allocationDistrict := dmActs.CurrentDistrict;

         List.Clear;
       end;
   end;

   FCCNegatives.CalculatePercents;
   //Distribucion de Costos Negativos
   for i := 0 to FCCNegatives.Count - 1 do begin
       TheCC := FCCNegatives.CostCenterAt[i];
       If (TheCC.Value <> 0) Then begin
         //Create Operation
         SetLength(RequestMultiCreate, Length(RequestMultiCreate) + 1);
         RequestMultiCreate[Length(RequestMultiCreate) - 1] := ContractCostingServiceCreateRequestDTO.Create;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].portion     := PnlPortion.Caption;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].costingInd  := 'V';
         //if TheCC.DocumentType = '0' then
         //  RequestMultiCreate[Length(RequestMultiCreate) - 1].equipmentNo := TheCC.DocumentNo;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].contractNo  := PnlContract.Caption;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].element := ElementNo;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].categoryNo  := '03';
         RequestMultiCreate[Length(RequestMultiCreate) - 1].workOrder  := ContractCostingService.WorkOrderDTO.Create;
         if TheCC.DocumentType = '1' then begin
             RequestMultiCreate[Length(RequestMultiCreate) - 1].workOrder.prefix  := Copy(TheCC.DocumentNo,1,2);
             RequestMultiCreate[Length(RequestMultiCreate) - 1].workOrder.no  := Copy(TheCC.DocumentNo,2,6);
         end;
         if TheCC.DocumentType = '2' then begin
             RequestMultiCreate[Length(RequestMultiCreate) - 1].project := TheCC.DocumentNo;
         end;
         if TheCC.DocumentType = '3' then begin
             RequestMultiCreate[Length(RequestMultiCreate) - 1].equipmentRef := TheCC.DocumentNo;
         end;

         Value := FCCNegatives[i];
         ExtractStrings(['%'], [], PChar(FCCNegatives[i]), List);
         Value := List[0];

         RequestMultiCreate[Length(RequestMultiCreate) - 1].allocatedPercent := StringReplace(TheCC.PercentAsText,'%','',[RfReplaceAll]);
         RequestMultiCreate[Length(RequestMultiCreate) - 1].accountCode := Value;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].valuationNo := ValnNo;
         RequestMultiCreate[Length(RequestMultiCreate) - 1].allocationDistrict := dmActs.CurrentDistrict;
       end;
   end;

   HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecute;
   HTTPRIO1.Port := 'ContractCostingServiceHttpPort';
   HTTPRIO1.Service := 'ContractCostingService';
   HTTPRIO1.Tag := 0;

   try
     HTTPRIO1.WSDLLocation := dmActs.CurrentHost + '/ews/services/vba/ContractCostingService?WSDL';
     ReplyMultiDelete := (HTTPRIO1 as ContractCosting).multipleDelete(Context,RequestMultiDelete);
     ReplyMultiCreate := (HTTPRIO1 as ContractCosting).multipleCreate(Context,RequestMultiCreate);
     CreateCostingAllocation := true;
   except
    on E : Exception do begin
      ShowMessage(E.Message);
      CreateCostingAllocation := false;
    end;
   end;
end;}


{function TfrmSAQ301005ActPaid.CreateValuation: String;
var
   HTTPRIO1 : THTTPRIO;
   Context : ValuationsService.OperationContext;
   RequestCreate : ValuationsService.ValuationsServiceCreateRequestDTO;
   ReplyCreate   : ValuationsService.ValuationsServiceCreateReplyDTO;
   MinElementNo  : String;
   ActPaidValue : Currency;
Begin
   HTTPRIO1 := THTTPRIO.Create(nil);

   Context := ValuationsService.OperationContext.Create;
   Context.position := dmActs.MimsPosition;
   Context.district := dmActs.CurrentDistrict;

   //ActPaidValue     := dmActs.GetActPaidValue(dmActs.CurrentActPaid.ActPaidContract,dmActs.CurrentActPaid.ActPaidCode);
   MinElementNo := dmActs.GetMinPorEle(PnlContract.Caption, PnlPortion.Caption);

   GetPositivesAndNegativeValues;
   ActPaidValue := TotalPositiveValue + TotalNegativeValue;

   if trim(PnlChangeRate.Caption) <> '' then
       ActPaidValue := ActPaidValue * StrToFloat(PnlChangeRate.Caption)
   else if (trim(EdtChangeRate.Text) <> '') then
       ActPaidValue := ActPaidValue * StrToFloat(EdtChangeRate.Text)
   else
       ActPaidValue := ActPaidValue * 1;

   RequestCreate := ValuationsService.ValuationsServiceCreateRequestDTO.Create;
   RequestCreate.valnTypeFlag := 'N';

   RequestCreate.contractNo := PnlContract.Caption;
   RequestCreate.cntrctrRefNo := '0000-0000';   
   RequestCreate.contractor := PnlSupplierCode.Caption;
   RequestCreate.valuedBy := trim(dmActs.CurrentUserID);

   RequestCreate.cntrctrRefAmt := StringReplace(CurrToStr(ActPaidValue),',','.',[RfReplaceAll]);

   RequestCreate.cntrctrRefRcptDate := SetFormatDateMMDDYYYY(dmActs.CurrentActPaid.ActPaidDate);
   RequestCreate.valuationDate := SetFormatDateMMDDYYYY(dmActs.CurrentActPaid.ActPaidDate);
   RequestCreate.cntrctrRefDate := SetFormatDateMMDDYYYY(dmActs.CurrentActPaid.ActPaidDate);
   RequestCreate.calculatedMethod := 'V';
   RequestCreate.calculatedType := 'A';

   //FCurrentXmlns := 'xmlns="http://valuations.ellipse.enterpriseservice.mincom.com"';

   HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecute;
   HTTPRIO1.Port := 'ValuationsServiceHttpPort';
   HTTPRIO1.Service := 'ValuationsService';
   HTTPRIO1.Tag := 0;

   try
     CreateValuation := '';

     HTTPRIO1.WSDLLocation := dmActs.CurrentHost + '/ews/services/vba/ValuationsService?WSDL';
     ReplyCreate := (HTTPRIO1 as Valuations).create(Context, RequestCreate);
     CreateRefCode(ReplyCreate.valuationNo);

     if CreateValnItems(ReplyCreate.valuationNo, MinElementNo) Then begin
         if CreateCostingAllocation(ReplyCreate.valuationNo, MinElementNo) Then begin
             CreateValuation := ReplyCreate.valuationNo;
             PnlValnNo.Caption := ReplyCreate.valuationNo;
             ShowMessage('Valuacion No: ' + ReplyCreate.valuationNo + ' creada ');
             dmActs.ValnNo := ReplyCreate.valuationNo;;
         end
         else begin
             DeleteValn(ReplyCreate.valuationNo);
         end;
     end
     else begin
         DeleteValn(ReplyCreate.valuationNo);
     end;
   except
    on E : Exception do begin
      ShowMessage(E.Message);
      CreateValuation := '';
    end;
   end;
end;}

{function TfrmSAQ301005ActPaid.DeleteValn(AValnNo : String): boolean;
var
   HTTPRIO1 : THTTPRIO;
   Context : ValuationsService.OperationContext;
   RequestDelete : ValuationsServiceDeleteRequestDTO;
   ReplyDelete   : ValuationsServiceDeleteReplyDTO;
Begin

   HTTPRIO1 := THTTPRIO.Create(nil);
   RequestDelete := ValuationsServiceDeleteRequestDTO.Create;
   Context := ValuationsService.OperationContext.Create;
   Context.position := dmActs.MimsPosition;
   Context.district := dmActs.CurrentDistrict;
   RequestDelete.contractNo := PnlContract.Caption;
   RequestDelete.valuationNo := AValnNo;

   HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecute;
   HTTPRIO1.Port := 'ValuationsServiceHttpPort';
   HTTPRIO1.Service := 'ValuationsService';
   HTTPRIO1.Tag := 0;

   try
     HTTPRIO1.WSDLLocation := dmActs.CurrentHost + '/ews/services/vba/ValuationsService?WSDL';
     ReplyDelete := (HTTPRIO1 as Valuations).delete(Context,RequestDelete);
     //DeleteRefCode( dmActs.tblSearchVALN_NO.AsString );
     DeleteValn := true;
     PnlValnNo.Caption := ' ';
   except
    on E : Exception do begin
      ShowMessage(E.Message);
      DeleteValn := false;
    end;
   end;
end;}

Function TfrmSAQ301005ActPaid.SetFormatDateMMDDYYYY(actualDate : String) : String;
begin
   actualDate := Copy(actualDate,5,2) + '/' + Copy(actualDate,7,2) + '/' + Copy(actualDate,1,4);
   Result := actualDate;
end;

procedure TfrmSAQ301005ActPaid.HTTPRIO1BeforeExecute(const MethodName: String;
    var SOAPRequest: WideString);
var
  stringToFind : String;
  StringToReplace : String;
  headerAuthentication : String;
  i : integer;
begin

  StringToFind := '<district';
  StringToReplace := '<district xmlns="http://connectivity.service.ews.mincom.com"';
  SOAPRequest := StringReplace(SOAPRequest, StringToFind, StringToReplace, [RfReplaceAll] );

  StringToFind := '<position';
  StringToReplace := '<position xmlns="http://connectivity.service.ews.mincom.com"';
  SOAPRequest := StringReplace(SOAPRequest, StringToFind, StringToReplace, [RfReplaceAll] );

  SetAuthenticationHeader(SOAPRequest);
end;

Function TfrmSAQ301005ActPaid.SetAuthenticationHeader(var SOAPRequest : WideString):String;
var
  stringToFind : String;
  headerAuthentication : String;
begin
  try

    StringToFind := '<SOAP-ENV:Body>';
    HeaderAuthentication :=
        '<SOAP-ENV:Header>' +
        '        <wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" SOAP-ENV:mustUnderstand="1">' +
        '                <wsse:UsernameToken                                                                                                              ' +
        '                xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"                                   ' +
        '                wsu:Id="UsernameToken-3862294"                                                                                                   ' +
        '                xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">                                  ' +
        '                        <wsse:Username                                                                                                           ' +
        '                        xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">'+dmActs.CurrentUserID+'</wsse:Username>  ' +
        '                        <wsse:Password                                                                                                           ' +
        '                        Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText"                   ' +
        '                        xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">'+dmActs.CurrentPassword+'</wsse:Password>  ' +
        '                </wsse:UsernameToken> ' +
        '        </wsse:Security>              ' +
        '</SOAP-ENV:Header> ' +  stringToFind;

    SOAPRequest := StringReplace(SOAPRequest,
      StringToFind, HeaderAuthentication, [RfReplaceAll] );
  except
    on E : Exception do
      //ShowMessage(E.ClassName + ' error raised, with message : ' + E.Message);
  end;
End;

end.







