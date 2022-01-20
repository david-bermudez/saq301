unit SAQ301003;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, db, DBGrids, DBCtrls, ExtCtrls, Buttons, ComCtrls;
                                                                       
type
  TfrmSAQ301003CostCenters = class(TForm)
    GrdCostCenters: TDBGrid;
    Panel1: TPanel;
    NavCostCenters: TDBNavigator;
    BtnHelp: TSpeedButton;
    BtnReturn: TSpeedButton;
    StbCostCenters: TStatusBar;
    BtnCopy: TSpeedButton;
    BtnPegar: TSpeedButton;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnReturnClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCopyClick(Sender: TObject);
    procedure BtnPegarClick(Sender: TObject);
  private
    { Private declarations }
    FIsReadOnly:        Boolean;
    FElementValue:      Currency;
    procedure ValidateByPercent(var CanClose: Boolean);
    procedure ValidateByValue(var CanClose: Boolean);
    procedure InitByPercent;
    procedure InitByValue;
    procedure InitCostCenters;
    procedure CheckProjectIndicator;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent;AIsReadOnly:Boolean);
    Property IsReadOnly:Boolean Read FIsReadOnly Write FIsReadOnly;
    Property ElementValue:Currency Read FElementValue Write FElementValue;

    {IC633:Flag que indica si debemos hacer la validacion}
//    Property FCheckProjInd:Boolean Read FElementValue Write FElementValue;

  end;

var
  frmSAQ301003CostCenters: TfrmSAQ301003CostCenters;

Procedure EditCostCenters(AOwner:TComponent;IsReadOnly:Boolean);
implementation

uses MCDMActs, MCTypes, MCUtils, MCObjcts;

{$R *.DFM}
Procedure EditCostCenters(AOwner:TComponent;IsReadOnly:Boolean);
Begin
     frmSAQ301003CostCenters := Nil;
     Try
        frmSAQ301003CostCenters := TfrmSAQ301003CostCenters.Create(AOwner,IsReadOnly);
        frmSAQ301003CostCenters.ShowModal;
     Finally
        frmSAQ301003CostCenters.Free;
     End;
End;
Constructor TfrmSAQ301003CostCenters.Create(AOwner:TComponent;AIsReadOnly:Boolean);
Begin
     Inherited Create(AOwner);
     FIsReadOnly := AIsReadOnly;
     Try
        InitCostCenters;
//        CheckProjectIndicator;
     Except
        On E:Exception Do Begin
           ShowMessage(E.Message);
           GrdCostCenters.Enabled := False;
           NavCostCenters.Enabled := False;
        End;
     End;
End;
procedure TfrmSAQ301003CostCenters.InitByPercent;
Var
   ColValue:            TColumn;
Begin
     ColValue := GetColumnByName(GrdCostCenters,'VALUE');
     If Not Assigned(ColValue) Then Begin
        raise Exception.CreateFmt(ME_122,['VALUE']);
     End;
     ColValue.Visible := False;
End;
procedure TfrmSAQ301003CostCenters.InitByValue;
Var
   ColPercent:          TColumn;
Begin
     ColPercent := GetColumnByName(GrdCostCenters,'PERCENT');
     If Not Assigned(ColPercent) Then Begin
        raise Exception.CreateFmt(ME_122,['PERCENT']);
     End;
     ColPercent.Visible := False;
End;

procedure TfrmSAQ301003CostCenters.InitCostCenters;
Var
   ColDocType:          TColumn;
   Index1:              TDocument;
