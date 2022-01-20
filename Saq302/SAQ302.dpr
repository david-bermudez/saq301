program SAQ302;

uses
  Forms,
  SAQ302001 in 'SAQ302001.pas' {FrmSAQ302001Main},
  SAQ300003 in '..\..\Common Files\SAQ300003.pas' {frmSAQ300003Connecting},
  MCTypes in '..\..\Common Files\MCTypes.pas',
  MCUtils in '..\..\Common Files\MCUtils.pas',
  SAQ300002 in '..\..\Common Files\SAQ300002.pas',
  MCConnct in '..\..\Common Files\MCConnct.pas',
  MCObjcts in '..\Common Files\MCObjcts.pas',
  SAQ300005 in '..\..\Common Files\SAQ300005.pas' {frmSAQ300005MIMSXFields},
  SAQUtils in '..\..\Common Files\SAQUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSAQ302001Main, FrmSAQ302001Main);
  Application.CreateForm(TfrmSAQ300003Connecting, frmSAQ300003Connecting);
  Application.CreateForm(TfrmSAQ300005MIMSXFields, frmSAQ300005MIMSXFields);
  Application.Run;
end.
