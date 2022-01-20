unit SAQ301006;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, DBCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TfrmSAQ301006InfoAtax = class(TForm)
    Panel1: TPanel;
    BtnHelp: TSpeedButton;
    BtnReturn: TSpeedButton;
    NavCostCenters: TDBNavigator;
    GrdAPInfoAtax: TDBGrid;
    BtnLoadDefault: TSpeedButton;
    BtnLoadLast: TSpeedButton;
    StbInfoAtax: TStatusBar;
    procedure BtnReturnClick(Sender: TObject);
    procedure BtnLoadDefaultClick(Sender: TObject);
    procedure BtnLoadLastClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSAQ301006InfoAtax: TfrmSAQ301006InfoAtax;

Procedure EditAPInfoAtax(AOwner:TComponent);
implementation

uses MCDMActs, MCTypes;

{$R *.DFM}

Procedure EditAPInfoAtax(AOwner:TComponent);
Begin
     frmSAQ301006InfoAtax := Nil;
     Try
        frmSAQ301006InfoAtax := TfrmSAQ301006InfoAtax.Create(AOwner);
        frmSAQ301006InfoAtax.ShowModal;
     Finally
        frmSAQ301006InfoAtax.Free;
     End;
End;
procedure TfrmSAQ301006InfoAtax.BtnReturnClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmSAQ301006InfoAtax.BtnLoadDefaultClick(Sender: TObject);
begin
     With dmActs Do Begin
          If tblInfoAtax.UpdatesPending Then Begin
             tblInfoAtax.CancelUpdates;
          End;
          CreateTemporalAtaxTableFromDistrictDefault;
     End;
end;

procedure TfrmSAQ301006InfoAtax.BtnLoadLastClick(Sender: TObject);
Var
   PrvActPaidCode:      String;     { Code of the last Act Paid before the current }
begin
     With dmActs Do Begin
          PrvActPaidCode := GetPreviousActPaidCode(CurrentActPaid.ActPaidContract,
                                                   CurrentActPaid.ActPaidDate);
          If PrvActPaidCode = '' Then Begin
             ShowMessage(ME_155);End
          Else Begin
             GetActPaidInfoAtax(CurrentActPaid.ActPaidContract,PrvActPaidCode);
             CreateTemporalAtaxTable;
          End;
     End;
end;

procedure TfrmSAQ301006InfoAtax.FormCreate(Sender: TObject);
begin
     StbInfoAtax.SimpleText := Format(MI_028,[dmActs.ActPaidNewNetValue]);
end;

procedure TfrmSAQ301006InfoAtax.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3011328);
end;

end.