Begin
     { Init conditions for the Type Distribution }
     Case dmActs.UserConfig.DCCTypeDstrb Of
     cctdPercent : InitByPercent;
     cctdValue   : InitByValue;
     End;
     { Display Current values on the Status Bar }
     ElementValue := dmActs.GetCurrentElementValue;
     StbCostCenters.SimpleText := Format(MI_024,[ElementValue,dmActs.ActPaidNewNetValue]);
     { Check Read Only Access }
     With GrdCostCenters Do Begin
          If IsReadOnly Then Begin
             NavCostCenters.VisibleButtons := BtnReadOnly;
             Options := Options + [dgRowSelect]; End
          Else Begin
             NavCostCenters.VisibleButtons := BtnFullAccess;
             Options := Options - [dgRowSelect];
          End;
     End;
     { Init Pick list for the Document types }
     ColDocType := GetColumnByName(GrdCostCenters,'DOCUMENT_TYPE');
     If Not Assigned(ColDocType) Then Begin
        raise Exception.CreateFmt(ME_122,['DOCUMENT_TYPE']);
     End;
     With ColDocType.PickList Do Begin
          Clear;
          For Index1 := Low(TDocument) To High(TDocument) Do Begin
              ColDocType.PickList.Add(DocumentNames[Index1]);
          End;
     End;
End;

procedure TfrmSAQ301003CostCenters.CheckProjectIndicator;
Begin
{
 03 WO-ENTRY-IND         PIC X(1).   Indicator to control Work Order entry
    88  MANDATORY-WO     VALUE 'M'.    Mandatory Work Order
    88  NO-WO            VALUE 'N'.    No Work Order
    88  OPTIONAL-WO      VALUE 'O'.    Optional Work Order
 03 PROJ-ENTRY-IND       PIC X(1).   Indicator to control Project entry
    88  MANDATORY-PROJ   VALUE 'M'.    Mandatory Project
    88  NO-PROJ          VALUE 'N'.    No Project
    88  OPTIONAL-PROJ    VALUE 'O'.    Optional Project
 03 EQUIP-ENTRY-IND      PIC X(1).   Indicator to control Equipment Entry
    88  MANDATORY-EQ     VALUE 'M'.    Mandatory Equipment
    88  NO-EQ            VALUE 'N'.    No Equipment
    88  OPTIONAL-EQ      VALUE 'O'.    Optional Equipment

Desc MSF966
WO_ENTRY_IND
PROJ_ENTRY_IND
EQUIP_ENTRY_IND
}
   dmacts.tblCosts.First;
   While not dmacts.tblCosts.Eof do begin

      if dmacts.tblCostsDOCUMENT_TYPE.AsString = '2' then begin
         with dmacts.SQLValCCMims do begin
            Try
               Active := False;
               Params[0].AsString := dmacts.CurrentDistrict;
                Params[1].AsString := dmacts.tblCostsGL_ACCOUNT.AsString;
                If Not Prepared Then Begin
                   Prepare;
                End;
                Active:=True;

                If (Fields[3].AsString = 'M') and
                   (dmacts.tblCostsDOCUMENT_NO.AsString = '') Then begin
                      raise EAbort.Create('');
                end;
            Except
                On E:Exception Do Begin
                   raise Exception.CreateFmt(ME_047,[dmacts.tblCostsGL_ACCOUNT.AsString]);
                End;
            End;
         end;
      end;
      dmacts.tblCosts.Next;
   end;


End;


procedure TfrmSAQ301003CostCenters.BtnCancelClick(Sender: TObject);
begin
     Close;
end;
{ Use this routine to check if the percent assigned to the cost center of
  the current element are equal to 100%. This routine is required when the
  method to distribute the element cost is by percent. Note : The percents
  are stored as integer numbers scaled by 100  }
procedure TfrmSAQ301003CostCenters.ValidateByPercent(var CanClose: Boolean);
Var
   Percent:             Integer;    { Total Percent assigned to the cost centers }
Begin
     Percent  := dmActs.GetTotalPercentAssigned;
     CanClose := Percent = 10000;
     If Not CanClose Then Begin
        ShowMessageFmt(ME_046,[Percent Div 100,Percent Mod 100]);
     End;
