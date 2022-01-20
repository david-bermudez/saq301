{ This report use, basically, the same logic structures of the Rep01;
  therefore, it's possible (and easy) to create it as a descendent
  class. We did prefer to create it as an independent report because
  two reasons :
  1. There are only two reports with the same structure
  2. For a most easy update, the best is to have independent codes }
unit SAQ301012;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SAQ301009, DBCtrls, Qrctrls, QuickRpt, ExtCtrls;

type
  TfrmSAQ301012QRRep02 = class(TfrmSAQ301009ParentReports)
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QLblPortionDate: TQRLabel;
    QLblDescription: TQRLabel;
    QLblContractQty: TQRLabel;
    QLblItemValue: TQRLabel;
    QLblPaidValue: TQRLabel;
    QLblPortionNo: TQRLabel;
    QLblPaidQty: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QLblContractNo: TQRLabel;
    QLblContractDesc: TQRLabel;
    QRLabel11: TQRLabel;
    QLblContractValue: TQRLabel;
    QRLabel12: TQRLabel;
    QLblPaidToContract: TQRLabel;
    QRLabel13: TQRLabel;
    QLblSupplierName: TQRLabel;
    QRLabel14: TQRLabel;
    QLblContractDate: TQRLabel;
    QRLabel15: TQRLabel;
    QLblSupplierId: TQRLabel;
    QLblCurrency: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QRReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
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
  frmSAQ301012QRRep02: TfrmSAQ301012QRRep02;

Procedure PrintRep02(AOwner:TComponent;ACondition:String);
implementation

uses MCDMActs, MCObjcts, MCTypes, MCUtils;

{$R *.DFM}
Procedure PrintRep02(AOwner:TComponent;ACondition:String);
Begin
     frmSAQ301012QRRep02 := Nil;
     Try
        frmSAQ301012QRRep02 := TfrmSAQ301012QRRep02.Create(AOwner,ACondition);
        frmSAQ301012QRRep02.QRReport.Preview;
     Finally
        frmSAQ301012QRRep02.Free;
     End;
End;
Function Rep02Sorted(Item1,Item2:Pointer):Integer;
Var
   Line1:               TLine02;
   Line2:               TLine02;
Begin
     Line1 := TLine02(Item1);
     Line2 := TLine02(Item2);
     If Line1.Key = Line2.Key Then Begin
        Rep02Sorted := 0; End
     Else Begin
        If Line1.Key < Line2.Key Then Begin
           Rep02Sorted := -1; End
        Else Begin
           Rep02Sorted := 1;
        End;
     End;
End;
Constructor TfrmSAQ301012QRRep02.Create(AOwner:TComponent;ACondition:String);
Begin
     FSelection := ACondition;
     Inherited Create(AOwner);
End;
Procedure TfrmSAQ301012QRRep02.ProcessLine(Sender:TObject);
  Procedure NormalDetailLine;
  Begin
        With Sender As TLine02 Do Begin
             QLblPortionNo.Caption   := '';
             QLblPortionDate.Caption := '';
             QLblDescription.Caption := '      ' + CategoryName;
             QLblItemValue.Caption   := Format('%m',[ItemValue]);
             QLblPaidValue.Caption   := Format('%m',[PaidValue]);
             If Abs(ContractQty)<0.00001 Then Begin
                QLblContractQty.Caption := '';
                QLblPaidQty.Caption     := ''; End
             Else Begin
                QLblContractQty.Caption := Format('%15.2f',[ContractQty]);
                QLblPaidQty.Caption     := Format('%15.2f',[PaidQty]);
             End;
        End;
  End;
  Procedure ElementSection;
  Begin
       With Sender As TLine02 Do Begin
            QLblPortionNo.Caption   := '';
            QLblPortionDate.Caption := '';
            QLblDescription.Caption := Format('   %s %s',[ElementNo,ElementName]);
            QLblContractQty.Caption := '';
            QLblPaidQty.Caption     := '';
            QLblItemValue.Caption   := Format('%m',[ItemValue]);
            QLblPaidValue.Caption   := Format('%m',[PaidValue]);
       End;
  End;
  Procedure SubHeaderOfSection;
  Begin
       With dmActs,Sender As TLine02 Do Begin
            GetPortionDefinition(ContractNo,PortionNo);
            QLblPortionNo.Caption   := PortionNo;
            QLblCurrency.Caption    := SQLPortionLIQ_DAM_BASE.AsString;
            QLblPortionDate.Caption := ContractDate;
            QLblDescription.Caption := SQLPortionPORTION_DESC.AsString;
            QLblContractQty.Caption := '';
            QLblPaidQty.Caption     := '';
            QLblItemValue.Caption   := Format('%m',[ItemValue]);
            QLblPaidValue.Caption   := Format('%m',[PaidValue]);
       End;
  End;
  Procedure HeaderOfSection;
  Var
     SupplierNo:        String;     { Contract Supplier No }
  Begin
       FPrintDetail := False;
       With dmActs,Sender As TLine02 Do Begin
            GetContractDefinition(ContractNo);
            SupplierNo := SQLContractSUPPLIER_NO.AsString;
            QLblSupplierName.Caption   := GetSupplierName(SupplierNo);
            QLblSupplierId.Caption     := GetSupplierId(CurrentDistrict,SupplierNo);
            QLblContractNo.Caption     := ContractNo;
            QLblContractDate.Caption   := ContractDate;
            QLblContractDesc.Caption   := SQLContractCONTRACT_DESC.AsString;
            QLblContractValue.Caption  := Format('%m',[ItemValue]);
            QLblPaidToContract.Caption := Format('%m',[PaidValue]);
       End;
       QRReport.NewColumn;
  End;
