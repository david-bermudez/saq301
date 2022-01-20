unit DPInstnc;

interface
Uses Windows;

const
  MI_QUERYWINDOWHANDLE   = 1;
  MI_RESPONDWINDOWHANDLE = 2;

  MI_ERROR_NONE          = 0;
  MI_ERROR_FAILSUBCLASS  = 1;
  MI_ERROR_CREATINGMUTEX = 2;

{ We need to redefine BroadcastSystemMessage because there is a bug in the
  original Delphi definition (On the Windows unit). The bug is because the
  clause name must be BroadcastSystemMessage ; but, in the Windows unit is
  defined as BroadcastSystemMessageA }
function BroadcastSystemMessage(Flags: DWORD; Recipients: PDWORD;
  uiMessage: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;

Function OpenMultiInstanceSupport(AName:PChar):Integer;
Procedure CloseMultiInstanceSupport;
implementation

uses Forms, SysUtils;

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

