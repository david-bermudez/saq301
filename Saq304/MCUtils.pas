unit MCUtils;

{ This unit provide some common routines, not based in objects }

interface
Uses Classes,db,dbtables,dbGrids,MCTypes, Variants;

Function VarIsUnAssigned(AVariant:Variant):Boolean;
Function GetParamNo(AIndex:Integer):String;
Function IsEmptyField(AField:TField):Boolean;
Function GetColumnByName(AGrid:TDBGrid;AFieldName:String):TColumn;
Function GetFullNumericField(AValue,ALength:Integer):String;
Function DaysToDisplayFormat(ADays:Integer):String;
Function GetMIMSKey(AKey:String;ALength:Integer):String;
Function GetMIMSKeyInt(AKey:String;ALength:Integer):String;
Function GetFullMIMSKey(AValue:String;ALength:Integer):String;
Function GetInverseDate(ADate:String):String;
Function IsInFormat8(AText:String):Boolean;
Function DateTimeToDate8(ADate:TDateTime):String;
Function Date8ToDateTime(ADate:String):TDateTime;
Function Date8ToDisplayFormat(ADate8:String):String;
Function IsValidDateField(ADate:TField):Boolean;
Function GetMDTimeElapsed(AnStartDate,AFinalDate:String):String;
Function StrStatusOf(AnStatus:TActStatus):String;
Function OperationOk(Mensaje:String):Boolean;
Procedure OpenActPaidSession(ASession:TSession);
Procedure DisconnectObjectsIn(AList:TStrings);
function GetUser(usrpwd: string): string;
function GetPass(usrpwd: string): string;
function tp_xcrypt(direction: byte; pw: string): string;
Procedure Nothing;

implementation
Uses SysUtils,Windows,Forms;

Function VarIsUnAssigned(AVariant:Variant):Boolean;
Begin
     VarIsUnAssigned := VarIsNull(AVariant) Or VarIsEmpty(AVariant);
End;
Function GetParamNo(AIndex:Integer):String;
Var
   Prefix:              String;
   ParamNo:             String;
Begin
     Prefix  := Format('/%2.2d=',[AIndex]);
     ParamNo := ParamStr(AIndex);
     If Prefix <> Copy(ParamNo,1,4) Then Begin
        raise Exception.Create(ME_029);
     End;
     GetParamNo := Copy(ParamNo,5,Length(ParamNo)-4);
End;
Function IsEmptyField(AField:TField):Boolean;
Begin
     IsEmptyField := AField.IsNull Or (Trim(AField.AsString) = '');
End;
{ Use this routine to get the first column object assigned to a Field
  named AFieldName }
Function GetColumnByName(AGrid:TDBGrid;AFieldName:String):TColumn;
Var
   CurrentIndex:              Integer;    { Index of current column }
   CurrentColumn:       TColumn;
Begin
     GetColumnByName := Nil;
     CurrentIndex := 0;
     While CurrentIndex < AGrid.Columns.Count Do Begin
           CurrentColumn := AGrid.Columns[CurrentIndex];
           If CurrentColumn.FieldName = AFieldName Then Begin
              GetColumnByName := CurrentColumn;
              CurrentIndex := AGrid.Columns.Count;
           End;
           Inc(CurrentIndex);
     End;
End;
{ *** MIMS Key routines *** }

{ Fill a numeric field }

Function GetFullNumericField(AValue,ALength:Integer):String;
Var
   AsString:            String;
Begin
     AsString := IntTostr(AValue);
     While Length(AsString) < ALength Do Begin
           AsString := '0' + AsString;
     End;
     GetFullNumericField := AsString;
End;
{ Use this routine to get ADays (a number of days) as an string. }

Function DaysToDisplayFormat(ADays:Integer):String;
Begin
     If ADays < 30 Then Begin
        DaysToDisplayFormat := Format('%d días',[ADays]);End
     Else Begin
        If (ADays Mod 30) = 0 Then Begin
           DaysToDisplayFormat := Format('%d meses',[ADays Div 30]);End
        Else Begin
           DaysToDisplayFormat := Format('%dm %dd',[ADays Div 30,ADays Mod 30]);
        End;
     End;
End;

{ Get the number of the days for AMonth in the year AYear }

Function DayOfTheMonth(AYear,AMonth:Word):Integer;
Type
    TDaysByMonth = Array[1..12] Of Byte;
Const
     DaysByMonth : TDaysByMonth = (31,28,31,30,31,30,31,31,30,31,30,31);
Begin
     DayOfTheMonth := DaysByMonth[AMonth];
     If (AMonth = 2) And ((AYear Mod 4)=0) Then Begin
        { Case February in a Leap Year }
        DayOfTheMonth:=29;
     End;
