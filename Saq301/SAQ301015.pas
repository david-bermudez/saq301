unit SAQ301015;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SAQ301010, Qrctrls, QuickRpt, ExtCtrls, MCTypes, MCObjcts;

type
  TfrmSAQ301015QRAPSummary = class(TfrmSAQ301010QRActPaid)
    QRBndServices: TQRChildBand;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QBndSumSection: TQRChildBand;
    QLblSection: TQRLabel;
    QLblInvValue: TQRLabel;
    QLblActValue: TQRLabel;
    QRBndHeaderSection: TQRChildBand;
    QLblTitleSection: TQRLabel;
    QRAPTotal: TQRChildBand;
    QLblInvValue2: TQRLabel;
    procedure QRReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRReportNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRBndInfoAtaxBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndInfAtxDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRHeaderBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QBndSumSectionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndHeaderSectionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBndServicesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRAPTotalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSummarySection:    Currency;   { Total value for a section (Services,Discounts) }
    FSummaryValue:      Currency;   { Total value for an element }
    FPrintedSection:    Boolean;    { True, just printed the end of a section }
    FLastPrinted:       Boolean;    { True, already printed the last element }
    FPrintServices:     Boolean;
    FEndOfSection:      Boolean;
    FEndOfElement:      Boolean;
    FSectionValue:      Currency;
    FCurrentSection:    Integer;
    FCurrentElement:    String;
    FNextSection:       Integer;
    FNextElement:       String;
    FPrintables:        TStringList;{ List of Element_No printables (> 0)  }
    procedure GetGroupsOf(AIndex:Integer;
                          Var ASection:Integer;
                          Var AnElement:String);
    procedure CheckEndOfGroups;
    procedure ProcessDetailLine;
  Protected
    procedure FillUpDetailLine(AnIndex:Integer); override;
  public
    { Public declarations }
    Property PrintedSection:Boolean Read FPrintedSection Write FPrintedSection;
    Property LastPrinted:Boolean    Read FLastPrinted    Write FLastPrinted;
    Property SummaryValue:Currency  Read FSummaryValue   Write FSummaryValue;
    Property CurrentSection:Integer Read FCurrentSection Write FCurrentSection;
    Property NextSection:Integer    Read FNextSection    Write FNextSection;
  end;

var
  frmSAQ301015QRAPSummary: TfrmSAQ301015QRAPSummary;

Procedure PrintActPaidSummary(AOwner:TComponent);
implementation

uses MCDMActs;

{$R *.DFM}
Procedure PrintActPaidSummary(AOwner:TComponent);
Begin
     frmSAQ301015QRAPSummary := Nil;
     Try
        frmSAQ301015QRAPSummary := TfrmSAQ301015QRAPSummary.Create(AOwner);
        frmSAQ301015QRAPSummary.QRReport.Preview;
     Finally
        dmActs.SQLInfoAtax.Active := False;
        frmSAQ301015QRAPSummary.Free;
     End;
End;
procedure TfrmSAQ301015QRAPSummary.GetGroupsOf(AIndex:Integer;
                                               Var ASection:Integer;
                                               Var AnElement:String);
var
     AnElementCode:    String;
Begin
     With dmActs,TCategoryDef(Details.Items[AIndex]) Do Begin
          AnElement := CategoryElement;
          AnElementCode := CategoryElementCode;
          ASection  := 0;

          If CrrEleNoDef.IsPercent[trim(AnElement) + trim(AnElementCode)] Then Begin
             ASection := 1; End
          Else Begin
             If CrrEleNoDef.IsDiscount[trim(AnElement) + trim(AnElementCode)] Then Begin
                ASection := 2;
             End;
          End;
     End;
End;
procedure TfrmSAQ301015QRAPSummary.CheckEndOfGroups;
Var
   NextIndex:           Integer;
Begin
     GetGroupsOf(DetailIndex,FCurrentSection,FCurrentElement);
     NextIndex := DetailIndex + 1;
     If NextIndex < dmActs.Details.Count Then Begin
        GetGroupsOf(NextIndex,FNextSection,FNextElement);
        FEndOfSection := NextSection <> CurrentSection;
        FEndOfElement := FEndOfSection Or (FCurrentElement <> FNextElement); End
     Else Begin
        FEndOfSection := True;
        FEndOfElement := True;
     End;
     If FEndOfSection Then Begin
        FSectionValue := FSummarySection;
     End;
End;
{ Use this routine to Fill Up a detail line in the report. AnIndex is the
  index in the internal detail list; unused in this routine; but required
  by the ancester class }
