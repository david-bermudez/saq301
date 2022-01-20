unit SAQUtils;

interface
Uses Windows;

{ *** Support to Private Directories of the sessions *** }

Function GetEnvironmentVariableValue(AVariable:String):String;
Function GetWorkingDirectory(AnErrorMsgFmt:String):String;
Procedure DeleteDirectory(ADirectory:String);

{ *** MultiInstances Support *** }

{ We need to redefine BroadcastSystemMessage because there is a bug in the
  original Delphi definition (In the Windows unit). The bug is because the
  clause name must be BroadcastSystemMessage ; but, in the Windows unit is
  defined as BroadcastSystemMessageA }
function BroadcastSystemMessage(Flags: DWORD; Recipients: PDWORD;
  uiMessage: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;

Function OpenMultiInstanceSupport(AName:PChar):Integer;
Procedure CloseMultiInstanceSupport;
implementation

Uses FileCtrl,forms,Dialogs,SysUtils;

{ This constants are used to the multiinstances support.

  The first group is used to a dialogue between instances by using
  private messages.

  The second group is used to error control }

const
  MI_QUERYWINDOWHANDLE   = 1;
  MI_RESPONDWINDOWHANDLE = 2;

  MI_ERROR_NONE          = 0;
  MI_ERROR_FAILSUBCLASS  = 1;
  MI_ERROR_CREATINGMUTEX = 2;

{ *** Support to Private Directories of the sessions *** }

{ Use this routine to get the current Value for an environment variable.
  Typically, this routine is used to get the searching paths (Variable
  PATH) or the temporal directory (Variable TEMP, or TMP in some system) }
Function GetEnvironmentVariableValue(AVariable:String):String;
Var
   Buffer:              PChar;
   EnvVarDesc:          String;
   VariableLength:      Integer;
Begin
     GetEnvironmentVariableValue := '';
     VariableLength              := Length(AVariable);
     {$IFDEF WIN32}
     Buffer := GetEnvironmentStrings;
    {$ELSE}
     Buffer := GetDOSEnvironment;
    {$ENDIF}
     While Buffer^ <> #0 do begin
           EnvVarDesc := StrPas(Buffer);
           If Copy(EnvVarDesc,1,VariableLength) = AVariable Then Begin
              GetEnvironmentVariableValue := Copy(EnvVarDesc,
                                                  VariableLength+2,
                                                  Length(EnvVarDesc)-
                                                  VariableLength-1);
           End;
           inc(Buffer, lStrLen(Buffer) + 1);
     end;
    {$IFDEF WIN32}
     FreeEnvironmentStrings(Buffer);
    {$ENDIF}
End;
{ Use this routine to get a working directory for a session. The applications
  must assign this value to the PrivateDir property of its TSession component
  in the OnStartUp event. The calling application MUST delete this directory
  when the session is closed }
Function GetWorkingDirectory(AnErrorMsgFmt:String):String;
Var
   WorkingDirectory:    String;
   CurrentDirectory:    String;
   ApplicationName:     String;
   DirectoryCount:      Integer;
begin
     { Get the system temporal directory }
     WorkingDirectory := GetEnvironmentVariableValue('TEMP');
     If WorkingDirectory = '' Then Begin
        WorkingDirectory := GetEnvironmentVariableValue('TMP');
     End;
     { If the system doesn't have a temporal directory, then try to create it
       as C:\TEMP }
     If WorkingDirectory = '' Then Begin
        WorkingDirectory := 'C:\TEMP';
        If Not DirectoryExists(WorkingDirectory) Then Begin
           If Not CreateDir(WorkingDirectory) Then Begin
              raise Exception.CreateFmt(AnErrorMsgFmt,[WorkingDirectory]);
           End;
        End;
     End;
     { Get the application name without the path, the ".Exe" extension and
          using uppercase }
     ApplicationName  := ExtractFileName(Application.ExeName);
     ApplicationName  := Copy(ApplicationName,1,Length(ApplicationName)-4);
     ApplicationName  := UpperCase(ApplicationName);
     { Create a private directory as a subdirectory in the temporal directory.
       The name for this subdirectory is the application name plus a secuencial
       number. }
     CurrentDirectory := WorkingDirectory + '\' + ApplicationName;
     DirectoryCount   := 0;
     Repeat
           Inc(DirectoryCount);
           WorkingDirectory := Format('%s%4.4d',[CurrentDirectory,DirectoryCount]);
     Until Not DirectoryExists(WorkingDirectory);
     If Not CreateDir(WorkingDirectory) Then Begin
        raise Exception.CreateFmt(AnErrorMsgFmt,[WorkingDirectory]);
     End;
     GetWorkingDirectory := WorkingDirectory;
End;
{ Use this routine to delete a non-empty directory. Use the standard function
  RemoveDir to delete an empty directory. Normally, you should not delete
  a non-empty directory; but this useful to clear the private directory
  of a session after the session is closed because sometimes the temporal
  files are not correctly deleted by the system }
Procedure DeleteDirectory(ADirectory:String);
var
   SearchRec:           TSearchRec;
   ThereIsAFile:        Integer;
   FileName:            String;
Const
     MErrNotDelete = 'Unable to delete %s';
Begin
     { Verify if ADirectory is empty }
     If Trim(ADirectory) = '' Then Begin
        Exit;
     End;
     ThereIsAFile := FindFirst(ADirectory + '\*.*', faAnyFile-faDirectory, SearchRec);
     Try
        While ThereIsAFile = 0 Do Begin
              FileName := ADirectory + '\' + SearchRec.Name;
              If Not DeleteFile(PChar(FileName)) Then Begin
                 raise Exception.CreateFmt(MErrNotDelete,[FileName]);
              End;
              ThereIsAFile := FindNext(SearchRec);
        End;
     Finally
        FindClose(SearchRec);
     End;
     RemoveDir(ADirectory);
End;

{ *** MultiInstances Support *** }

{ The following routines are used to the multi instances administration
  to guarantee that one only instances will be running. The SAQ application
  usually mustn't be multi instances; therefore, when there is an instance
  running and the user try to run the application again, this routine
  take care the old instance take the control and the new instance is
  closed.

  We use the following technique :

  We create a mutex object the first time that an application run.
  The programmers must call the OpenMultiInstanceSupport function
  in the Initialization section of the main unit of the application.
  This function check if there is a mutex object already created
  by trying to open it using a unique name provided by the application
  for this object. If the object mutex exists, then, there is one instance
  already running; therefore the routine active it and terminate the new
  instance.

  Now, if the function fail, it's a good practice to show a message and
  terminate the application; therefore, usually, you must write a short
  routine to control it and call this routine since the Initialization
  section.

  The programmers also must call the CloseMultiInstanceSupport procedure
  in the Finalization section of the main unit of the application.
  This routine delete the mutex object when the application close

  According to the previous explanation, the last lines of the main unit
  of an application must be something as the following example for SAQ660 :

  Procedure InitMultiInstanceSupport;
  Const
       SAQ660MutexID = 'SAQ660MutexID';
  Var
     MIError:             Integer;
  Begin
       MIError := OpenMultiInstanceSupport(SAQ660MutexID);
       If MIError <> 0 Then Begin
          ShowMessageFmt(ME_180,[MIError]);
          Application.Terminate;
       End;
  End;
  Initialization
     InitMultiInstanceSupport;
  Finalization
     CloseMultiInstanceSupport;
  end.

  There is two other additional details :

  As OpenMultiInstanceSupport need to have a dialogue with other instances,
  other messages can be received before to have an answer from the other
  instances; specially, the message to create the main form. To avoid
  unnecessary actions, your code must check the Application.ShowMainForm
  property in the OnCreate event. OpenMultiInstanceSupport set this
  property to False before to try the dialogue; therefore, your OnCreate
  event must be something as :

  procedure TForm1.FormCreate(Sender: TObject);
  Begin
       If Application.ShowMainForm Then Begin
          ....
          ..
          Normal instructions for your OnCreate event
          ...
          ..
       End;
  End;

  The second detail is in connection to the destructor Destroy and the
  OnDestroy events. It's neccesary to be sure its instructions can
  manage the case when the OnCreate events are not executed

  }
function BroadcastSystemMessage; external 'user32.dll' name 'BroadcastSystemMessage';

var
   MessageId:           Integer;
   WProc:               TFNWndProc;
   MutexHandle:         THandle;
   MIError:             Integer;

function MIWndProc(Handle: HWND; Msg: Integer; wParam, lParam: Longint):
  Longint; stdcall;

 { A new instance is asking for main window handle in order
   to focus the main window, so normalize app and send back
   message with main window handle.  }
 Procedure OnQueryWindowHandle;
 Begin
      if IsIconic(Application.Handle) then Begin
         Application.MainForm.WindowState := wsNormal;
         Application.Restore;
      End;
      PostMessage(HWND(lParam), MessageID, MI_RESPONDWINDOWHANDLE,
        Application.MainForm.Handle);
 End;
 { The running instance has returned its main window handle,
   so we need to focus it and go away. }
 Procedure OnRespondWindowHandle;
 begin
      SetForegroundWindow(HWND(lParam));
      Application.Terminate;
 end;
begin
     MIWndProc := 0;
     if Msg = MessageID then begin
        { Process the registered message... }
        case wParam of
        MI_QUERYWINDOWHANDLE   : OnQueryWindowHandle;
        MI_RESPONDWINDOWHANDLE : OnRespondWindowHandle;
        end; end
     Else Begin
        { On other messages, call the original window proc }
        MIWndProc := CallWindowProc(WProc, Handle, Msg, wParam, lParam);
     End;
end;

procedure SubClassApplication;
begin
     { We subclass Application window procedure so that
        Application.OnMessage remains available for user. }
     WProc := TFNWndProc(SetWindowLong(Application.Handle,
                                       GWL_WNDPROC,
                                       Longint(@MIWndProc)));
     { Set appropriate error flag if error condition occurred  }
     if WProc = nil then Begin
        MIError := MIError or MI_ERROR_FAILSUBCLASS;
     End;
end;

procedure DoFirstInstance(AName:PChar);
{ This is called only for the first instance of the application }
begin
     { Create the mutex with the (hopefully) unique string  }
     MutexHandle := CreateMutex(nil, False, AName);
     If MutexHandle = 0 Then Begin
        MIError := MIError or MI_ERROR_CREATINGMUTEX;
     End;
end;

procedure BroadcastFocusMessage;
{ This is called when there is already an instance running. }
var
   BSMRecipients:       DWORD;
begin
     { Prevent main form from flashing  }
     Application.ShowMainForm := False;
     { Post message to try to establish a dialogue with previous instance }
     BSMRecipients := BSM_APPLICATIONS;
     BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
       @BSMRecipients, MessageID, MI_QUERYWINDOWHANDLE,
       Application.Handle);
end;

{ This function is succesful if the result value is 0, in other case,
  it will be one or more of the MI_ERROR_* error flags.  }
Function OpenMultiInstanceSupport(AName:PChar):Integer;
Begin
     MessageID := RegisterWindowMessage(AName);
     SubClassApplication;   // hook application message loop
     MutexHandle := OpenMutex(MUTEX_ALL_ACCESS, False, AName);
     If MutexHandle = 0 then Begin
        { Mutex object has not yet been created, meaning that no previous
          instance has been created. }
        DoFirstInstance(AName); End
     Else Begin
        BroadcastFocusMessage;
     End;
     OpenMultiInstanceSupport := MIError;
End;

Procedure CloseMultiInstanceSupport;
Begin
     { Restore old application window procedure }
     if WProc <> Nil then bEGIN
        SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(WProc));
     End;
     { Free mutex }
     if MutexHandle <> 0 then Begin
        CloseHandle(MutexHandle);
     End;
End;

end.
