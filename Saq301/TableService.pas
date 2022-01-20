// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://187.191.69.185:8080/ews/services/vba/TableService?WSDL&op=read
// Encoding : UTF-8
// Version  : 1.0
// (26/03/2015 11:11:43 p.m. - $Revision:   1.9.1.0.1.0.1.9  $)
// ************************************************************************ //

unit TableService;

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
  // !:AbstractDTO     - "http://table.ellipse.enterpriseservice.mincom.com"
  // !:AbstractRequiredAttributesDTO - "http://table.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyDTO - "http://table.ellipse.enterpriseservice.mincom.com"

  RunAs                = class;                 { "http://connectivity.service.ews.mincom.com" }
  OperationContext     = class;                 { "http://connectivity.service.ews.mincom.com" }
  TableServiceReadRequiredAttributesDTO = class;   { "http://table.ellipse.enterpriseservice.mincom.com" }
  TableServiceReadRequestDTO = class;           { "http://table.ellipse.enterpriseservice.mincom.com" }
  TableServiceReadReplyDTO = class;             { "http://table.ellipse.enterpriseservice.mincom.com" }



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
  // Namespace : http://table.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  TableServiceReadRequiredAttributesDTO = class(TRemotable)
  private
    FreturnActiveFlag: String;
    FreturnAssociatedRecord: String;
    FreturnCodeDescription: String;
    FreturnDescription: String;
    FreturnLastModifiedBy: String;
    FreturnLastModifiedDate: String;
    FreturnLastModifiedTime: String;
    FreturnQuestCount: String;
    FreturnQuestErrorMsgNo: String;
    FreturnQuestLength: String;
    FreturnQuestMachineType: String;
    FreturnQuestTableLookup: String;
    FreturnStdText: String;
    FreturnStdTextExists: String;
    FreturnTableCode: String;
    FreturnTableType: String;
    FreturnTypeDescription: String;
  published
    property returnActiveFlag: String read FreturnActiveFlag write FreturnActiveFlag;
    property returnAssociatedRecord: String read FreturnAssociatedRecord write FreturnAssociatedRecord;
    property returnCodeDescription: String read FreturnCodeDescription write FreturnCodeDescription;
    property returnDescription: String read FreturnDescription write FreturnDescription;
    property returnLastModifiedBy: String read FreturnLastModifiedBy write FreturnLastModifiedBy;
    property returnLastModifiedDate: String read FreturnLastModifiedDate write FreturnLastModifiedDate;
    property returnLastModifiedTime: String read FreturnLastModifiedTime write FreturnLastModifiedTime;
    property returnQuestCount: String read FreturnQuestCount write FreturnQuestCount;
    property returnQuestErrorMsgNo: String read FreturnQuestErrorMsgNo write FreturnQuestErrorMsgNo;
    property returnQuestLength: String read FreturnQuestLength write FreturnQuestLength;
    property returnQuestMachineType: String read FreturnQuestMachineType write FreturnQuestMachineType;
    property returnQuestTableLookup: String read FreturnQuestTableLookup write FreturnQuestTableLookup;
    property returnStdText: String read FreturnStdText write FreturnStdText;
    property returnStdTextExists: String read FreturnStdTextExists write FreturnStdTextExists;
    property returnTableCode: String read FreturnTableCode write FreturnTableCode;
    property returnTableType: String read FreturnTableType write FreturnTableType;
    property returnTypeDescription: String read FreturnTypeDescription write FreturnTypeDescription;
  end;



  // ************************************************************************ //
  // Namespace : http://table.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  TableServiceReadRequestDTO = class(TRemotable)
  private
    FrequiredAttributes: TableServiceReadRequiredAttributesDTO;
    FtableCode: String;
    FtableType: String;
  public
    destructor Destroy; override;
  published
    property requiredAttributes: TableServiceReadRequiredAttributesDTO read FrequiredAttributes write FrequiredAttributes;
    property tableCode: String read FtableCode write FtableCode;
    property tableType: String read FtableType write FtableType;
  end;



  // ************************************************************************ //
  // Namespace : http://table.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  TableServiceReadReplyDTO = class(TRemotable)
  private
    FactiveFlag: String;
    FassociatedRecord: String;
    FcodeDescription: String;
    Fdescription: String;
    FlastModifiedBy: String;
    FlastModifiedDate: String;
    FlastModifiedTime: String;
    FquestCount: String;
    FquestErrorMsgNo: String;
    FquestLength: String;
    FquestMachineType: String;
    FquestTableLookup: String;
    FstdText: String;
    FstdTextExists: String;
    FtableCode: String;
    FtableType: String;
    FtypeDescription: String;
  published
    property activeFlag: String read FactiveFlag write FactiveFlag;
    property associatedRecord: String read FassociatedRecord write FassociatedRecord;
    property codeDescription: String read FcodeDescription write FcodeDescription;
    property description: String read Fdescription write Fdescription;
    property lastModifiedBy: String read FlastModifiedBy write FlastModifiedBy;
    property lastModifiedDate: String read FlastModifiedDate write FlastModifiedDate;
    property lastModifiedTime: String read FlastModifiedTime write FlastModifiedTime;
    property questCount: String read FquestCount write FquestCount;
    property questErrorMsgNo: String read FquestErrorMsgNo write FquestErrorMsgNo;
    property questLength: String read FquestLength write FquestLength;
    property questMachineType: String read FquestMachineType write FquestMachineType;
    property questTableLookup: String read FquestTableLookup write FquestTableLookup;
    property stdText: String read FstdText write FstdText;
    property stdTextExists: String read FstdTextExists write FstdTextExists;
    property tableCode: String read FtableCode write FtableCode;
    property tableType: String read FtableType write FtableType;
    property typeDescription: String read FtypeDescription write FtypeDescription;
  end;


  // ************************************************************************ //
  // Namespace : http://table.ellipse.enterpriseservice.mincom.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : TableServiceHttpBinding
  // service   : TableService
  // port      : TableServiceHttpPort
  // URL       : http://187.191.69.185:8080/ews/services/vba/TableService
  // ************************************************************************ //
  Table = interface(IInvokable)
  ['{3A5C5FF0-C7A4-2443-395B-1F4BDCEE0A30}']
    function  read(const context: OperationContext; const requestParameters: TableServiceReadRequestDTO): TableServiceReadReplyDTO; stdcall;
  end;

