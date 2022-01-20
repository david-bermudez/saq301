unit SAQ301010;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SAQ301009, Qrctrls, QuickRpt, ExtCtrls, DBCtrls, MCTypes, MCObjcts;

type
  TfrmSAQ301010QRActPaid = class(TfrmSAQ301009ParentReports)
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand2: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QLblApprover: TQRLabel;
    QLblActPaidNo: TQRLabel;
    QRLabel11: TQRLabel;
    QLblAPApveDate: TQRLabel;
    QRLabel13: TQRLabel;
    QLblContractNo: TQRLabel;
    QRLabel14: TQRLabel;
    QLblPortion: TQRLabel;
    QRLabel15: TQRLabel;
    QLblSupplierName: TQRLabel;
    QLblElement: TQRLabel;
    QLblCategory: TQRLabel;
    QLblQuantity: TQRLabel;
    QLblRateValue: TQRLabel;
    QLblValue: TQRLabel;
    QRLabel12: TQRLabel;
    QLblTotal: TQRLabel;
    QRLabel16: TQRLabel;
    QLblStatus: TQRLabel;
    QLblContractDesc: TQRLabel;
    QRLabel17: TQRLabel;
    QLblCurrency: TQRLabel;
    QLblKindOfValue: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QLblContractValue: TQRLabel;
    QLblContractTime: TQRLabel;
    QLblSContractDate: TQRLabel;
    QRLabel21: TQRLabel;
    QLblWorkingTime: TQRLabel;
    QRLbl25: TQRLabel;
    QLblFContractDate: TQRLabel;
    QRLabel22: TQRLabel;
    QLblExecutedValue: TQRLabel;
    QRLabel23: TQRLabel;
    QLblProgress: TQRLabel;
    QRLabel24: TQRLabel;
    QLblRemainTime: TQRLabel;
    QLblUnit: TQRLabel;
    QRLabel25: TQRLabel;
    QLblSupplierId: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QLblNewExecValue: TQRLabel;
    QRBndActPaidExt: TQRChildBand;
    QRBndComments: TQRChildBand;
    QRLabel28: TQRLabel;
    QMmComments: TQRMemo;
    QRLabel30: TQRLabel;
    QLblOriStartDt: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QLblAmnStartDt: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QLblOriComplDt: TQRLabel;
    QLblAmnComplDt: TQRLabel;
    QLblFinComplDt: TQRLabel;
    QRLabel37: TQRLabel;
    QRBndInfoAtax: TQRChildBand;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QLblInvCurrency: TQRLabel;
    QRLabel44: TQRLabel;
    QLblInvChangeRate: TQRLabel;
    QRLabel46: TQRLabel;
    QLblInvChangeRateDt: TQRLabel;
    QRBndInfAtxDetail: TQRSubDetail;
    QRDBText1: TQRDBText;
    QLblInfoAtaxDesc: TQRLabel;
    QLblInfoAtaxBase: TQRLabel;
    QLblInfoAtaxValue: TQRLabel;
    QLblInfoAtaxRate: TQRLabel;
    QRLabel18: TQRLabel;
    QLblActPaidDate: TQRLabel;
    QRLabel45: TQRLabel;
    QLblTotalInvoice: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QLblAdministrator: TQRLabel;
    QRLabel54: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRLabel55: TQRLabel;
    QLblPeriodRange: TQRLabel;
    QLblSupplierNo: TQRLabel;
    QLblLocation: TQRLabel;
    QRSysData2: TQRSysData;
    QLabel80: TQRLabel;
    QLblAvalaible: TQRLabel;
    QRLabel61: TQRLabel;
    QLblContractCode: TQRLabel;
    QRLabel97: TQRLabel;
    QRLabel96: TQRLabel;
    QLblInfoInvAtaxValue: TQRLabel;
    QRLabel98: TQRLabel;
    QRLabel99: TQRLabel;
    QLblInfoInvAtaxBase: TQRLabel;
    QLblBruto: TQRLabel;
    QLblNetValue: TQRLabel;
    QRBndCCSummary: TQRChildBand;
    QRLabel62: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRBndCCDetailSummmary: TQRSubDetail;
    QLblCCAccount: TQRLabel;
    QLblCCPercent: TQRLabel;
    QLblCCValue: TQRLabel;
    QRTtlBndCCPositive: TQRChildBand;
    QLblCCSection1: TQRLabel;
    QRTtlBndCCNegative: TQRChildBand;
    QLblCCSection2: TQRLabel;
    QLblPosApprover: TQRLabel;
    QRLblAnalista: TQRLabel;
    QLblAnalista: TQRLabel;
    qrMensaje: TQRLabel;
    QRLabel1: TQRLabel;
    QLblCCDocType: TQRLabel;
    QRLabel47: TQRLabel;
    QLblCCDocNo: TQRLabel;
    QRLabel48: TQRLabel;
    QLBlSentDate: TQRLabel;
    procedure QRReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRReportNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndActPaidExtBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndCommentsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndInfoAtaxBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndInfAtxDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndCCDetailSummmaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndCCSummaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndCCDetailSummmaryNeedData(Sender: TObject;
      var MoreData: Boolean);
    procedure QRTtlBndCCNegativeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRTtlBndCCNegativeAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBndCCDetailSummmaryAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QLblCCSection1Print(sender: TObject; var Value: String);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPeriodFrom:        String;  { Initial Period Date in MIMS format }
    FPeriodTo:          String;  { Final Period Date in MIMS format }
    FDetailIndex:       Integer; { Index of the current category }
    FPrintInfoAtax:     Boolean;
    FPrintedCCHeader:   Boolean;
    FPrintAtax:         Boolean;
    FInvChangeRate:     Double;  { Change rate to be used in the Invoice }
    FCCListKind:        TCCListKind;    { Current CC List Kind }
    FCCListIndex:       Integer;
    FCCPositives:       TCCSummaryList; { Cost Centers of Positive Elements }
    FCCNegatives:       TCCSummaryList; { Cost Centers of Negative Elements }
    FPrintTtlNegative:  Boolean;
    Function CheckMoreDataByPositive:Boolean;
    Function CheckMoreDataByNegative:Boolean;
    procedure PrintCCLine(AList:TCCSummaryList;ALineNo:Integer);
    Procedure LoadCC;
  protected
    Procedure ProcessLine(Sender:TObject); override;
    procedure FillUpDetailLine(AnIndex:Integer); virtual;
  public
    { Public declarations }
    procedure PrintAtaxDetails;
    Property DetailIndex:Integer     Read FDetailIndex     Write FDetailIndex;
    Property InvChangeRate:Double    Read FInvChangeRate   Write FInvChangeRate;
    Property PrintInfoAtax:Boolean   Read FPrintInfoAtax   Write FPrintInfoAtax;
    Property PrintedCCHeader:Boolean Read FPrintedCCHeader Write FPrintedCCHeader;
  end;

