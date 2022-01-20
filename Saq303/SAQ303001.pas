unit SAQ303001;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Mask, db, DBCtrls, ComCtrls, ExtCtrls,
  Buttons, Gauges;

type
  TfrmSAQ303001MainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GrdInvoice: TDBGrid;
    Splitter1: TSplitter;
    sbLoadInvoice: TStatusBar;
    BtnSearch: TSpeedButton;
    BtnExit: TSpeedButton;
    BtnHelp: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure GrdInvoiceDblClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSAQ303001MainForm: TfrmSAQ303001MainForm;

implementation

uses SAQ303002, MCUtils, MCTypes, SAQ303003, SAQ303004, SAQ300003,
  SAQ303006;

{$R *.DFM}

procedure TfrmSAQ303001MainForm.FormCreate(Sender: TObject);
Var
   RecCount:            Integer;
begin
     RecCount := 0;
     Try
        sbLoadInvoice.SimpleText := 'Buscando';
        Try
           dmSAQ303006MIMSX.ConnectToMSQMUI;
           With dmSAQ303002DataModule Do Begin
                OpenActPaidSession(SsnInvoice);
                dbLocal.Connected := True;
                ConnectToBDMIMS;
                InitStructures;
                SearchActPaidsPendents;
                RecCount := tblPays.RecordCount;
           End;
        Finally
           sbLoadInvoice.SimpleText := Format(MI_001,[RecCount]);
           EndOfConnectionActivity;
        End;
     Except
        On E:Exception Do Begin
           ShowMessage(E.Message);
           Application.Terminate;
        End;
     End;
end;

procedure TfrmSAQ303001MainForm.BtnExitClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmSAQ303001MainForm.GrdInvoiceDblClick(Sender: TObject);
begin
     dmSAQ303002DataModule.tblItems.Active := True;
     Try
        frmSAQ303004Invoice.ShowModal;
     Finally
        If dmSAQ303002DataModule.tblItems.UpdatesPending Then Begin
           dmSAQ303002DataModule.tblItems.CancelUpdates;
        End;
     End;
end;

procedure TfrmSAQ303001MainForm.BtnSearchClick(Sender: TObject);
Var
   RecCount:            Integer;
begin
     RecCount := 0;
     sbLoadInvoice.Panels[0].Text := 'Buscando';
     Try
        dmSAQ303002DataModule.SearchActPaidsPendents;
        RecCount := dmSAQ303002DataModule.tblPays.RecordCount;
     Finally
        sbLoadInvoice.SimpleText := Format(MI_001,[RecCount]);
     End;
end;

procedure TfrmSAQ303001MainForm.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3031000);
end;


end.
