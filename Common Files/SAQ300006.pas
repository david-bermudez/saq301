unit SAQ300006;

interface
Uses Classes,ComObj,sysutils,Dialogs,MSQMUILib_TLB;
Type
    { Forward declarations }

    TMIMSBlock = Class;
    TMIMSRequest = Class;
    TMIMSInstance = Class;

    { MIMSX Class }

    { This class is intended to an special support for the Act Paid module }
    TMIMSXServer = Class
    Private
      FMSQMUI:          MimsApplication;
      FUserName:        String;
      FMimsUser:        String;
      FMimsDistrict:    String;
      FMimsPosition:    String;
      FOracleUser:      String;
      FOraclePassword:  String;
      Function GelLevelAccess:String;
      Function GetScreenName:String;
      Function GetItemValue(AnIndex:Variant):String;
      Function GetMimsError:String;
      Function GetErrorNo: string;
      Function GetTableValue(ATable,ACode:String): string;
      Procedure SetItemValue(AnIndex:Variant;AValue:String);
      Procedure GetOracleUserPassword;
    Public
      Constructor Create;
      procedure DoCommand(pCommand: String);
      Procedure Connect;
      Procedure Disconnect;
      Procedure GetMIMSFields(AFieldList:TStringList);
      Procedure ExecProgram(AProgram:String);
      Destructor Destroy; override;
      Function NewBlock(ABlock:String):TMIMSBlock;
      Property ScreenName:     String Read GetScreenName;
      Property MimsError:      String Read GetMimsError;
      Property ErrorNo:        String Read GetErrorNo;
      Property UserName:       String Read FUserName;
      Property MimsUser:       String Read FMIMSUser;
      Property MimsDistrict:   String Read FMimsDistrict;
      Property MimsPosition:   String Read FMimsPosition;
      Property OracleUser:     String Read FOracleUser;
      Property OraclePassword: String Read FOraclePassword;
      Property LevelAccess:    String Read GelLevelAccess;
      Property ItemValue[AnIndex:Variant]:String Read GetItemValue Write SetItemValue;
      Property TableValue[ATable,ACode:String]:String Read GetTableValue;
    End;

    TMIMSBlock = Class
    Private
      FOwner:           TMIMSXServer;
      FName:            String;
      FMIMSX:           OleVariant;
      FBlock:           OleVariant;
    Public
      Constructor Create(AOwner:TMIMSXServer;AName:String);
      Function NewRequest(ARequest:String):TMIMSRequest;
      Function Send(AUseCache:Boolean):OleVariant;
      Property MIMSX:OleVariant Read FMIMSX;
      Property Name:String Read FName;
      Property Block:OleVariant Read FBlock;
    End;

    TMIMSRequest = Class
    Private
      FOwner:           TMIMSBlock;
      FName:            String;
      FBlockName:       String;
      FMIMSX:           OleVariant;
      FRequest:         OleVariant;
    Public
      Constructor Create(AOwner:TMIMSBlock;AName:String);
      Function NewInstance(AnInstance:String):TMIMSInstance;
      Procedure AddFieldNameValue(AName,AValue:String);
      Property MIMSX:OleVariant Read FMIMSX;
      Property BlockName:String Read FBlockName;
      Property Name:String Read FName;
      Property Request:OleVariant Read FRequest;
    End;

    TMIMSInstance = Class
    Private
      FOwner:           TMIMSRequest;
      FName:            String;
      FBlockName:       String;
      FRequestName:     String;
      FMIMSX:           OleVariant;
      FInstance:        OleVariant;
    Public
      Constructor Create(AOwner:TMIMSRequest;AName:String);
      Procedure AddFieldNameValue(AName,AValue:String);
      Property MIMSX:OleVariant Read FMIMSX;
      Property BlockName:String Read FBlockName;
      Property RequestName:String Read FRequestName;
      Property Instance:OleVariant Read FInstance;
    End;

Const
     MIMSX_FLAG_SERVICE   = '_Service';
     MIMSX_FLAG_REPLYLIST = '_ReplyList';
     MIMSX_FLAG_MAXINST   = '_MaxInst';
     MIMSX_FLAG_RESTART   = '_Restart';

implementation
Uses Forms, MCTypes, MCUtils, SAQ300005;

{ Class TMIMSBlock }

Constructor TMIMSBlock.Create(AOwner:TMIMSXServer;AName:String);
Begin
     Inherited Create;
     FOwner := AOwner;
     FName  := AName;
     FMIMSX := FOwner.FMSQMUI;
     FBlock := FMIMSX.Blocks.New(AName);
