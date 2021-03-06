unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    function tp_xcrypt(direction: byte; pw: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
   Edit2.Text := tp_xcrypt(1, Edit1.Text);
end;

function TForm1.tp_xcrypt(direction: byte; pw: string): string;
const
  Zcrypt = ' Q!W@E#R$T%Y^U&I*O(P)1_2-3+4=5\6`7[8]9:0"A;S' + #39 +
           'D<F>G?H,J.K/LZXCVBNM';
var
  iX1, iX2, iX3, Len, ZcryptLen : integer;
  pwc                           : string;
  Magic                         : byte;

begin
  Magic := 3;
  ZcryptLen := Length(Zcrypt) - 1;
  Len := Length(pw);
  pwc := '';

  if direction = 0 then begin
    iX1 := 0;
    while (iX1 < len) do begin
      iX1 := iX1 + 1;
      iX2 := Ord(pw[iX1]) + Magic;
      iX3 := 1;
      while iX2 >= ZcryptLen do begin
        iX3 := iX3 + 1;
        iX2 := iX2 - ZcryptLen;
      end;
      if (ix3 <> 2) then
        pwc := pwc + Chr(Ord('a') + ix3);
      pwc := pwc + Zcrypt[iX2 + 2];
      Magic := (Magic + ix2) mod 10;
    end;
    Result := pwc;
  end
  else begin
    iX1 := 0;
    while (iX1 < Len) do begin
      iX1 := iX1 + 1;
      iX3 := ord(pw[iX1]) - ord('a');
      if (iX3 <1) or (iX3 > 26) then
        iX3 := 2
      else
        iX1 := iX1 + 1;
      iX2 := Pos(pw[iX1], ZCrypt) - 1;
      if iX2 = 0 then
        iX2 := 1;
      iX2 := iX2 - 1;
      pwc := pwc + chr(iX2 + ( (iX3 - 1) * ZcryptLen) - Magic);
      Magic := (Magic + iX2) mod 10;
    end;
  end;
  Result := pwc;
end;


end.