var
  frmSAQ301010QRActPaid: TfrmSAQ301010QRActPaid;

Procedure PrintActPaid(AOwner:TComponent);
implementation

uses MCUtils, MCDMActs;

{$R *.DFM}
Procedure PrintActPaid(AOwner:TComponent);
Begin
     frmSAQ301010QRActPaid := Nil;
     Try
        frmSAQ301010QRActPaid := TfrmSAQ301010QRActPaid.Create(AOwner);
        frmSAQ301010QRActPaid.QRReport.Preview;
     Finally
        dmActs.SQLInfoAtax.Active := False;
        frmSAQ301010QRActPaid.Free;
     End;
End;
{ ProcessLine is an abstract method in the parent form; but, unnecessary
  in TFrmQRActPaid }
Procedure TfrmSAQ301010QRActPaid.ProcessLine(Sender:TObject);
Begin
End;
procedure TfrmSAQ301010QRActPaid.QRReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
   Administrator:       String;     { Employee ID of the main ADC }
   Approver:            String;     { Employee ID of the user approver }
   ApproveDate:         String;     { Approve date of the Act }
   StartDate:           String;     { Date of the contract start (format 8) }
   FinalDate:           String;     { Date of the contract finalization (format 8) }
   ContractPaid:        Currency;   { Total Acts Paid for the contract }
   PortionPaid:         Currency;   { Total Acts Paid for the portion }
   PortionValue:        Currency;   { Portion value to calculate execution }
   StillAvalaible:      Currency;   { Pendent for execution }
   PaidPercent:         Double;     { PaidExecution Percent }
   APCurrency:          String;     { Currency of the Act Paid }
   InvCurrency:         String;     { Currency to be used in the Invoice }
   InvChangeRateDt:     String;     { Date used to calculate InvChangeRate }
   ContractNo:          String;     {De Moya 2006-03-02}
