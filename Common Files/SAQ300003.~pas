unit SAQ300003;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfrmSAQ300003Connecting = class(TForm)
    AnmConnection: TAnimate;
    LblConnecting: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSAQ300003Connecting: TfrmSAQ300003Connecting;

Procedure ShowConnectionActivity(AOwner:TComponent);
Procedure EndOfConnectionActivity;
implementation

{$R *.DFM}
Procedure ShowConnectionActivity(AOwner:TComponent);
Begin
     frmSAQ300003Connecting := TfrmSAQ300003Connecting.Create(AOwner);
     frmSAQ300003Connecting.Show;
     frmSAQ300003Connecting.AnmConnection.Active := True;
     frmSAQ300003Connecting.LblConnecting.Refresh;
End;
Procedure EndOfConnectionActivity;
Begin
     frmSAQ300003Connecting.Free;
End;
end.
