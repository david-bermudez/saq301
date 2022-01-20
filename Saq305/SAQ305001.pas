unit SAQ305001;

{ This is the main window of the program to set the parameters used by a
  District in the Act Paid module (program SAQ305). }
  
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TFrmUserPreferences = class(TForm)
    PnlButtons: TPanel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    BtnHelp: TBitBtn;
    PnlUserInfo: TPanel;
    LblUserId: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PnlUserId: TPanel;
    PnlUserName: TPanel;
    PnlEmployeeId: TPanel;
    PnlOptions: TPanel;
    Panel4: TPanel;
    Label4: TLabel;
    CmbCCTypeDstrb: TComboBox;
    Label5: TLabel;
    CmbCCDefaultDstrb: TComboBox;
    Label6: TLabel;
    CmbTypeComments: TComboBox;
    Label7: TLabel;
    CmbTypeCntrctExt: TComboBox;
    Label8: TLabel;
    CmbLoadInvType: TComboBox;
    Label9: TLabel;
    CmbActValidation: TComboBox;
    PnlDistrict: TPanel;
    Label1: TLabel;
    CmbInvValidation: TComboBox;
    Label10: TLabel;
    CmbTypeCntLimit: TComboBox;
    Label11: TLabel;
    CmbAPInfoAtax: TComboBox;
    Label12: TLabel;
    CmbAPRight: TComboBox;
    Label13: TLabel;
    CmbAPSecuence: TComboBox;
    procedure PnlButtonsResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayUserIdentity;
    Procedure FillUpComboBox;
    procedure LoadCurrentValues;
    procedure SaveValues;
    procedure ExecInitialization;
  public
    { Public declarations }
  end;

var
  FrmUserPreferences: TFrmUserPreferences;

implementation

uses MCTypes, SAQ305002, SAQUtils;

{$R *.DFM}

procedure TFrmUserPreferences.PnlButtonsResize(Sender: TObject);
begin
     BtnHelp.Left   := PnlButtons.ClientWidth - PnlButtons.BevelWidth -
                       PnlButtons.BorderWidth - BtnHelp.Width;
     BtnCancel.Left := (PnlButtons.ClientWidth - BtnCancel.Width ) Div 2;
end;
{ Fill Up the combo box of each option with the avalaible values for its
  option }
Procedure TFrmUserPreferences.FillUpComboBox;
Var
   Index01:             TCCTypeDstrb;
   Index02:             TCCDefaultDstrb;
   Index03:             TTypeComments;
   Index04:             TTypeCntrctExt;
   Index05:             TLoadInvType;
   Index06:             TActValidation;
   Index07:             TInvValidation;
   Index08:             TTypeCntLimit;
   Index09:             TAPInfoAtax;
   Index10:             TAPRight;
   Index11:             TAPSecuence;
begin
     CmbCCTypeDstrb.Clear;
     For Index01 := Low(TCCTypeDstrb) To High(TCCTypeDstrb) Do Begin
         CmbCCTypeDstrb.Items.Add(Prf01Names[Index01]);
     End;
     CmbCCDefaultDstrb.Clear;
     For Index02 := Low(TCCDefaultDstrb) To High(TCCDefaultDstrb) Do Begin
         CmbCCDefaultDstrb.Items.Add(Prf02Names[Index02]);
     End;
     CmbTypeComments.Clear;
     For Index03 := Low(TTypeComments) To High(TTypeComments) Do Begin
         CmbTypeComments.Items.Add(Prf03Names[Index03]);
     End;
     CmbTypeCntrctExt.Clear;
     For Index04 := Low(TTypeCntrctExt) To High(TTypeCntrctExt) Do Begin
         CmbTypeCntrctExt.Items.Add(Prf04Names[Index04]);
     End;
     CmbLoadInvType.Clear;
     For Index05 := Low(TLoadInvType) To High(TLoadInvType) Do Begin
         CmbLoadInvType.Items.Add(Prf05Names[Index05]);
     End;
     CmbActValidation.Clear;
     For Index06 := Low(TActValidation) To High(TActValidation) Do Begin
         CmbActValidation.Items.Add(Prf06Names[Index06]);
     End;
     CmbInvValidation.Clear;
     For Index07 := Low(TInvValidation) To High(TInvValidation) Do Begin
         CmbInvValidation.Items.Add(Prf07Names[Index07]);
     End;
     CmbTypeCntLimit.Clear;
     For Index08 := Low(TTypeCntLimit) To High(TTypeCntLimit) Do Begin
         CmbTypeCntLimit.Items.Add(Prf08Names[Index08]);
     End;
     CmbAPInfoAtax.Clear;
     For Index09 := Low(TAPInfoAtax) To High(TAPInfoAtax) Do Begin
         CmbAPInfoAtax.Items.Add(Prf09Names[Index09]);
     End;
     CmbAPRight.Clear;
     For Index10 := Low(TAPRight) To High(TAPRight) Do Begin
         CmbAPRight.Items.Add(Prf10Names[Index10]);
     End;
     CmbAPSecuence.Clear;
     For Index11 := Low(TAPSecuence) To High(TAPSecuence) Do Begin
         CmbAPSecuence.Items.Add(Prf11Names[Index11]);
     End;
end;
{ Display the user identification fields }
procedure TFrmUserPreferences.DisplayUserIdentity;
Begin
     With dmSAQ305002 Do Begin
          PnlUserId.Caption     := CurrentUserID;
          PnlEmployeeId.Caption := CurrentUser;
          PnlDistrict.Caption   := Format(SAQ305DstrctTitle,[CurrentDistrict]);
          PnlUserName.Caption   := CurrentUserName;
     End;
End;

{ Select the current value for each option in its corresponding Combo Box }

