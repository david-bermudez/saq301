unit SAQ301007;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, MCTypes;

type
  TfrmSAQ301007SelectContracts = class(TForm)
    Panel1: TPanel;
    BtnHelp: TSpeedButton;
    BtnCancel: TSpeedButton;
    BtnAll: TSpeedButton;
    LbContracts: TListBox;
    BtnReport: TSpeedButton;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnReportClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
  private
    { Private declarations }
    Function GetSQLCondition:String;
  public
    { Public declarations }
    Property SQLCondition:String Read GetSQLCondition;
  end;

var
  frmSAQ301007SelectContracts: TfrmSAQ301007SelectContracts;

Procedure ListContracts(AOwner:TComponent;AReport:TKindReport);

implementation

uses MCObjcts, MCDMActs, SAQ301012, SAQ301014;

{$R *.DFM}

Procedure ListContracts(AOwner:TComponent;AReport:TKindReport);
Begin
     Try
        frmSAQ301007SelectContracts := TfrmSAQ301007SelectContracts.Create(AOwner);
        With frmSAQ301007SelectContracts Do Begin
             ShowModal;
             If ModalResult = mrOk Then Begin
                Case AReport Of
                kr02 : PrintRep02(AOwner,SQLCondition);
                kr04 : PrintRep04(AOwner,SQLCondition);
                End;
             End;
        End;
     Finally
        frmSAQ301007SelectContracts.Free;
     End;
End;
Function TfrmSAQ301007SelectContracts.GetSQLCondition:String;
Var
   Condition:           String;
   ContractIndex:       Integer;
Begin
     Condition := '';
     With LbContracts Do Begin
          For ContractIndex := 0 To Items.Count -1 Do Begin
              If Selected[ContractIndex] Then Begin
                 With Items.Objects[ContractIndex] As TContractNode Do Begin
                      Condition := Condition + '''' + ContractNo + ''',';
                 End;
              End;
          End;
     End;
     Condition := Copy(Condition,1,Length(Condition)-1);
     If LbContracts.SelCount = 1 Then Begin
        GetSQLCondition := Format('A.CONTRACT_NO=%s',[Condition]); End
     Else Begin
        GetSQLCondition := Format('A.CONTRACT_NO in (%s)',[Condition]);
     End;
End;
procedure TfrmSAQ301007SelectContracts.BtnCancelClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmSAQ301007SelectContracts.BtnAllClick(Sender: TObject);
Var
   ContractIndex:       Integer;
begin
     For ContractIndex := 0 To LbContracts.Items.Count -1 Do Begin
         LbContracts.Selected[ContractIndex] := True;
     End;
end;

procedure TfrmSAQ301007SelectContracts.FormCreate(Sender: TObject);
Var
   Node:                TContractNode;
begin
     Try
        With dmActs,SQLContracts Do Begin
             GetUserContracts;
             { Because the list of contracts assigned to the user can be
               too large, to improve performance, we don't use the traditional
               system (A TDBGrid connected to SQLContracts); we use a TListBox,
               loading into it the contracts definitions }
             Try
                While Not EoF Do Begin
                      Node := TContractNode.Create;
                      With Node Do Begin
                           ContractNo   := SQLContractsCONTRACT_NO.AsString;
                           ContractDate := SQLContractsCNTRCT_BASE_DT.AsString;
                           ContractDesc := SQLContractsCONTRACT_DESC.AsString;
                      End;
                      LbContracts.Items.AddObject(Node.Key,Node);
                      Next;
                End;
             Finally
                Active := False;
             End;
        End;
     Except
        On E:Exception Do Begin
           ShowMessage(E.Message);
           BtnReport.Enabled := False;
        End;
     End;
end;

procedure TfrmSAQ301007SelectContracts.BtnReportClick(Sender: TObject);
begin
     { Check if there is at least one contract selected }
     If LbContracts.SelCount > 0 Then Begin
        ModalResult := mrOk; End
     Else Begin
        ShowMessage(ME_082);
     End;
end;

procedure TfrmSAQ301007SelectContracts.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3011335);
end;

end.