function GetTable(UseWSDL: Boolean=System.False; Addr: string=''): Table;


implementation
  uses SOAPHTTPClient;

function GetTable(UseWSDL: Boolean; Addr: string): Table;
const
  defWSDL = 'http://187.191.69.185:8080/ews/services/vba/TableService?WSDL&op=read';
  defURL  = 'http://187.191.69.185:8080/ews/services/vba/TableService';
  defSvc  = 'TableService';
  defPrt  = 'TableServiceHttpPort';
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
    Result := (RIO as Table);
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

destructor TableServiceReadRequestDTO.Destroy;
begin
  if Assigned(FrequiredAttributes) then
    FrequiredAttributes.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(Table), 'http://table.ellipse.enterpriseservice.mincom.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Table), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Table), ioDocument);
  RemClassRegistry.RegisterXSClass(RunAs, 'http://connectivity.service.ews.mincom.com', 'RunAs');
  RemClassRegistry.RegisterXSClass(OperationContext, 'http://connectivity.service.ews.mincom.com', 'OperationContext');
  RemClassRegistry.RegisterXSClass(TableServiceReadRequiredAttributesDTO, 'http://table.ellipse.enterpriseservice.mincom.com', 'TableServiceReadRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(TableServiceReadRequestDTO, 'http://table.ellipse.enterpriseservice.mincom.com', 'TableServiceReadRequestDTO');
  RemClassRegistry.RegisterXSClass(TableServiceReadReplyDTO, 'http://table.ellipse.enterpriseservice.mincom.com', 'TableServiceReadReplyDTO');

end. 