// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://187.191.69.185:8080/ews/services/vba/ContractCostingService?WSDL&op=multipleCreate&op=multipleDelete
// Encoding : UTF-8
// Version  : 1.0
// (20/06/2015 09:41:45 a.m. - $Revision:   1.9.1.0.1.0.1.9  $)
// ************************************************************************ //

unit ContractCostingService;

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
  // !:AbstractDTO     - "http://contractcosting.ellipse.enterpriseservice.mincom.com"
  // !:AbstractRequiredAttributesDTO - "http://contractcosting.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyCollectionDTO - "http://contractcosting.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyDTO - "http://contractcosting.ellipse.enterpriseservice.mincom.com"

  RunAs                = class;                 { "http://connectivity.service.ews.mincom.com" }
  OperationContext     = class;                 { "http://connectivity.service.ews.mincom.com" }
  WorkOrderDTO         = class;                 { "http://dto.dependant.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceDeleteRequiredAttributesDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceDeleteRequestDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceDeleteReplyDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceDeleteReplyCollectionDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceCreateRequiredAttributesDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceCreateRequestDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceCreateReplyDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }
  ContractCostingServiceCreateReplyCollectionDTO = class;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }



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
  // Namespace : http://dto.dependant.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  WorkOrderDTO = class(TRemotable)
  private
    Fprefix: String;
    Fno: String;
  published
    property prefix: String read Fprefix write Fprefix;
    property no: String read Fno write Fno;
  end;



  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceDeleteRequiredAttributesDTO = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceDeleteRequestDTO = class(TRemotable)
  private
    FallocCount: String;
    FcategoryNo: String;
    FcontractNo: String;
    FcostingInd: String;
    Felement: String;
    Fportion: String;
    FrequiredAttributes: ContractCostingServiceDeleteRequiredAttributesDTO;
    FvaluationNo: String;
  public
    destructor Destroy; override;
  published
    property allocCount: String read FallocCount write FallocCount;
    property categoryNo: String read FcategoryNo write FcategoryNo;
    property contractNo: String read FcontractNo write FcontractNo;
    property costingInd: String read FcostingInd write FcostingInd;
    property element: String read Felement write Felement;
    property portion: String read Fportion write Fportion;
    property requiredAttributes: ContractCostingServiceDeleteRequiredAttributesDTO read FrequiredAttributes write FrequiredAttributes;
    property valuationNo: String read FvaluationNo write FvaluationNo;
  end;

  ArrayOfContractCostingServiceDeleteRequestDTO = array of ContractCostingServiceDeleteRequestDTO;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }


  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceDeleteReplyDTO = class(TRemotable)
  private
  published
  end;

  ArrayOfContractCostingServiceDeleteReplyDTO = array of ContractCostingServiceDeleteReplyDTO;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }


  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceDeleteReplyCollectionDTO = class(TRemotable)
  private
    FreplyElements: ArrayOfContractCostingServiceDeleteReplyDTO;
  public
    destructor Destroy; override;
  published
    property replyElements: ArrayOfContractCostingServiceDeleteReplyDTO read FreplyElements write FreplyElements;
  end;



  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceCreateRequiredAttributesDTO = class(TRemotable)
  private
    FreturnAccountCode: String;
    FreturnAccountCodeDescription: String;
    FreturnAllocCount: String;
    FreturnAllocatedPercent: String;
    FreturnAllocatedValue: String;
    FreturnAllocationDistrict: String;
    FreturnContractNo: String;
    FreturnCostingInd: String;
    FreturnElement: String;
    FreturnEquipmentNo: String;
    FreturnEquipmentNoDescription: String;
    FreturnEquipmentRef: String;
    FreturnPortion: String;
    FreturnProject: String;
    FreturnProjectDescription: String;
    FreturnValuationNo: String;
    FreturnWorkOrder: String;
    FreturnWorkOrderDescription: String;
  published
    property returnAccountCode: String read FreturnAccountCode write FreturnAccountCode;
    property returnAccountCodeDescription: String read FreturnAccountCodeDescription write FreturnAccountCodeDescription;
    property returnAllocCount: String read FreturnAllocCount write FreturnAllocCount;
    property returnAllocatedPercent: String read FreturnAllocatedPercent write FreturnAllocatedPercent;
    property returnAllocatedValue: String read FreturnAllocatedValue write FreturnAllocatedValue;
    property returnAllocationDistrict: String read FreturnAllocationDistrict write FreturnAllocationDistrict;
    property returnContractNo: String read FreturnContractNo write FreturnContractNo;
    property returnCostingInd: String read FreturnCostingInd write FreturnCostingInd;
    property returnElement: String read FreturnElement write FreturnElement;
    property returnEquipmentNo: String read FreturnEquipmentNo write FreturnEquipmentNo;
    property returnEquipmentNoDescription: String read FreturnEquipmentNoDescription write FreturnEquipmentNoDescription;
    property returnEquipmentRef: String read FreturnEquipmentRef write FreturnEquipmentRef;
    property returnPortion: String read FreturnPortion write FreturnPortion;
    property returnProject: String read FreturnProject write FreturnProject;
    property returnProjectDescription: String read FreturnProjectDescription write FreturnProjectDescription;
    property returnValuationNo: String read FreturnValuationNo write FreturnValuationNo;
    property returnWorkOrder: String read FreturnWorkOrder write FreturnWorkOrder;
    property returnWorkOrderDescription: String read FreturnWorkOrderDescription write FreturnWorkOrderDescription;
  end;



  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceCreateRequestDTO = class(TRemotable)
  private
    FaccountCode: String;
    FallocCount: String;
    FallocatedPercent: String;
    FallocatedValue: String;
    FallocationDistrict: String;
    FcategoryNo: String;
    FcontractNo: String;
    FcostingInd: String;
    Felement: String;
    FequipmentNo: String;
    FequipmentRef: String;
    Fportion: String;
    Fproject: String;
    FrequiredAttributes: ContractCostingServiceCreateRequiredAttributesDTO;
    FvaluationNo: String;
    FworkOrder: WorkOrderDTO;
  public
    destructor Destroy; override;
  published
    property accountCode: String read FaccountCode write FaccountCode;
    property allocCount: String read FallocCount write FallocCount;
    property allocatedPercent: String read FallocatedPercent write FallocatedPercent;
    property allocatedValue: String read FallocatedValue write FallocatedValue;
    property allocationDistrict: String read FallocationDistrict write FallocationDistrict;
    property categoryNo: String read FcategoryNo write FcategoryNo;
    property contractNo: String read FcontractNo write FcontractNo;
    property costingInd: String read FcostingInd write FcostingInd;
    property element: String read Felement write Felement;
    property equipmentNo: String read FequipmentNo write FequipmentNo;
    property equipmentRef: String read FequipmentRef write FequipmentRef;
    property portion: String read Fportion write Fportion;
    property project: String read Fproject write Fproject;
    property requiredAttributes: ContractCostingServiceCreateRequiredAttributesDTO read FrequiredAttributes write FrequiredAttributes;
    property valuationNo: String read FvaluationNo write FvaluationNo;
    property workOrder: WorkOrderDTO read FworkOrder write FworkOrder;
  end;

  ArrayOfContractCostingServiceCreateRequestDTO = array of ContractCostingServiceCreateRequestDTO;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }


  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceCreateReplyDTO = class(TRemotable)
  private
    FaccountCode: String;
    FaccountCodeDescription: String;
    FallocCount: String;
    FallocatedPercent: String;
    FallocatedValue: String;
    FallocationDistrict: String;
    FcontractNo: String;
    FcostingInd: String;
    Felement: String;
    FequipmentNo: String;
    FequipmentNoDescription: String;
    FequipmentRef: String;
    Fportion: String;
    Fproject: String;
    FprojectDescription: String;
    FvaluationNo: String;
    FworkOrder: WorkOrderDTO;
    FworkOrderDescription: String;
  public
    destructor Destroy; override;
  published
    property accountCode: String read FaccountCode write FaccountCode;
    property accountCodeDescription: String read FaccountCodeDescription write FaccountCodeDescription;
    property allocCount: String read FallocCount write FallocCount;
    property allocatedPercent: String read FallocatedPercent write FallocatedPercent;
    property allocatedValue: String read FallocatedValue write FallocatedValue;
    property allocationDistrict: String read FallocationDistrict write FallocationDistrict;
    property contractNo: String read FcontractNo write FcontractNo;
    property costingInd: String read FcostingInd write FcostingInd;
    property element: String read Felement write Felement;
    property equipmentNo: String read FequipmentNo write FequipmentNo;
    property equipmentNoDescription: String read FequipmentNoDescription write FequipmentNoDescription;
    property equipmentRef: String read FequipmentRef write FequipmentRef;
    property portion: String read Fportion write Fportion;
    property project: String read Fproject write Fproject;
    property projectDescription: String read FprojectDescription write FprojectDescription;
    property valuationNo: String read FvaluationNo write FvaluationNo;
    property workOrder: WorkOrderDTO read FworkOrder write FworkOrder;
    property workOrderDescription: String read FworkOrderDescription write FworkOrderDescription;
  end;

  ArrayOfContractCostingServiceCreateReplyDTO = array of ContractCostingServiceCreateReplyDTO;   { "http://contractcosting.ellipse.enterpriseservice.mincom.com" }


  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ContractCostingServiceCreateReplyCollectionDTO = class(TRemotable)
  private
    FreplyElements: ArrayOfContractCostingServiceCreateReplyDTO;
  public
    destructor Destroy; override;
  published
    property replyElements: ArrayOfContractCostingServiceCreateReplyDTO read FreplyElements write FreplyElements;
  end;


  // ************************************************************************ //
  // Namespace : http://contractcosting.ellipse.enterpriseservice.mincom.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : ContractCostingServiceHttpBinding
  // service   : ContractCostingService
  // port      : ContractCostingServiceHttpPort
  // URL       : http://187.191.69.185:8080/ews/services/vba/ContractCostingService
  // ************************************************************************ //
  ContractCosting = interface(IInvokable)
  ['{B3103E14-24FF-1020-FFFF-B314F418E8B2}']
    function  multipleDelete(const context: OperationContext; const requestParameters: ArrayOfContractCostingServiceDeleteRequestDTO): ContractCostingServiceDeleteReplyCollectionDTO; stdcall;
    function  multipleCreate(const context: OperationContext; const requestParameters: ArrayOfContractCostingServiceCreateRequestDTO): ContractCostingServiceCreateReplyCollectionDTO; stdcall;
  end;

