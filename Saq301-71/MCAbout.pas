unit MCAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, jpeg, SAQTypes;

type
  TFrmAbout = class(TForm)
    PageControl1: TPageControl;
    TabGeneral: TTabSheet;
    TabVersion: TTabSheet;
    TabCopyrights: TTabSheet;
    PnlBottom: TPanel;
    BtnOk: TBitBtn;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    LblWindowsVersion: TLabel;
    LblTotalMemory: TLabel;
    LblFreeMemory: TLabel;
    LblFreeDiskSpace: TLabel;
    LblFreeMemoryPercent: TLabel;
    Label9: TLabel;
    LblCompiled: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    Label1: TLabel;
    Label10: TLabel;
    Image2: TImage;
    TabLicenses: TTabSheet;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    LblProject: TLabel;
    LblVersion: TLabel;
    LblRevision: TLabel;
    LblModule: TLabel;
    LblFileVersion: TLabel;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    LBItemName: TListBox;
    Label17: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    MemValue: TMemo;
    LblProgramName: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LblDescription: TLabel;
    LblLocation: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LBItemNameClick(Sender: TObject);
  private
    { Private declarations }
    VersionSize:         DWORD;      { File Version Info Size (0=Not avalaible) }
    VersionBuffer:       String;     { Buffer for the Version Info }
    TranslationTable:    PLongInt;   { Translation Table }
    MIMSVersion:         PInfoVersion;{ MIMS Version parameters }
    Function GetItemVersionValue(AnItem:Integer):String;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent;AMIMSVersion:PInfoVersion);
  end;

var
  FrmAbout: TFrmAbout;

Procedure ShowAbout(AOwner:TComponent;AMIMSVersion:PInfoVersion);
implementation

{$R *.DFM}

Procedure ShowAbout(AOwner:TComponent;AMIMSVersion:PInfoVersion);
Begin
     FrmAbout:=Nil;
     Try
        FrmAbout:=TFrmAbout.Create(AOwner,AMIMSVersion);
        FrmAbout.ShowModal;
     Finally
        FrmAbout.Free;
     End;
End;
Constructor TFrmAbout.Create(AOwner:TComponent;AMIMSVersion:PInfoVersion);
Begin
     Inherited Create(AOwner);
     MIMSVersion := AMIMSVersion;
End;
Function TFrmAbout.GetItemVersionValue(AnItem:Integer):String;
Var
   P:                   PChar;      { Buffer for Query Value }
   QueryDescription:    String;     { Description of Query required }
   QuerySize:           UINT;       { Size Of Info Query Value }
Begin
     GetItemVersionValue := '';
     QueryDescription := Format(VersionQueryStr,
                                [LoWord(TranslationTable^),
                                 HiWord(TranslationTable^),
                                 VersionLabels[AnItem]]);
     If VerQueryValue(PChar(VersionBuffer),
                      PChar(QueryDescription),
                      Pointer(P),
                      QuerySize) Then Begin
        GetItemVersionValue := StrPas(P);
     End;
End;
procedure TFrmAbout.FormCreate(Sender: TObject);
Var
   VI:                  TOSVersionInfo; { Operating System Information }
   MS:                  TMemoryStatus;  { Memory status }
   OSVersion:           String;     { Operating System and version description }
   TotalMemoryKB:       Integer;    { Total physical memory (KiloBytes) }
   FreeMemoryKB:        Integer;    { Physical free Memory (KiloBytes) }
   FreeMemoryPercent:   Integer;    { Percent of physical free memory }
   FreeDiskSpaceMB:     Integer;    { Free Disk Space (Megabytes) }
   I:                   Integer;    { Index }
   Handle:              DWORD;      { Handle }
   TranslationSize:     UINT;       { Size of Translation Table }
   FileDateCompiled:    Integer;    { Date-and-time stamp of the Exe file }
