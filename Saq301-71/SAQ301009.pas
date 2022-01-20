unit SAQ301009;

interface

{ This is the Parent form for the report forms. We use the following technique :

  The descendent forms must create objects with the necessary information to
  print every data line in the report; typically, in the OnCreate event. They
  must use this information to fill the TQRLabels on the band to print for
  each line by using the ProcessLine. This is an abstract method called by
  the Parent form when the system is recovering data information for a line.
  The Sender parameter is the corresponding object for the current line.

  We use this technique to improve performance in some reports because the
  Quick Report forms work around TDataSet two times, the first time, to
  show the preview and the second time to the real printing; this process
  has a weakness because in order to get the calculated fields in the
  dataset is necessary to call OnCalcFields two times for every record;
  therefore, if the event include some long process (as an SQL command)
  we are using unnecessary resources. By using our technique we avoid
  this problem }

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, DBCtrls;

type
  TfrmSAQ301009ParentReports = class(TForm)
    QRReport: TQuickRep;
    QRBand1: TQRBand;
    QRTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRDetail: TQRBand;
    QRHeader: TQRBand;
    QImgLogo: TQRDBImage;
    QLblCompanyName: TQRLabel;
    procedure QRReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRReportNeedData(Sender: TObject; var MoreData: Boolean);
  private
    { Private declarations }
    FCurrentLine:       Integer;    { Number of the current line }
    FReportLines:       TList;      { Lines of the Report }
  protected
    Procedure ProcessLine(Sender:TObject); Virtual; Abstract;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent);
    Destructor Destroy; override;
    Procedure AddDataLine(ALine:TObject);
    Property CurrentLine:Integer Read FCurrentLine;
    Property ReportLines:TList   Read FReportLines;
  end;

var
  frmSAQ301009ParentReports : TfrmSAQ301009ParentReports;

implementation

uses MCDMActs;

{$R *.DFM}

Constructor TfrmSAQ301009ParentReports.Create(AOwner:TComponent);
begin
     FReportLines := TList.Create;
     Inherited Create(AOwner);
end;
Destructor TfrmSAQ301009ParentReports.Destroy;
Var
   Line:                TObject;    { Object for a line in the report }
begin
     { Free the objects for every line before to free the list. It's
       necessary because TList class don't support automatic free for
       the objects in the list }
     FCurrentLine := 0;
     While FCurrentLine < FReportLines.Count Do Begin
           Line := FReportLines.Items[FCurrentLine];
           Line.Free;
           Inc(FCurrentLine);
     End;
     FReportLines.Free;
     Inherited Destroy;
end;

Procedure TfrmSAQ301009ParentReports.AddDataLine(ALine:TObject);
Begin
     FReportLines.Add(ALine);
End;

procedure TfrmSAQ301009ParentReports.QRReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     FCurrentLine := 0;
     QLblCompanyName.Caption := dmActs.CurrentCompany;
end;

procedure TfrmSAQ301009ParentReports.QRReportNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
     MoreData := FCurrentLine < FReportLines.Count;
     If MoreData Then Begin
        ProcessLine(FReportLines.Items[FCurrentLine]);
     End;
     Inc(FCurrentLine);
end;

end.
