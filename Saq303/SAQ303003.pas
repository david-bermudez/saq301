unit SAQ303003;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, MCObjcts;

type
  TfrmSAQ303003AtaxCodes = class(TForm)
    ttvAtaxCodes: TTreeView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ProcessAtaxCode(AnAtax:TAtaxDfntn);
    procedure AddAtaxComponents(CurrentAtax:String;Node:TTreeNode);
  public
    { Public declarations }
  end;

var
  frmSAQ303003AtaxCodes: TfrmSAQ303003AtaxCodes;

implementation

uses MCUtils, SAQ303002, MCTypes;

{$R *.DFM}

procedure TfrmSAQ303003AtaxCodes.AddAtaxComponents(CurrentAtax:String;Node:TTreeNode);
Var
   AtaxLine:            String;
   AtaxIndex:           Integer;
   AtaxPercent:         Double;
Begin
     With dmSAQ303002DataModule,SQLAtaxGrps Do Begin
          While (Not EoF) And (SQLAtaxGrpsATAX_CODE.AsString<CurrentAtax) Do Begin
                Next;
          End;
          While (Not EoF) And (SQLAtaxGrpsATAX_CODE.AsString=CurrentAtax) Do Begin
                AtaxLine := SQLAtaxGrpsREL_ATAX_CODE.AsString;
                AtaxIndex := AtaxDefs.IndexOf(AtaxLine);
                If AtaxIndex>=0 Then Begin
                   AtaxPercent := (AtaxDefs.Objects[AtaxIndex] As TAtaxDfntn).Percent;
                   AtaxLine := Format('%-4s %5.2f',[AtaxLine,AtaxPercent])+'%';
                End;
                ttvAtaxCodes.Items.AddChild(Node,AtaxLine);
                Next;
          End;
     End;
End;
procedure TfrmSAQ303003AtaxCodes.ProcessAtaxCode(AnAtax:TAtaxDfntn);
Var
   AtaxLine:            String;
   Node:                TTreeNode;
Begin
     With AnAtax Do Begin
          If Group Then Begin
             AtaxLine := MI_016; End
          Else Begin
             AtaxLine := Format('%5.2f',[Percent]);
             AtaxLine := AtaxLine + '%';
          End;
          AtaxLine := Format(AtaxFmt,[AtaxCode,AtaxLine]);
          AtaxLine := AtaxLine + Description;
          Node := ttvAtaxCodes.Items.Add(Nil,AtaxLine);
          If Group Then Begin
             AddAtaxComponents(AtaxCode,Node);
          End;
     End;
End;
procedure TfrmSAQ303003AtaxCodes.FormCreate(Sender: TObject);
Var
   AtaxIndex:           Integer;
begin
     AtaxIndex := 0;
     ttvAtaxCodes.Items.Clear;
     With dmSAQ303002DataModule Do Begin
          SQLAtaxGrps.First;
          While AtaxIndex < AtaxDefs.Count Do Begin
                ProcessAtaxCode(AtaxDefs.Objects[AtaxIndex] As TAtaxDfntn);
                Inc(AtaxIndex);
          End;
     End;
end;

end.
