unit SAQ301014;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SAQ301009, DBCtrls, Qrctrls, QuickRpt, ExtCtrls;

type
  TfrmSAQ301014QRRep04 = class(TfrmSAQ301009ParentReports)
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QLblItemValue: TQRLabel;
    QLblPaidValue: TQRLabel;
    QLblPortionSDate: TQRLabel;
    QLblActPaidNo: TQRLabel;
    QLblActPaidDate: TQRLabel;
    QRLabel9: TQRLabel;
    QLblPortionNo: TQRLabel;
    QRLabel10: TQRLabel;
    QLblStatus: TQRLabel;
    QRLabel12: TQRLabel;
    QLblContractNo: TQRLabel;
    QLblContractDesc: TQRLabel;
    QRLabel14: TQRLabel;
    QLblSupplierName: TQRLabel;
    QRLabel16: TQRLabel;
    QLblContractValue: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QLblSupplierId: TQRLabel;
    QLblPaidToContract: TQRLabel;
    QRLabel19: TQRLabel;
    QLblContractDate: TQRLabel;
    QLblPortionFDate: TQRLabel;
    QRLabel8: TQRLabel;
    QLblPortionDesc: TQRLabel;
    QLblCurrency: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QRDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    FSelection:         String;   { Condition to include only contracts selected }
    FPrintDetail:       Boolean;  { Flag to disable the detail printing for the contract lines }
    Procedure CreateLines;
    Procedure AddSubTotalLines;
  protected
    { Protected declarations }
    Procedure ProcessLine(Sender:TObject); override;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent;ACondition:String);
  end;

var
  frmSAQ301014QRRep04: TfrmSAQ301014QRRep04;

Procedure PrintRep04(AOwner:TComponent;ACondition:String);
implementation

uses MCDMActs, MCObjcts, MCTypes, MCUtils;

{$R *.DFM}
Procedure PrintRep04(AOwner:TComponent;ACondition:String);
Begin
     frmSAQ301014QRRep04:=Nil;
     Try
        frmSAQ301014QRRep04 := TfrmSAQ301014QRRep04.Create(AOwner,ACondition);
        frmSAQ301014QRRep04.QRReport.Preview;
     Finally
        frmSAQ301014QRRep04.Free;
     End;
End;
Constructor TfrmSAQ301014QRRep04.Create(AOwner:TComponent;ACondition:String);
Begin
     FSelection := ACondition;
     Inherited Create(AOwner);
End;
{ Modify the list of lines to insert at begin of each group Contract/Portion
  the total values of this group. We need to create this routine because
  the Quick Report tools default behavior add the total values at end of
  each group, not at begin }
Procedure TfrmSAQ301014QRRep04.AddSubTotalLines;
Var
   IndexLine:           Integer;
   InsertContractIn:    Integer;    { Insertion point index for a Header line }
   InsertPortionIn:     Integer;    { Insertion point index for a SubHeader line }
   CurrentContract:     String;     { Current Contract Code }
   CurrentPortion:      String;     { Current Portion Code }
   CurrentLine:         TLine04;    { Current Act Paid Definition  }
   NewLine:             TLine04;    { Definition of a New SubTotal line }
   ContractSum1:        Currency;   { Contract Value for a Contract }
   PortionSum1:         Currency;   { Contract Value for a Contract/Portion }
  Procedure InsertSubTotalLine(InsertIn:Integer;AKind:TKindLine;AValue:Currency);
  Begin
       NewLine              := TLine04.Create;
       NewLine.Kind         := AKind;
       NewLine.ContractNo   := CurrentContract;
       NewLine.PortionNo    := CurrentPortion;
       NewLine.PaidValue    := AValue;
       ReportLines.Insert(InsertIn,NewLine);
  End;
Begin
     IndexLine        := 0;
     InsertContractIn := 0;
     InsertPortionIn  := 0;
     PortionSum1      := 0;
     ContractSum1     := 0;
     CurrentLine      := ReportLines[IndexLine];
     CurrentContract  := CurrentLine.ContractNo;
     CurrentPortion   := CurrentLine.PortionNo;
     While IndexLine < ReportLines.Count Do Begin
           CurrentLine := ReportLines[IndexLine];
           With CurrentLine Do Begin
                If (CurrentContract = ContractNo) And
                   (CurrentPortion  = PortionNo) Then Begin
                   If ActPaidStatus in [asApproved,asInvoiced] Then Begin
                      PortionSum1 := PortionSum1 + ItemValue;
                   End; End
                Else Begin
                   { First, create the SubTotal Line and insert it into the list }
                   InsertSubTotalLine(InsertPortionIn,klSubHeader,PortionSum1);
                   InsertPortionIn := IndexLine + 1;
                   ContractSum1    := ContractSum1 + PortionSum1;
                   { Second, if it's also a change of contract, create the
                     Header Line and insert it into the list }
                   If CurrentContract <> ContractNo Then Begin
                      InsertSubTotalLine(InsertContractIn,klHeader,ContractSum1);
                      ContractSum1 := 0;
                      Inc(InsertPortionIn);
                      InsertContractIn := InsertPortionIn;
                   End;
                   { Now, set the initial values for the new group }
                   IndexLine       := InsertPortionIn - 1;
                   CurrentContract := ContractNo;
                   CurrentPortion  := PortionNo;
                   PortionSum1     := 0;
                End;
           End;
           Inc(IndexLine);
     End;
     { Create the last SubTotal Line and insert it into the list }
     InsertSubTotalLine(InsertPortionIn,klSubHeader,PortionSum1);
     ContractSum1 := ContractSum1 + PortionSum1;
     InsertSubTotalLine(InsertContractIn,klHeader,ContractSum1);
