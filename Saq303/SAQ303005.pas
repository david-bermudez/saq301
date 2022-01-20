unit SAQ303005;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, DBCtrls, ExtCtrls, Mask, Buttons, Variants;

type
  TfrmSAQ303005AtaxValues = class(TForm)
    PnlHeader: TPanel;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    GrdAtaxValues: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    EdtSupplierName: TDBEdit;
    PnlInvoiceNo: TDBEdit;
    BtnHelp: TSpeedButton;
    Label3: TLabel;
    EdtSupplierNo: TDBEdit;
    PnlFixedKind: TPanel;
    LblElement: TLabel;
    PnlElementName: TPanel;
    LblCategory: TLabel;
    PnlCategoryName: TPanel;
    BtnExit: TSpeedButton;
    Label4: TLabel;
    PnlTaxPayable: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure PnlHeaderResize(Sender: TObject);
  private
    { Private declarations }
    FScreenItem:        String;
    FTaxPayable:        String;
    procedure DisplayHeaderForGlobal;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent;AnScreenItem,ATaxPayable:String);
  end;

var
  frmSAQ303005AtaxValues: TfrmSAQ303005AtaxValues;

Procedure EditAtaxValues(AOwner:TComponent;AnScreenItem,ATaxPayable:String;
                         OnCloseAtaxDetail:TCloseQueryEvent);
implementation

uses SAQ303001, SAQ303002, MCUtils, MCTypes, MCObjcts;

{$R *.DFM}
Procedure EditAtaxValues(AOwner:TComponent;AnScreenItem,ATaxPayable:String;
                         OnCloseAtaxDetail:TCloseQueryEvent);
Begin
     frmSAQ303005AtaxValues := Nil;
     Try
        frmSAQ303005AtaxValues := TfrmSAQ303005AtaxValues.Create(AOwner,AnScreenItem,ATaxPayable);
        frmSAQ303005AtaxValues.OnCloseQuery := OnCloseAtaxDetail;
        frmSAQ303005AtaxValues.ShowModal;
     Finally;
        frmSAQ303005AtaxValues.Free;
     End;
End;
Constructor TfrmSAQ303005AtaxValues.Create(AOwner:TComponent;AnScreenItem,ATaxPayable:String);
Begin
     FScreenItem := Trim(AnScreenItem);
     FTaxPayable := ATaxPayable;
     Inherited Create(AOwner);
End;
procedure TfrmSAQ303005AtaxValues.DisplayHeaderForGlobal;
Begin
     PnlHeader.Height        := PnlElementName.Top;
     PnlElementName.Visible  := False;
     PnlCategoryName.Visible := False;
     PnlFixedKind.Caption    := MI_021;
End;
procedure TfrmSAQ303005AtaxValues.FormCreate(Sender: TObject);
Var
   AtaxCodeColumn:      TColumn;
   ItemKey:             Variant;
   ItemIndex:           Integer;
   Node389:             TItem389Map;
begin
     AtaxCodeColumn := GetColumnByName(GrdAtaxValues,'ATAX_CODE');
     AtaxCodeColumn.PickList.Clear;
     dmSAQ303002DataModule.AtaxCodesToDisplayList(AtaxCodeColumn.PickList);
     PnlTaxPayable.Caption := FTaxPayable;
     ItemIndex := dmSAQ303002DataModule.MapItem389.IndexOf(FScreenItem);
     If ItemIndex >= 0 Then Begin
        Node389 := dmSAQ303002DataModule.MapItem389.Objects[ItemIndex] As TItem389Map;
        ItemKey := VarArrayOf([Node389.ElementNo,Node389.CategoryNo]);
        If dmSAQ303002DataModule.tblItems.Locate(KNL_001,ItemKey,[]) Then Begin
           PnlElementName.Caption  := dmSAQ303002DataModule.tblItemsELEMENT_DESC.AsString;
           If dmSAQ303002DataModule.UserConfig.LoadInvType = litElement Then Begin
              PnlCategoryName.Visible := False;
              LblCategory.Visible     := False; End
           Else Begin
              PnlCategoryName.Caption := dmSAQ303002DataModule.tblItemsCATEGORY_DESC.AsString;
           End;
           PnlFixedKind.Caption := MI_020; End
        Else Begin
           DisplayHeaderForGlobal;
        End; End
     Else Begin
        DisplayHeaderForGlobal;
     End;
end;

procedure TfrmSAQ303005AtaxValues.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3031300);
end;

procedure TfrmSAQ303005AtaxValues.BtnExitClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmSAQ303005AtaxValues.PnlHeaderResize(Sender: TObject);
Var
   FreeSpace:           Integer;
begin
     FreeSpace := PnlHeader.ClientWidth - LblElement.Left;
     EdtSupplierName.Width := FreeSpace - EdtSupplierName.Left;
     PnlFixedKind.Width    := FreeSpace - PnlFixedKind.Left;
     PnlCategoryName.Width := FreeSpace - PnlCategoryName.Left;
end;

end.
