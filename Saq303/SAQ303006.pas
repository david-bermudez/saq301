{ This module is intended to manage the received invoices for the corresponding
  approved Acts. The process is the following :
  1. In SAQ303001, the system connect to MIMS by using the interface COM with
     MSQMUI (technology MIMSX, routine ConnectToMSQMUI ) supported by the
     variable MIMSXServer defined here. MIMSXServer is an instance of the
     class TMIMSXServer, implemented in SAQ300002. This class is Delphi
     class to hide the details of the COM connection.
  2. Also in SAQ303001, after to connect to MIMS, the system connect to
     the MIMS Database (routine ConnectToBDMIMS) by using the user id
     and password to the Oracle database provided by MIMSXServer; and,
     then, init the basic structures as Element names, Atax codes, etc
     (routine InitStructures)
  3. The system create a temporal table (tblPays) with all the acts in the
     asCounted state by using the routine CreateTablePays, defined in
     SAQ303002
  4. SAQ303001 list the table; then, the user can create the invoice in MIMS
     by doubleclicking on the Act Paid selected; this operation call the form
     in SAQ303004, then, on this form, the user enter the data fields values
     for the invoices
  5. The new information is send to MIMS, saved to the Database table SAF3A4
     and the Act state changes to asInvoiced by calling since BtnSave in
     SAQ303004 the routine UpdateDataBase, defined here }

unit SAQ303006;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SAQ300002;

type
  TdmSAQ303006MIMSX = class(TDataModule)
    procedure dmSAQ303006MIMSXDestroy(Sender: TObject);
    procedure dmSAQ303006MIMSXCreate(Sender: TObject);
  private
    { Private declarations }
    FMIMSXServer:       TMIMSXServer;
    FLiabilityAccount:  String;     { Liability Account for all the cost centers }
    FVoucherStyle:      String;     { Field VCHR_NO1I in MSM389A }
    FCurrentItem:       String;     { Field INV_ITEM_NO1I in MSM26JA }
    FTaxPayable:        String;     { Field TAX_PAYABLE1I in MSM26JA }
    FSentItems:         Boolean;    { True = Sent all the items to MIMS }
    Function WasLoaded:Boolean;
    Function StayInItem:Boolean;
    Procedure ReturnToScreen(AnScreen:String);
    procedure ProcessScreenMSM26JA;
    Procedure CheckLoadOk;
    Procedure MSM26JALineTotblAtax(ANumber:String);
    Procedure MSM26JATotblAtax;
    Procedure tblAtaxToMSM26JALine(ANumber:String);
    Procedure ClearMSM26JALine(ANumber:String);
    Procedure tblAtaxToMSM26JA;
    Procedure MSM389AFeedBack;
    Procedure CloseAtaxDetail(Sender: TObject; var CanClose: Boolean);
    Procedure CommandOkInMSM389A;
    Procedure SendItemToMIMS(ANumber:String);
    Procedure SendCostToMIMS;
    Procedure SendInvoiceToMIMS;
    Procedure SendItemsToMIMS;
    Procedure SendCostsToMIMS;
    Procedure CreateInvoiceInMIMS;
  public
    { Public declarations }
    Procedure ConnectToMSQMUI;
    Procedure UpdateDataBase;
    Property MIMSXServer: TMIMSXServer Read FMIMSXServer;
    Property LiabilityAccount:String Read FLiabilityAccount Write FLiabilityAccount;
    Property VoucherStyle:String Read FVoucherStyle Write FVoucherStyle;
  end;

var
  dmSAQ303006MIMSX: TdmSAQ303006MIMSX;

implementation

uses SAQ303002, SAQ300003, MCTypes, SAQ303005, MCObjcts;

{$R *.DFM}

