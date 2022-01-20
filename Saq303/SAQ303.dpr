program SAQ303;

uses
  Forms,
  SAQ303001 in 'SAQ303001.pas' {frmSAQ303001MainForm},
  SAQ303002 in 'SAQ303002.pas' {dmSAQ303002DataModule: TDataModule},
  SAQ303003 in 'SAQ303003.pas' {frmSAQ303003AtaxCodes},
  SAQ303004 in 'SAQ303004.pas' {frmSAQ303004Invoice},
  SAQ303005 in 'SAQ303005.pas' {frmSAQ303005AtaxValues},
  SAQ303006 in 'SAQ303006.pas' {dmSAQ303006MIMSX: TDataModule},
  MCObjcts in '..\Common Files\MCObjcts.pas',
  SAQ300005 in '..\..\Common Files\SAQ300005.pas' {frmSAQ300005MIMSXFields},
  MCTypes in '..\..\Common Files\MCTypes.pas',
  MCUtils in '..\..\Common Files\MCUtils.pas',
  SAQ300002 in '..\..\Common Files\SAQ300002.pas',
  SAQ300003 in '..\..\Common Files\SAQ300003.pas' {frmSAQ300003Connecting},
  MCConnct in '..\..\Common Files\MCConnct.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmSAQ303002DataModule, dmSAQ303002DataModule);
  Application.CreateForm(TdmSAQ303006MIMSX, dmSAQ303006MIMSX);
  Application.CreateForm(TfrmSAQ303001MainForm, frmSAQ303001MainForm);
  Application.CreateForm(TfrmSAQ303003AtaxCodes, frmSAQ303003AtaxCodes);
  Application.CreateForm(TfrmSAQ303004Invoice, frmSAQ303004Invoice);
  Application.CreateForm(TfrmSAQ300003Connecting, frmSAQ300003Connecting);
  Application.Run;
end.