begin
     Inherited;
     FPrintInfoAtax   := False;
     FPrintedCCHeader := False;
     FPrintAtax       := True;
     With dmActs,CurrentActPaid Do Begin
          APCurrency := SQLPortionLIQ_DAM_BASE.AsString;
          GetActPaidExt(ActPaidContract,ActPaidCode,
                        Administrator,Approver,ApproveDate,
                        PortionPaid,ContractPaid,
                        InvCurrency,InvChangeRateDt,FInvChangeRate,
                        FPeriodFrom,FPeriodTo);
          QLblPeriodRange.Caption := Date8ToDisplayFormat(FPeriodFrom) +
                                     '-' +
                                     Date8ToDisplayFormat(FPeriodTo);
          SetCostCentersRangeForSave(ActPaidContract,ActPaidCode);
          GetActPaidInfoAtax(ActPaidContract,ActPaidCode);
          If UserConfig.ActValidation = avNone Then Begin
             PortionValue := SQLPortionLIQ_DAM_LIMIT.Value;
             QLblKindOfValue.Caption   := MI_019 + MI_018 + ' :'; End
          Else Begin
             PortionValue := SQLPortionPORTION_VAL.Value;
             QLblKindOfValue.Caption   := MI_019 + MI_017 + ' :';
          End;
          If Not (ActPaidStatus In [asApproved,asCounted,asInvoiced,asClosed]) Then Begin
             PortionPaid := GetPaidsToPortion(ActPaidContract,ActPaidPortion);
          End;
          {2004-03-30 De Moya. Incluyo lectura de la PortionPaid independiente
          del estado.  El cliente indica que antes no salia este error, pero el
          código inmediatamente anterior indica que leía la variable sólo en
          algunos estados}
          {ContractPaid := GetPaidsToContract(ActPaidContract);
          PortionPaid := GetPaidsToPortion(ActPaidContract,ActPaidPortion);}
          PaidPercent    := 100*(PortionPaid/PortionValue);
          StillAvalaible := PortionValue - PortionPaid;
          GetPortionRange(StartDate,FinalDate);
          QLblActPaidNo.Caption     := ActPaidCode;
          //QLblValnNo.Caption        := ActPaidValnNo;
          QLblContractNo.Caption    := ActPaidContract;
          QLblPortion.Caption       := ActPaidPortion;
          QLblStatus.Caption        := Uppercase(StatusNames[ActPaidStatus]);
          QLblContractDesc.Caption  := SQLContractCONTRACT_DESC.AsString;
          QLblSupplierNo.Caption    := ActPaidSupplier;
          QLblSupplierId.Caption    := GetSupplierId(SQLContractDSTRCT_CODE.AsString,
                                                     ActPaidSupplier);
          QLblSupplierName.Caption  := GetSupplierName(ActPaidSupplier);
          QLblActPaidDate.Caption   := Date8ToDisplayFormat(ActPaidDate);
          QLblLocation.Caption      := SQLPortionCONTRACT_LOCAT.AsString;
          If ActPaidStatus in [asNone,asPendent,asSent,asNull] Then Begin
             QLblAPApveDate.Caption := ''; End
          Else Begin
             QLblAPApveDate.Caption := Date8ToDisplayFormat(ApproveDate);
             StillAvalaible         := StillAvalaible - ExecAPValue;
          End;
          {De Moya 2005-08-25 IC672 Agrego despliegue de la fecha de envío}
          With dmacts.SQLGetSentDate Do Begin
              Try
                  Active:=False;
                  Params[0].AsString:=ActPaidContract;
                  {De Moya 2006-03-02}
                  ContractNo:=GetMimsKey(ActPaidContract,8);
                  Params[1].AsString:=ActPaidCode;
                  Params[2].AsString:=ActPaidPortion;
                  If Not Prepared Then Begin
                     Prepare;
                  End;
                  Active:=True;
              Except
                  On E:Exception Do Begin
                     raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                  End;
              End;
          End;
          if (Trim(dmActs.SQLGetSentDate.Fields[0].AsString) = '') then
          {if (dmActs.SQLGetSentDate.Fields[0].AsString <= ' ') or
             (dmActs.SQLGetSentDate.Fields[0].AsString = '') then }
             QLblSentDate.Caption := 'No definida'
          else
             QLblSentDate.Caption := Date8ToDisplayFormat(dmActs.SQLGetSentDate.Fields[0].AsString);
          QLblContractCode.Caption  := GetOriginalContractCode(ActPaidContract);
          QLblTotal.Caption         := Format('%m',[Details.Value]);
          QLblTotalInvoice.Caption  := Format('%m',[Details.Value*InvChangeRate]);
          QLblCurrency.Caption      := APCurrency;
          QLblContractValue.Caption := Format('%m',[PortionValue]);
          QLblContractTime.Caption  := GetMDTimeElapsed(StartDate,FinalDate);
          QLblSContractDate.Caption := Date8ToDisplayFormat(StartDate);
          QLblWorkingTime.Caption   := GetMDTimeElapsed(StartDate,ActPaidDate);
          QLblFContractDate.Caption := Date8ToDisplayFormat(FinalDate);
          {2004-04-01 De Moya Recalculo el PortionPaid de acuerdo con lo sugerido
          por el cliente}
          {2004-07-04 Se retira del Filtro la condicion a.discount_flag = 'N', ya que
          excluye valores los cuales estan con valor Y}
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
          {De Moya 2004-04-23 Si el valor del acta es negativo entonces el
          valor de PortionPaid debe ser disminuido por el valor del acta}
          {if ActPaidNetValue < 0 then
          begin
            PortionPaid:=PortionPaid + ActPaidNetValue;
          end;}
          QLblExecutedValue.Caption := Format('%m',[PortionPaid]);
          PaidPercent    := 100*(PortionPaid/PortionValue);
          StillAvalaible:=PortionValue - PortionPaid;
          QLblAvalaible.Caption     := Format('%m',[StillAvalaible]);
          QLblProgress.Caption      := Format('%5.2f',[PaidPercent])+' %';
          QLblRemainTime.Caption    := GetMDTimeElapsed(ActPaidDate,FinalDate);
          {2004-03-31 De Moya. Adiciono IF-ELSE para manejar el valor ExecAPValue
          de acuerdo al estado.  El cliente indica que deben ser iguales los valores
          ejecutado a la fecha como el nuevo ejecutado desde que el acta pasa a estado
          aprobado}
          {If Not (ActPaidStatus In [asApproved,asCounted,asInvoiced,asClosed]) Then Begin}
          QLblNewExecValue.Caption  := Format('%m',[PortionPaid+ExecAPValue]);
          StillAvalaible:=PortionValue - PortionPaid - ExecAPValue;
          QLblAvalaible.Caption     := Format('%m',[StillAvalaible]);

          {end
          else
          begin
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
                    If Fields[0].IsNull Then Begin
                       raise Exception.Create(ME_010);
                    End;
                Except
                    On E:Exception Do Begin
                       raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                    End;
                End;
            End;
            QLblNewExecValue.Caption  := Format('%m',[PortionPaid+ExecAPValue-dmActs.sqlrestavalor.fields[0].AsFloat]);
          End;}