procedure TFrmUserPreferences.LoadCurrentValues;
Begin
     With dmSAQ305002 Do Begin
          CmbCCTypeDstrb.ItemIndex    := tblUserConfigCC_TYPE_DSTRB.AsInteger;
          CmbCCDefaultDstrb.ItemIndex := tblUserConfigCC_DEFAULT_DSTRB.AsInteger;
          CmbTypeComments.ItemIndex   := tblUserConfigTYPE_COMMENTS.AsInteger;
          CmbTypeCntrctExt.ItemIndex  := tblUserConfigTYPE_CNTRCT_EXT.AsInteger;
          CmbLoadInvType.ItemIndex    := tblUserConfigLOAD_INV_TYPE.AsInteger;
          CmbActValidation.ItemIndex  := tblUserConfigACT_VALIDATION.AsInteger;
          CmbInvValidation.ItemIndex  := tblUserConfigINV_VALIDATION.AsInteger;
          CmbTypeCntLimit.ItemIndex   := tblUserConfigTYPE_CNT_LIMIT.AsInteger;
          CmbAPInfoAtax.ItemIndex     := tblUserConfigAP_INFO_ATAX.AsInteger;
          CmbAPRight.ItemIndex        := tblUserConfigAP_RIGHT.AsInteger;
          CmbAPSecuence.ItemIndex     := tblUserConfigAP_SECUENCE.AsInteger;
     End;
End;
procedure TFrmUserPreferences.SaveValues;
Begin
     With dmSAQ305002 Do Begin
          tblUserConfigDSTRCT_CODE.AsString       := CurrentDistrict;
          tblUserConfigEMPLOYEE_ID.AsString       := CurrentUser;
          tblUserConfigCC_TYPE_DSTRB.AsInteger    := CmbCCTypeDstrb.ItemIndex;
          tblUserConfigCC_DEFAULT_DSTRB.AsInteger := CmbCCDefaultDstrb.ItemIndex;
          tblUserConfigTYPE_COMMENTS.AsInteger    := CmbTypeComments.ItemIndex;
          tblUserConfigTYPE_CNTRCT_EXT.AsInteger  := CmbTypeCntrctExt.ItemIndex;
          tblUserConfigLOAD_INV_TYPE.AsInteger    := CmbLoadInvType.ItemIndex;
          tblUserConfigACT_VALIDATION.AsInteger   := CmbActValidation.ItemIndex;
          tblUserConfigINV_VALIDATION.AsInteger   := CmbInvValidation.ItemIndex;
          tblUserConfigTYPE_CNT_LIMIT.AsInteger   := CmbTypeCntLimit.ItemIndex;
          tblUserConfigAP_INFO_ATAX.AsInteger     := CmbAPInfoAtax.ItemIndex;
          tblUserConfigAP_RIGHT.AsInteger         := CmbAPRight.ItemIndex;
          tblUserConfigAP_SECUENCE.AsInteger      := CmbAPSecuence.ItemIndex;
     End;
End;
procedure TFrmUserPreferences.ExecInitialization;
Begin
     { Display Current User }
     DisplayUserIdentity;
     { Fill up combo box }
     FillUpComboBox;
     { Open the Configuration Table and look for current values }
     With dmSAQ305002,tblUserConfig Do Begin
          Active := True;
          If Locate(KNL_002,CurrentDistrict,[]) Then Begin
             LoadCurrentValues;
          End;
     End;
End;
procedure TFrmUserPreferences.FormCreate(Sender: TObject);
Begin
     Try
        If Application.ShowMainForm Then Begin
           dmSAQ305002.ConnectTODBMIMS;
           ExecInitialization;
        End;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(SAQ305LoadFailure,[E.Message]);
           Application.Terminate;
        End;
     End;
End;
procedure TFrmUserPreferences.BtnOkClick(Sender: TObject);
begin
     Try
        With dmSAQ305002,tblUserConfig Do Begin
             If Locate(KNL_002,CurrentDistrict,[]) Then Begin
                Edit; End
             Else Begin
                Append;
             End;
             SaveValues;
             Post;
        End;
        Close;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(SAQ305SaveFailure,[E.Message]);
           ModalResult := mrNone;
        End;
     End;
end;

procedure TFrmUserPreferences.FormResize(Sender: TObject);
Var
   CBWidth:             Integer;
begin
     PnlUserName.Width := PnlUserInfo.ClientWidth - PnlUserName.Left - LblUserId.Left;
     CBWidth := PnlOptions.ClientWidth - CmbCCTypeDstrb.Left - LblUserId.Left;
     CmbCCTypeDstrb.Width    := CBWidth;
     CmbCCDefaultDstrb.Width := CBWidth;
     CmbTypeComments.Width   := CBWidth;
     CmbTypeCntrctExt.Width  := CBWidth;
     CmbLoadInvType.Width    := CBWidth;
     CmbActValidation.Width  := CBWidth;
     CmbInvValidation.Width  := CBWidth;
     CmbTypeCntLimit.Width   := CBWidth;
     CmbAPInfoAtax.Width     := CBWidth;
     CmbAPRight.Width        := CBWidth;
     CmbAPSecuence.Width     := CBWidth;
end;

procedure TFrmUserPreferences.BtnCancelClick(Sender: TObject);
begin
     Close;
end;
Procedure InitMultiInstanceSupport;
Const
     SAQ305MutexID = 'SAQ305MutexID';
Var
   MIError:             Integer;
Begin
     MIError := OpenMultiInstanceSupport(SAQ305MutexID);
     If MIError <> 0 Then Begin
        ShowMessageFmt(ME_180,[MIError]);
        Application.Terminate;
     End;
End;
Initialization
   InitMultiInstanceSupport;
Finalization
   CloseMultiInstanceSupport;
end.
