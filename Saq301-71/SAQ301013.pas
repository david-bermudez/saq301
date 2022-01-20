unit SAQ301013;

{ Rep 03 :
  The report 03 contains the progress in the execution of every contract
  assigned to the user. The report show only the total value of a contract
  against the progess. The progress are the total values of the Acts for a
  contract. The report is ordered by Contract Code.
  For a detailed report by category, see Rep 01}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SAQ301009, Qrctrls, QuickRpt, ExtCtrls, DBCtrls;

type
  TfrmSAQ301013QRRep03 = class(TfrmSAQ301009ParentReports)
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QLblContractNo: TQRLabel;
    QLblCntStartDate: TQRLabel;
    QLblSupplierName: TQRLabel;
    QLblContractValue: TQRLabel;
    QLblPaidValue: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QLblSupplierGovId: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QLblCntFinalDate: TQRLabel;
    QLblContractDesc: TQRLabel;
    QRLabel12: TQRLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure CreateLines;
  protected
    Procedure ProcessLine(Sender:TObject); override;
  public
    { Public declarations }
  end;

var
  frmSAQ301013QRRep03: TfrmSAQ301013QRRep03;

Procedure PrintRep03(AOwner:TComponent);
implementation

uses MCDMActs, MCObjcts, MCUtils;

{$R *.DFM}
Procedure PrintRep03(AOwner:TComponent);
Begin
     frmSAQ301013QRRep03 := Nil;
     Try
        frmSAQ301013QRRep03 := TfrmSAQ301013QRRep03.Create(AOwner);
        frmSAQ301013QRRep03.QRReport.Preview;
     Finally
        frmSAQ301013QRRep03.Free;
     End;
End;
Procedure TfrmSAQ301013QRRep03.ProcessLine(Sender:TObject);
Begin
     With Sender As TLine03 Do Begin
          QLblContractNo.Caption    := ContractNo;
          QLblContractDesc.Caption  := ContractDesc;
          QLblCntStartDate.Caption  := ContractDate;
          QLblCntFinalDate.Caption  := ContractFDate;
          QLblSupplierGovId.Caption := SupplierId;
          QLblSupplierName.Caption  := SupplierName;
          QLblContractValue.Caption := Format('%m',[ContractValue]);
          QLblPaidValue.Caption     := Format('%m',[PaidValue]);
     End;
End;
Procedure TfrmSAQ301013QRRep03.CreateLines;
Var
   Line:                TLine03;
Begin
     With dmActs,SQLRep03 Do Begin
          ExecQueryForRep03;
          While Not EoF Do Begin
                Line := TLine03.Create;
                With Line Do Begin
                     ContractNo    := SQLRep03CONTRACT_NO.AsString;
                     ContractDesc  := SQLRep03CONTRACT_DESC.AsString;
                     ContractDate  := SQLRep03CNTRCT_BASE_DT.AsString;
                     ContractDate  := Date8ToDisplayFormat(ContractDate);
                     ContractValue := SQLRep03CONTRACT_VAL.AsCurrency;
                     SupplierName  := GetSupplierName(SQLRep03SUPPLIER_NO.AsString);
                     SupplierId    := GetSupplierId(SQLRep03DSTRCT_CODE.AsString,
                                                    SQLRep03SUPPLIER_NO.AsString);
                     PaidValue     := GetPaidsToContract(SQLRep03CONTRACT_NO.AsString);
                     { Get the final date }
                     ContractFDate := SQLRep03FINAL_COMPL_DT.AsString;
                     ContractFDate := Date8ToDisplayFormat(ContractFDate);
                     If ContractFDate = '' Then Begin
                        ContractFDate := SQLRep03AMEND_COMPL_DT.AsString;
                        ContractFDate := Date8ToDisplayFormat(ContractFDate);
                     End;
                     If ContractFDate = '' Then Begin
                        ContractFDate := SQLRep03ORIG_COMPL_DT.AsString;
                        ContractFDate := Date8ToDisplayFormat(ContractFDate);
                     End;
                End;
                AddDataLine(Line);
                Next;
          End;
     End;
End;
procedure TfrmSAQ301013QRRep03.FormCreate(Sender: TObject);
begin
     Try
        CreateLines;
     Finally
        { Close the DataSet }
        dmActs.SQLRep03.Active := False;
     End;
end;

end.
