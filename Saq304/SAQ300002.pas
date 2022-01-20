unit SAQ300002;

interface
Uses Classes,ComObj,sysutils,Windows,Dialogs;
Type
    { Forward declarations }

    TMIMSBlock = Class;
    TMIMSRequest = Class;
    TMIMSInstance = Class;

    { MIMSX Class }

    { This class is intended to an special support for the Act Paid module }
    TMIMSXServer = Class
    Private
      FMSQMUI:          OleVariant;
      FPort:            String;
      FHost:            String;
      FUserName:        String;
      FMimsUser:        String;
      FMimsDistrict:    String;
      FMimsPosition:    String;
      FOracleUser:      String;
      FOraclePassword:  String;
      FArcCnfTxt:       TextFile;
      Function ToHexValue(ADecimalValue:String):String;
      Function GetMIMSXItem(AnIndex:String):OleVariant;
      Function GetConfigDirectory:String;
      Function GetHostName:String;
      Function GetAliasName:String;
      Function GelLevelAccess:String;
      Function GetScreenName:String;
      Function GetItemValue(AnIndex:Variant):String;
      Function GetMimsError:String;
      Function GetErrorNo: string;
      Function GetTableValue(ATable,ACode:String): string;
      Procedure SetItemValue(AnIndex:Variant;AValue:String);
      Procedure GetOracleUserPassword;
      Procedure ShowFieldNamesOnTheScreen(AnIndex:Variant;AValue,AMessage:String);
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
      Property Host:           String Read FHost;
      Property Port:           String Read FPort;
      Property MimsUser:       String Read FMIMSUser;
      Property MimsDistrict:   String Read FMimsDistrict;
      Property MimsPosition:   String Read FMimsPosition;
      Property OracleUser:     String Read FOracleUser;
      Property OraclePassword: String Read FOraclePassword;
      Property LevelAccess:    String Read GelLevelAccess;
      Property AliasName:      String Read GetAliasName;
      Property MIMSXItem[AnIndex:String]:OleVariant Read GetMIMSXItem;
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
     FMSQMUI := CreateOleObject('MIMSX.MIMSXServer.1');
     If Not FMSQMUI.Initialise Then Begin
        raise Exception.Create(ME_161);
     End;
End;
Destructor TMIMSXServer.Destroy;
Begin
     Disconnect;
     Inherited;
End;
procedure TMIMSXServer.DoCommand(pCommand: String);
begin
     If FMSQMUI.SCREEN.MSO.IsCommand(pCommand) Then Begin
        FMSQMUI.SCREEN.MSO.Commands.Item(WideString(pCommand)).Execute; End
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
     GetScreenName := FMSQMUI.SCREEN.MSO.Name;
End;
Function TMIMSXServer.GetItemValue(AnIndex:Variant):String;
Var
   FMIMSXItem:          OleVariant;
Begin
     Try
        FMIMSXItem   := MIMSXItem[AnIndex];
        GetItemValue := FMIMSXItem.Value;
     Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_163,[AnIndex,E.Message]);
           { On debugging, replace the previous line for the following
             to see what fields are avalaibles on the current screen

             ShowFieldNamesOnTheScreen(AnIndex,'',ME_163);  }
        End;
     End;
End;
Function TMIMSXServer.GetMimsError:String;
Begin
     GetMimsError := Trim(FMSQMUI.SCREEN.MSO.Error);
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
     {DoCommand('Home');   }
     DoCommand('Cancel'); 
End;
{ Get the names of the fields for the current screen }
Procedure TMIMSXServer.GetMIMSFields(AFieldList:TStringList);
Var
   FieldCount:          Integer;
   FieldIndex:          Integer;
   MIMSXIndex:          Variant;
Begin
     FieldCount := FMSQMUI.SCREEN.MSO.Fields.Count;
     FieldIndex := 1;
     While FieldIndex <= FieldCount Do Begin
           MIMSXIndex := FieldIndex;
           AFieldList.Add(FMSQMUI.SCREEN.MSO.Fields.Item(MIMSXIndex).Name);
           Inc(FieldIndex);
     End;
End;
 { This routine is used only on debugging to see what fields are avalaibles
   on the screen when we receive an error accessing a MIMS field. View the
   routines GetItemValue and SetItemValue for details }
Procedure TMIMSXServer.ShowFieldNamesOnTheScreen(AnIndex:Variant;AValue,AMessage:String);
Var
   FieldList:           TStringList;