Procedure TdmSAQ303006MIMSX.ConnectToMSQMUI;
Begin
     try
        FMIMSXServer := TMIMSXServer.Create;
        MIMSXServer.Connect;
        ShowConnectionActivity(Application);
        { Check right access. }
        If MIMSXServer.LevelAccess <> '2' Then Begin
           raise Exception.Create(ME_138);
        End;
        { Get global params for the module }
        With dmSAQ303002DataModule Do Begin
             CurrentUserID    := MIMSXServer.MimsUser;
             MimsPosition     := MIMSXServer.MimsPosition;
             CurrentDistrict  := MIMSXServer.MimsDistrict;
             OracleUser       := MIMSXServer.OracleUser;
             OraclePassword   := MIMSXServer.OraclePassword;
             LiabilityAccount := MIMSXServer.TableValue['+SAP','CPAP'];
        End;
     Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_107,[E.Message]);
        End;
     End;
     { Get Bank Information }
     Try
        MIMSXServer.ExecProgram('MSO389');
        With dmSAQ303002DataModule,MIMSXServer Do Begin
             DefBankCode    := ItemValue['BRANCH_CODE1I'];
             DefBankAccount := ItemValue['BANK_ACCT_NO1I'];
        End;
     Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_147,[E.Message,'MSO389']);
        End;
     End;
End;
{ Return to the right screen }
Procedure TdmSAQ303006MIMSX.ReturnToScreen(AnScreen:String);
Begin
     While MIMSXServer.ScreenName <> AnScreen Do Begin
           MIMSXServer.DoCommand('OK');
     End;
