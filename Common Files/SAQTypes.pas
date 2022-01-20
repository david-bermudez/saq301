unit SAQTypes;

interface

{ Masks and lines for text informations in the About form }

Const
     TIA_Windows9598    = 'Windows 95/98';
     TIA_WindowsNT      = 'Windows NT';
     TIA_OSUnknown      = 'OS Unknown';
     TIA_WindowsVersion = '%s %d.%d [Build %d]';
     TIA_MemoryKB       = '%d KB';
     TIA_SpaceMB        = '%d MB';
     TIA_Percent        = '%d %';

{ Version Information Section }

Type
     TArrVersionInfo = Array[0..10] Of String;
Const
     VersionTranslation:PChar = '\VarFileInfo\Translation';
     VersionQueryStr = '\StringFileInfo\%.4x%.4x\%s';
     VersionLabels:TArrVersionInfo = ('FileVersionInfoSize',
                                      'CompanyName',
                                      'FileDescription',
                                      'FileVersion',
                                      'InternalName',
                                      'LegalCopyright',
                                      'LegalTrademarks',
                                      'OriginalFileName',
                                      'ProductName',
                                      'ProductVersion',
                                      'Comments');
{ MIMS Version Section }

Type
    PInfoVersion = ^TInfoVersion;
    TInfoVersion = Record
       Project:         String;
       VersionNo:       String;
       RevisionNo:      String;
       ModuleNo:        String;
    End;
implementation

end.
 
