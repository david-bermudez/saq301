// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://187.191.69.185:8080/ews/services/vba/AuthenticatorService?WSDL
// Encoding : UTF-8
// Codegen  : [wfDebug,wfVerbose,wfSkipHttpBindings,wfSkipUnusedTypes]
// Version  : 1.0
// (22/03/2015 10:01:33 p.m. - $Revision:   1.9.1.0.1.0.1.9  $)
// ************************************************************************ //

unit AuthenticatorService;

interface

uses InvokeRegistry, Types, XSBuiltIns;

type

  RunAs                = class;               
  OperationContext     = class;               
  NameValuePair        = class;               



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
  // Namespace : http://connectivity.service.ews.mincom.com
  // ************************************************************************ //
  NameValuePair = class(TRemotable)
  private
    Fname: String;
    Fvalue: String;
  published
    property name: String read Fname write Fname;
    property value: String read Fvalue write Fvalue;
  end;

  ArrayOfNameValuePair = array of NameValuePair; 

  // ************************************************************************ //
  // Namespace : http://connectivity.service.ews.mincom.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : AuthenticatorServiceHttpBinding
  // service   : AuthenticatorService
  // port      : AuthenticatorServiceHttpPort
  // URL       : http://187.191.69.185:8080/ews/services/vba/AuthenticatorService
  // ************************************************************************ //
  Authenticator = interface(IInvokable)
  ['{F0B62F8B-C9D8-CA13-CBA1-5FDB97B9C368}']
    procedure authenticate(const context: OperationContext); stdcall;
    procedure flush(const context: OperationContext); stdcall;
    function  getDistricts(const context: OperationContext): ArrayOfNameValuePair; stdcall;
    function  getPositions(const context: OperationContext): ArrayOfNameValuePair; stdcall;
  end;

function GetAuthenticator(UseWSDL: Boolean=System.False; Addr: string=''): Authenticator;


implementation
  uses SOAPHTTPClient;

function GetAuthenticator(UseWSDL: Boolean; Addr: string): Authenticator;
const
  defWSDL = 'http://187.191.69.185:8080/ews/services/vba/AuthenticatorService?WSDL';
  defURL  = 'http://187.191.69.185:8080/ews/services/vba/AuthenticatorService';
  defSvc  = 'AuthenticatorService';
  defPrt  = 'AuthenticatorServiceHttpPort';
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
    Result := (RIO as Authenticator);
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

initialization
  InvRegistry.RegisterInterface(TypeInfo(Authenticator), 'http://connectivity.service.ews.mincom.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Authenticator), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Authenticator), ioDocument);
  RemClassRegistry.RegisterXSClass(RunAs, 'http://connectivity.service.ews.mincom.com', 'RunAs');
  RemClassRegistry.RegisterXSClass(OperationContext, 'http://connectivity.service.ews.mincom.com', 'OperationContext');
  RemClassRegistry.RegisterXSClass(NameValuePair, 'http://connectivity.service.ews.mincom.com', 'NameValuePair');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfNameValuePair), 'http://connectivity.service.ews.mincom.com', 'ArrayOfNameValuePair');

end. 