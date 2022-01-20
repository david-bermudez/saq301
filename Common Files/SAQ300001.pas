unit SAQ300001;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TFrmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtUserID: TEdit;
    EdtLogin: TEdit;
    EdtPassword: TEdit;
    EdtDistrito: TEdit;
    BSAQ301: TBitBtn;
    BCerrar: TBitBtn;
    BSAQ304: TBitBtn;
    BSAQ303: TBitBtn;
    BSAQ302: TBitBtn;
    BSAQ305: TBitBtn;
    Label5: TLabel;
    EdtMIMSPassword: TEdit;
    Label6: TLabel;
    EdtPosition: TEdit;
    Label7: TLabel;
    EdtHost: TEdit;
    Label8: TLabel;
    EdtPort: TEdit;
    Label9: TLabel;
    EdtHostUser: TEdit;
    Label10: TLabel;
    EdtHostPassword: TEdit;
    procedure BCerrarClick(Sender: TObject);
    procedure BSAQ301Click(Sender: TObject);
    procedure BSAQ389Click(Sender: TObject);
  private
    { Private declarations }
    Procedure ExecSAQ(AName:String);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses MCConnct;

{$R *.DFM}

Const
     ExecLine = '%s.EXE /01=%s /02=%s /03=%s /04=%s /05=%s /06=%s /07=%s /08=%s /09=%s /10=%s';
procedure TFrmMain.BCerrarClick(Sender: TObject);
begin
     Close;
end;

Procedure TFrmMain.ExecSAQ(AName:String);
Var
   Line : String;
Begin
     Line := Format(ExecLine,[AName,
                              EdtLogin.Text,
                              EncodeText(EdtPassword.Text),
                              EdtHost.Text,
                              EdtPort.Text,
                              EdtHostUser.Text,
                              EncodeText(EdtHostPassword.Text),
                              EdtUserID.Text,
                              EncodeText(EdtMIMSPassword.Text),
                              EdtPosition.Text,
                              EdtDistrito.Text]);
     WinExec(PChar(Line),SW_SHOW);
End;

procedure TFrmMain.BSAQ301Click(Sender: TObject);
begin
     ExecSAQ((Sender As TBitBtn).Caption);
end;

procedure TFrmMain.BSAQ389Click(Sender: TObject);
begin
     WinExec('SAQ389.EXE',SW_SHOW);
end;

end.