End;
{ Get the year, the month and the day for a date in format 8; format 8
  is a date, as string and without date separators, for example, a date
  as 2001/12/31 is stored in format 8 as the string '20011231' }
Procedure Format8ToYYYYMMDD(ADate:String;Var AYear,AMonth,ADay:Word);
Var
   AsInteger:           Integer;
Begin
     AsInteger := StrToInt(ADate);
     AYear     := AsInteger Div 10000;
     AMonth    := (AsInteger Mod 10000) Div 100;
     ADay      := AsInteger Mod 100;
End;
{ Get the Months and Days since the Start Date to the Final Date. The routine
  doesn't validate neither that the dates have a right format nor the final
  date greather than the start date. The values are supposed to be previously
  validated }
Procedure GetDateDiference(AnStartDate,AFinalDate:String;Var AMonths,ADays:Word);
Var
   StartYear:           Word;
   StartMonth:          Word;
   StartDay:            Word;
   FinalYear:           Word;
   FinalMonth:          Word;
   FinalDay:            Word;
   Years:               Word;
Begin
     Format8ToYYYYMMDD(AnStartDate,StartYear,StartMonth,StartDay);
     Format8ToYYYYMMDD(AFinalDate,FinalYear,FinalMonth,FinalDay);
     AMonths := 0;
     Years   := FinalYear - StartYear;
     If Years = 0 Then Begin
        If FinalMonth = StartMonth Then Begin
           AMonths := 0;
           ADays   := FinalDay - StartDay; End
        Else Begin                                   
           If FinalDay >= StartDay Then Begin
              AMonths := FinalMonth - StartMonth;
              ADays   := FinalDay - StartDay; End
           Else Begin
              ADays := DayOfTheMonth(StartYear,StartMonth);
              ADays := FinalDay + (ADays - StartDay);
              AMonths := 0;
           End;
        End; End
     Else Begin
        If Years > 1 Then Begin
           AMonths := 12 * (Years - 1);
        End;
        If FinalMonth >= StartMonth Then Begin
           If FinalDay >= StartDay Then Begin
              AMonths := AMonths + 12 + (FinalMonth - StartMonth);
              ADays   := FinalDay - StartDay; End
           Else Begin
              AMonths := AMonths + 11 + (FinalMonth - StartMonth);
              ADays   := DayOfTheMonth(StartYear,StartMonth);
              ADays   := FinalDay + (ADays - StartDay);
           End; End
        Else Begin
           If FinalDay >= StartDay Then Begin
              AMonths := AMonths + FinalMonth + (12 - StartMonth);
              ADays   := FinalDay - StartDay; End
           Else Begin
              AMonths := AMonths + FinalMonth + (12 - StartMonth) - 1;
              ADays   := DayOfTheMonth(StartYear,StartMonth);
              ADays   := FinalDay + (ADays - StartDay);
           End;
        End;
     End;
End;
{ Get the time elapsed between two dates, in the format months days }
Function GetMDTimeElapsed(AnStartDate,AFinalDate:String):String;
Var
   Months:              Word;
   Days:                Word;
Begin
     If AnStartDate < AFinalDate Then Begin
        GetDateDiference(AnStartDate,AFinalDate,Months,Days);
        If Months = 0 Then Begin
           GetMDTimeElapsed := Format('%d días',[Days]);End
        Else Begin
           If Days = 0 Then Begin
              GetMDTimeElapsed := Format('%d meses',[Months]);End
           Else Begin
              GetMDTimeElapsed := Format('%dm %dd',[Months,Days]);
           End;
        End; End
     Else Begin
        { Case : final date less than (or equal to) start date }
        GetMDTimeElapsed := '0  días';
     End;

End;
{ Translate a user input for a MIMS key field to the MIMS integer format :
  The original value padding with left '0' and stored as string }
Function GetKeyAsMIMSInteger(AKey:String;ALength:Integer):String;
Var
   AsInteger:           Integer;
   AsString:            String;
Begin
     AsInteger := StrToInt(AKey);
     AsString  := AKey;
     While Length(AsString) < ALength Do Begin
           AsString := '0' + AsString;
     End;
     GetKeyAsMIMSInteger := AsString;
End;
{ Translate a user input for a MIMS key field to the MIMS format.
  If the user input is an integer value, then the MIMS key is this value
  padding with left '0'. In other case, the MIMS key is the same original
  value }
Function GetMIMSKey(AKey:String;ALength:Integer):String;
Begin
     Try
        GetMIMSKey := GetKeyAsMIMSInteger(AKey,ALength);
     Except
        On E:Exception Do GetMIMSKey := AKey;
     End;