function GetContractCosting(UseWSDL: Boolean=System.False; Addr: string=''): ContractCosting;


implementation
  uses SOAPHTTPClient;

function GetContractCosting(UseWSDL: Boolean; Addr: string): ContractCosting;
const
  defWSDL = 'http://187.191.69.185:8080/ews/services/vba/ContractCostingService?WSDL&op=multipleCreate&op=multipleDelete';
  defURL  = 'http://187.191.69.185:8080/ews/services/vba/ContractCostingService';
  defSvc  = 'ContractCostingService';
  defPrt  = 'ContractCostingServiceHttpPort';
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
    Result := (RIO as ContractCosting);
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

destructor ContractCostingServiceDeleteRequestDTO.Destroy;
begin
  if Assigned(FrequiredAttributes) then
    FrequiredAttributes.Free;
  inherited Destroy;
end;

destructor ContractCostingServiceDeleteReplyCollectionDTO.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FreplyElements)-1 do
    if Assigned(FreplyElements[I]) then
      FreplyElements[I].Free;
  SetLength(FreplyElements, 0);
  inherited Destroy;
end;

destructor ContractCostingServiceCreateRequestDTO.Destroy;
begin
  if Assigned(FrequiredAttributes) then
    FrequiredAttributes.Free;
  if Assigned(FworkOrder) then
    FworkOrder.Free;
  inherited Destroy;
