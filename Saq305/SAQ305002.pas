unit SAQ305002;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TdmSAQ305002 = class(TDataModule)
    SsnActPaid: TSession;
    dbActPaid: TDatabase;
    SQLInfoUser: TQuery;
    SQLEmployee: TQuery;
    SQLEmployeeEMPLOYEE_ID: TStringField;
    SQLEmployeeSURNAME: TStringField;
    SQLEmployeeFIRST_NAME: TStringField;
    SQLEmployeeSECOND_NAME: TStringField;
    SQLEmployeeTHIRD_NAME: TStringField;
    tblUserConfig: TTable;
    tblUserConfigDSTRCT_CODE: TStringField;
    tblUserConfigEMPLOYEE_ID: TStringField;
    tblUserConfigCC_TYPE_DSTRB: TStringField;
    tblUserConfigCC_DEFAULT_DSTRB: TStringField;
    tblUserConfigTYPE_COMMENTS: TStringField;
    tblUserConfigTYPE_CNTRCT_EXT: TStringField;
    tblUserConfigLOAD_INV_TYPE: TStringField;
    tblUserConfigACT_VALIDATION: TStringField;
    tblUserConfigINV_VALIDATION: TStringField;
    tblUserConfigTYPE_CNT_LIMIT: TStringField;
    tblUserConfigAP_INFO_ATAX: TStringField;
    tblUserConfigAP_RIGHT: TStringField;
    tblUserConfigAP_SECUENCE: TStringField;
    procedure SsnActPaidStartup(Sender: TObject);
  private
    { Private declarations }
    FCurrentUserID:     String;     { User_Id of the current user }
    FCurrentUser:       String;     { Employee_Id of the current user }
    FCurrentUserName:   String;     { Name of the current user }
    FCurrentDistrict:   String;     { District code of the current session }
    FHost:              String;     { Host machine }
    FPort:              String;     { Port }
    FHostUserName:      String;     { Name of the user logged on the host }
    FHostPassword:      String;     { Password of the user logged on the host }
    FMimsPassword:      String;     { Password to connect MIMS }
    FMimsPosition:      String;     { User position in MIMS }
    FCurrentLoadStep:   Integer;    { Number of the current step loading the program }
    FPrivateDirectory:  String;     { Private Directory for the session }
    Function GetEmployeeName(AnEmployee:String;MustExists:Boolean):String;
    Function GetEmployeeID(AUser:String):String;
    Function GetUserEmployeeID(AUser:String):String;
    procedure LoadRegistryInformation;
  public
    { Public declarations }
    Destructor Destroy; override;
    procedure ConnectTODBMIMS;
    Property CurrentUserID:String    Read FCurrentUserID;
    Property CurrentUser:String      Read FCurrentUser;
    Property CurrentDistrict:String  Read FCurrentDistrict;
    Property CurrentUserName:String  Read FCurrentUserName;
  end;

var
  dmSAQ305002: TdmSAQ305002;

implementation

uses MCTypes, MCObjcts, MCConnct, MCUtils, SAQ300002, SAQ300003, SAQUtils;

{$R *.DFM}

{ Use this function to get the name of the employee with EMPLOYEE_ID = AnEmployee.
  The parameter MustExists force to validate that MSF810 has an Employee
  with EMPLOYEE_ID = AnEmployee. The validation require this EMPLOYEE_ID
  has a valid name defined in MSF810; it's not enough that MSF810 has
  a record for this EMPLOYEE_ID }