End;
{ Translate a user input for a MIMS key field to the MIMS integer format
  and validate if the user input is really an integer value. This routine
  is useful when the MIMS key must be an integer; use GetMIMSKey when the
  MIMS field can has alphanumeric values }
Function GetMIMSKeyInt(AKey:String;ALength:Integer):String;
Begin
     Try
        GetMIMSKeyInt := GetKeyAsMIMSInteger(AKey,ALength);
     Except
        On E:Exception Do raise Exception.CreateFmt(ME_171,[AKey]);
     End;
End;
{ Use this routine to get AValue in a full MIMS format. The full format
  require the value has the maximun field length; therefore, first, we
  try to get it using GetMIMSKey, GetMIMSKey will be full successful if
  the AValue is numeric; in other case, we complete the new value with
  right blanks }
Function GetFullMIMSKey(AValue:String;ALength:Integer):String;
Var
   NewValue:            String;
Begin
     NewValue := GetMIMSKey(AValue,ALength);
     While Length(NewValue) < ALength Do Begin
           NewValue := NewValue + ' ';
     End;
     GetFullMIMSKey := NewValue;
End;
{ **** Date/Time routines **** }

{ Use this routine to verify if AText is a valid format 8 date. A Valid
  format 8 date is a date in the format yyyymmdd }
Function IsInFormat8(AText:String):Boolean;
Var
   Format8Ok:           Boolean;
   TheDate:             TDateTime;
Begin
     Format8Ok := Length(AText) = 8;
     If Format8Ok Then Begin
        Try
           TheDate   := Date8ToDateTime(AText);
           Format8Ok := True;
        Except
           Format8Ok := False;
        End;
     End;
     IsInFormat8 := Format8Ok;
End;
{ Get the inverse date. MIMS use an inverse format to save some dates.
  The inverse format is the difference between the integer value of the
  usual date format (yyyymmdd) and the constant MIMSTopInvDate (99999999) }
Function GetInverseDate(ADate:String):String;
Begin
     GetInverseDate := IntToStr(MIMSTopInvDate - StrToInt(ADate));
End;
{ Translate a Date in DateTime format to the yyyymmdd format }

Function DateTimeToDate8(ADate:TDateTime):String;
Var OldShortDateFormat : String;
Begin
     OldShortDateFormat := ShortDateFormat;
     Try
        ShortDateFormat := 'yyyymmdd';
        DateTimeToDate8 := DateToStr(ADate);
     Finally
        ShortDateFormat := OldShortDateFormat;
     End;
End;

{ This is an auxiliary routine to work around a bug in Delphi 4. Under
  Delphi 4, if we set ShortDateFormat to yyyymmdd, the function DateToStr
  work well, but NOT the inverse function StrToDate; in order to get a
  yyyymmdd date in a DateTime format, we must translate the yyyymmdd format
  to a valid format for StrToDate. We use the yyyy/mm/dd format }

Function Format8ToFormat10(ADate8:String):String;
Var
   TempDate:            String;     { Temporal variable }
Begin
     TempDate := ADate8;
     Insert(DateSeparator,TempDate,7);
     Insert(DateSeparator,TempDate,5);
     Format8ToFormat10 := TempDate;
End;

{ Translate a Date in the yyyymmdd format to the DateTime format. Because
  a Delphi 4.0 bug, we NEED to use the auxiliary function Format8ToFormat10 }

Function Date8ToDateTime(ADate:String):TDateTime;
Var
   OldShortDateFormat:  String;     { Temp to preserve the short Date format }
Begin
     OldShortDateFormat := ShortDateFormat;
     Try
        ShortDateFormat := 'yyyy/mm/dd';
        Date8ToDateTime := StrToDate(Format8ToFormat10(ADate));
     Finally
        ShortDateFormat := OldShortDateFormat;
     End;
End;

{ Translate a date yyyymmdd to the current display format for a date }

Function Date8ToDisplayFormat(ADate8:String):String;
Begin
     Try
        Date8ToDisplayFormat := DateToStr(Date8ToDateTime(ADate8));
     Except
        Date8ToDisplayFormat := '';
     End;
End;

{ Use this routine to verify if a date field contains a valid format
  date field. A valid date field must contains a numeric value, 8 digits
  and greather than 0 }

Function IsValidDateField(ADate:TField):Boolean;
Begin
     Try
        IsValidDateField := (Length(ADate.AsString) = 8) And
                            (ADate.AsInteger > 0)
     Except
        IsValidDateField := False;
     End;
End;

{ **** End of the Date/Time routines **** }

{ Open a session using MIMS Popup as private directory }
Procedure OpenActPaidSession(ASession:TSession);
Var
   ParamList:           TStringList;
   ParamIndex:          Integer;
   LocalDirectory:      String;
   ParamLine:           String;
