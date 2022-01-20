program SAQ301;
{
*** Revision History ***
*** 21-Jun-10 DBermu IC1136
*** ................. Se agrego la condicion Discount_Flag = 'N' al DataSet
*** ................. SQLRestaValor para obtener el Valor Bruto del Acta.
*** 03-Oct-08 CR2290 IC1015
*** ................. TdmActs.ValidateBySignedPortion muestra el error ME_037
*** ................. -apesar que EditedValue y MaxValue tiene el mismo valor.
*** ................. Esto ocurre ya que las variables estan definidas como currency,
*** ................. tipo que en Delphi es trabajado con 4 decimales, y los indicados
*** ................. solo trabajan con 2 decimales.
*** ................. Pero Delphi siempre calcula los cuatro decimales, generando
*** ................. diferencias de 0.0001 que originan injustificadamente el mensaje
*** ................. de Error.
*** ................. Se agrega validacion adicional en:
*** ................. TdmActs.ValidateByPortion
*** ................. TdmActs.ValidateByContract
*** ................. ValidateBySignedContract.
*** 03-Oct-08 CR2290 IC1015
*** ................. Se ha eliminado del Obejto SQLRestaValor el filtro
*** ................. Discount_Flag = 'N', ya que esto excluia los
*** ................. descuentos/registros que tuvieran el valor Discount_Flag ='Y'
*** 09-Jun-05 WVIDELA IC668 ICOR1
*** ................. Se aplican cambios realizados por Javier de Moya, estos tienen
*** ................. relacion con disponibilidad de porcion.
*** 01-Abr-05 WVIDELA IC658 ICOR1
*** ................. Si valida que el centro de costo este asociado al proyecto.
*** .................  -Se modifica el procedure ValidateProject
*** .................  -Se agrega mensaje de error ME214
*** 21-Feb-05 WVIDELA IC633 ICOR1
*** ................. Si MSF966.PROJ_ENTRY_IND = 'M' de debe especificar el proyecto
}
uses
  Forms,
  SAQ301001 in 'SAQ301001.pas' {frmSAQ301001Main},
  SAQ301002 in 'SAQ301002.pas' {frmSAQ301002NewAct},
  SAQ301003 in 'SAQ301003.pas' {frmSAQ301003CostCenters},
  SAQ301004 in 'SAQ301004.pas' {frmSAQ301004Approve},
  SAQ301005 in 'SAQ301005.pas' {frmSAQ301005ActPaid},
  SAQ301006 in 'SAQ301006.pas' {frmSAQ301006InfoAtax},
  SAQ301007 in 'SAQ301007.pas' {frmSAQ301007SelectContracts},
  SAQ301008 in 'SAQ301008.pas' {frmSAQ301008Suppliers},
  SAQ301009 in 'SAQ301009.pas' {frmSAQ301009ParentReports},
  SAQ301010 in 'SAQ301010.pas' {frmSAQ301010QRActPaid},
  SAQ301011 in 'SAQ301011.pas' {frmSAQ301011QRRep01},
  SAQ301012 in 'SAQ301012.pas' {frmSAQ301012QRRep02},
  SAQ301013 in 'SAQ301013.pas' {frmSAQ301013QRRep03},
  SAQ301014 in 'SAQ301014.pas' {frmSAQ301014QRRep04},
  SAQ301015 in 'SAQ301015.pas' {frmSAQ301015QRAPSummary},
  SAQ300002 in '..\Common Files\SAQ300002.pas',
  SAQ300003 in '..\Common Files\SAQ300003.pas' {frmSAQ300003Connecting},
  SAQ300005 in '..\Common Files\SAQ300005.pas' {frmSAQ300005MIMSXFields},
  SAQ300007 in '..\Common Files\SAQ300007.pas' {frmGen03Profiles},
  MCObjcts  in '..\Common Files\MCObjcts.pas',
  MCTypes   in '..\Common Files\MCTypes.pas',
  MCUtils   in '..\Common Files\MCUtils.pas',
  MCConnct  in '..\Common Files\MCConnct.pas',
  MCDMActs  in 'MCDMActs.pas' {dmActs: TDataModule},
  MCAbout   in 'MCAbout.pas' {FrmAbout},
  SAQTypes  in '..\Common Files\SAQTypes.pas',
  SAQUtils  in '..\Common Files\SAQUtils.pas',
  SecurityService        in 'SecurityService.pas',
  TableService           in 'TableService.pas',
  TableCodeService       in 'TableCodeService.pas',
  AuthenticatorService   in 'AuthenticatorService.pas';
  {RefCodesService        in 'RefCodesService.pas',}
  {ValuationsService      in 'ValuationsService.pas',}
  {ContractCostingService in 'ContractCostingService.pas';}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmActs, dmActs);
  Application.CreateForm(TfrmSAQ301001Main, frmSAQ301001Main);
  Application.CreateForm(TfrmSAQ301008Suppliers, frmSAQ301008Suppliers);
  Application.CreateForm(TfrmSAQ300003Connecting, frmSAQ300003Connecting);
  Application.CreateForm(TfrmSAQ300005MIMSXFields, frmSAQ300005MIMSXFields);
  Application.Run;
end.