End;
Function TMIMSBlock.NewRequest(ARequest:String):TMIMSRequest;
Begin
     NewRequest := TMIMSRequest.Create(Self,ARequest);
End;
Function TMIMSBlock.Send(AUseCache:Boolean):OleVariant;
Begin
     Send := FBlock.Send(AUseCache);
End;
{ Class TMIMSRequest }
Constructor TMIMSRequest.Create(AOwner:TMIMSBlock;AName:String);
Begin
     Inherited Create;
     FOwner := AOwner;
     FName  := AName;
     FMIMSX := FOwner.FMIMSX;
     FBlockName := FOwner.Name;
     FRequest   := FOwner.Block.Requests.New(AName);
End;
Function TMIMSRequest.NewInstance(AnInstance:String):TMIMSInstance;
Begin
     NewInstance := TMIMSInstance.Create(Self,AnInstance);
End;
Procedure TMIMSRequest.AddFieldNameValue(AName,AValue:String);
Var
   IsOk:                Boolean;
Begin
     IsOk := FRequest.AddFieldNameValue(AName,AValue);
     If Not IsOk Then Begin
        raise Exception.CreateFmt(ME_140,[AName,AValue,FName,FBlockName]);
     End;
End;
{ Class TMIMSInstance }
Constructor TMIMSInstance.Create(AOwner:TMIMSRequest;AName:String);
Begin
     Inherited Create;
     FOwner := AOwner;
     FName  := AName;
     FMIMSX := FOwner.MIMSX;
     FRequestName := FOwner.Name;
     FBlockName   := FOwner.BlockName;
     FInstance    := FOwner.Request.Instances.New(AName);
End;
Procedure TMIMSInstance.AddFieldNameValue(AName,AValue:String);
Var
   IsOk:                Boolean;
Begin
     IsOk := FInstance.AddFieldNameValue(AName,AValue);
     If Not IsOk Then Begin
        raise Exception.CreateFmt(ME_141,[AName,AValue,FName,FRequestName,FBlockName]);
     End;
End;
{ Class TMIMSXServer }
Constructor TMIMSXServer.Create;
Begin
     Inherited;
     FMSQMUI := coMimsApplication.Create;
  {   If Not FMSQMUI.Initialise Then Begin
        raise Exception.Create(ME_161);
     End;   }
End;
Destructor TMIMSXServer.Destroy;
Begin
     Try
        DoCommand('Home');
        Disconnect;
     Finally
        Inherited;
     End;
End;
procedure TMIMSXServer.DoCommand(pCommand: String);
begin
     If FMSQMUI.MSO.IsCommand(pCommand) Then Begin
        FMSQMUI.MSO.Commands.Item(WideString(pCommand)).Execute; End
     Else begin
        raise exception.CreateFmt(ME_115,[pCommand]);
     End;
end;
Function TMIMSXServer.GelLevelAccess:String;
Var
   MIMSBlock:           TMIMSBlock;
   MIMSRequest:         TMIMSRequest;
   MIMSInstance:        TMIMSInstance;
   MIMSReply:           OleVariant;
   ApplicationName:     String;
Begin
     Try
        MIMSBlock        := NewBlock('BlockSure');
        MIMSRequest      := MIMSBlock.NewRequest('RequestSure');
        MIMSRequest.AddFieldNameValue(MIMSX_FLAG_SERVICE, 'SECURITY.RetrieveAppSec');
        MIMSRequest.AddFieldNameValue(MIMSX_FLAG_REPLYLIST, 'AccessLevel');
        MIMSInstance     := MIMSRequest.NewInstance('InstanceSure');
        { Get the application name without the path, the ".Exe" extension and
          using uppercase }
        ApplicationName  := ExtractFileName(Application.ExeName);
        ApplicationName  := Copy(ApplicationName,1,Length(ApplicationName)-4);
        ApplicationName  := UpperCase(ApplicationName);
        MIMSInstance.AddFieldNameValue('AppName', ApplicationName);
        MIMSInstance.AddFieldNameValue('AppType', 'M');
        MIMSInstance.AddFieldNameValue('DistrictCode', FMimsDistrict);
        MIMSReply := MIMSBlock.Send(False);
        GelLevelAccess := MIMSReply.Requests.Item(1).Instances.Item(1).Fields.Item('AccessLevel').Value;
     Finally
        MIMSInstance.Free;
        MIMSRequest.Free;
        MIMSBlock.Free;
     End;
End;
Function TMIMSXServer.GetScreenName:String;
Begin
     GetScreenName := FMSQMUI.MSO.Name;
