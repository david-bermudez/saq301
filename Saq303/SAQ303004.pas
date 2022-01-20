unit SAQ303004;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Grids, DBGrids, StdCtrls, db, DBCtrls, Mask, Buttons, ExtCtrls,
  Gauges;

type
  TfrmSAQ303004Invoice = class(TForm)
    Panel1: TPanel;
    BtnSave: TSpeedButton;
    BtnCancel: TSpeedButton;
    BtnHelp: TSpeedButton;
    BtnAtaxCodes: TSpeedButton;
    Panel2: TPanel;
    Label1: TLabel;
    LblContractNo: TLabel;
    EdtContractNo: TDBEdit;
    EdyPortionNo: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdtActPaidNo: TDBEdit;
    Label8: TLabel;
    EdtActPaidCrr: TDBEdit;
    Label7: TLabel;
    EdtActPaidValue: TDBEdit;
    Label4: TLabel;
    EdtActPaidDate: TDBEdit;
    Label5: TLabel;
    EdtSupplierName: TDBEdit;
    Label6: TLabel;
    EdtApproverName: TDBEdit;
    PnlEditInvoice: TPanel;
    Label9: TLabel;
    EdtInvoiceNo: TDBEdit;
    Label13: TLabel;
    EdtInvoiceRtCrr: TDBEdit;
    Label10: TLabel;
    EdtInvoiceDate: TDBEdit;
    Label12: TLabel;
    EdtInvoiceCrr: TDBEdit;
    Label14: TLabel;
    EdtInvoiceValue: TDBEdit;
    Label11: TLabel;
    EdtInvoiceRcDt: TDBEdit;
    dtpInvoiceDate: TDateTimePicker;
    dtpInvoiceRcvDt: TDateTimePicker;
    Label15: TLabel;
    CmbAtaxCode: TDBComboBox;
    Label16: TLabel;
    Label17: TLabel;
    EdtAtaxValue: TDBEdit;
    Label18: TLabel;
    CmbAtaxItems: TComboBox;
    BtnApplyAtaxCode: TSpeedButton;
    GrdItems: TDBGrid;
    sbLoadInvoice: TStatusBar;
    Label20: TLabel;
    GgeProgress: TGauge;
    Label19: TLabel;
    Label21: TLabel;
    EdtInvoiceDueDt: TDBEdit;
    dtpInvoiceDueDt: TDateTimePicker;
    Label22: TLabel;
    EdtInvoiceBank: TDBEdit;
    Label23: TLabel;
    EdtInvoiceBankAcct: TDBEdit;
    BtnEditAtaxValues: TSpeedButton;
    Label24: TLabel;
    CmbHandleCode: TDBComboBox;
    EdtSupplierNo: TDBEdit;
    LblVoucher: TLabel;
    EdtVoucher: TDBEdit;
    BtnHome: TSpeedButton;
    procedure BtnAtaxCodesClick(Sender: TObject);
    procedure dtpInvoiceDateCloseUp(Sender: TObject);
    procedure dtpInvoiceRcvDtCloseUp(Sender: TObject);
    procedure dtpInvoiceDateEnter(Sender: TObject);
    procedure dtpInvoiceRcvDtEnter(Sender: TObject);
    procedure BtnApplyAtaxCodeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure dtpInvoiceDueDtCloseUp(Sender: TObject);
    procedure dtpInvoiceDueDtEnter(Sender: TObject);
    procedure GrdItemsEditButtonClick(Sender: TObject);
    procedure BtnEditAtaxValuesClick(Sender: TObject);
    procedure BtnHomeClick(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowProgress(ACount:Integer;AMessage1,AMessage2:String);
    procedure LoadAtaxCodesInPickList;
    procedure LoadHandleCodes;
    Procedure SetInvoiceValueField;
    Procedure SetVoucherField;
    procedure SetColumns;
  public
    { Public declarations }
  end;

var
  frmSAQ303004Invoice: TfrmSAQ303004Invoice;

implementation

uses SAQ303002, SAQ303003, MCUtils, MCObjcts, MCTypes, SAQ303006;

{$R *.DFM}

Procedure TfrmSAQ303004Invoice.ShowProgress(ACount:Integer;AMessage1,AMessage2:String);
Begin
     GgeProgress.AddProgress(ACount);
     sbLoadInvoice.Panels[0].Text := AMessage1;
     sbLoadInvoice.Panels[2].Text := AMessage2;
     sbLoadInvoice.Update;
End;
procedure TfrmSAQ303004Invoice.BtnAtaxCodesClick(Sender: TObject);
begin
     frmSAQ303003AtaxCodes.ShowModal;
end;

procedure TfrmSAQ303004Invoice.dtpInvoiceDateCloseUp(Sender: TObject);
begin
     With dmSAQ303002DataModule,tblPays Do Begin
          If State <> dsEdit Then Begin
             Edit;
          End;
          tblPaysINVOICE_DATE.AsString := DateTimeToDate8(dtpInvoiceDate.Date);
     End;
end;

procedure TfrmSAQ303004Invoice.dtpInvoiceRcvDtCloseUp(Sender: TObject);
begin
     With dmSAQ303002DataModule,tblPays Do Begin
          If State <> dsEdit Then Begin
             Edit;
          End;
          tblPaysINVOICE_RCV_DT.AsString := DateTimeToDate8(dtpInvoiceRcvDt.Date);
     End;
end;

procedure TfrmSAQ303004Invoice.dtpInvoiceDateEnter(Sender: TObject);
Var
   NewDate:             TDateTime;
begin
     Try
        NewDate := Date8ToDateTime(dmSAQ303002DataModule.tblPaysINVOICE_DATE.AsString);
        dtpInvoiceDate.Date := NewDate;
     Except
        On E:Exception Do dtpInvoiceDate.Date := Date;
     End;
end;

procedure TfrmSAQ303004Invoice.dtpInvoiceRcvDtEnter(Sender: TObject);
Var
   NewDate:             TDateTime;
begin
     Try
        NewDate := Date8ToDateTime(dmSAQ303002DataModule.tblPaysINVOICE_RCV_DT.AsString);
        dtpInvoiceRcvDt.Date := NewDate;
     Except
        On E:Exception Do dtpInvoiceRcvDt.Date := Date;
     End;
end;
procedure TfrmSAQ303004Invoice.BtnApplyAtaxCodeClick(Sender: TObject);
begin
     With dmSAQ303002DataModule,tblItems Do Begin
          DisableControls;
          Try
             First;
             While Not EoF Do Begin
                   Edit;
                   tblItemsATAX_CODE.AsString := CmbAtaxItems.Text;
                   Post;
                   Next;
             End;
             First;
          Finally
             EnableControls;
          End;
     End;
end;

procedure TfrmSAQ303004Invoice.FormResize(Sender: TObject);
Var
   Margin:              Integer;    { Horizontal Margin to a border }
   Area:                Integer;    { Width of Client Area in the Panel }
begin
     Margin := LblContractNo.Left;
     Area   := PnlEditInvoice.ClientWidth;
     EdtSupplierName.Width := Area - EdtSupplierName.Left - Margin;
     EdtApproverName.Width := Area - EdtApproverName.Left - Margin;
     EdtActPaidDate.Width  := Area - EdtActPaidDate.Left - Margin;
     dtpInvoiceDate.Left   := Area - dtpInvoiceDate.Width - Margin;
     EdtInvoiceDate.Width  := dtpInvoiceDate.Left - EdtInvoiceDate.Left - 1;
     dtpInvoiceRcvDt.Left  := dtpInvoiceDate.Left;
     EdtInvoiceRcDt.Width  := EdtInvoiceDate.Width;
     dtpInvoiceDueDt.Left  := dtpInvoiceDate.Left;
     EdtInvoiceDueDt.Width := EdtInvoiceDate.Width;
     CmbHandleCode.Width   := Area - CmbHandleCode.Left - Margin;
end;

procedure TfrmSAQ303004Invoice.LoadAtaxCodesInPickList;
Var
   AtaxColumn:          TColumn;
begin
     CmbAtaxCode.Clear;
     dmSAQ303002DataModule.AtaxCodesToDisplayList(CmbAtaxCode.Items);
     CmbAtaxItems.Clear;
     CmbAtaxItems.Items.AddStrings(CmbAtaxCode.Items);
     AtaxColumn := GetColumnByName(GrdItems,'ATAX_CODE');
     AtaxColumn.PickList.Clear;
     AtaxColumn.PickList.AddStrings(CmbAtaxCode.Items);
end;
procedure TfrmSAQ303004Invoice.LoadHandleCodes;
Begin
     CmbHandleCode.Items.AddStrings(dmSAQ303002DataModule.HandleCodes);
End;
{ Set Invoice Value Field properties depending on the setting for the
  InvValidation (Invoice validation method) option in the User Configuration }
Procedure TfrmSAQ303004Invoice.SetInvoiceValueField;
Begin
     { Normally, the user must not type the Invoice Value because
       the system is able to calculate this value. Also normally
       this value (calculate field INVOICE_VALUE) is displayed in
       EdtInvoiceValue; however, if InvValidation in the User
       Configuration is set to ivTyping, the user is required to
       input this value (into the same EdtInvoiceValue) and the
       typed value is stored in INVOICE_TYPING_VALUE. Next, in the
       BeforePost event we validate both value are the equals }
     If dmSAQ303002DataModule.UserConfig.InvValidation = ivTyping Then Begin
        EdtInvoiceValue.Color     := clWindow;
        EdtInvoiceValue.DataField := 'INVOICE_TYPING_VALUE';
        EdtInvoiceValue.ReadOnly  := False;
     End;
End;
{ Set Voucher Field properties depending on the Voucher style }
Procedure TfrmSAQ303004Invoice.SetVoucherField;
Begin
     With dmSAQ303002DataModule,dmSAQ303006MIMSX Do Begin
          VoucherStyle := GetVoucherStyle(CurrentDistrict);
          If VoucherStyle = 'A' Then Begin
             { Automatic, user is not able to modify the value }
             EdtVoucher.ReadOnly := True;
             EdtVoucher.Color    := clBtnFace;
             EdtVoucher.Visible  := True;
             LblVoucher.Visible  := True; End
          Else Begin
             If VoucherStyle = 'N' Then Begin
                { Non apply, field is not displayed }
                EdtVoucher.Visible  := False;
                LblVoucher.Visible  := False; End
             Else Begin
                { In other case, the user can modify the value }
                EdtVoucher.ReadOnly := False;
                EdtVoucher.Color    := clWindow;
                EdtVoucher.Visible  := True;
                LblVoucher.Visible  := True;
             End;
          End;
     End;
End;
{ Set the columns in GrdItems depending on the current value for the
  district option LoadInvType (method used to load invoice into MIMS) }
procedure TfrmSAQ303004Invoice.SetColumns;
Var
   CCategory:           TColumn;
   CElement:            TColumn;
   CItemValue:          TColumn;
   LoadOption:          TLoadInvType;
Begin
     LoadOption := dmSAQ303002DataModule.UserConfig.LoadInvType;
     { If the Invoice is loaded by Element, we hide the Category column
       and fixed the width for the Element column to the original width
       plus the width of the Category column }
     If LoadOption = litElement Then Begin
        CCategory := GetColumnByName(GrdItems,'CATEGORY_DESC');
        CElement  := GetColumnByName(GrdItems,'ELEMENT_DESC');
        CElement.Width    := CElement.Width + CCategory.Width;
        CCategory.Visible := False;
     End;
     { If the user is able to Modify the invoice items, then we need
       to able the columns ITEM_VALUE, ELEMENT_NO and CATEGORY_NO }
     If LoadOption in [litEditCategory,litEditElement] Then Begin
        CCategory  := GetColumnByName(GrdItems,'CATEGORY_NO');
        CElement   := GetColumnByName(GrdItems,'ELEMENT_NO');
        CItemValue := GetColumnByName(GrdItems,'ITEM_VALUE');
        CItemValue.Color    := clWindow;
        CItemValue.ReadOnly := False;
        CCategory.Visible   := True;
        CElement.Visible    := True;
     End;
End;
procedure TfrmSAQ303004Invoice.FormCreate(Sender: TObject);
Begin
     Try
        Try
           LoadAtaxCodesInPickList;
        Except
           On E:Exception Do Begin
              raise Exception.CreateFmt(ME_131,[E.Message]);
           End;
        End;
        LoadHandleCodes;
        SetInvoiceValueField;
        SetColumns;
        SetVoucherField;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_103,[E.Message]);
           Application.Terminate;
        End;
     End;
