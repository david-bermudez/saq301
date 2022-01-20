// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/RefCodesService?WSDL&op=modify
// Encoding : UTF-8
// Version  : 1.0
// (06/06/2015 10:56:07 a.m. - $Revision:   1.9.1.0.1.0.1.9  $)
// ************************************************************************ //

unit RefCodesService;

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
  // !:AbstractDTO     - "http://refcodes.ellipse.enterpriseservice.mincom.com"
  // !:AbstractRequiredAttributesDTO - "http://refcodes.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyDTO - "http://refcodes.ellipse.enterpriseservice.mincom.com"

  RunAs                = class;                 { "http://connectivity.service.ews.mincom.com" }
  OperationContext     = class;                 { "http://connectivity.service.ews.mincom.com" }
  RefCodesServiceModifyRequiredAttributesDTO = class;   { "http://refcodes.ellipse.enterpriseservice.mincom.com" }
  RefCodesServiceModifyRequestDTO = class;      { "http://refcodes.ellipse.enterpriseservice.mincom.com" }
  RefCodesServiceModifyReplyDTO = class;        { "http://refcodes.ellipse.enterpriseservice.mincom.com" }



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
  // Namespace : http://refcodes.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  RefCodesServiceModifyRequiredAttributesDTO = class(TRemotable)
  private
    FreturnEntityValue: String;
    FreturnRefCode: String;
    FreturnRefCodeDesc: String;
    FreturnStdTxtKey: String;
  published
    property returnEntityValue: String read FreturnEntityValue write FreturnEntityValue;
    property returnRefCode: String read FreturnRefCode write FreturnRefCode;
    property returnRefCodeDesc: String read FreturnRefCodeDesc write FreturnRefCodeDesc;
    property returnStdTxtKey: String read FreturnStdTxtKey write FreturnStdTxtKey;
  end;



  // ************************************************************************ //
  // Namespace : http://refcodes.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  RefCodesServiceModifyRequestDTO = class(TRemotable)
  private
    FentityType: String;
    FentityValue: String;
    FrefCode: String;
    FrefNo: String;
    FrequiredAttributes: RefCodesServiceModifyRequiredAttributesDTO;
    FseqNum: String;
    FstdTxtKey: String;
  public
    destructor Destroy; override;
  published
    property entityType: String read FentityType write FentityType;
    property entityValue: String read FentityValue write FentityValue;
    property refCode: String read FrefCode write FrefCode;
    property refNo: String read FrefNo write FrefNo;
    property requiredAttributes: RefCodesServiceModifyRequiredAttributesDTO read FrequiredAttributes write FrequiredAttributes;
    property seqNum: String read FseqNum write FseqNum;
    property stdTxtKey: String read FstdTxtKey write FstdTxtKey;
  end;



  // ************************************************************************ //
  // Namespace : http://refcodes.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  RefCodesServiceModifyReplyDTO = class(TRemotable)
  private
    FentityValue: String;
    FrefCode: String;
    FrefCodeDesc: String;
    FstdTxtKey: String;
  published
    property entityValue: String read FentityValue write FentityValue;
    property refCode: String read FrefCode write FrefCode;
    property refCodeDesc: String read FrefCodeDesc write FrefCodeDesc;
    property stdTxtKey: String read FstdTxtKey write FstdTxtKey;
  end;


  // ************************************************************************ //
  // Namespace : http://refcodes.ellipse.enterpriseservice.mincom.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : RefCodesServiceHttpBinding
  // service   : RefCodesService
  // port      : RefCodesServiceHttpPort
  // URL       : http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/RefCodesService
  // ************************************************************************ //
  RefCodes = interface(IInvokable)
  ['{C76F5096-1C8A-3747-4AFC-556D7B429ABD}']
    function  modify(const context: OperationContext; const requestParameters: RefCodesServiceModifyRequestDTO): RefCodesServiceModifyReplyDTO; stdcall;
  end;

function GetRefCodes(UseWSDL: Boolean=System.False; Addr: string=''): RefCodes;


implementation
  uses SOAPHTTPClient;

function GetRefCodes(UseWSDL: Boolean; Addr: string): RefCodes;
const
  defWSDL = 'http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/RefCodesService?WSDL&op=modify';
  defURL  = 'http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/RefCodesService';
  defSvc  = 'RefCodesService';
  defPrt  = 'RefCodesServiceHttpPort';
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
    Result := (RIO as RefCodes);
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

destructor RefCodesServiceModifyRequestDTO.Destroy;
begin
  if Assigned(FrequiredAttributes) then
    FrequiredAttributes.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(RefCodes), 'http://refcodes.ellipse.enterpriseservice.mincom.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RefCodes), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RefCodes), ioDocument);
  RemClassRegistry.RegisterXSClass(RunAs, 'http://connectivity.service.ews.mincom.com', 'RunAs');
  RemClassRegistry.RegisterXSClass(OperationContext, 'http://connectivity.service.ews.mincom.com', 'OperationContext');
  RemClassRegistry.RegisterXSClass(RefCodesServiceModifyRequiredAttributesDTO, 'http://refcodes.ellipse.enterpriseservice.mincom.com', 'RefCodesServiceModifyRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(RefCodesServiceModifyRequestDTO, 'http://refcodes.ellipse.enterpriseservice.mincom.com', 'RefCodesServiceModifyRequestDTO');
  RemClassRegistry.RegisterXSClass(RefCodesServiceModifyReplyDTO, 'http://refcodes.ellipse.enterpriseservice.mincom.com', 'RefCodesServiceModifyReplyDTO');

end. 