end;

destructor ContractCostingServiceCreateReplyDTO.Destroy;
begin
  if Assigned(FworkOrder) then
    FworkOrder.Free;
  inherited Destroy;
end;

destructor ContractCostingServiceCreateReplyCollectionDTO.Destroy;
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
  InvRegistry.RegisterInterface(TypeInfo(ContractCosting), 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ContractCosting), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ContractCosting), ioDocument);
  RemClassRegistry.RegisterXSClass(RunAs, 'http://connectivity.service.ews.mincom.com', 'RunAs');
  RemClassRegistry.RegisterXSClass(OperationContext, 'http://connectivity.service.ews.mincom.com', 'OperationContext');
  RemClassRegistry.RegisterXSClass(WorkOrderDTO, 'http://dto.dependant.ellipse.enterpriseservice.mincom.com', 'WorkOrderDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceDeleteRequiredAttributesDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceDeleteRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceDeleteRequestDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceDeleteRequestDTO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfContractCostingServiceDeleteRequestDTO), 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ArrayOfContractCostingServiceDeleteRequestDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceDeleteReplyDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceDeleteReplyDTO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfContractCostingServiceDeleteReplyDTO), 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ArrayOfContractCostingServiceDeleteReplyDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceDeleteReplyCollectionDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceDeleteReplyCollectionDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceCreateRequiredAttributesDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceCreateRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceCreateRequestDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceCreateRequestDTO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfContractCostingServiceCreateRequestDTO), 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ArrayOfContractCostingServiceCreateRequestDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceCreateReplyDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceCreateReplyDTO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfContractCostingServiceCreateReplyDTO), 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ArrayOfContractCostingServiceCreateReplyDTO');
  RemClassRegistry.RegisterXSClass(ContractCostingServiceCreateReplyCollectionDTO, 'http://contractcosting.ellipse.enterpriseservice.mincom.com', 'ContractCostingServiceCreateReplyCollectionDTO');

end. 