End;
procedure TfrmSAQ303004Invoice.BtnCancelClick(Sender: TObject);
begin
     dmSAQ303006MIMSX.MIMSXServer.DoCommand('Revert');
     dmSAQ303002DataModule.tblPays.Cancel;
     Close;
end;

procedure TfrmSAQ303004Invoice.FormShow(Sender: TObject);
begin
     Try
        sbLoadInvoice.Panels[0].Text := 'Editando';
        { We need to able insert operations on tblItems while we create it;
          but, next, we need disable it to forbid the user to create new
          item lines (although, the user will be anyway able to insert
          if the CanModify property is True) }
        With dmSAQ303002DataModule,dmSAQ303006MIMSX,MIMSXServer  Do Begin
             Try
                EnabledInsert := True;
                CreateTemporalInvoice;
                If (VoucherStyle <> 'A') And (VoucherStyle <> 'N') Then Begin
                   tblPaysINVOICE_VOUCHER.AsString := ItemValue['VOUCHER1I'];
                End;
             Finally
                EnabledInsert := False;
             End;
        End;
     Except
        On E:Exception Do Begin
           ShowMessage(E.Message);
           Close;
        End;
     End;
end;

procedure TfrmSAQ303004Invoice.BtnSaveClick(Sender: TObject);
begin
     Try
        Try
           With GgeProgress Do Begin
                Visible  := True;
                MinValue := 0;
                { MaxValue must be the total number of possible calls to DoOnFeedBack
                  in dmSAQ303002DataModule. We count, 1 by the header, 1 by each
                  record in tblItems,1 by each cost center and 1 to set status
                  SAF3A0 }
                MaxValue := 2 + dmSAQ303002DataModule.ItemCount;
                MaxValue := MaxValue + dmSAQ303002DataModule.CCCount;
                Progress := 0;
           End;
           dmSAQ303002DataModule.OnFeedBack := ShowProgress;
           dmSAQ303006MIMSX.UpdateDataBase;
        Finally
           sbLoadInvoice.Panels[0].Text := 'Editando';
           sbLoadInvoice.Panels[2].Text := '';
           GgeProgress.Visible          := False;
        End;
        Close;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_134,[E.Message]);
        End;
     End;