{20-DIC-04 WVIDELA IC549}
{Incluir el texto "Régimen Simplificado" al lado del título Acta de Pago, si el proveedor
está marcado como "RS" en el MSF200.SUP_TYPEX5.}

          With dmacts.SQLSupplier Do Begin
               Try
                   Active:=False;
                   Params[0].AsString:=ActPaidSupplier;
                   If Not Prepared Then Begin
                      Prepare;
                   End;
                   Active:=True;
                Except
                   On E:Exception Do Begin
                      raise Exception.CreateFmt(ME_004,[' ',E.Message]);
                   End;
                End;
          End;
          qrMensaje.Caption := ' ';
          if (not dmActs.SQLSupplier.Fields[1].IsNull) and
             (dmActs.SQLSupplier.Fields[1].AsString = 'RS') then
             qrMensaje.Caption := 'Régimen Simplificado';
{20-DIC-04 WVIDELA IC549}

          {De Moya 2004-04-22 Agrego código para desplegar el nuevo campo Analista
          en las actas de pago extendida y resumida}
          With dmacts.SQLGetAnalista Do Begin
               Try
                   Active:=False;
                   Params[0].AsString:=ActPaidContract;
                   Params[1].AsString:=ActPaidPortion;
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
          if not dmActs.SQLGetAnalista.Fields[0].IsNull then
          begin
            if (dmActs.SQLGetAnalista.Fields[0].AsString = 'AD') or
               (dmActs.SQLGetAnalista.Fields[0].AsString = 'CA') then
               QLblAnalista.Caption:=dmActs.SQLGetAnalista.Fields[1].AsString
            else
              if (dmActs.SQLGetAnalista.Fields[2].AsString = 'AD') or
                 (dmActs.SQLGetAnalista.Fields[2].AsString = 'CA') then
                 QLblAnalista.Caption:=dmActs.SQLGetAnalista.Fields[3].AsString
              else
                if (dmActs.SQLGetAnalista.Fields[4].AsString = 'AD') or
                   (dmActs.SQLGetAnalista.Fields[4].AsString = 'CA') then
                   QLblAnalista.Caption:=dmActs.SQLGetAnalista.Fields[5].AsString
                else
                  if (dmActs.SQLGetAnalista.Fields[6].AsString = 'AD') or
                     (dmActs.SQLGetAnalista.Fields[6].AsString = 'CA') then
                     QLblAnalista.Caption:=dmActs.SQLGetAnalista.Fields[7].AsString
                  else
                     QLblAnalista.Caption:='';
          end;
          if QLblAnalista.Caption <> '' then
          begin
            QLblAnalista.Caption := GetEmployeeNameAnalista(QLblAnalista.Caption,True);
           // QLblAnalista.Caption := copy(QLblAnalista.Caption,1,20);
          end
          else
          begin
            QLblAnalista.Caption := 'No Definido';
          end;
          QLblNetValue.Caption      := Format('%m',[ActPaidNetValue]);
          Administrator := dmActs.GetContractAdministrator(ActPaidContract,ActPaidPortion);
          QLblAdministrator.Caption := Administrator + ' (' + GetEmployeeName(Administrator,True) + ')';
          If Trim(Approver) = '' Then Begin
             QLblApprover.Caption := ''; End
          Else Begin
             QLblApprover.Caption := GetEmployeeName(Approver,True);
          End;
          With dmacts.SQLGetPosApprover Do Begin
               Try
                   Active:=False;
                   Params[0].AsString:=ActPaidContract;
                   Params[1].AsString:=ActPaidCode;
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
          If Trim(dmActs.SQLGetPosApprover.Fields[0].AsString) = '' Then Begin
             QLblPosApprover.Caption := ''; End
          Else Begin
             QLblPosApprover.Caption := dmActs.SQLGetPosApprover.Fields[0].AsString;
          End;

          QLblApprover.Caption := QLblApprover.Caption + ' (' + QLblPosApprover.Caption + ')';
          QLblPosApprover.Caption := '';

          If UserConfig.DTypeComments = tcFull Then Begin
             OpenComments;
             QMmComments.Lines.Assign(SQLCommentsACT_COMMENTS);
          End;
          If UserConfig.DTypeCntrctExt = tcePrintExt Then Begin
             QLblOriStartDt.Caption := Date8ToDisplayFormat(SQLContractORIG_START_DT.AsString);
             QLblAmnStartDt.Caption := Date8ToDisplayFormat(SQLContractAMEND_START_DT.AsString);
             QLblOriComplDt.Caption := Date8ToDisplayFormat(SQLContractORIG_COMPL_DT.AsString);
             QLblAmnComplDt.Caption := Date8ToDisplayFormat(SQLContractAMEND_COMPL_DT.AsString);
             QLblFinComplDt.Caption := Date8ToDisplayFormat(SQLContractFINAL_COMPL_DT.AsString);
          End;
          QLblInvCurrency.Caption     := InvCurrency;
          QLblInvChangeRate.Caption   := FloatToStr(InvChangeRate);
          Try
             If StrToInt(InvChangeRateDt) = 0 Then Begin
                QLblInvChangeRateDt.Caption := ''; End
             Else Begin
                QLblInvChangeRateDt.Caption := Date8ToDisplayFormat(InvChangeRateDt);
             End;
          Except
             QLblInvChangeRateDt.Caption := '';
          End;
     End;
     FDetailIndex          := 0;
     FCCListKind           := cclkPositive;
     FCCListIndex          := 0;
     FPrintTtlNegative     := False;
     LoadCC;
