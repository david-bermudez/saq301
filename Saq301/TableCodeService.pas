// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ews-el8desa.lmnerp03.cerrejon.com/ews/services/vba/TableCodeService?WSDL&op=read
// Encoding : UTF-8
// Version  : 1.0
// (13/04/2015 09:42:42 p.m. - $Revision:   1.9.1.0.1.0.1.9  $)
// ************************************************************************ //

unit TableCodeService;

interface

uses InvokeRegistry, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:ServiceDTO      - "http://instances.m3001.types.ellipse.mincom.com"
  // !:ServiceResult   - "http://instances.m3001.types.ellipse.mincom.com"

  RunAs                = class;                 { "http://connectivity.service.ews.mincom.com" }
  OperationContext     = class;                 { "http://connectivity.service.ews.mincom.com" }
  TableCodeDTO         = class;                 { "http://instances.m3001.types.ellipse.mincom.com" }
  TableCodeServiceResult = class;               { "http://instances.m3001.types.ellipse.mincom.com" }



  // ************************************************************************ //
  // Namespace : http://connectivity.service.ews.mincom.com
  // ************************************************************************ //
  RunAs = class(TRemotable)
  private
    Fdistrict: String;
    Fposition: String;
    Fuser: String;
  published
    property district: String read Fdistrict write Fdistrict;
    property position: String read Fposition write Fposition;
    property user: String read Fuser write Fuser;
  end;



  // ************************************************************************ //
  // Namespace : http://connectivity.service.ews.mincom.com
  // ************************************************************************ //
  OperationContext = class(TRemotable)
  private
    Fdistrict: String;
    FmaxInstances: String;
    Fposition: String;
    FreturnWarnings: String;
    FrunAs: RunAs;
    Ftrace: String;
    Ftransaction: String;
  public
    destructor Destroy; override;
  published
    property district: String read Fdistrict write Fdistrict;
    property maxInstances: String read FmaxInstances write FmaxInstances;
    property position: String read Fposition write Fposition;
    property returnWarnings: String read FreturnWarnings write FreturnWarnings;
    property runAs: RunAs read FrunAs write FrunAs;
    property trace: String read Ftrace write Ftrace;
    property transaction: String read Ftransaction write Ftransaction;
  end;



  // ************************************************************************ //
  // Namespace : http://instances.m3001.types.ellipse.mincom.com
  // ************************************************************************ //
  TableCodeDTO = class(TRemotable)
  private
    FactiveFlag: String;
    FassociatedRecord: String;
    FtableCode: String;
    FtableDescription: String;
    FtableType: String;
  published
    property activeFlag: String read FactiveFlag write FactiveFlag;
    property associatedRecord: String read FassociatedRecord write FassociatedRecord;
    property tableCode: String read FtableCode write FtableCode;
    property tableDescription: String read FtableDescription write FtableDescription;
    property tableType: String read FtableType write FtableType;
  end;



  // ************************************************************************ //
  // Namespace : http://instances.m3001.types.ellipse.mincom.com
  // ************************************************************************ //
  TableCodeServiceResult = class(TRemotable)
  private
    FtableCodeDTO: TableCodeDTO;
  public
    destructor Destroy; override;
  published
    property tableCodeDTO: TableCodeDTO read FtableCodeDTO write FtableCodeDTO;
  end;


  // ************************************************************************ //
  // Namespace : http://tablecode.m3001.service.ellipse.mincom.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : TableCodeServiceHttpBinding
  // service   : TableCodeService
  // port      : TableCodeServiceHttpPort
  // URL       : http://ews-el8desa.lmnerp03.cerrejon.com/ews/services/vba/TableCodeService
  // ************************************************************************ //
  TableCode = interface(IInvokable)
  ['{FB7360DE-30FA-63B7-E630-FF9BEA353FFF}']
    function  read(const context: OperationContext; const serviceDTO: TableCodeDTO): TableCodeServiceResult; stdcall;
  end;

function GetTableCode(UseWSDL: Boolean=System.False; Addr: string=''): TableCode;


implementation
  uses SOAPHTTPClient;

function GetTableCode(UseWSDL: Boolean; Addr: string): TableCode;
const
  defWSDL = 'http://ews-el8desa.lmnerp03.cerrejon.com/ews/services/vba/TableCodeService?WSDL&op=read';
  defURL  = 'http://ews-el8desa.lmnerp03.cerrejon.com/ews/services/vba/TableCodeService';
  defSvc  = 'TableCodeService';
  defPrt  = 'TableCodeServiceHttpPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  RIO := THTTPRIO.Create(nil);
  try
     if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
    Result := (RIO as TableCode);
  finally
    if Result = nil then
      RIO.Free;
  end;
end;


destructor OperationContext.Destroy;
begin
  if Assigned(FrunAs) then
    FrunAs.Free;
  inherited Destroy;
end;

destructor TableCodeServiceResult.Destroy;
begin
  if Assigned(FtableCodeDTO) then
    FtableCodeDTO.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(TableCode), 'http://tablecode.m3001.service.ellipse.mincom.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(TableCode), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(TableCode), ioDocument);
  RemClassRegistry.RegisterXSClass(RunAs, 'http://connectivity.service.ews.mincom.com', 'RunAs');
  RemClassRegistry.RegisterXSClass(OperationContext, 'http://connectivity.service.ews.mincom.com', 'OperationContext');
  RemClassRegistry.RegisterXSClass(TableCodeDTO, 'http://instances.m3001.types.ellipse.mincom.com', 'TableCodeDTO');
  RemClassRegistry.RegisterXSClass(TableCodeServiceResult, 'http://instances.m3001.types.ellipse.mincom.com', 'TableCodeServiceResult');

end. 