End;
{ Use this routine to check if the values assigned to the cost center of
  the current element are equal to the element value in the Act. This
  routine is required when the method to distribute the element cost
  is by value  }
procedure TfrmSAQ301003CostCenters.ValidateByValue(var CanClose: Boolean);
Var
   CCValues:            Currency;
Begin
     CCValues := dmActs.GetCCValuesAssignedByElement;
     //CanClose := Abs(CCValues - ElementValue) < 0.0001;
     CanClose := Abs(Round(CCValues) - Round(ElementValue)) < 0.0001;
     If Not CanClose Then Begin
        ShowMessageFmt(ME_094,[CCValues,ElementValue]);
     End;
End;
procedure TfrmSAQ301003CostCenters.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     CanClose := True;
     If dmActs.EditMode Then Begin
        CanClose := Not (dmActs.tblCosts.State in [dsInsert,dsEdit]);
        If CanClose Then Begin
           { Validate the cost distribution }
           Case dmActs.UserConfig.DCCTypeDstrb Of
           cctdPercent : ValidateByPercent(CanClose);
           cctdValue   : ValidateByValue(CanClose);
           End; End
        Else Begin
           ShowMessage(MI_008);
        End;
     End;
end;

procedure TfrmSAQ301003CostCenters.BtnReturnClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmSAQ301003CostCenters.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3011325);
end;
procedure TfrmSAQ301003CostCenters.FormShow(Sender: TObject);
begin
     { Work around for the display trouble (duplicated views of records)
       shown sometimes in the grid GrdCostCenters }
     dmActs.tblCosts.First;    
end;

procedure TfrmSAQ301003CostCenters.BtnCopyClick(Sender: TObject);
Var
   CCPosition:          TBookmarkStr;
   CCCBItem:            TCCCBItem;
begin
     CCPosition := dmActs.tblCosts.Bookmark;
     Try
        With dmActs,tblCosts Do Begin
             CCClipboard.Clear;
             First;
             While Not Eof Do Begin
                   CCCBItem := TCCCBItem.Create;
                   CCCBItem.GLAccount    := tblCostsGL_ACCOUNT.AsString;
                   CCCBItem.DocumentType := tblCostsDOCUMENT_TYPE.AsString;
                   CCCBItem.DocumentNo   := tblCostsDOCUMENT_NO.AsString;
                   CCCBItem.EquipNo      := tblCostsEQUIP_NO.AsString;
                   CCCBItem.Percent      := tblCostsPERCENT.AsString;
                   CCClipboard.AddCBItem(CCCBItem);
                   Next;
             End;
        End;
     Finally
        dmActs.tblCosts.Bookmark := CCPosition;
     End;
end;

procedure TfrmSAQ301003CostCenters.BtnPegarClick(Sender: TObject);
Var
   CCCBItem:            TCCCBItem;
   CCIndex:             Integer;
begin
     dmActs.tblCosts.DisableControls;
     Try
        CCIndex := 0;
        While CCIndex < dmActs.CCClipboard.Count Do Begin
              CCCBItem := dmActs.CCClipboard.CCCBItemAt[CCIndex];
              Try
                 dmActs.tblCosts.Append;
                 dmActs.tblCostsGL_ACCOUNT.AsString    := CCCBItem.GLAccount;
                 dmActs.tblCostsDOCUMENT_TYPE.AsString := CCCBItem.DocumentType;
                 dmActs.tblCostsDOCUMENT_NO.AsString   := CCCBItem.DocumentNo;
                 dmActs.tblCostsEQUIP_NO.AsString      := CCCBItem.EquipNo;
                 dmActs.tblCostsPERCENT.AsString       := CCCBItem.Percent;
                 dmActs.tblCosts.Post;
              Except
                 On Exception Do Begin
                    dmActs.tblCosts.Cancel;
                 End;
              End;
              Inc(CCIndex);
        End;
     Finally
        dmActs.tblCosts.EnableControls;
     End;
end;

end.