end;

procedure TfrmSAQ303004Invoice.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3031100);
end;

procedure TfrmSAQ303004Invoice.dtpInvoiceDueDtCloseUp(Sender: TObject);
begin
     With dmSAQ303002DataModule,tblPays Do Begin
          If State <> dsEdit Then Begin
             Edit;
          End;
          tblPaysINVOICE_DUE_DT.AsString := DateTimeToDate8(dtpInvoiceDueDt.Date);
     End;
end;

procedure TfrmSAQ303004Invoice.dtpInvoiceDueDtEnter(Sender: TObject);
Var
   NewDate:             TDateTime;
begin
     Try
        NewDate := Date8ToDateTime(dmSAQ303002DataModule.tblPaysINVOICE_DUE_DT.AsString);
        dtpInvoiceDueDt.Date := NewDate;
     Except
        On E:Exception Do dtpInvoiceDueDt.Date := Date;
     End;
end;

procedure TfrmSAQ303004Invoice.GrdItemsEditButtonClick(Sender: TObject);
begin
     dmSAQ303002DataModule.EditItemAtax := True;
     BtnSaveClick(Self);
end;

procedure TfrmSAQ303004Invoice.BtnEditAtaxValuesClick(Sender: TObject);
begin
     dmSAQ303002DataModule.EditGlobalAtax := True;
     BtnSaveClick(Self);
end;

procedure TfrmSAQ303004Invoice.BtnHomeClick(Sender: TObject);
begin
     dmSAQ303006MIMSX.MIMSXServer.DoCommand('Cancel');
     dmSAQ303006MIMSX.MIMSXServer.ExecProgram('MSO389');
end;

end.
