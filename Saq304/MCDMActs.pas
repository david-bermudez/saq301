unit MCDMActs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables;
  //MCObjcts;

type
  TdmActs = class(TDataModule)
    dbActPaid: TDatabase;
    SsnActPaid: TSession;
    sqlbuscon: TQuery;
    sqlbuspor: TQuery;
    sqlbusele: TQuery;
    sqldesele: TQuery;
    sqlbuscat: TQuery;
    sqldescat: TQuery;
    DSbuscon: TDataSource;
    DSbuspor: TDataSource;
    DSbusele: TDataSource;
    DSbuscat: TDataSource;
    DSdescat: TDataSource;
    DSdesele: TDataSource;
    sqlfindcon: TQuery;
    DSfindcon: TDataSource;
    sqlActPaid: TQuery;
    DSactPaid: TDataSource;
    sqlinsert: TQuery;
    SqlCheck: TQuery;
    DSCheck: TDataSource;
    procedure dmActsCreate(Sender: TObject);
    Procedure InitActStructures;
  private
      FCurrentLoadStep:   Integer;    { Number of the current step loading the program }
      FCurrentUserID :    string;
      FMimsPosition :     string;
      FCurrentDistrict:   string;
      FLocalCurrency:     String;
      Function GetCurrentDate:String;
  protected
    { Protected declarations }
  public
    Property CurrentDate:String         Read GetCurrentDate;
    { Public declarations }
  public
     UserId : string;
     dat    : string;
 end;

var
  dmActs: TdmActs;


implementation

uses MCTypes, MCUtils,  SAQ300002, SAQ300003;
//MCConnct

{$R *.DFM}

{ Use this routine to call the OnFeedBack event. We use the standard methodology
  in spite of it's unnecessary because maybe other applications will use this
  data module }

procedure TdmActs.dmActsCreate(Sender: TObject);
Var
   MIMSXServer:         TMIMSXServer;
begin
     frmSAQ300003Connecting := Nil;
     FCurrentLoadStep       := 0;
     Try
        { First, connect to MIMS. Close the connection as soon as it's not
          longer necessary }
        Try
           MIMSXServer := TMIMSXServer.Create;
           MIMSXServer.Connect;
           FCurrentLoadStep := 1;
           ShowConnectionActivity(Self);
           FCurrentUserID   := MIMSXServer.MimsUser;
           UserId := fcurrentUserId;
           FMimsPosition    := MIMSXServer.MimsPosition;
           FCurrentDistrict := MIMSXServer.MimsDistrict;
           dbActPaid.Params.Values['USER NAME'] := MIMSXServer.OracleUser;
           dbActPaid.Params.Values['PASSWORD']  := MIMSXServer.OraclePassword;
        Finally
           MIMSXServer.Free;
        End;
        FCurrentLoadStep := 2;
        { Second, connect to the MIMS database }
        If Not dbActPaid.IsSQLBased Then Begin
           dbActPaid.TransIsolation := tiDirtyRead;
        End;
        dbActPaid.Connected := True;
        FCurrentLoadStep    := 3;
        { Now, init the data structures for the Act Paid module }
        InitActStructures;
        { Finally, close the form used to show the connection activity }
        EndOfConnectionActivity;
     Except
        On E:Exception Do Begin
           Try
              ShowMessageFmt(ME_028,[FCurrentLoadStep,E.Message]);
           Finally
              Application.Terminate;
           End;
        End;
     End;
End;

Procedure TdmActs.InitActStructures;
Begin
     FCurrentLoadStep := 4;
     FCurrentLoadStep := 5;
     FCurrentLoadStep := 6;
     FCurrentLoadStep := 7;
     FCurrentUserID   := GetMIMSKey(FCurrentUserID,10);
     FCurrentLoadStep := 8;
     FCurrentLoadStep := 9;
     FCurrentLoadStep := 10;
     FCurrentLoadStep := 12;
     FCurrentLoadStep := 13;
     dat:=GetCurrentDate;
End;

Function TdmActs.GetCurrentDate:String;
Var OldShortDateFormat : String;
Begin
     OldShortDateFormat:=ShortDateFormat;
     Try
        ShortDateFormat:='yyyymmdd';
        GetCurrentDate:=DateToStr(Date);
     Finally
        ShortDateFormat:=OldShortDateFormat;
     End;
End;

end.