End;
Procedure TfrmSAQ301014QRRep04.CreateLines;
Var
   Line:                TLine04;
   StatusCode:          Byte;
Begin
     With dmActs,SQLRep04 Do Begin
          ExecQueryForRep04(FSelection);
          While Not EoF Do Begin
                Line := TLine04.Create;
                With Line Do Begin
                     Kind          := klNormal;
                     ContractNo    := SQLRep04CONTRACT_NO.AsString;
                     PortionNo     := SQLRep04PORTION_NO.AsString;
                     ActPaidNo     := SQLRep04ACT_PAID_NO.AsString;
                     ActPaidDate   := SQLRep04ACT_PAID_DATE.AsString;
                     StatusCode    := SQLRep04STATUS.AsInteger;
                     ActPaidStatus := TActStatus(StatusCode);
                     If ActPaidStatus <> asNull Then Begin
                        ItemValue  := GetActPaidValue(ContractNo,ActPaidNo);
                     End;
                     If ActPaidStatus In [asApproved,asCounted,asInvoiced,asClosed] Then Begin
                        PaidValue  := SQLRep04PRV_EXEC_VALUE.AsCurrency;
                     End;
                End;
                AddDataLine(Line);
                Next;
          End;
     End;
End;
Procedure TfrmSAQ301014QRRep04.ProcessLine(Sender:TObject);
  Procedure NormalDetailLine;
  Begin
        With Sender As TLine04 Do Begin
             QLblPortionNo.Caption    := '';
             QLblPortionSDate.Caption := '';
             QLblPortionFDate.Caption := '';
             QLblPortionDesc.Caption  := '';
             //QLblActPaidNo.Caption    := ActPaidNo;
             {QLblValnNo.Caption       := dmActs.SQLGetValnNo(Trim(ContractNo), Trim(ActPaidNo));}
             QLblActPaidDate.Caption  := Date8ToDisplayFormat(ActPaidDate);
             QLblStatus.Caption       := StatusNames[ActPaidStatus];
             If ActPaidStatus <> asNull Then Begin
                QLblItemValue.Caption := Format('%m',[ItemValue]); End
             Else Begin
                QLblItemValue.Caption := '';
             End;
             If ActPaidStatus In [asApproved,asInvoiced] Then Begin
                QLblPaidValue.Caption := Format('%m',[PaidValue]); End
             Else Begin
                QLblPaidValue.Caption := '';
             End;
        End;
  End;
  Procedure SubHeaderOfSection;
  Var
     StartDateStr:      String;     { Date of the portion start (format 8) }
     FinalDateStr:      String;     { Date of the portion finalization (format 8) }
  Begin
       With dmActs,Sender As TLine04 Do Begin
            GetPortionDefinition(ContractNo,PortionNo);
            GetPortionRange(StartDateStr,FinalDateStr);
            QLblPortionNo.Caption    := PortionNo;
            QLblCurrency.Caption     := SQLPortionLIQ_DAM_BASE.AsString;
            QLblPortionSDate.Caption := Date8ToDisplayFormat(StartDateStr);
            QLblPortionFDate.Caption := Date8ToDisplayFormat(FinalDateStr);
            QLblPortionDesc.Caption  := SQLPortionPORTION_DESC.AsString;
            //QLblActPaidNo.Caption    := '';
            {QLblValnNo.Caption       := '';}
            QLblActPaidDate.Caption  := '';
            QLblStatus.Caption       := '';
            QLblItemValue.Caption    := Format('%m',[SQLPortionPORTION_VAL.AsCurrency]);
            QLblPaidValue.Caption    := Format('%m',[PaidValue]);
       End;
  End;
  Procedure HeaderOfSection;
  Var
     SupplierNo:        String;     { Contract Supplier No }
  Begin
       FPrintDetail := False;
       With dmActs,Sender As TLine04 Do Begin
            GetContractDefinition(ContractNo);
            SupplierNo := SQLContractSUPPLIER_NO.AsString;
            QLblSupplierName.Caption   := GetSupplierName(SupplierNo);
            QLblSupplierId.Caption     := GetSupplierId(CurrentDistrict,SupplierNo);
            QLblContractNo.Caption     := ContractNo;
            QLblContractDate.Caption   := Date8ToDisplayFormat(SQLContractCNTRCT_BASE_DT.AsString);
            QLblContractDesc.Caption   := SQLContractCONTRACT_DESC.AsString;
            QLblContractValue.Caption  := Format('%m',[SQLContractCONTRACT_VAL.AsCurrency]);
            QLblPaidToContract.Caption := Format('%m',[PaidValue]);
       End;
       QRReport.NewColumn;
  End;
Begin
     Case (Sender As TLine04).Kind Of
     klNormal    : NormalDetailLine;
     klSubHeader : SubHeaderOfSection;
     klHeader    : HeaderOfSection;
     End;
End;
procedure TfrmSAQ301014QRRep04.FormCreate(Sender: TObject);
var
   Save_Cursor:         TCursor;
begin
     Save_Cursor      := Screen.Cursor;
     Try
        Screen.Cursor := crHourglass;
        CreateLines;
        If ReportLines.Count > 0 Then Begin
           AddSubTotalLines;
        End;
     Finally
        Screen.Cursor := Save_Cursor;
        { Close the DataSet }
        dmActs.SQLRep04.Active := False;
     End;
end;

procedure TfrmSAQ301014QRRep04.QRDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     inherited;
     PrintBand    := FPrintDetail;
     FPrintDetail := True;
end;
procedure TfrmSAQ301014QRRep04.QRReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     inherited;
     FPrintDetail := True;
end;
end.
