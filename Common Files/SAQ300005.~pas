unit SAQ300005;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmSAQ300005MIMSXFields = class(TForm)
    LbFields: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSAQ300005MIMSXFields: TfrmSAQ300005MIMSXFields;

Procedure ShowMIMSFields(AList:TStringList;AField:String);
implementation

{$R *.DFM}
Procedure ShowMIMSFields(AList:TStringList;AField:String);
Begin
     frmSAQ300005MIMSXFields := Nil;
     Try
        frmSAQ300005MIMSXFields := TfrmSAQ300005MIMSXFields.Create(Application);
        frmSAQ300005MIMSXFields.Caption := 'Campo de llamada '+AField;
        frmSAQ300005MIMSXFields.LbFields.Items.AddStrings(AList);
        frmSAQ300005MIMSXFields.ShowModal;
     Finally
        frmSAQ300005MIMSXFields.Free;
     End;
End;
end.