End;
{ Use this routine to Fill Up a detail line in the report. AnIndex is the
  index in the internal detail list }
procedure TfrmSAQ301010QRActPaid.FillUpDetailLine(AnIndex:Integer);
Begin
     With dmActs,TCategoryDef(Details.Items[AnIndex]) Do Begin
          QLblElement.Caption  := ElementActs.GetElementName(CurrentActPaid.ActPaidContract,
                                                             CurrentActPaid.ActPaidPortion,
                                                             CategoryElement);
          QLblCategory.Caption := CategoryDesc;
          If Abs(CategoryGlobal) < 0.1 Then Begin
             { Don't print zero values }
             QLblValue.Caption := '';End
          Else Begin
             QLblValue.Caption := Format('%m',[CategoryGlobal]);
          End;
          If CategoryByGlobal Then Begin
             QLblQuantity.Caption  := '';
             QLblUnit.Caption      := '';
             QLblRateValue.Caption := ''; End
          Else Begin
             QLblQuantity.Caption  := FloatToStr(CategoryQuantity);
             QLblUnit.Caption      := CategoryMeasure;
             QLblRateValue.Caption := Format('%m',[CategoryRate]);
          End;
     End;
End;

Procedure TfrmSAQ301010QRActPaid.LoadCC;
Var
   TheValue:            Currency;
   TheElement:          String;
   TheElementCode:      String;
   TheCC:               String;
   ThePercent:          Double;
   IsNegative:          Boolean;
   TheDocumentType:     String; {IC658}
   TheDocumentNo:       String; {IC658}
Begin
     FCCPositives.Clear;
     FCCNegatives.Clear;
     With dmActs,tblCosts, CurrentActPaid Do Begin
          First;
          While Not Eof Do Begin
                TheElement := tblCostsELEMENT_NO.AsString;
                TheElementCode := dmActs.GetElementCode(ActPaidContract,ActPaidPortion,TheElement);
                TheValue   := Details.ValueOfElementNo[TheElement];
                If (Abs(TheValue) > Delta) and (tblCostsPERCENT.AsInteger>0) Then Begin
                {If Abs(TheValue) > Delta Then Begin }
                   { Only Add values No Zero. Use Delta to avoid precision errors}
                   ThePercent := tblCostsPERCENT.AsInteger / 10000.0;
                   TheValue   := ThePercent * TheValue;
                   TheCC      := tblCostsGL_ACCOUNT.AsString;
                   IsNegative := CrrEleNoDef.IsDiscount[TheElement + TheElementCode];
           {IC658} TheDocumentType := tblCostsDOCUMENT_TYPE.AsString;
           {IC658} TheDocumentNo   := tblCostsDOCUMENT_NO.AsString;
                   If IsNegative Then Begin
           {IC658}    FCCNegatives.AddCC(TheCC,TheValue,TheDocumentType,TheDocumentNo); End
                   Else Begin
           {IC658}    FCCPositives.AddCC(TheCC,TheValue,TheDocumentType,TheDocumentNo);
                   End;
                End;
                Next;
          End;
     End;
     FCCPositives.CalculatePercents;
     FCCNegatives.CalculatePercents;
     FCCPositives.Sorted := True;
     FCCNegatives.Sorted := True;
End;
procedure TfrmSAQ301010QRActPaid.QRReportNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
     MoreData := FDetailIndex < dmActs.Details.Count;
     If MoreData Then Begin
        FillUpDetailLine(FDetailIndex);
        Inc(FDetailIndex);
     End;
end;

procedure TfrmSAQ301010QRActPaid.QRDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     { Print only non zero values }
     PrintBand := QLblValue.Caption <> '';
end;

procedure TfrmSAQ301010QRActPaid.QRBndActPaidExtBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     PrintBand := dmActs.UserConfig.DTypeCntrctExt = tcePrintExt;
     PrintBand := PrintBand And FPrintAtax;
     If PrintBand Then Begin
        FPrintAtax := False;
     End;
end;

procedure TfrmSAQ301010QRActPaid.QRBndCommentsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     PrintBand := dmActs.UserConfig.DTypeComments = tcFull;
end;

procedure TfrmSAQ301010QRActPaid.QRBndInfoAtaxBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     PrintBand := dmActs.UserConfig.DAPInfoAtax = apiaYes;
     If PrintBand Then Begin
        PrintBand := FDetailIndex = dmActs.Details.Count;
     End;
     If PrintBand Then Begin
        PrintBand := Not dmActs.SQLInfoAtaxATAX_CODE.IsNull;
     End;
end;
procedure TfrmSAQ301010QRActPaid.PrintAtaxDetails;
Var
   AtaxCode:            String;
   AtaxRate:            String;
   AtaxDesc:            Variant;
   AtaxBase:            Currency;
   AtaxValue:           Currency;
Begin
     FPrintInfoAtax := True;
     AtaxCode  := dmActs.SQLInfoAtaxATAX_CODE.AsString;
     AtaxRate  := Format('%8.2f',[dmActs.SQLInfoAtaxATAX_RATE.AsFloat]);
     AtaxDesc  := dmActs.GetAtaxDesc( Trim(AtaxCode) );
     //AtaxDesc  := dmActs.SQLAtaxCodes010.Lookup('TABLE_CODE',AtaxCode,'TABLE_DESC');
     AtaxBase  := dmActs.SQLInfoAtaxATAX_BASE.AsCurrency;
     AtaxValue := dmActs.SQLInfoAtaxATAX_VALUE.AsCurrency;
     QLblInfoAtaxRate.Caption  := AtaxRate + ' %';
     If VarIsUnAssigned(AtaxDesc) Then Begin
        QLblInfoAtaxDesc.Caption  := ''; End
     Else Begin
        QLblInfoAtaxDesc.Caption  := AtaxDesc;
     End;
     QLblInfoAtaxBase.Caption     := Format('%m',[AtaxBase]);
     QLblInfoInvAtaxBase.Caption  := Format('%m',[InvChangeRate*AtaxBase]);
     QLblInfoAtaxValue.Caption    := Format('%m',[AtaxValue]);
     QLblInfoInvAtaxValue.Caption := Format('%m',[InvChangeRate*AtaxValue]);
End;
procedure TfrmSAQ301010QRActPaid.QRBndInfAtxDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     QRBndInfoAtaxBeforePrint(Sender,PrintBand);
     If PrintBand Then Begin
        PrintAtaxDetails;
     End;
end;
procedure TfrmSAQ301010QRActPaid.QRBndCCDetailSummmaryBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := PrintedCCHeader;
end;

procedure TfrmSAQ301010QRActPaid.QRBndCCSummaryBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := FDetailIndex = dmActs.Details.Count;
     If PrintBand Then Begin
        If dmActs.UserConfig.DAPInfoAtax = apiaYes Then Begin
           PrintBand := PrintInfoAtax And dmActs.SQLInfoAtax.EoF;
        End;
     End;
     If PrintBand Then Begin
        PrintedCCHeader := True;
     End;
end;

procedure TfrmSAQ301010QRActPaid.QRBndCCDetailSummmaryNeedData(
  Sender: TObject; var MoreData: Boolean);
begin
     MoreData := False;
     QRBndCCSummaryBeforePrint(Nil,MoreData);
     If PrintedCCHeader Then Begin
        Case FCCListKind Of
        cclkPositive : MoreData := CheckMoreDataByPositive;
        cclkNegative : MoreData := CheckMoreDataByNegative;
        End;
        If MoreData Then Begin
           Case FCCListKind Of
           cclkPositive : PrintCCLine(FCCPositives,FCCListIndex);
           cclkNegative : PrintCCLine(FCCNegatives,FCCListIndex);
           End;
           Inc(FCCListIndex);
        End;
     End;
end;

procedure TfrmSAQ301010QRActPaid.QRTtlBndCCNegativeBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := FPrintTtlNegative;
end;

procedure TfrmSAQ301010QRActPaid.QRTtlBndCCNegativeAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
     FPrintTtlNegative := False;
end;

procedure TfrmSAQ301010QRActPaid.QRBndCCDetailSummmaryAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
     If FCCNegatives.Count > 0 Then Begin
        If FCCListKind = cclkPositive Then Begin
           FPrintTtlNegative := FCCListIndex = FCCPositives.Count;
        End;
     End;
end;

procedure TfrmSAQ301010QRActPaid.QLblCCSection1Print(sender: TObject;
  var Value: String);
begin
     If (FCCPositives.Count = 0) And (FCCNegatives.Count > 0) Then Begin
        QLblCCSection1.Caption := QLblCCSection2.Caption;
     End;
end;
Function TfrmSAQ301010QRActPaid.CheckMoreDataByPositive:Boolean;
Begin
     If FCCListIndex < FCCPositives.Count Then Begin
        CheckMoreDataByPositive := True; End
     Else Begin
        FCCListKind  := cclkNegative;
        FCCListIndex := 0;
        CheckMoreDataByPositive := CheckMoreDataByNegative;
     End;
End;
Function TfrmSAQ301010QRActPaid.CheckMoreDataByNegative:Boolean;
Begin
     CheckMoreDataByNegative := FCCListIndex < FCCNegatives.Count;
End;
procedure TfrmSAQ301010QRActPaid.PrintCCLine(AList:TCCSummaryList;ALineNo:Integer);
Var
   TheCC:               TCCSummary;
Begin
     TheCC := AList.CostCenterAt[ALineNo];
     {De Moya 2006-09-13 IC845 - incluyo copy para que sólo despliegue el centro de costos}
     QLblCCAccount.Caption := copy(AList[ALineNo],1,pos('%#',AList[ALineNo])-1);
     QLblCCPercent.Caption := TheCC.PercentAsText;
     QLblCCValue.Caption   := Format('%m',[TheCC.Value]);
     if TheCC.DocumentType = '1' then               {IC658}
        QLblCCDocType.Caption := 'Orden de Trabajo' {IC658}
     else if TheCC.DocumentType = '2' then          {IC658}
        QLblCCDocType.Caption := 'Proyecto'         {IC658}
     else                                           {IC658}
        QLblCCDocType.Caption := '';                {IC658}
     QLblCCDocNo.Caption   := TheCC.DocumentNo;     {IC658}
End;
procedure TfrmSAQ301010QRActPaid.FormCreate(Sender: TObject);
begin
     inherited;
     FCCPositives := TCCSummaryList.Create;
     FCCNegatives := TCCSummaryList.Create;
end;

procedure TfrmSAQ301010QRActPaid.FormDestroy(Sender: TObject);
begin
     FCCPositives.Free;
     FCCNegatives.Free;
     inherited;
end;

end.
