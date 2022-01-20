// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://187.191.69.185:8080/ews/services/vba/SecurityService?WSDL&op=retrieveAppSec
// Encoding : UTF-8
// Version  : 1.0
// (24/03/2015 10:26:16 p.m. - $Revision:   1.9.1.0.1.0.1.9  $)
// ************************************************************************ //

unit SecurityService;

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
  // !:AbstractDTO     - "http://security.ellipse.enterpriseservice.mincom.com"
  // !:AbstractRequiredAttributesDTO - "http://security.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyCollectionDTO - "http://security.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyDTO - "http://security.ellipse.enterpriseservice.mincom.com"

  RunAs                = class;                 { "http://connectivity.service.ews.mincom.com" }
  OperationContext     = class;                 { "http://connectivity.service.ews.mincom.com" }
  SecurityServiceRetrieveAppSecRequestDTO = class;   { "http://security.ellipse.enterpriseservice.mincom.com" }
  SecurityServiceRetrieveAppSecRequiredAttributesDTO = class;   { "http://security.ellipse.enterpriseservice.mincom.com" }
  SecurityServiceRetrieveAppSecReplyDTO = class;   { "http://security.ellipse.enterpriseservice.mincom.com" }
  SecurityServiceRetrieveAppSecReplyCollectionDTO = class;   { "http://security.ellipse.enterpriseservice.mincom.com" }



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
  // Namespace : http://security.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  SecurityServiceRetrieveAppSecRequestDTO = class(TRemotable)
  private
    FappName: String;
    FappType: String;
    FdistrictCode: String;
  published
    property appName: String read FappName write FappName;
    property appType: String read FappType write FappType;
    property districtCode: String read FdistrictCode write FdistrictCode;
  end;



  // ************************************************************************ //
  // Namespace : http://security.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  SecurityServiceRetrieveAppSecRequiredAttributesDTO = class(TRemotable)
  private
    FreturnAccessLevel: String;
    FreturnClassAttribute: String;
    FreturnClassMethod: String;
    FreturnClassName: String;
    FreturnDistrictCode: String;
    FreturnErrorFlag: String;
    FreturnFetchRetrFlag: String;
    FreturnRefCodeEntity: String;
  published
    property returnAccessLevel: String read FreturnAccessLevel write FreturnAccessLevel;
    property returnClassAttribute: String read FreturnClassAttribute write FreturnClassAttribute;
    property returnClassMethod: String read FreturnClassMethod write FreturnClassMethod;
    property returnClassName: String read FreturnClassName write FreturnClassName;
    property returnDistrictCode: String read FreturnDistrictCode write FreturnDistrictCode;
    property returnErrorFlag: String read FreturnErrorFlag write FreturnErrorFlag;
    property returnFetchRetrFlag: String read FreturnFetchRetrFlag write FreturnFetchRetrFlag;
    property returnRefCodeEntity: String read FreturnRefCodeEntity write FreturnRefCodeEntity;
  end;



  // ************************************************************************ //
  // Namespace : http://security.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  SecurityServiceRetrieveAppSecReplyDTO = class(TRemotable)
  private
    FaccessLevel: String;
    FclassAttribute: String;
    FclassMethod: String;
    FclassName: String;
    FdistrictCode: String;
    FerrorFlag: String;
    FfetchRetrFlag: String;
    FrefCodeEntity: String;
  published
    property accessLevel: String read FaccessLevel write FaccessLevel;
    property classAttribute: String read FclassAttribute write FclassAttribute;
    property classMethod: String read FclassMethod write FclassMethod;
    property className: String read FclassName write FclassName;
    property districtCode: String read FdistrictCode write FdistrictCode;
    property errorFlag: String read FerrorFlag write FerrorFlag;
    property fetchRetrFlag: String read FfetchRetrFlag write FfetchRetrFlag;
    property refCodeEntity: String read FrefCodeEntity write FrefCodeEntity;
  end;

  ArrayOfSecurityServiceRetrieveAppSecReplyDTO = array of SecurityServiceRetrieveAppSecReplyDTO;   { "http://security.ellipse.enterpriseservice.mincom.com" }


  // ************************************************************************ //
  // Namespace : http://security.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  SecurityServiceRetrieveAppSecReplyCollectionDTO = class(TRemotable)
  private
    FreplyElements: ArrayOfSecurityServiceRetrieveAppSecReplyDTO;
  public
    destructor Destroy; override;
  published
    property replyElements: ArrayOfSecurityServiceRetrieveAppSecReplyDTO read FreplyElements write FreplyElements;
  end;


  // ************************************************************************ //
  // Namespace : http://security.ellipse.enterpriseservice.mincom.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : SecurityServiceHttpBinding
  // service   : SecurityService
  // port      : SecurityServiceHttpPort
  // URL       : http://187.191.69.185:8080/ews/services/vba/SecurityService
  // ************************************************************************ //
  Security = interface(IInvokable)
  ['{68141DB0-DCD0-2BB1-285C-BDF82FC9AE4E}']
    function  retrieveAppSec(const context: OperationContext; const requestParameters: SecurityServiceRetrieveAppSecRequestDTO; const requiredAttributes: SecurityServiceRetrieveAppSecRequiredAttributesDTO; const restartInfo: String): SecurityServiceRetrieveAppSecReplyCollectionDTO; stdcall;
  end;

function GetSecurity(UseWSDL: Boolean=System.False; Addr: string=''): Security;


implementation
  uses SOAPHTTPClient;

function GetSecurity(UseWSDL: Boolean; Addr: string): Security;
const
  defWSDL = 'http://187.191.69.185:8080/ews/services/vba/SecurityService?WSDL&op=retrieveAppSec';
  defURL  = 'http://187.191.69.185:8080/ews/services/vba/SecurityService';
  defSvc  = 'SecurityService';
  defPrt  = 'SecurityServiceHttpPort';
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
    Result := (RIO as Security);
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

destructor SecurityServiceRetrieveAppSecReplyCollectionDTO.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FreplyElements)-1 do
    if Assigned(FreplyElements[I]) then
      FreplyElements[I].Free;
  SetLength(FreplyElements, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(Security), 'http://security.ellipse.enterpriseservice.mincom.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Security), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Security), ioDocument);
  RemClassRegistry.RegisterXSClass(RunAs, 'http://connectivity.service.ews.mincom.com', 'RunAs');
  RemClassRegistry.RegisterXSClass(OperationContext, 'http://connectivity.service.ews.mincom.com', 'OperationContext');
  RemClassRegistry.RegisterXSClass(SecurityServiceRetrieveAppSecRequestDTO, 'http://security.ellipse.enterpriseservice.mincom.com', 'SecurityServiceRetrieveAppSecRequestDTO');
  RemClassRegistry.RegisterXSClass(SecurityServiceRetrieveAppSecRequiredAttributesDTO, 'http://security.ellipse.enterpriseservice.mincom.com', 'SecurityServiceRetrieveAppSecRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(SecurityServiceRetrieveAppSecReplyDTO, 'http://security.ellipse.enterpriseservice.mincom.com', 'SecurityServiceRetrieveAppSecReplyDTO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfSecurityServiceRetrieveAppSecReplyDTO), 'http://security.ellipse.enterpriseservice.mincom.com', 'ArrayOfSecurityServiceRetrieveAppSecReplyDTO');
  RemClassRegistry.RegisterXSClass(SecurityServiceRetrieveAppSecReplyCollectionDTO, 'http://security.ellipse.enterpriseservice.mincom.com', 'SecurityServiceRetrieveAppSecReplyCollectionDTO');

end. 