unit SAQ301008;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmSAQ301008Suppliers = class(TForm)
    LbSuppliers: TListBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EdtSupplierName: TEdit;
    EdtIdentification: TEdit;
    BtnSearch: TButton;
    BtnNewSearch: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure BtnNewSearchClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure LbSuppliersDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function SelectSupplierCode(CurrentCode:String):String;
  end;

var
  frmSAQ301008Suppliers: TfrmSAQ301008Suppliers;


implementation

uses MCDMActs, MCObjcts, MCUtils, MCTypes;

{$R *.DFM}

{ To improve performance, we use a non standard technique. FrmSuppliers
  is one form in the list of auto-create forms because we preserve the
  list of suppliers retrieved until the user choice the Search button
  again. In this way, the user select a supplier closing the window and
  when he (or she) open the window again, looking for other supplier,
  the old supplier list is already avalaible; therefore, if the new
  supplier is in the list, it's not neccessary to use the Search button
  again. }
Function TfrmSAQ301008Suppliers.SelectSupplierCode(CurrentCode:String):String;
Var
   SupplierIndex:       Integer;     { Index of the Supplier Selected }
   CurrentSupplier:     TSupplierDef;{ Definition of the  Supplier Selected }
Begin
     ShowModal;
     With LbSuppliers Do Begin
          SupplierIndex := ItemIndex;
          If SupplierIndex >= 0 Then Begin
             CurrentSupplier := Items.Objects[SupplierIndex] As TSupplierDef;
             SelectSupplierCode := CurrentSupplier.SupplierCode; End
          Else Begin
             SelectSupplierCode := CurrentCode;
          End;
     End;
End;
procedure TfrmSAQ301008Suppliers.FormDestroy(Sender: TObject);
begin
     { The Objects in LbSuppliers are owned by the Supplier List (Check
       MCDatos unit); therefore, it's necessary to disconnect them from
       LbSuppliers }
     DisconnectObjectsIn(LbSuppliers.Items);
end;

procedure TfrmSAQ301008Suppliers.BtnNewSearchClick(Sender: TObject);
begin
     EdtSupplierName.Text:='';
     EdtIdentification.Text:='';
     DisconnectObjectsIn(LbSuppliers.Items);
     LbSuppliers.Clear;
end;

procedure TfrmSAQ301008Suppliers.BtnSearchClick(Sender: TObject);
begin
     dmActs.LoadSuppliers(LbSuppliers,
                         EdtSupplierName.Text,
                         EdtIdentification.Text);
end;

procedure TfrmSAQ301008Suppliers.LbSuppliersDblClick(Sender: TObject);
begin
     Close;
end;

end.