Begin
     Try
        Try
           FieldList := TStringList.Create;
           GetMIMSFields(FieldList);
           ShowMIMSFields(FieldList,AnIndex);
        Finally
           FieldList.Free;
        End;
     Except
        On E:Exception Do Begin
           If AMessage = ME_162 Then Begin
              ShowMessageFmt(ME_162,[AValue,AnIndex,E.Message]); End
           Else Begin
              ShowMessageFmt(ME_163,[AnIndex,E.Message]); 
           End;
        End;
     End;
End;
{ AnIndex is the Name of the MIMS field on the screen or the ordinal number
  of this field }
Procedure TMIMSXServer.SetItemValue(AnIndex:Variant;AValue:String);
Var
   FieldList:           TStringList;
   FMIMSXItem:          OleVariant;
Begin
     Try
        FMIMSXItem := MIMSXItem[AnIndex];
        FMIMSXItem.Value := AValue;
     Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_162,[AValue,AnIndex,E.Message]);
           { On debugging, replace the previous line for the following
             to see what fields are avalaibles on the current screen

             ShowFieldNamesOnTheScreen(AnIndex,AValue,ME_163);  }
        End;
     End;
End;
Function TMIMSXServer.GetMIMSXItem(AnIndex:String):OleVariant;
Var
   FMIMSXItem:          OleVariant;
   ItemCount:           Integer;
   ItemIndex:           Integer;
   OLEIndex:            OLEVariant;
Begin
     GetMIMSXItem := '';
     ItemCount    := FMSQMUI.SCREEN.MSO.Fields.Count;
     ItemIndex    := 1;
     While ItemIndex <= ItemCount Do Begin
           OLEIndex   := ItemIndex;
           FMIMSXItem := FMSQMUI.SCREEN.MSO.Fields.Item(OLEIndex);
           If FMIMSXItem.Name = AnIndex Then Begin
              GetMIMSXItem := FMIMSXItem;
              ItemIndex    := ItemCount;
           End;
           Inc(ItemIndex);
     End;
End;
Function TMIMSXServer.GetConfigDirectory:String;
Const
     MAX_LONG_NAME = 256;
Var
   szDirectory:        PChar;
   StrDirectory:       String;
   LngStrDir:          Integer;
Begin
     Try
        GetMem(szDirectory,MAX_LONG_NAME);
        GetWindowsDirectory(szDirectory,MAX_LONG_NAME);
        StrDirectory := StrPas(szDirectory);
     Finally
        FreeMem(szDirectory,MAX_LONG_NAME);
     End;
     LngStrDir := Length(StrDirectory);
     If StrDirectory[LngStrDir] <> '\' Then Begin
        StrDirectory := StrDirectory + '\';
     End;
     GetConfigDirectory := StrDirectory;
End;

{ Convert ADecimalValue to an hexadecimal string. This routine is
  used only to translate IP address; because it, you will find unusual
  validations and also the Abort function. Check the GetHostName
  function for a full discussion }
Function TMIMSXServer.ToHexValue(ADecimalValue:String):String;
Var
   Value:               Integer;
  Function HexDigit(ADecimal:Integer):Char;
  Begin
       If ADecimal < 10 Then Begin
          HexDigit := Chr(Ord('0')+ ADecimal); End
       Else Begin
          HexDigit := Chr(Ord('A')+ ADecimal - 10);
       End;
  End;
Begin
     Value := StrToInt(ADecimalValue);
     If Value > 255 Then Begin
        Abort;
     End;
     ToHexValue := HexDigit(Value Div 16) + HexDigit(Value Mod 16);
End;
{ ** GetHostName is a support function for the original version of the
  ** GetAliasName function. Unfortunately, sometimes GetAliasName don't
  ** work because a bug in MIMSX.Dll. This bug is the message "Unable to match index",
  ** actually under investigation in the Mincom headquarters in Australia.
  ** As soon as the error can be solved, we suggest to use this function
  ** and the original version of the GetAliasName because this is a best
  ** solution than our current solution.

  The Host Name encrypted is an special convention to create a unique
  key for the MIMS instance as this host name plus the port into the
  table +HNP in MSF010. This is really a "work around" because the
  natural key must be the original host name plus the port. However,
  the TABLE_CODE field is defined to have maximun 18 characters and
  when the host name is an IP address we can have 15 characters (check
  the format : nnn.nnn.nnn.nnn , where n is a decimal digit) plus 4
  characters for the port, we would have 19 characters.
  Our solution is to change the host name corresponding to IP address
  to an hexadecimal notation; therefore, the format will be hh.hh.hh.hh ,
  equivalent to 11 characters, plus the port, we will have maximun 15
  characters.

  Note the following : If the host name is not an IP address, this name
  is supposed to be under 14 characters. This is not a serious trouble
  because the company can work easily using names under 14 }
