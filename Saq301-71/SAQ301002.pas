unit SAQ301002;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmSAQ301002NewAct = class(TForm)
    Panel1: TPanel;
    BtnCreate: TBitBtn;
    BtnCancel: TBitBtn;
    BtnHelp: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtContract: TEdit;
    EdtPortion: TEdit;
    EdtActPaid: TEdit;
    Label4: TLabel;
    CmbCCDefaultDstrb: TComboBox;
    Label5: TLabel;
    CmbCCTypeDstrb: TComboBox;
    procedure BtnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCCOnlyByPercent:   Boolean;
    procedure InitNewActForm;
  public
    { Public declarations }
    MimsUser : String;
  end;

var
  frmSAQ301002NewAct: TfrmSAQ301002NewAct;

Procedure CreateNewActPaid(AOwner:TComponent; Username:String);

implementation

uses SAQ301005, MCDMActs, MCTypes, MCUtils;

{$R *.DFM}

Procedure CreateNewActPaid(AOwner:TComponent; Username : String);
Begin
     FrmSAQ301002NewAct := Nil;
     Try
        FrmSAQ301002NewAct := TFrmSAQ301002NewAct.Create(AOwner);
        FrmSAQ301002NewAct.MimsUser := Username;
        If FrmSAQ301002NewAct.ShowModal=mrOK Then Begin
           dmActs.NewAct := True; { Rolando Celedón 2003-06-19 Check for New act }
           EditActPaid(AOwner);
        End;
     Finally
        FrmSAQ301002NewAct.Free;
     End;
End;
procedure TfrmSAQ301002NewAct.BtnCreateClick(Sender: TObject);
Var
  NewCode:              String;     { Code for the new Act Paid }
  LastCode:             Integer;    { Only if Act Paid codes are numeric values }
begin
     Try
        EdtContract.Text := GetMIMSKey(UpperCase(EdtContract.Text),8);
        EdtPortion.Text  := GetMIMSKey(EdtPortion.Text,2);
        With dmActs Do Begin
             { User Preferences for the document }

             UserConfig.DCCDefaultDstrb := TCCDefaultDstrb(Ord(CmbCCDefaultDstrb.ItemIndex));
             UserConfig.DAPInfoAtax     := UserConfig.APInfoAtax;
             If FCCOnlyByPercent Then Begin
                UserConfig.DCCTypeDstrb := cctdPercent; End
             Else Begin
                UserConfig.DCCTypeDstrb := TCCTypeDstrb(Ord(CmbCCTypeDstrb.ItemIndex));
             End;

             { Get definitions }

             GetContractDefinition(EdtContract.Text);
             GetPortionDefinition(EdtContract.Text,EdtPortion.Text);

             { Verify authorization }

             If SQLContractAPPROVED_BY.IsNull Or
                (Trim(SQLContractAPPROVED_BY.AsString) = '') Then Begin
                raise Exception.CreateFmt(ME_073,[EdtContract.Text]);
             End;
             {De Moya 2006-09-06 IC843 No debe permitir crear actas para contratos cerrados}
             If SQLContractSTATUS_384.IsNull Or
                (Trim(SQLContractSTATUS_384.AsString) = 'CC') Then Begin
                raise Exception.CreateFmt(ME_219,[EdtContract.Text]);
             End;

             If Not CanCreateAct Then Begin
                raise Exception.CreateFmt(ME_013 + ' ' + MimsUser ,[EdtContract.Text]);
             End;

             { Verify supplier status (It must be active) }

             ValidateSupplierStatus(SQLContractSUPPLIER_NO.AsString);

             { Get code for the new Act Paid }

             NewCode := Trim(EdtActPaid.Text);
             If NewCode='' Then Begin
                { If Empty then try to get a secuencial number }
                LastCode := GetLastCodeOfActPaid(EdtContract.Text);
                If LastCode>=0 Then Begin
                   NewCode := GetFullNumericField(LastCode+1,10);End
                Else Begin
                   { If LastCode < 0 then it's impossible to get a new
                     secuencial number; therefore, the user must type the value }
                   raise Exception.Create(ME_014);
                End;End
             Else Begin
                NewCode := GetMIMSKeyInt(EdtActPaid.Text,10);
             End;

             { Create the new Act Paid and set its definition in memory }
             InsertActPaid(EdtContract.Text,EdtPortion.Text,NewCode);
             With CurrentActPaid Do Begin
                  ActPaidCode     := NewCode;
                  ActPaidContract := EdtContract.Text;
                  ActPaidPortion  := EdtPortion.Text;
                  ActPaidDate     := CurrentDate;
                  ActPaidStatus   := asPendent;
                  ActPaidValue    := 0;   
             End;
        End;
     Except
        On E:Exception Do Begin
           ModalResult:=mrNone;
           ShowMessage(E.Message);
        End;
     End;
end;

procedure TfrmSAQ301002NewAct.InitNewActForm;
Var
   Index1:              TCCTypeDstrb;
   Index2:              TCCDefaultDstrb;
begin
     CmbCCTypeDstrb.Clear;
     For Index1 := Low(TCCTypeDstrb) To High(TCCTypeDstrb) Do Begin
         CmbCCTypeDstrb.Items.Add(Prf01Names[Index1]);
     End;
     { Check if user is only authorized to distribute by Percent }
     FCCOnlyByPercent := dmActs.IsAIUCCPercentDistributionOn;
     If FCCOnlyByPercent Then Begin
        CmbCCTypeDstrb.ItemIndex := Ord(cctdPercent);
        CmbCCTypeDstrb.Enabled   := False; End
     Else Begin
        CmbCCTypeDstrb.ItemIndex := Ord(dmActs.UserConfig.CCTypeDstrb);
     End;
     CmbCCDefaultDstrb.Clear;
     For Index2 := Low(TCCDefaultDstrb) To High(TCCDefaultDstrb) Do Begin
         CmbCCDefaultDstrb.Items.Add(Prf02Names[Index2]);
     End;
     CmbCCDefaultDstrb.ItemIndex := Ord(dmActs.UserConfig.CCDefaultDstrb);
end;
procedure TfrmSAQ301002NewAct.FormCreate(Sender: TObject);
Begin
     try
        InitNewActForm;
     except
        On E:Exception Do Begin
           BtnCreate.Enabled := False;
           ShowMessage(E.Message);
        End;
     end;
End;
end.