End;
{ Use this routine to check if MIMS still stay in the Atax screen for the
  current item. Two test are necessaries : First, we check if we are in the
  Atax screen (MSM26JA) ans Second, we verify if the Atax are for the same
  item (Field INV_ITEM_NO1I equal to the current item). The second test is
  necessary because MIMS is able to check Atax for each item one after one;
  therefore, it's not enough to stay in MSM26JA }
Function TdmSAQ303006MIMSX.StayInItem:Boolean;
Var
   InMSM26JA:         Boolean;
Begin
     With MIMSXServer Do Begin
          InMSM26JA := ScreenName = 'MSM26JA';
          If InMSM26JA Then Begin
             InMSM26JA := FCurrentItem = ItemValue['INV_ITEM_NO1I'];
          End;
     End;
     StayInItem := InMSM26JA;
End;
{ This routine is used to synchronize MSM26JA with the Atax detail windows
  (frmSAQ303005AtaxValues). It's called as the OnCloseQuery event in that
  window; therefore, the user is sending a request to close the input about
  atax for the current item, in order we do it in MIMS by copying the details
  in that windows (tblAtax) to MIMS (routine tblAtaxToMSM26JA), next, we send
  a command 'Ok' to MIMS and we check the MIMS reply in the following order :
  First, we check if MIMS is still editing the Atax for current item (function
  StayInItem), in that case, we check if there is an error; on error, we
  display the new Tax Payable and the error message, plus we cancel the
  window close (CanClose = False); on succesfull, MIMS is asking confirmation;
  therefore, we do it with a command 'Ok' and we display the Tax Payable
  Second, in other case, MIMS closed MSM26JA; therefore, we check if there was
  an error and we display this error message}
Procedure TdmSAQ303006MIMSX.CloseAtaxDetail(Sender: TObject; var CanClose: Boolean);
Var
   MIMSErrMsg:          String;
Begin
     tblAtaxToMSM26JA;
     With MIMSXServer Do Begin
          DoCommand('OK');
          If StayInItem Then Begin
             FTaxPayable := ItemValue['TAX_PAYABLE1I'];
             MIMSErrMsg  := MimsError;
             If Length(MIMSErrMsg) > 0 Then begin
                CanClose := False;
                frmSAQ303005AtaxValues.PnlTaxPayable.Caption := FTaxPayable;
                ShowMessageFmt(ME_160,[MIMSErrMsg]); End
             Else Begin
                DoCommand('OK');
                If FCurrentItem = '' Then Begin
                   { Global Atax }
                   ShowMessageFmt(MI_022,[FTaxPayable]); End
                Else Begin
                   { Atax for the current item }
                   ShowMessageFmt(MI_023,[FCurrentItem,FTaxPayable]);
                End;
             End; End
          Else Begin
             If Not WasLoaded Then Begin
                ShowMessageFmt(ME_160,[MimsError]);
             End;
          End;
     End;
End;
{ Process screen MSM26JA }
procedure TdmSAQ303006MIMSX.ProcessScreenMSM26JA;
begin
     With MIMSXServer Do Begin
          Try
             While (ScreenName = 'MSM26JA') do Begin
                   FCurrentItem := ItemValue['INV_ITEM_NO1I'];
                   FTaxPayable  := ItemValue['TAX_PAYABLE1I'];
                   MSM26JATotblAtax;
                   EditAtaxValues(Self,FCurrentItem,FTaxPayable,CloseAtaxDetail);
             End;
          Finally
             dmSAQ303002DataModule.ClearEditAtaxFlags;
          End;
          if ErrorNo = '2287' Then Begin
             { Warning - Bank info replaced by supplier defaults }
             DoCommand('OK');
          End;
     End;
end;
{ True = The invoice was loaded sucessfull. We check it by comparing a substring
  that MIMS include at end of its message informing a sucessfull loaded. Now,
  this only work in the MIMS English version, to other language it will be
  necessary to change this substring (MI_015). Unfortunately, there is not a
  code to identify the message "Loaded Ok"; therefore, this is a critical
  issue because is an unsafe method to check a successfull load. }
Function TdmSAQ303006MIMSX.WasLoaded:Boolean;
Var
   MIMSError:           String;
   LngErrMsg:           Integer;
 Function ContainText(AText:String):Boolean;
 Var
    StrLoadOk:           String;
    LngText:             Integer;
 Begin
      ContainText := False;
      LngText     := Length(AText);
      if LngErrMsg >= LngText Then Begin
         StrLoadOk   := Copy(MIMSError,LngErrMsg-LngText+1,LngText);
         ContainText := AText = StrLoadOk;
      End;
 End;
Begin
     MIMSError := MIMSXServer.MimsError;
     LngErrMsg := Length(MIMSError);
     WasLoaded := ContainText(MI_015) Or ContainText(MI_025);
End;
{ Call this routine when it supposed the invoice was loaded successful; on
  error, raise an exception with the last MIMS error }
Procedure TdmSAQ303006MIMSX.CheckLoadOk;
Begin
     If MIMSXServer.MimsError = '' Then Begin
        MIMSXServer.DoCommand('Ok');
     End;
     If Not WasLoaded Then Begin
        raise Exception.CreateFmt(ME_113,[MIMSXServer.MimsError]);
     End;
End;
{ Copy one Atax line in MSM26JA to one record in the table tblAtax }
Procedure TdmSAQ303006MIMSX.MSM26JALineTotblAtax(ANumber:String);
Begin
     With dmSAQ303002DataModule,MIMSXServer Do Begin
          tblAtax.Append;
          tblAtaxATAX_CODE.AsString := ItemValue['ATAX_CODE1I' + ANumber];
          tblAtaxATAX_RATE.AsString := ItemValue['ATAX_RATE1I' + ANumber];
          tblAtaxATAX_DESC.AsString := ItemValue['ATAX_DESC1I' + ANumber];
          tblAtaxTAX_VALUE.AsString := ItemValue['TAX_VALUE1I' + ANumber];
          tblAtax.Post;
     End;
End;
{ Copy the Atax lines in MSM26JA to records in the table tblAtax }
Procedure TdmSAQ303006MIMSX.MSM26JATotblAtax;
Var
   IntLine:             Integer;
   StrLine:             String;
   AtaxCode:            String;
Begin
     dmSAQ303002DataModule.tblAtax.CancelUpdates;
     For IntLine := 1 To MSM26JALines Do Begin
         StrLine  := IntToStr(IntLine);
         AtaxCode := Trim(MIMSXServer.ItemValue['ATAX_CODE1I'+StrLine]);
         If AtaxCode <> '' Then Begin
            MSM26JALineTotblAtax(StrLine);
         End;
     End;
End;
{ Copy one record in the table tblAtax to one Atax line in MSM26JA }
Procedure TdmSAQ303006MIMSX.tblAtaxToMSM26JALine(ANumber:String);
Begin
     With dmSAQ303002DataModule,MIMSXServer Do Begin
          ItemValue['ATAX_CODE1I' + ANumber] := tblAtaxATAX_CODE.AsString;
          ItemValue['ATAX_RATE1I' + ANumber] := tblAtaxATAX_RATE.AsString;
          ItemValue['ATAX_DESC1I' + ANumber] := tblAtaxATAX_DESC.AsString;
          ItemValue['TAX_VALUE1I' + ANumber] := tblAtaxTAX_VALUE.AsString;
     End;
End;
{ Clear one Atax line in MSM26JA }
Procedure TdmSAQ303006MIMSX.ClearMSM26JALine(ANumber:String);
Begin
     With dmSAQ303002DataModule,MIMSXServer Do Begin
          ItemValue['ATAX_CODE1I' + ANumber] := '';
          ItemValue['ATAX_RATE1I' + ANumber] := '';
          ItemValue['ATAX_DESC1I' + ANumber] := '';
          ItemValue['TAX_VALUE1I' + ANumber] := '';
     End;
End;
{ Copy the records in the table tblAtax to the Atax lines in MSM26JA and
  clear the remain Atax lines  }
Procedure TdmSAQ303006MIMSX.tblAtaxToMSM26JA;
Var
   IntLine:             Integer;
   StrLine:             String;
Begin
     IntLine := 1;
     With dmSAQ303002DataModule,tblAtax Do Begin
          First;
          While Not EoF Do Begin
                StrLine := IntToStr(IntLine);
                tblAtaxToMSM26JALine(StrLine);
                Next;
                Inc(IntLine);
          End;
     End;
     While IntLine <= MSM26JALines Do Begin
           StrLine := IntToStr(IntLine);
           ClearMSM26JALine(StrLine);
           Inc(IntLine);
     End;
End;
Procedure TdmSAQ303006MIMSX.CommandOkInMSM389A;
Var
   MIMSError:           String;
   ElementNo:           String;
Begin
     MIMSXServer.DoCommand('Ok');
     { Check MSQMUI errors }
     MIMSError := MIMSXServer.MimsError;
     if length(MIMSError) > 0 then begin
        If Not WasLoaded Then Begin
           If FSentItems Then Begin
              raise Exception.CreateFmt(ME_110,[MIMSError]); End
           Else Begin
              ElementNo := dmSAQ303002DataModule.SQLItmXEleELEMENT_NO.AsString;
              raise Exception.CreateFmt(ME_109,[MIMSError,ElementNo]);
           End;
        End;
     End;
End;
{ Fill up an item line in MSM389A }
Procedure TdmSAQ303006MIMSX.SendItemToMIMS(ANumber:String);
Var
   Node389:             TItem389Map;
   Item389:             String;
Begin
     With dmSAQ303002DataModule,MIMSXServer Do Begin
          Item389 := Trim(ItemValue['INV_ITEM_NO1I' + ANumber]);
          Node389 := TItem389Map.Create;
          Node389.ElementNo  := tblItemsELEMENT_NO.AsString;
          Node389.CategoryNo := tblItemsCATEGORY_NO.AsString;
          MapItem389.AddObject(Item389,Node389);
          ItemValue['ELEMENT_NO1I' + ANumber]     := Node389.ElementNo;
          ItemValue['CATEGORY_NO1I' + ANumber]    := Node389.CategoryNo;
          ItemValue['INV_ITEM_QTY1I' + ANumber]   := '';
          ItemValue['INV_ITEM_VALUE1I' + ANumber] := CrrValue(tblItemsITEM_VALUE);
          ItemValue['ATAX_CODE_ITM1I' + ANumber]  := tblItemsATAX_CODE.AsString;
          If tblItemsATAX_VIEW.AsBoolean Then Begin
             ItemValue['ACTION1I' + ANumber] := 'T'; End
          Else Begin
             ItemValue['ACTION1I' + ANumber] := 'A';
          End;
     End;
End;
Procedure TdmSAQ303006MIMSX.SendCostToMIMS;
Begin
     With MIMSXServer Do Begin
          ItemValue['COST_CEN_ACCT1I1'] := LiabilityAccount;
          ItemValue['ALLOC_AMT1I1']     := '100.00';
          ItemValue['WO_PROJECT1I1']    := '';
          ItemValue['PROJECT_IND1I1']   := '';
          ItemValue['PLANT_NO1I1']      := '';
     End;
End;
Procedure TdmSAQ303006MIMSX.SendInvoiceToMIMS;
Begin
     With dmSAQ303002DataModule,MIMSXServer Do Begin
          If ScreenName <> 'MSM389A' Then Begin
             raise Exception.CreateFmt(ME_135,[ScreenName]);
          End;
          OnFeedBack(1,SAQ303Processing,SAQ303SendHeader);
          ItemValue['ACCOUNTANT1I']    := CurrentUser;
          ItemValue['SUPPLIER_NO1I']   := tblPaysSUPPLIER_NO.AsString;
          ItemValue['CONTRACT_NO1I']   := tblPaysCONTRACT_NO.AsString;
          ItemValue['PORTION_NO1I']    := tblPaysPORTION_NO.AsString;
          ItemValue['INV_NO1I']        := tblPaysINVOICE_NO.AsString;
          ItemValue['INV_DATE1I']      := tblPaysINVOICE_DATE.AsString;
          ItemValue['INV_RCPT_DATE1I'] := tblPaysINVOICE_RCV_DT.AsString;
          ItemValue['DUE_DATE1I']      := tblPaysINVOICE_DUE_DT.AsString;
          ItemValue['BRANCH_CODE1I']   := tblPaysINVOICE_BANK.AsString;
          ItemValue['BANK_ACCT_NO1I']  := tblPaysINVOICE_BANK_ACCT.AsString;
          ItemValue['HANDLE_CDE1I']    := tblPaysINVOICE_HANDLE_CODE.AsString;
          If (VoucherStyle <> 'A') And (VoucherStyle <> 'N') Then Begin
             ItemValue['VCHR_NO1I']    := tblPaysINVOICE_VOUCHER.AsString;
          End;
          If UserConfig.InvValidation = ivTyping Then Begin
             ItemValue['INV_AMT1I'] := tblPaysINVOICE_TYPING_VALUE.AsString; End
          Else Begin
             ItemValue['INV_AMT1I'] := FloatToStr(tblPaysINVOICE_VALUE.AsCurrency +
                                                  tblPaysINVOICE_ATAX_VALUE.AsCurrency);
          End;
          ItemValue['ADD_TAX_AMOUNT1I'] := tblPaysINVOICE_ATAX_VALUE.AsString;
          ItemValue['ATAX_CODE_HDR1I']  := tblPaysINVOICE_ATAX_CODE.AsString;
          If EditGlobalAtax Then Begin
             ItemValue['PROCESS1I'] := 'T'; End
          Else Begin
             ItemValue['PROCESS1I'] := '';
          End;
          EditGlobalAtax := False;
     End;
End;
{ Send the Item Lines to MIMS. NeedOk is used to know when we need to send
  a last command "Ok"; we need it because MSM389A only process 4 items at
  once; therefore we need to send a command "Ok" for each four items block,
  at end, if the last "screen" have less than four items we need a final
  command "Ok" }
Procedure TdmSAQ303006MIMSX.SendItemsToMIMS;
Var
   Line:                Integer;
   ItemNo:              Integer;
   NeedOk:              Boolean;
Begin
     ItemNo := 1;
     Line   := 1;
     NeedOk := True;
     FSentItems := False;
     With dmSAQ303002DataModule,tblItems Do Begin
          MapItem389.Clear;
          First;
          While Not EoF Do Begin
                NeedOk  := True;
                StbLine := Format(SAQ303CurrentRec,['Itm',ItemNo,ItemCount]);
                OnFeedBack(1,SAQ303Processing,StbLine);
                SendItemToMIMS(IntToStr(Line));
                Inc(Line);
                If Line = 5 then begin
                   { refresh items for next 4 records }
                   Line   := 1;
                   NeedOk := False;
                   CommandOkInMSM389A;
                   ProcessScreenMSM26JA;
                End;
                Next;
                Inc(ItemNo);
          End;
     End;
     FSentItems := True;
     If NeedOk Then Begin
        CommandOkInMSM389A;
        ProcessScreenMSM26JA;
     End;
End;
Procedure TdmSAQ303006MIMSX.SendCostsToMIMS;
Var
   CCNo:                Integer;
   CCCount:             Integer;
   ItemNo:              String;
   MIMSErrorMsg:        String;
   StbLine:             String;
Begin
     CCCount := dmSAQ303002DataModule.ItemCount;
     CCNo := 1;
     With MIMSXServer Do Begin
          DoCommand('Ok');
          While (CCNo <= CCCount) And (ScreenName = 'MSM26DA') Do Begin
                ItemNo := ItemValue['INV_ITEM_NO1I'];
                StbLine := Format(SAQ303CurrentRec,['CC',CCNo,CCCount]);
                dmSAQ303002DataModule.OnFeedBack(1,SAQ303Processing,StbLine);
                SendCostToMIMS;
                DoCommand('OK');
                { Check MSQMUI errors }
                MIMSErrorMsg := MimsError;
                if length(MIMSErrorMsg) > 0 then begin
                   raise Exception.CreateFmt(ME_112,
                                            [MIMSErrorMsg,ItemNo,
                                             LiabilityAccount]);
                End;
                Inc(CCNo);
          End;
     End;
End;
Procedure TdmSAQ303006MIMSX.CreateInvoiceInMIMS;
Var
   MIMSError:           String;
   OriginalError:       String;
Begin
     Try
        SendInvoiceToMIMS;
        SendItemsToMIMS;
        { Check if must process costs }
        If Not WasLoaded Then Begin
           SendCostsToMIMS;
           { Look up for Load Successful or MSQMUI errors }
           CheckLoadOk;
        End;
        dmSAQ303002DataModule.SentOk := True;
     Except
        On E:Exception Do Begin
           OriginalError := E.Message;
           { Check if we are in the right screen }
           If MIMSXServer.ScreenName = 'MSM389A' Then Begin
              Try
                 MSM389AFeedBack;
                 If Trim(MIMSXServer.MimsError) <> '' Then Begin
                    MIMSXServer.DoCommand('Ok');
                 End;
              Except
                 On E:Exception Do Begin
                    raise Exception.CreateFmt(ME_166,[E.Message,OriginalError]);
                 End;
              End; End
           Else Begin
              MIMSXServer.DoCommand('Revert');
              raise Exception.CreateFmt(ME_167,[OriginalError]);
           End;
           raise;
        End;
     End;
End;
Procedure TdmSAQ303006MIMSX.UpdateDataBase;
Begin
     dmSAQ303002DataModule.SetCurrentSaveParams;
     CreateInvoiceInMIMS;
     dmSAQ303002DataModule.ProcessMIMSResults;
End;
Procedure TdmSAQ303006MIMSX.MSM389AFeedBack;
Begin
     With dmSAQ303002DataModule,MIMSXServer Do Begin
          If ScreenName <> 'MSM389A' Then Begin
             raise Exception.CreateFmt(ME_135,[ScreenName]);
          End;
          tblPaysINVOICE_NO.AsString          := ItemValue['INV_NO1I'];
          tblPaysINVOICE_DATE.Text            := ItemValue['INV_DATE1I'];
          tblPaysINVOICE_RCV_DT.Text          := ItemValue['INV_RCPT_DATE1I'];
          tblPaysINVOICE_DUE_DT.Text          := ItemValue['DUE_DATE1I'];
          tblPaysINVOICE_BANK.AsString        := ItemValue['BRANCH_CODE1I'] ;
          tblPaysINVOICE_BANK_ACCT.AsString   := ItemValue['BANK_ACCT_NO1I'];
          tblPaysINVOICE_HANDLE_CODE.AsString := ItemValue['HANDLE_CDE1I'];
          If VoucherStyle <> 'N' Then Begin
             tblPaysINVOICE_VOUCHER.AsString := ItemValue['VCHR_NO1I'] ;
          End;
     End;
End;
procedure TdmSAQ303006MIMSX.dmSAQ303006MIMSXDestroy(Sender: TObject);
begin
     Try
        MIMSXServer.Free;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_165,[E.Message]);
        End;
     End;
end;

procedure TdmSAQ303006MIMSX.dmSAQ303006MIMSXCreate(Sender: TObject);
begin
     FMIMSXServer := Nil;
end;

end.