procedure TfrmSAQ301015QRAPSummary.FillUpDetailLine(AnIndex:Integer);
Begin
     With dmActs Do Begin
          QLblElement.Caption := ElementActs.GetElementName(CurrentActPaid.ActPaidContract,
                                                            CurrentActPaid.ActPaidPortion,
                                                            FCurrentElement);
          QLblElement.Caption := FCurrentElement + ' ' + QLblElement.Caption;
     End;
     QLblCategory.Caption  := '';
     QLblQuantity.Caption  := '';
     QLblUnit.Caption      := '';
     QLblRateValue.Caption := Format('%m',[SummaryValue]);
     QLblValue.Caption     := Format('%m',[InvChangeRate*SummaryValue]);
End;

procedure TfrmSAQ301015QRAPSummary.QRReportBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
     inherited;
     FPrintables.Clear;
     QLblRateValue.Left    := QLblActValue.Left;
     QLblInvValue2.Caption := QLblTotalInvoice.Caption;
     QRTitulo.Caption      := MI_026;
     FSummarySection       := 0;
     FSummaryValue         := 0;
     FPrintedSection       := False;
     FLastPrinted          := False;
     FPrintServices        := True;
end;
procedure TfrmSAQ301015QRAPSummary.ProcessDetailLine;
Begin
     With dmActs,Details.CategoryAt[DetailIndex] Do Begin
          SummaryValue := SummaryValue + CategoryGlobal;
          If FEndOfElement And (Abs(SummaryValue) > Delta) Then Begin
             FPrintables.Add(FCurrentElement);
             FillUpDetailLine(DetailIndex);
             FSummarySection   := FSummarySection + SummaryValue;
             SummaryValue      := 0; End
          Else Begin
             { Because the ancester class use QLblValue.Caption as a flag to
               know if it must print the line. If It's blank, don't print }
             QLblValue.Caption := '';
          End;
     End;
     If FEndOfSection Then Begin
        FSectionValue   := FSummarySection;
        FSummarySection := 0;
     End;
End;
procedure TfrmSAQ301015QRAPSummary.QRReportNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
     FEndOfSection := False;
     FEndOfElement := False;
     MoreData      := DetailIndex < dmActs.Details.Count;
     LastPrinted   := (DetailIndex + 1) = dmActs.Details.Count;
     If MoreData Then Begin
        CheckEndOfGroups;
        ProcessDetailLine;
        DetailIndex := DetailIndex + 1;
     End;
end;

procedure TfrmSAQ301015QRAPSummary.QRBndInfoAtaxBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := LastPrinted And (dmActs.UserConfig.DAPInfoAtax = apiaYes);
     If PrintBand Then Begin
        PrintBand := Not dmActs.SQLInfoAtaxATAX_CODE.IsNull;
     End;
end;
procedure TfrmSAQ301015QRAPSummary.QRBndInfAtxDetailBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     QRBndInfoAtaxBeforePrint(Sender,PrintBand);
     If PrintBand Then Begin
        PrintAtaxDetails;
     End;
end;

procedure TfrmSAQ301015QRAPSummary.QRHeaderBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := False;
end;

procedure TfrmSAQ301015QRAPSummary.QBndSumSectionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := FEndOfSection;
     If PrintBand Then Begin
        QLblSection.Caption  := SectionsValueNames[CurrentSection];
        QLblActValue.Caption := Format('%m',[FSectionValue]);
        QLblInvValue.Caption := Format('%m',[InvChangeRate*FSectionValue]);
        PrintedSection       := True;
     End;
end;

procedure TfrmSAQ301015QRAPSummary.QRBndHeaderSectionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := PrintedSection;
     If PrintedSection Then Begin
        PrintedSection := False;
        PrintBand      := DetailIndex < dmActs.Details.Count;
        If PrintBand Then Begin
           QLblTitleSection.Caption := SectionsTitles[NextSection];
        End;
     End;
end;

procedure TfrmSAQ301015QRAPSummary.QRBndServicesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := FPrintServices;
     If PrintBand Then Begin
        FPrintServices := False;
     End;
end;

procedure TfrmSAQ301015QRAPSummary.QRAPTotalBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     PrintBand := LastPrinted;
end;

procedure TfrmSAQ301015QRAPSummary.FormCreate(Sender: TObject);
begin
     inherited;
     FPrintables  := TStringList.Create;
end;

procedure TfrmSAQ301015QRAPSummary.FormDestroy(Sender: TObject);
begin
     FPrintables.Free;
     inherited;
end;

end.