Begin
     Case (Sender As TLine02).Kind Of
     klNormal    : NormalDetailLine;
     klElement   : ElementSection;
     klSubHeader : SubHeaderOfSection;
     klHeader    : HeaderOfSection;
     End;
End;
Procedure TfrmSAQ301012QRRep02.CreateLines;
Var
   Line:                TLine02;
Begin
     With dmActs,SQLRep02 Do Begin
          ExecQueryForRep02(FSelection);    
          While Not EoF Do Begin
                Line := TLine02.Create;
                With Line Do Begin
                     Kind         := klNormal;
                     ContractNo   := SQLRep02CONTRACT_NO.AsString;
                     PortionNo    := SQLRep02PORTION_NO.AsString;
                     ElementNo    := SQLRep02ELEMENT_NO.AsString;
                     ContractDate := '';
                     LoadElementsIn(ContractNo,PortionNo);
                     ElementName  := ElementActs.GetElementName(ContractNo,
                                                                PortionNo,
                                                                ElementNo);
                     { Try to get a custom name for the category. If doesn't
                       exist, then use the global name (the name in the table
                       'CE' of MSF010, avalaible as SQLRep01TABLE_DESC }
                     RefreshCustomCategoryNames(ContractNo,PortionNo);
                     CategoryName  := CategoryNames.GetCategoryNameAt(
                                         ContractNo,PortionNo,ElementNo,
                                         SQLRep02CATEGORY_NO.AsString);
                     If CategoryName = '' Then Begin
                        CategoryName := SQLRep02TABLE_DESC.AsString;
                     End;
                     ContractQty  := SQLRep02CATEG_BASE_QTY.AsFloat;
                     ItemValue    := SQLRep02CATEG_BASE_VAL.AsCurrency;
                     GetPaidsToCategory(ContractNo,PortionNo,ElementNo,
                                        SQLRep02CATEGORY_NO.AsString,
                                        PaidValue,PaidQty);
                End;
                AddDataLine(Line);
                Next;
          End;
     End;
End;
{ Modify the list of lines to insert at begin of each group of detail lines
  the total values of this group. There are three kind of groups : The most
  internal groups are the detail lines of an element (element lines) into
  a Portion (the SubHeader lines) and the external groups are the SubHeader
  lines, of a Contract (Header Lines). We need to create this routine because
  the Quick Report tools default behavior add the total values at end of
  each group, not at begin }
Procedure TfrmSAQ301012QRRep02.AddSubTotalLines;
Var
   IndexLine:           Integer;    { Current Line Index in the List }
   InsertContractIn:    Integer;    { Insertion point index for a Header line }
   InsertPortionIn:     Integer;    { Insertion point index for a SubHeader line }
   InsertElementIn:     Integer;    { Insertion point index for an Element line }
   CurrentContract:     String;     { Current Contract Code }
   CurrentPortion:      String;     { Current Portion Code }
   CurrentElement:      String;     { Current Element Code }
   CurrentLine:         TLine01;    { Current Data Line values }
   NewLine:             TLine01;    { New Data Lines values }
   StartDate:           String;     { Start Date for a Contract/Portion }
   ContractSum1:        Currency;   { Contract Value for a Contract }
   ContractSum2:        Currency;   { Paid Value for a Contract }
   PortionSum1:         Currency;   { Contract Value for a Contract/Portion }
   PortionSum2:         Currency;   { Paid Value for a Contract/Portion }
   ElementSum1:         Currency;   { Contract Value for a Contract/Portion/Element }
   ElementSum2:         Currency;   { Paid Value for a Contract/Portion/Element }
  Procedure InitGroup;
  Begin
       ElementSum1     := 0;
       ElementSum2     := 0;
       CurrentContract := CurrentLine.ContractNo;
       CurrentPortion  := CurrentLine.PortionNo;
       CurrentElement  := CurrentLine.ElementNo;
  End;
  Procedure InsertSubTotalLine(InsertIn:Integer;AKind:TKindLine;ADate:String;
                               ASum1,ASum2:Currency);
  Begin
       NewLine              := TLine02.Create;
       With NewLine Do Begin
            Kind         := AKind;
            ContractNo   := CurrentContract;
            PortionNo    := CurrentPortion;
            ElementNo    := CurrentElement;
            ElementName  := dmActs.ElementActs.GetElementName(ContractNo,
                                                              PortionNo,
                                                              ElementNo);
            ContractDate := Date8ToDisplayFormat(ADate);
            ItemValue    := ASum1;
            PaidValue    := ASum2;
       End;
       ReportLines.Insert(InsertIn,NewLine);
  End;
Begin
     IndexLine        := 0;
     InsertContractIn := 0;
     InsertPortionIn  := 0;
     InsertElementIn  := 0;
     PortionSum1      := 0;
     PortionSum2      := 0;
     ContractSum1     := 0;
     ContractSum2     := 0;
     CurrentLine      := ReportLines[0];
     InitGroup;
     While IndexLine < ReportLines.Count Do Begin
           CurrentLine := ReportLines[IndexLine];
           With CurrentLine Do Begin
                If (CurrentContract = ContractNo) And
                   (CurrentPortion  = PortionNo)  And
                   (CurrentElement  = ElementNo) Then Begin
                   ElementSum1 := ElementSum1 + ItemValue;
                   ElementSum2 := ElementSum2 + PaidValue;End
                Else Begin
                   { First, create the Element Line and insert it into the list }
                   InsertSubTotalLine(InsertElementIn,klElement,'',
                                      ElementSum1,ElementSum2);
                   InsertElementIn := IndexLine + 1;
                   PortionSum1 := PortionSum1 + ElementSum1;
                   PortionSum2 := PortionSum2 + ElementSum2;
                   { Second, if it's also a change of portion, create the
                     SubHeader Line and insert it into the list }
                   If (CurrentContract <> ContractNo) Or
                      (CurrentPortion  <> PortionNo) Then Begin
                      StartDate := dmActs.GetPortionDate(CurrentContract,
                                                         CurrentPortion);
                      InsertSubTotalLine(InsertPortionIn,klSubHeader,StartDate,
                                         PortionSum1,PortionSum2);
                      Inc(InsertElementIn);
                      InsertPortionIn := InsertElementIn;
                      ContractSum1    := ContractSum1 + PortionSum1;
                      ContractSum2    := ContractSum2 + PortionSum2;
                      PortionSum1     := 0;
                      PortionSum2     := 0;
                   End;
                   { Third, if it's also a change of contract, create the
                     Header Line and insert it into the list }
                   If CurrentContract <> ContractNo Then Begin
                      StartDate := dmActs.GetContractDate(CurrentContract);
                      InsertSubTotalLine(InsertContractIn,klHeader,StartDate,
                                         ContractSum1,ContractSum2);
                      Inc(InsertElementIn);
                      Inc(InsertPortionIn);
                      InsertContractIn := InsertPortionIn;
                      ContractSum1     := 0;
                      ContractSum2     := 0;
                   End;
                   { Set the new current position }
                   IndexLine := InsertElementIn - 1;
                   { Now, update the initial values for the new group }
                   InitGroup;
                End;
           End;
           Inc(IndexLine);
     End;
     { Create the last SubTotal Lines and insert them into the list }
     InsertSubTotalLine(InsertElementIn,klElement,'',ElementSum1,ElementSum2);
     PortionSum1 := PortionSum1 + ElementSum1;
     PortionSum2 := PortionSum2 + ElementSum2;
     StartDate   := dmActs.GetPortionDate(CurrentContract,CurrentPortion);
     InsertSubTotalLine(InsertPortionIn,klSubHeader,StartDate,
                        PortionSum1,PortionSum2);
     ContractSum1 := ContractSum1 + PortionSum1;
     ContractSum2 := ContractSum2 + PortionSum2;
     StartDate    := dmActs.GetContractDate(CurrentContract);
     InsertSubTotalLine(InsertContractIn,klHeader,StartDate,
                        ContractSum1,ContractSum2);
End;
procedure TfrmSAQ301012QRRep02.FormCreate(Sender: TObject);
var
   Save_Cursor:         TCursor;
begin
     Save_Cursor      := Screen.Cursor;
     Try
        Screen.Cursor := crHourglass;
        CreateLines;
        If ReportLines.Count > 0 Then Begin
           ReportLines.Sort(Rep02Sorted);
           AddSubTotalLines;
        End;
     Finally
        Screen.Cursor := Save_Cursor;
        { Close the DataSet }
        dmActs.SQLRep02.Active := False;
     End;
end;
procedure TfrmSAQ301012QRRep02.QRReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     inherited;
     FPrintDetail := True;
end;

procedure TfrmSAQ301012QRRep02.QRDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     inherited;
     PrintBand    := FPrintDetail;
     FPrintDetail := True;
end;

end.
