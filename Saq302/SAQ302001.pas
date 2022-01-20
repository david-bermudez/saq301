unit SAQ302001;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Mask, DBCtrls, ExtCtrls, jpeg, ExtDlgs, Buttons;

type
  TFrmSAQ302001Main = class(TForm)
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    SsnLogo: TSession;
    dbActPaid: TDatabase;
    TblLogo: TTable;
    STblLogo: TDataSource;
    DBImage1: TDBImage;
    BtnLoad: TButton;
    DlgLoad: TOpenPictureDialog;
    TblLogoLOGO_CODE: TStringField;
    TblLogoDSTRCT_CODE: TStringField;
    TblLogoCOMPANY_LOGO: TGraphicField;
    BtnSave: TButton;
    DlgSave: TSavePictureDialog;
    BtnHelp: TSpeedButton;
    procedure BtnLoadClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure SsnLogoStartup(Sender: TObject);
  private
    { Private declarations }
    FCurrentUserID:     String;     { MIMS User Id }
    FCurrentDistrict:   String;     { MIMS District }
    FHost:              String;     { Host name or IP Address }
    FPort:              String;     { Port }
    FHostUserName:      String;     { Name of the user logged on the host }
    FHostPassword:      String;     { Password of the user logged on the host }
    FMimsPassword:      String;     { Password to connect MIMS }
    FMimsPosition:      String;     { User position in MIMS }
    FCurrentLoadStep:   Integer;    { Number of the current step loading the program }
    FPrivateDirectory:  String;     { Private Directory for the session }
    procedure LoadRegistryInformation;
    procedure ConnectToDB;
  public
    { Public declarations }
    Destructor Destroy; override;
  end;

var
  FrmSAQ302001Main: TFrmSAQ302001Main;

implementation

uses MCTypes, MCConnct, MCUtils, MCObjcts, SAQ300002, SAQ300003, SAQUtils;

{$R *.DFM}

Const
   MLogo01 = 'El registro actual está siendo editado';
   
procedure TFrmSAQ302001Main.BtnLoadClick(Sender: TObject);
begin
     If DlgLoad.Execute Then Begin
        TblLogoCOMPANY_LOGO.LoadFromFile(DlgLoad.FileName);
     End;
end;

procedure TFrmSAQ302001Main.BtnSaveClick(Sender: TObject);
begin
     If DlgSave.Execute Then Begin
        TblLogoCOMPANY_LOGO.SaveToFile(DlgSave.FileName);
     End;
end;

procedure TFrmSAQ302001Main.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     If TblLogo.State in [dsEdit,dsInsert] Then Begin
        CanClose := False;
        ShowMessage(MLogo01);
     End;
end;
procedure TFrmSAQ302001Main.LoadRegistryInformation;
Var
   FMIMSRegistry:       TMIMSRegistry;
begin
     FMIMSRegistry := Nil;
     Try
        Try
           FMIMSRegistry        := TMIMSRegistry.Create;
           Application.HelpFile := FMIMSRegistry.HelpDirectory+'\SAQ302.hlp';
        Except
           On E:Exception Do Begin
              ShowMessage(Format(ME_070,[E.Message]));
           End;
        End;
     Finally
        FMIMSRegistry.Free;
     End;
End;
procedure TFrmSAQ302001Main.ConnectToDB;
Var
   MIMSXServer:         TMIMSXServer;
Begin
     Try
        Try
           MIMSXServer := TMIMSXServer.Create;
           MIMSXServer.Connect;
           FCurrentLoadStep := 0;
           ShowConnectionActivity(Self);
           FCurrentLoadStep := 1;
           FCurrentUserID   := MIMSXServer.MimsUser;
           FMimsPosition    := MIMSXServer.MimsPosition;
           FCurrentDistrict := MIMSXServer.MimsDistrict;
           If MIMSXServer.LevelAccess <> '2' Then Begin
              raise Exception.Create(ME_138);
           End;
           dbActPaid.Params.Values['USER NAME'] := MIMSXServer.OracleUser;
           dbActPaid.Params.Values['PASSWORD']  := MIMSXServer.OraclePassword;
        Finally
           MIMSXServer.Free;
        End;
        FCurrentLoadStep := 2;
        SsnLogo.Active   := True;
        If Not dbActPaid.IsSQLBased Then Begin
           dbActPaid.TransIsolation := tiDirtyRead;
        End;
        dbActPaid.Connected := True;
        FCurrentLoadStep    := 3;
        TblLogo.Active      := True;
        FCurrentLoadStep    := 4;
     Finally
        EndOfConnectionActivity;
     End;
End;
procedure TFrmSAQ302001Main.FormCreate(Sender: TObject);
begin
     FCurrentLoadStep := 0;
     Try
        If Application.ShowMainForm Then Begin
           LoadRegistryInformation;
           ConnectToDB;
        End;
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_028,[FCurrentLoadStep,E.Message]);
           Application.Terminate;
        End;
     End;  
end;

procedure TFrmSAQ302001Main.BtnHelpClick(Sender: TObject);
begin
     Application.HelpContext(SAH3021000);
end;
Procedure InitMultiInstanceSupport;
Const
     SAQ302MutexID = 'SAQ302MutexID';
Var
   MIError:             Integer;
Begin
     MIError := OpenMultiInstanceSupport(SAQ302MutexID);
     If MIError <> 0 Then Begin
        ShowMessageFmt(ME_180,[MIError]);
        Application.Terminate;
     End;
End;
procedure TFrmSAQ302001Main.SsnLogoStartup(Sender: TObject);
begin
     FPrivateDirectory  := GetWorkingDirectory(ME_169);
     SsnLogo.PrivateDir := FPrivateDirectory;
end;
Destructor TFrmSAQ302001Main.Destroy;
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

Initialization
   InitMultiInstanceSupport;
Finalization
   CloseMultiInstanceSupport;
end.