Function TdmSAQ305002.GetEmployeeName(AnEmployee:String;MustExists:Boolean):String;
Var
   NotName:             Boolean;    { True = User doesn't have a name }
Begin
     GetEmployeeName := '';
     With SQLEmployee Do Begin
          Try
             Active:=False;
             Params[0].AsString:=AnEmployee;
             If Not Prepared Then Begin
                Prepare;
             End;
             Try
                Active:=True;
                If MustExists And IsEmptyField(SQLEmployeeEMPLOYEE_ID) Then Begin
                   raise Exception.Create(ME_030);
                End;
                NotName := IsEmptyField(SQLEmployeeSURNAME);
                NotName := NotName And IsEmptyField(SQLEmployeeTHIRD_NAME);
                NotName := NotName And IsEmptyField(SQLEmployeeFIRST_NAME);
                NotName := NotName And IsEmptyField(SQLEmployeeSECOND_NAME);
                If NotName And MustExists Then Begin
                   raise Exception.Create(ME_137);
                End;
                If Not NotName Then Begin
                   GetEmployeeName := SQLEmployeeSURNAME.AsString + ' '+
                                      SQLEmployeeTHIRD_NAME.AsString + ', '+
                                      SQLEmployeeFIRST_NAME.AsString + ' '+
                                      SQLEmployeeSECOND_NAME.AsString;
                End;
             Finally
                Active:=False;
             End;
          Except
             On E:Exception Do Begin
                GetEmployeeName := '';
                ShowMessageFmt(ME_031,[AnEmployee,E.Message]);
             End;
          End;
     End;
End;
{ Use this function to get the Employee ID of the user AUser. }

Function TdmSAQ305002.GetEmployeeID(AUser:String):String;
Begin
     With SQLInfoUser Do Begin
          Try
             Params[0].AsString := UpperCase(AUser);
             Try
                Active := True;
                If Fields[0].IsNull Then Begin
                   raise Exception.Create(ME_032);
                End;
                GetEmployeeID := Fields[0].AsString;
             Finally
                Active := False;
             End;
          Except
             On E:Exception Do Begin
                ShowMessageFmt(ME_024,[AUser,E.Message]);
                Application.Terminate;
             End;
          End;
     End;
End;
{ Use this function to get the Employee ID of the current user.
  There are two cases :
  If the current User ID is really the Employee ID, then the function
  GetEmployeeName must get a value; in other case, the current User ID
  is an independent MIMS ID and the Employee ID must be get from MSF020
  by using GetEmployeeID. }

Function TdmSAQ305002.GetUserEmployeeID(AUser:String):String;
Begin
     FCurrentUserName := GetEmployeeName(AUser,False);
     If FCurrentUserName = '' Then Begin
        GetUserEmployeeID := GetEmployeeID(AUser); End
     Else Begin
        GetUserEmployeeID := AUser;
     End;
End;
{ Use this routine to get MIMS global parameters stored in the Windows
  Registry. Actually, the only parameter that we need in this module is
  the HelpDirectory, used to set the Help File of this Application }
procedure TdmSAQ305002.LoadRegistryInformation;
Var
   FMIMSRegistry:       TMIMSRegistry;
begin
     FMIMSRegistry := Nil;
     Try
        Try
           FMIMSRegistry        := TMIMSRegistry.Create;
           Application.HelpFile := FMIMSRegistry.HelpDirectory+'\SAQ305.hlp';
        Except
           On E:Exception Do Begin
              ShowMessage(Format(ME_070,[E.Message]));
           End;
        End;
     Finally
        FMIMSRegistry.Free;
     End;
End;

procedure TdmSAQ305002.ConnectTODBMIMS;
Var
   MIMSXServer:         TMIMSXServer;
   FAliasName:          String;
begin
     { Get the location of the Help File }
     LoadRegistryInformation;
     FCurrentLoadStep := 0;
     Try
        { Connect to MIMS }
        frmSAQ300003Connecting := Nil;
        Try
           Try
              MIMSXServer := TMIMSXServer.Create;
              MIMSXServer.Connect;
              FCurrentLoadStep := 1;
              ShowConnectionActivity(Self);
              FCurrentUserID   := MIMSXServer.MimsUser;
              FMimsPosition    := MIMSXServer.MimsPosition;
              FCurrentDistrict := MIMSXServer.MimsDistrict;
            {  FAliasName       := MIMSXServer.AliasName;  }
              If MIMSXServer.LevelAccess <> '2' Then Begin
                 raise Exception.Create(ME_138);
              End;
              SsnActPaid.Active   := True;
             { dbActPaid.AliasName := FAliasName; }
              dbActPaid.Params.Values['USER NAME'] := MIMSXServer.OracleUser;
              dbActPaid.Params.Values['PASSWORD']  := MIMSXServer.OraclePassword;
           Finally
              MIMSXServer.Free;
           End;
           FCurrentLoadStep := 2;
           If Not dbActPaid.IsSQLBased Then Begin
              dbActPaid.TransIsolation := tiDirtyRead;
           End;
           dbActPaid.Connected := True;
           FCurrentLoadStep    := 3;
        Finally
           EndOfConnectionActivity;
        End;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_028,[FCurrentLoadStep,E.Message]);
           Application.Terminate;
        End;
     End;
     { Set the user identification properties }
     FCurrentUserID  := GetMIMSKey(FCurrentUserID,10);
     FCurrentUser    := GetUserEmployeeID(FCurrentUserID);
     If FCurrentUserName = '' Then Begin
        FCurrentUserName := GetEmployeeName(FCurrentUser,True);
     End;
end;

procedure TdmSAQ305002.SsnActPaidStartup(Sender: TObject);
begin
     FPrivateDirectory     := GetWorkingDirectory(ME_169);
     SsnActPaid.PrivateDir := FPrivateDirectory;
end;
Destructor TdmSAQ305002.Destroy;
Begin
     Try
        Inherited Destroy;
     Finally
        Try
           DeleteDirectory(FPrivateDirectory);
        Except
           On E:Exception Do Begin
              raise Exception.CreateFmt(ME_170,[FPrivateDirectory,E.Message]);
           End;
        End;
     End;
End;
end.
