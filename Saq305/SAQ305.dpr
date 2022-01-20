program SAQ305;

uses
  Forms,
  SAQ305001 in 'SAQ305001.pas' {FrmUserPreferences},
  SAQ305002 in 'SAQ305002.pas' {dmSAQ305002: TDataModule},
  SAQ300003 in '..\..\Common Files\SAQ300003.pas' {frmSAQ300003Connecting},
  MCUtils in '..\..\Common Files\MCUtils.pas',
  SAQ300002 in '..\..\Common Files\SAQ300002.pas',
  MCTypes in '..\..\Common Files\MCTypes.pas',
  MCObjcts in '..\Common Files\MCObjcts.pas',
  MCConnct in '..\..\Common Files\MCConnct.pas',
  SAQ300005 in '..\..\Common Files\SAQ300005.pas' {frmSAQ300005MIMSXFields},
  SAQUtils in '..\..\Common Files\SAQUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmSAQ305002, dmSAQ305002);
  Application.CreateForm(TFrmUserPreferences, FrmUserPreferences);
  Application.CreateForm(TfrmSAQ300003Connecting, frmSAQ300003Connecting);
  Application.CreateForm(TfrmSAQ300005MIMSXFields, frmSAQ300005MIMSXFields);
  Application.Run;
end.
