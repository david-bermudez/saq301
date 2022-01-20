unit SAQ301004;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, db, DBGrids, Buttons, ExtCtrls, ComCtrls;

type
  TfrmSAQ301004Approve = class(TForm)
    Panel1: TPanel;
    BtnHelp: TSpeedButton;
    BtnCancel: TSpeedButton;
    BtnSave: TSpeedButton;
    GrdPendents: TDBGrid;
    StbStatus: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure GrdPendentsEditButtonClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowProgress(Sender:TObject);
    Procedure UpdateCurrentSelection;
    Procedure LoadPendentActs;
  public
    { Public declarations }
  end;

var
  frmSAQ301004Approve: TfrmSAQ301004Approve;

Procedure ApproveActsPaid(AOwner:TComponent);
implementation

uses MCDMActs, MCTypes, MCUtils, SAQ301005;

{$R *.DFM}

Procedure ApproveActsPaid(AOwner:TComponent);
Begin
     frmSAQ301004Approve := Nil;
     Try
        frmSAQ301004Approve := TfrmSAQ301004Approve.Create(AOwner);
        frmSAQ301004Approve.ShowModal;
     Finally
        frmSAQ301004Approve.Free;
     End;
End;
{ This routine is assigned to the OnFeedBack event in the dmActs data module
  and it's called by the AfterPost event in the temporal table Approve. Use
  the routine to show the status of the Act Paid selected after any changes }
Procedure TfrmSAQ301004Approve.ShowProgress(Sender:TObject);
Begin
     StbStatus.Panels[0].Text := Format(MI_003,[dmActs.tblApprove.RecordCount]);
     StbStatus.Panels[1].Text := Format(MI_004,[dmActs.GetTotalApproved]);
End;
{ Use this routine to set the current Act Paid data in memory with
  the current record in the Window. }
Procedure TfrmSAQ301004Approve.UpdateCurrentSelection;
Begin
     With dmActs,CurrentActPaid Do Begin
          ActPaidContract := tblApproveCONTRACT_NO.AsString;
          ActPaidCode     := tblApproveACT_PAID_NO.AsString;
          ActPaidPortion  := tblApprovePORTION_NO.AsString;
          ActPaidSupplier := tblApproveSUPPLIER_NO.AsString;
          ActPaidDate     := tblApproveACT_PAID_DATE.AsString; 
          ActPaidStatusS  := tblApproveSTATUS.AsString;
     End;
End;
Procedure TfrmSAQ301004Approve.LoadPendentActs;
Var
   ColumnIndex:         Integer;    { Index of the current column }
begin
     { Load the Acts }
     dmActs.GetSentActsTo(dmActs.CurrentUser);
     dmActs.CopyPendentsToTemporalTable;
     { Disable the auto insert capability and active the feedback }
     dmActs.EnabledInsert := False;
     dmActs.OnFeedBack    := ShowProgress;
     { Fill the names of possible Status in the Pick List }
     ColumnIndex          := 0;
     With GrdPendents Do Begin
          While ColumnIndex < Columns.Count Do Begin
                With Columns[ColumnIndex],PickList Do Begin
                     If FieldName='STATUS' Then Begin
                        Add(StatusNames[asPendent]);
                        Add(StatusNames[asSent]);
                        Add(StatusNames[asApproved]);
                        ColumnIndex := Columns.Count
                     End;
                End;
                Inc(ColumnIndex);
          End;
     End;
     { Show the number of records found }
     StbStatus.Panels[0].Text := Format(MI_003,[dmActs.tblApprove.RecordCount]);
end;
procedure TfrmSAQ301004Approve.FormCreate(Sender: TObject);
Begin
     try
        LoadPendentActs;
     except
        On E:Exception Do Begin
           ShowMessage(Format(ME_055,[E.Message]));
           BtnSave.Enabled     := False;
           GrdPendents.Enabled := False;
        End;
     end;
End;
procedure TfrmSAQ301004Approve.FormDestroy(Sender: TObject);
begin
     dmActs.OnFeedBack    := Nil;
     dmActs.EnabledInsert := True;
     If dmActs.tblApprove.UpdatesPending Then Begin
        dmActs.tblApprove.CancelUpdates;
     End;
end;

procedure TfrmSAQ301004Approve.BtnSaveClick(Sender: TObject);
begin
     Try
        If dmActs.tblApprove.State in [dsEdit,dsInsert] Then Begin
           If OperationOk(MC_002) Then Begin
              dmActs.tblApprove.Post; End
           Else Begin
              dmActs.tblApprove.Cancel;
           End;
        End;
        dmActs.dbActPaid.StartTransaction;
        dmActs.UpdateActsStatus;
        dmActs.dbActPaid.Commit;
        Close;
     Except
       On E:Exception Do Begin
          ShowMessageFmt(ME_054,[E.Message]);
          If dmActs.dbActPaid.InTransaction Then Begin
             dmActs.dbActPaid.Rollback;
          End;
       End;
     End;
end;

procedure TfrmSAQ301004Approve.BtnCancelClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmSAQ301004Approve.GrdPendentsEditButtonClick(Sender: TObject);
begin
     { First, Fill the description of the record selected }
     UpdateCurrentSelection;
     { Get information about the corresponding Contract-Portion }
     With dmActs,CurrentActPaid Do Begin
          GetContractDefinition(ActPaidContract);
          GetPortionDefinition(ActPaidContract,ActPaidPortion);
     End;
     { Now, edit the record. The routine also verify the read only cases.
       Note the following : In Order to edit the Act Paid, the Insert
       operations must be enabled; but, they are actually disabled because
       the tblApprove must not be able to accept autoinsert operations
       in its grid; therefore, we need to able temporaly the Insert
       operations }
     Try
        dmActs.EnabledInsert := True;
        dmActs.NewAct        := False; { Rolando Celedón 2003-06-19 Check for New act }
        EditActPaid(Self);
     Finally
        dmActs.EnabledInsert := False;
     End;
end;

procedure TfrmSAQ301004Approve.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3011330);
end;

end.