Begin
     ParamList      := Nil;
     LocalDirectory := '';
     Try
        ParamList := TStringList.Create;
        ASession.GetAliasParams('MIMS',ParamList);
        ParamIndex := 0;
        While ParamIndex < ParamList.Count Do Begin
              ParamLine := ParamList[ParamIndex];
              If Copy(ParamLine,1,5) = 'PATH=' Then Begin
                 LocalDirectory := Trim(Copy(ParamLine,6,Length(ParamLine)-5));
                 ParamIndex     := ParamList.Count;
              End;
              Inc(ParamIndex);
        End;
        If LocalDirectory = '' Then Begin
           raise Exception.Create(ME_168);
        End;
      {  ASession.PrivateDir := LocalDirectory;  }
        ASession.Active     := True;
     Finally
        ParamList.Free;
     End;
End;

{ Get AnStatus as string }

Function StrStatusOf(AnStatus:TActStatus):String;
Begin
     StrStatusOf := IntToStr(Ord(AnStatus));
End;

{ Ask if It's Ok to continue a procces }

Function OperationOk(Mensaje:String):Boolean;
Begin
     OperationOk := Application.MessageBox(PChar(Mensaje),'CONFIRMAR',
                    MB_ICONQUESTION Or MB_YESNO)=IDYES;
End;

{ Put to Nil every Object in a List. This operation is neccessary when
  the objects in the list are going to be freed; but, they are owned by
  other object (typically, other list); therefore, before the owner
  can be able to free them, they must be disconnected from the list }

Procedure DisconnectObjectsIn(AList:TStrings);
Var  I:                 Integer;    { Index }
Begin
     I:=0;
     While I<AList.Count Do Begin
           AList.Objects[I]:=Nil;
           Inc(I);
     End;
End;
function GetUser(usrpwd: string): string;
var
  s1     : string;
  i, len :  byte;
begin
  s1 := '';
  i := 1;
  len := length(usrpwd);
  while (usrpwd[i] <> '/') and (i <= len) do begin
    s1 := s1 + usrpwd[i];
    i := i + 1;
  end;
  if i = len then
    Result := ''
  else
    Result := s1
end;

function GetPass(usrpwd: string): string;
var
  s1     : string;
  i, len :  byte;
begin
  s1 := '';
  i := 1;
  len := length(usrpwd);
  while (usrpwd[i] <> '/') and (i <= len) do
   i := i + 1;
  if i = len then begin
    Result := '';
    Exit;
  end;
  i := i + 1;
  while (i <= len) do begin
    s1 := s1 + usrpwd[i];
    i := i + 1;
  end;
  Result := Trim(s1);
end;
function tp_xcrypt(direction: byte; pw: string): string;
const
  Zcrypt = ' Q!W@E#R$T%Y^U&I*O(P)1_2-3+4=5\6`7[8]9:0"A;S' + #39 +
           'D<F>G?H,J.K/LZXCVBNM';
var
  iX1, iX2, iX3, Len, ZcryptLen : integer;
  pwc                           : string;
  Magic                         : byte;

begin
  Magic := 3;
  ZcryptLen := Length(Zcrypt) - 1;
  Len := Length(pw);
  pwc := '';

  if direction = 0 then begin
    iX1 := 0;
    while (iX1 < len) do begin
      iX1 := iX1 + 1;
      iX2 := Ord(pw[iX1]) + Magic;
      iX3 := 1;
      while iX2 >= ZcryptLen do begin
        iX3 := iX3 + 1;
        iX2 := iX2 - ZcryptLen;
      end;
      if (ix3 <> 2) then
        pwc := pwc + Chr(Ord('a') + ix3);
      pwc := pwc + Zcrypt[iX2 + 2];
      Magic := (Magic + ix2) mod 10;
    end;
    Result := pwc;
  end
  else begin
    iX1 := 0;
    while (iX1 < Len) do begin
      iX1 := iX1 + 1;
      iX3 := ord(pw[iX1]) - ord('a');
      if (iX3 <1) or (iX3 > 26) then
        iX3 := 2
      else
        iX1 := iX1 + 1;
      iX2 := Pos(pw[iX1], ZCrypt) - 1;
      if iX2 = 0 then
        iX2 := 1;
      iX2 := iX2 - 1;
      pwc := pwc + chr(iX2 + ( (iX3 - 1) * ZcryptLen) - Magic);
      Magic := (Magic + iX2) mod 10;
    end;
  end;
  Result := pwc;
end;
{ Use this procedure to non-actions operations in case blocks }
Procedure Nothing;
Begin
End;
end.
