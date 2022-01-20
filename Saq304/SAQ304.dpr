program SAQ304;
{
      *** Revision History ***
      *** 17-Feb-05 wvidela    IC637
      *** .................... Se modifica una linea del procedimiento BtnGenerarClick del
      *** .................... modulo SAQ301001.
}
uses
  Forms,
  SAQ304001 in 'SAQ304001.pas' {FRMSAQ304001ACT},
  MCTypes in 'MCTypes.pas',
  MCUtils in 'MCUtils.pas',
  SAQ300002 in 'SAQ300002.pas',
  SAQ300003 in 'SAQ300003.pas' {frmSAQ300003Connecting},
  MCDMActs in 'MCDMActs.pas' {dmActs: TDataModule};
{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmActs, dmActs);
  Application.CreateForm(TFRMSAQ304001ACT, FRMSAQ304001ACT);
  Application.CreateForm(TfrmSAQ300003Connecting, frmSAQ300003Connecting);
  Application.Run;
end.
