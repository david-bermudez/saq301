unit SAQ301011;

{ Rep 01 :
  The report 01 contains the progress in the execution of every contract
  assigned to the user. The progress is shown for every category in each
  contract. The progress are the total values of the Acts for a contract.
  The report is ordered by Supplier name, Contract Code. }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SAQ301009, Qrctrls, QuickRpt, ExtCtrls, DBCtrls;

type
  TfrmSAQ301011QRRep01 = class(TfrmSAQ301009ParentReports)
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QLblContractNo: TQRLabel;
    QLblContractDate: TQRLabel;
    QLblEleCatName: TQRLabel;
    QLblContractQty: TQRLabel;
    QLblItemValue: TQRLabel;
    QLblPaidValue: TQRLabel;
    QLblPortionNo: TQRLabel;
    QLblPaidQty: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QLblSupplierName: TQRLabel;
    QLblSupplierId: TQRLabel;
    QRLabel11: TQRLabel;
    QLblCurrency: TQRLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }         {
    FSupplierId:        String;     }
    Procedure CreateLines;
    Procedure AddSubTotalLines;
  protected
    Procedure ProcessLine(Sender:TObject); override;
  public
    { Public declarations }
  end;

var
  frmSAQ301011QRRep01: TfrmSAQ301011QRRep01;

Procedure PrintRep01(AOwner:TComponent);
implementation

uses MCDMActs, MCObjcts, MCTypes, MCUtils;

{$R *.DFM}
Procedure PrintRep01(AOwner:TComponent);
Begin
     frmSAQ301011QRRep01 := Nil;
     Try
        frmSAQ301011QRRep01 := TfrmSAQ301011QRRep01.Create(AOwner);
        frmSAQ301011QRRep01.QRReport.Preview;
     Finally
        frmSAQ301011QRRep01.Free;
     End;
End;
Function Rep01Sorted(Item1,Item2:Pointer):Integer;
Var
   Line1:               TLine01;
   Line2:               TLine01;
Begin
     Line1 := TLine01(Item1);
     Line2 := TLine01(Item2);
     If Line1.Key = Line2.Key Then Begin
        Rep01Sorted := 0; End
     Else Begin
        If Line1.Key < Line2.Key Then Begin
           Rep01Sorted := -1; End
        Else Begin
           Rep01Sorted := 1;
        End;
     End;
End;
Procedure TfrmSAQ301011QRRep01.ProcessLine(Sender:TObject);
  Procedure NormalDetailLine;
  Begin
        With Sender As TLine01 Do Begin
             QLblContractNo.Caption   := '';
             QLblPortionNo.Caption    := '';
             QLblContractDate.Caption := '';
             QLblEleCatName.Caption   := '     ' + CategoryName;
             QLblCurrency.Caption     := '';
             QLblItemValue.Caption    := Format('%m',[ItemValue]);
             QLblPaidValue.Caption    := Format('%m',[PaidValue]);
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
       With Sender As TLine01 Do Begin
            QLblContractNo.Caption   := '';
            QLblPortionNo.Caption    := '';
            QLblContractDate.Caption := '';
            QLblEleCatName.Caption   := Format('%s (%s)',[ElementName,ElementNo]);
            QLblCurrency.Caption     := '';
            QLblContractQty.Caption  := '';
            QLblPaidQty.Caption      := '';
            QLblItemValue.Caption    := Format('%m',[ItemValue]);
            QLblPaidValue.Caption    := Format('%m',[PaidValue]);
       End;
  End;
  Procedure SubHeaderOfSection;
  Begin
        With Sender As TLine01 Do Begin
             QLblContractNo.Caption   := '';
             QLblPortionNo.Caption    := PortionNo;
             QLblContractDate.Caption := ContractDate;
             QLblEleCatName.Caption   := '';
             QLblCurrency.Caption     := '';
             QLblContractQty.Caption  := '';
             QLblPaidQty.Caption      := '';
             QLblItemValue.Caption    := Format('%m',[ItemValue]);
             QLblPaidValue.Caption    := Format('%m',[PaidValue]);
        End;
  End;
  Procedure HeaderOfSection;
  Begin
        With Sender As TLine01 Do Begin
             dmActs.GetContractDefinition(ContractNo);
             QLblContractNo.Caption   := ContractNo;
             QLblPortionNo.Caption    := '';
             QLblContractDate.Caption := ContractDate;
             QLblEleCatName.Caption   := '';
             QLblCurrency.Caption     := dmActs.SQLContractCURRENCY_TYPE.AsString;
             QLblContractQty.Caption  := '';
             QLblPaidQty.Caption      := '';
             QLblItemValue.Caption    := Format('%m',[ItemValue]);
             QLblPaidValue.Caption    := Format('%m',[PaidValue]);
        End;
  End;
Begin
     Case (Sender As TLine01).Kind Of
     klNormal    : NormalDetailLine;
     klElement   : ElementSection;
     klSubHeader : SubHeaderOfSection;
     klHeader    : HeaderOfSection;
     End;
End;
Procedure TfrmSAQ301011QRRep01.CreateLines;
Var
   Line:                TLine01;
Begin
     With dmActs,SQLRep01 Do Begin
          ExecQueryForRep01;
          While Not EoF Do Begin
                Line := TLine01.Create;
                With Line Do Begin
                     ContractNo    := SQLRep01CONTRACT_NO.AsString;
                     PortionNo     := SQLRep01PORTION_NO.AsString;
                     ElementNo     := SQLRep01ELEMENT_NO.AsString;
                     ContractDate  := '';
                     LoadElementsIn(ContractNo,PortionNo);
                     ElementName   := ElementActs.GetElementName(ContractNo,
                                                                 PortionNo,
                                                                 ElementNo);
                     { Try to get a custom name for the category. If doesn't
                       exist, then use the global name (the name in the table
                       'CE' of MSF010, avalaible as SQLRep01TABLE_DESC }
                     RefreshCustomCategoryNames(ContractNo,PortionNo);
                     CategoryName  := CategoryNames.GetCategoryNameAt(
                                         ContractNo,PortionNo,ElementNo,
                                         SQLRep01CATEGORY_NO.AsString);
                     If CategoryName = '' Then Begin
                        CategoryName := SQLRep01TABLE_DESC.AsString;
                     End;
                     ContractQty   := SQLRep01CATEG_BASE_QTY.AsFloat;
                     ItemValue     := SQLRep01CATEG_BASE_VAL.AsCurrency;
                     GetPaidsToCategory(ContractNo,PortionNo,ElementNo,
                                        SQLRep01CATEGORY_NO.AsString,
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
Procedure TfrmSAQ301011QRRep01.AddSubTotalLines;
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
       NewLine              := TLine01.Create;
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
procedure TfrmSAQ301011QRRep01.FormCreate(Sender: TObject);
var 
   Save_Cursor:         TCursor;
begin
     Save_Cursor      := Screen.Cursor;
     Try
        Screen.Cursor := crHourglass;
        With dmActs Do Begin
             QLblSupplierName.Caption := GetSupplierName(CurrentSupplier);
             QLblSupplierId.Caption   := GetSupplierId(CurrentDistrict,
                                                       CurrentSupplier);
        End;
        CreateLines;
        If ReportLines.Count > 0 Then Begin
           ReportLines.Sort(Rep01Sorted);
           AddSubTotalLines;
        End;
     Finally
        Screen.Cursor := Save_Cursor;
        { Close the DataSet }
        dmActs.SQLRep01.Active := False;
     End;
end;

end.