begin
     { Clear Labels }
     LblDescription.Caption := '';
     LblLocation.Caption    := '';
     LblCompiled.Caption    := '';
     { Get File Info }
     FileDateCompiled       := FileAge(Application.ExeName);
     If FileDateCompiled >= 0 Then Begin
        LblCompiled.Caption := DateTimeToStr(FileDateToDateTime(FileDateCompiled));
     End;
     LblLocation.Caption    := ExtractFileDir(Application.ExeName);
     LblProgramName.Caption := ExtractFileName(Application.ExeName);
     LblProject.Caption     := MIMSVersion^.Project;
     LblVersion.Caption     := MIMSVersion^.VersionNo;
     LblRevision.Caption    := MIMSVersion^.RevisionNo;
     LblModule.Caption      := MIMSVersion^.ModuleNo;
     LblFileVersion.Caption := '';
     { Get Windows Version }
     VI.dwOSVersionInfoSize := SizeOf(VI);
     GetVersionEx(VI);
     With VI Do Begin
          Case dwPlatformId Of
          VER_PLATFORM_WIN32_WINDOWS : OSVersion := TIA_Windows9598;
          VER_PLATFORM_WIN32_NT      : OSVersion := TIA_WindowsNT;
          Else                         OSVersion := TIA_OSUnknown;
          End;
          OSVersion := Format(TIA_WindowsVersion,
                              [OSVersion,
                               dwMajorVersion,
                               dwMinorVersion,
                               LoWord(dwBuildNumber)]);
     End;
     LblWindowsVersion.Caption    := OSVersion;
     { Get Memory Use }
     MS.dwLength := SizeOf(MS);
     GlobalMemoryStatus(MS);
     TotalMemoryKB                := MS.dwTotalPhys Div 1024;
     FreeMemoryKB                 := MS.dwAvailPhys Div 1024;
     FreeMemoryPercent            := 100 - MS.dwMemoryLoad;
     LblTotalMemory.Caption       := Format(TIA_MemoryKB,[TotalMemoryKB]);
     LblFreeMemory.Caption        := Format(TIA_MemoryKB,[FreeMemoryKB]);
     LblFreeMemoryPercent.Caption := Format(TIA_Percent,[FreeMemoryPercent]);
     { Get Disk usage }
     FreeDiskSpaceMB              := DiskFree(3) Div 1048576;
     LblFreeDiskSpace.Caption     := Format(TIA_SpaceMB,[FreeDiskSpaceMB]);
     { Get File Version Info }
     For I := Low(VersionLabels) To High(VersionLabels) Do Begin
         LBItemName.Items.Add(VersionLabels[I]);
     End;
     VersionSize := GetFileVersionInfoSize(PChar(Application.ExeName),Handle);
     If VersionSize<>0 Then Begin
        SetLength(VersionBuffer,VersionSize);
        If GetFileVersionInfo(PChar(Application.ExeName),
                              Handle,VersionSize,
                              PChar(VersionBuffer)) Then Begin
           If VerQueryValue(PChar(VersionBuffer),
                            VersionTranslation,
                            Pointer(TranslationTable),
                            TranslationSize) Then Begin
              LBItemName.OnClick     := LBItemNameClick;
              LBItemName.ItemIndex   := 0;
              LblDescription.Caption := GetItemVersionValue(2);
              LblFileVersion.Caption := GetItemVersionValue(3);
              LBItemNameClick(Self);
           End;
        End;
     End;
end;

procedure TFrmAbout.LBItemNameClick(Sender: TObject);
Var
   CurrentItem:         Integer;    { Index of Info Query required }
begin
     MemValue.Clear;
     CurrentItem := LBItemName.ItemIndex;
     If CurrentItem = 0 Then Begin
        MemValue.Lines.Add(IntToStr(VersionSize)); End
     Else Begin
        If CurrentItem > 0 Then Begin
           MemValue.Lines.Add(GetItemVersionValue(CurrentItem));
        End;
     End;
end;

end.