Function TMIMSXServer.GetHostName:String;
Var
   FHostName:          String;
   DecimalValue:       String;
   CurrentChar:        Char;
   HostIndex:          Integer;
   HostLength:         Integer;
Begin
     Try
        FHostName    := '';
        DecimalValue := '';
        HostLength   := Length(FHost);
        HostIndex    := 1;
        While HostIndex <= HostLength Do Begin
              CurrentChar := FHost[HostIndex];
              If CurrentChar in ['0'..'9'] Then Begin
                 DecimalValue := DecimalValue + CurrentChar; End
              Else Begin
                 If CurrentChar <> '.' Then Begin
                    Abort;
                 End;
                 FHostName    := FHostName + ToHexValue(DecimalValue) + '.';
                 DecimalValue := '';
              End;
              Inc(HostIndex);
        End;
        GetHostName := FHostName + ToHexValue(DecimalValue);
     Except
        On Exception Do GetHostName := UpperCase(FHost);
     End;
End;

{ ** Original version of the GetAliasName function. Read the note for the
  ** GetHostName.

  Get the name for the Alias BDE corresponding to the current MIMS
  instance. The name is stored in the table +HNP of MSF010 and its
  corresponding key (field TABLE_CODE) is the host name plus the
  port.
Function TMIMSXServer.GetAliasName:String;
Begin
     GetAliasName := Trim(TableValue['+HNP',GetHostName + FPort]);
End;  }
Function TMIMSXServer.GetAliasName:String;
Var
   Line:                String;
   ArcCnfTxt:           String;
   ConfigName:          String;
   InstanceKey:         String;
   LngInstKey:          Integer;
   Searching:           Boolean;
Begin
     GetAliasName := '';
     Try
        Searching   := True;
        InstanceKey := UpperCase(FHost) + FPort;
        LngInstKey  := Length(InstanceKey);
        ConfigName  := GetConfigDirectory + 'MIMSInst.Txt';
        AssignFile(FArcCnfTxt,ConfigName);
        Reset(FArcCnfTxt);
        While Searching And (Not EoF(FArcCnfTxt)) Do Begin
              ReadLn(FArcCnfTxt,Line);
              If UpperCase(Copy(Line,1,LngInstKey)) = InstanceKey Then Begin
                 Delete(Line,1,LngInstKey);
                 Line := Trim(Line);
                 If Length(Line) < 1 Then Begin
                    raise Exception.CreateFmt(ME_181,[ConfigName]);
                 End;
                 If Line[1] <> '=' Then Begin
                    raise Exception.CreateFmt(ME_182,[ConfigName]);
                 End;
                 Delete(Line,1,1);
                 GetAliasName := Trim(Line);
                 Searching    := False;
              End;
        End;
     Finally
        CloseFile(FArcCnfTxt);
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
     If Not FMSQMUI.Connect(False) Then Begin
        raise Exception.Create(FMSQMUI.Errors(1).ErrorDescription);
     End;
     FUserName     := FMSQMUI.GetParameter('username');
     FMimsUser     := FMSQMUI.GetParameter('mimsuser');
     FMimsDistrict := FMSQMUI.GetParameter('mimsdistrict');
     FMimsPosition := FMSQMUI.GetParameter('mimsposition');
     FHost         := FMSQMUI.GetParameter('host');
     FPort         := FMSQMUI.GetParameter('port');
     If Trim(FMimsUser) = '' Then Begin
        FMimsUser := FUserName;
     End;
     GetOracleUserPassword;
End;
Procedure TMIMSXServer.Disconnect;
Begin
     Try
        If Not VarIsUnAssigned(FMSQMUI) Then Begin
           FMSQMUI.Disconnect;
        End;
     Finally
        FMSQMUI := varEmpty;
     End;
End;
Procedure TMIMSXServer.ExecProgram(AProgram:String);
Begin
     FMSQMUI.Screen.ExecuteMSO(AProgram,'','','N','');
End;
Function TMIMSXServer.NewBlock(ABlock:String):TMIMSBlock;
Begin
     NewBlock := TMIMSBlock.Create(Self,ABlock);
End;
end.