End;
Function TMIMSXServer.GetItemValue(AnIndex:Variant):String;
Begin
     GetItemValue := FMSQMUI.MSO.Fields.Item(AnIndex).Value;
End;
Function TMIMSXServer.GetMimsError:String;
Var
   MimsMessage:         String;
Begin
     MimsMessage  := Trim(FMSQMUI.MSO.Message);
     If Length(MimsMessage) >  0 Then Begin
        DoCommand('OK');
     End;
     GetMimsError := MimsMessage;
End;
Function TMIMSXServer.GetErrorNo: string;
var
   EMessage:            string;
begin
     EMessage := MimsError;
     if EMessage <> '' Then Begin
        GetErrorNo := Copy(EMessage,4,4); End
     else Begin
        GetErrorNo := '';
     End;
end;
{ Get values from the reference table in MSF010 by using MSO011 }
Function TMIMSXServer.GetTableValue(ATable,ACode:String): string;
Begin
     ExecProgram('MSO011');
     ItemValue['TABLE_TYPE1I'] := ATable;
     ItemValue['TABLE_CODE1I'] := ACode;
     DoCommand('OK');
     GetTableValue := ItemValue['TABLE_DESC2I1'];
     DoCommand('Home'); {
     DoCommand('Cancel'); }
End;
{ Get the names of the fields for the current screen }
Procedure TMIMSXServer.GetMIMSFields(AFieldList:TStringList);
Var
   FieldCount:          Integer;
   FieldIndex:          Integer;
   MIMSXIndex:          Variant;
Begin
     FieldCount := FMSQMUI.MSO.Fields.Count;
     FieldIndex := 1;
     While FieldIndex <= FieldCount Do Begin
           MIMSXIndex := FieldIndex;
           AFieldList.Add(FMSQMUI.MSO.Fields.Item(MIMSXIndex).Name);
           Inc(FieldIndex);
     End;
End;
Procedure TMIMSXServer.SetItemValue(AnIndex:Variant;AValue:String);
Var
   FieldList:           TStringList;
Const
     MEErr = 'Falla al asignar %s a %s. Error técnico : %s';
Begin
     Try
        FMSQMUI.MSO.Fields.Item(AnIndex).Value := AValue;
     Except
        On Exception Do Begin
           { If there is an exception we try to see what fields are
             avalaibles on the current screen }
           Try
              Try
                 ShowMessage('Indice no confronta');
                 FieldList := TStringList.Create;
                 GetMIMSFields(FieldList);
                 ShowMIMSFields(FieldList,AnIndex);
              Finally
                 FieldList.Free;
              End;
           Except
              On E:Exception Do Begin
                 ShowMessageFmt(MEErr,[AValue,AnIndex,E.Message]);
              End;
           End;
        End;
     End;
End;
{ Get the Oracle User/Password store in the +SAP table. This is only valid
  for the Act Paid module}
Procedure TMIMSXServer.GetOracleUserPassword;
Var
   Credentials:         String;
Begin
     Credentials     := TableValue['+SAP','SAQUSR'];
     FOracleUser     := GetUser(Credentials);
     FOraclePassword := tp_xcrypt(1, GetPass(Credentials));
End;
{ Connect to MSQMUI and get the most important values for the Act Paid module }
Procedure TMIMSXServer.Connect;
Begin
    { Try}
        FMSQMUI.Session.Login(0,True);
        FMSQMUI.Silent := False;
   {  Except
        raise Exception.Create(FMSQMUI.Errors(1).ErrorDescription);
     End; }
     FUserName     := FMSQMUI.Session.Username;
     FMimsUser     := FMSQMUI.Session.MimsUserId;
     FMimsDistrict := FMSQMUI.Session.MimsDistrict;
     FMimsPosition := FMSQMUI.Session.MimsPosition;
     If Trim(FMimsUser) = '' Then Begin
        FMimsUser := FUserName;
     End;
     GetOracleUserPassword;
End;
Procedure TMIMSXServer.Disconnect;
Begin
     If Assigned(FMSQMUI) Then Begin
        FMSQMUI.Quit;
     End;
End;
Procedure TMIMSXServer.ExecProgram(AProgram:String);
Var
   Executed:            Boolean;
Begin
     Executed := FMSQMUI.ExecuteMSO(AProgram,'','','N','');
     If Executed Then Begin
        ShowMessage('Ejecutado '+AProgram); End
     Else Begin
        ShowMessage('No Ejecutó '+AProgram);
     End;
End;
Function TMIMSXServer.NewBlock(ABlock:String):TMIMSBlock;
Begin
     NewBlock := TMIMSBlock.Create(Self,ABlock);
End;
end.
