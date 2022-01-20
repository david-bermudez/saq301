// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/ValuationsService?WSDL&op=create&op=delete&op=multipleModItems
// Encoding : UTF-8
// Version  : 1.0
// (16/06/2015 08:50:21 p.m. - $Revision:   1.9.1.0.1.0.1.9  $)
// ************************************************************************ //

unit ValuationsService;

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
  // !:AbstractDTO     - "http://valuations.ellipse.enterpriseservice.mincom.com"
  // !:AbstractRequiredAttributesDTO - "http://valuations.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyCollectionDTO - "http://valuations.ellipse.enterpriseservice.mincom.com"
  // !:AbstractReplyDTO - "http://valuations.ellipse.enterpriseservice.mincom.com"

  RunAs                = class;                 { "http://connectivity.service.ews.mincom.com" }
  OperationContext     = class;                 { "http://connectivity.service.ews.mincom.com" }
  ValuationsServiceDeleteRequiredAttributesDTO = class;   { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceDeleteRequestDTO = class;    { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceDeleteReplyDTO = class;      { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceCreateRequiredAttributesDTO = class;   { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceCreateRequestDTO = class;    { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceCreateReplyDTO = class;      { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceModItemsRequiredAttributesDTO = class;   { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceModItemsRequestDTO = class;   { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceModItemsReplyDTO = class;    { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ValuationsServiceModItemsReplyCollectionDTO = class;   { "http://valuations.ellipse.enterpriseservice.mincom.com" }



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
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceDeleteRequiredAttributesDTO = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceDeleteRequestDTO = class(TRemotable)
  private
    FcontractNo: String;
    FrequiredAttributes: ValuationsServiceDeleteRequiredAttributesDTO;
    FvaluationNo: String;
  public
    destructor Destroy; override;
  published
    property contractNo: String read FcontractNo write FcontractNo;
    property requiredAttributes: ValuationsServiceDeleteRequiredAttributesDTO read FrequiredAttributes write FrequiredAttributes;
    property valuationNo: String read FvaluationNo write FvaluationNo;
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceDeleteReplyDTO = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceCreateRequiredAttributesDTO = class(TRemotable)
  private
    FreturnATaxComponent: String;
    FreturnATaxInclPrice: String;
    FreturnATaxValue: String;
    FreturnAccountant: String;
    FreturnAccountantName: String;
    FreturnActualPaySchDate: String;
    FreturnAddComplPayment: String;
    FreturnAdjustedContractPrice: String;
    FreturnAmount1099: String;
    FreturnAmountDue: String;
    FreturnAmtToContractor: String;
    FreturnApplies1099: String;
    FreturnAuthSecSW: String;
    FreturnAuthorisedBy: String;
    FreturnBankAccountNo: String;
    FreturnBranchCode: String;
    FreturnCAAASW: String;
    FreturnCAAPSW: String;
    FreturnCVUPSW: String;
    FreturnCalculatedMethod: String;
    FreturnCalculatedType: String;
    FreturnCntrctrRefAmt: String;
    FreturnCntrctrRefDate: String;
    FreturnCntrctrRefNo: String;
    FreturnCntrctrRefRcptDate: String;
    FreturnCommType: String;
    FreturnCommonATaxCode: String;
    FreturnContractNo: String;
    FreturnContractNoDescription: String;
    FreturnContractValue: String;
    FreturnContractor: String;
    FreturnContractorName: String;
    FreturnCopyPrevValnFlag: String;
    FreturnDisplayLDFlag: String;
    FreturnDistrictCode: String;
    FreturnDocTypeDescription: String;
    FreturnDueDate: String;
    FreturnExtComment: String;
    FreturnExtCommentExists: String;
    FreturnExtInvAsInv: String;
    FreturnFinalValn: String;
    FreturnFinalValnDescription: String;
    FreturnHandleCode: String;
    FreturnHdrLevelATaxCode: String;
    FreturnHdrLevelATaxValue: String;
    FreturnIntComment: String;
    FreturnIntCommentExists: String;
    FreturnLastModDate: String;
    FreturnLastModTime: String;
    FreturnLastModUser: String;
    FreturnLiqDamThisValn: String;
    FreturnNetAmount: String;
    FreturnOriginalRefNo: String;
    FreturnPPaidYetToReclaim: String;
    FreturnPaidByClientFlg: String;
    FreturnPaySchDueDate: String;
    FreturnPrePayment: String;
    FreturnPrePaymentAvail: String;
    FreturnPreviouslyPaid: String;
    FreturnPriceInclTax: String;
    FreturnProjectNo: String;
    FreturnRctiFlag: String;
    FreturnReclaimPrePaid: String;
    FreturnRetenThisValn: String;
    FreturnStatDecSuppDate: String;
    FreturnTotalAddComplPay: String;
    FreturnTotalLiqDam: String;
    FreturnTotalRetention: String;
    FreturnTotalValuation: String;
    FreturnType1099: String;
    FreturnValnStatus: String;
    FreturnValnStatusDescription: String;
    FreturnValnTypeFlag: String;
    FreturnValuationDate: String;
    FreturnValuationNo: String;
    FreturnValueThisValn: String;
    FreturnValuedBy: String;
    FreturnValuedByName: String;
    FreturnValuedByUpdate: String;
    FreturnVersionNo: String;
    FreturnWIPValn: String;
    FreturnWhTaxInputReqd: String;
  published
    property returnATaxComponent: String read FreturnATaxComponent write FreturnATaxComponent;
    property returnATaxInclPrice: String read FreturnATaxInclPrice write FreturnATaxInclPrice;
    property returnATaxValue: String read FreturnATaxValue write FreturnATaxValue;
    property returnAccountant: String read FreturnAccountant write FreturnAccountant;
    property returnAccountantName: String read FreturnAccountantName write FreturnAccountantName;
    property returnActualPaySchDate: String read FreturnActualPaySchDate write FreturnActualPaySchDate;
    property returnAddComplPayment: String read FreturnAddComplPayment write FreturnAddComplPayment;
    property returnAdjustedContractPrice: String read FreturnAdjustedContractPrice write FreturnAdjustedContractPrice;
    property returnAmount1099: String read FreturnAmount1099 write FreturnAmount1099;
    property returnAmountDue: String read FreturnAmountDue write FreturnAmountDue;
    property returnAmtToContractor: String read FreturnAmtToContractor write FreturnAmtToContractor;
    property returnApplies1099: String read FreturnApplies1099 write FreturnApplies1099;
    property returnAuthSecSW: String read FreturnAuthSecSW write FreturnAuthSecSW;
    property returnAuthorisedBy: String read FreturnAuthorisedBy write FreturnAuthorisedBy;
    property returnBankAccountNo: String read FreturnBankAccountNo write FreturnBankAccountNo;
    property returnBranchCode: String read FreturnBranchCode write FreturnBranchCode;
    property returnCAAASW: String read FreturnCAAASW write FreturnCAAASW;
    property returnCAAPSW: String read FreturnCAAPSW write FreturnCAAPSW;
    property returnCVUPSW: String read FreturnCVUPSW write FreturnCVUPSW;
    property returnCalculatedMethod: String read FreturnCalculatedMethod write FreturnCalculatedMethod;
    property returnCalculatedType: String read FreturnCalculatedType write FreturnCalculatedType;
    property returnCntrctrRefAmt: String read FreturnCntrctrRefAmt write FreturnCntrctrRefAmt;
    property returnCntrctrRefDate: String read FreturnCntrctrRefDate write FreturnCntrctrRefDate;
    property returnCntrctrRefNo: String read FreturnCntrctrRefNo write FreturnCntrctrRefNo;
    property returnCntrctrRefRcptDate: String read FreturnCntrctrRefRcptDate write FreturnCntrctrRefRcptDate;
    property returnCommType: String read FreturnCommType write FreturnCommType;
    property returnCommonATaxCode: String read FreturnCommonATaxCode write FreturnCommonATaxCode;
    property returnContractNo: String read FreturnContractNo write FreturnContractNo;
    property returnContractNoDescription: String read FreturnContractNoDescription write FreturnContractNoDescription;
    property returnContractValue: String read FreturnContractValue write FreturnContractValue;
    property returnContractor: String read FreturnContractor write FreturnContractor;
    property returnContractorName: String read FreturnContractorName write FreturnContractorName;
    property returnCopyPrevValnFlag: String read FreturnCopyPrevValnFlag write FreturnCopyPrevValnFlag;
    property returnDisplayLDFlag: String read FreturnDisplayLDFlag write FreturnDisplayLDFlag;
    property returnDistrictCode: String read FreturnDistrictCode write FreturnDistrictCode;
    property returnDocTypeDescription: String read FreturnDocTypeDescription write FreturnDocTypeDescription;
    property returnDueDate: String read FreturnDueDate write FreturnDueDate;
    property returnExtComment: String read FreturnExtComment write FreturnExtComment;
    property returnExtCommentExists: String read FreturnExtCommentExists write FreturnExtCommentExists;
    property returnExtInvAsInv: String read FreturnExtInvAsInv write FreturnExtInvAsInv;
    property returnFinalValn: String read FreturnFinalValn write FreturnFinalValn;
    property returnFinalValnDescription: String read FreturnFinalValnDescription write FreturnFinalValnDescription;
    property returnHandleCode: String read FreturnHandleCode write FreturnHandleCode;
    property returnHdrLevelATaxCode: String read FreturnHdrLevelATaxCode write FreturnHdrLevelATaxCode;
    property returnHdrLevelATaxValue: String read FreturnHdrLevelATaxValue write FreturnHdrLevelATaxValue;
    property returnIntComment: String read FreturnIntComment write FreturnIntComment;
    property returnIntCommentExists: String read FreturnIntCommentExists write FreturnIntCommentExists;
    property returnLastModDate: String read FreturnLastModDate write FreturnLastModDate;
    property returnLastModTime: String read FreturnLastModTime write FreturnLastModTime;
    property returnLastModUser: String read FreturnLastModUser write FreturnLastModUser;
    property returnLiqDamThisValn: String read FreturnLiqDamThisValn write FreturnLiqDamThisValn;
    property returnNetAmount: String read FreturnNetAmount write FreturnNetAmount;
    property returnOriginalRefNo: String read FreturnOriginalRefNo write FreturnOriginalRefNo;
    property returnPPaidYetToReclaim: String read FreturnPPaidYetToReclaim write FreturnPPaidYetToReclaim;
    property returnPaidByClientFlg: String read FreturnPaidByClientFlg write FreturnPaidByClientFlg;
    property returnPaySchDueDate: String read FreturnPaySchDueDate write FreturnPaySchDueDate;
    property returnPrePayment: String read FreturnPrePayment write FreturnPrePayment;
    property returnPrePaymentAvail: String read FreturnPrePaymentAvail write FreturnPrePaymentAvail;
    property returnPreviouslyPaid: String read FreturnPreviouslyPaid write FreturnPreviouslyPaid;
    property returnPriceInclTax: String read FreturnPriceInclTax write FreturnPriceInclTax;
    property returnProjectNo: String read FreturnProjectNo write FreturnProjectNo;
    property returnRctiFlag: String read FreturnRctiFlag write FreturnRctiFlag;
    property returnReclaimPrePaid: String read FreturnReclaimPrePaid write FreturnReclaimPrePaid;
    property returnRetenThisValn: String read FreturnRetenThisValn write FreturnRetenThisValn;
    property returnStatDecSuppDate: String read FreturnStatDecSuppDate write FreturnStatDecSuppDate;
    property returnTotalAddComplPay: String read FreturnTotalAddComplPay write FreturnTotalAddComplPay;
    property returnTotalLiqDam: String read FreturnTotalLiqDam write FreturnTotalLiqDam;
    property returnTotalRetention: String read FreturnTotalRetention write FreturnTotalRetention;
    property returnTotalValuation: String read FreturnTotalValuation write FreturnTotalValuation;
    property returnType1099: String read FreturnType1099 write FreturnType1099;
    property returnValnStatus: String read FreturnValnStatus write FreturnValnStatus;
    property returnValnStatusDescription: String read FreturnValnStatusDescription write FreturnValnStatusDescription;
    property returnValnTypeFlag: String read FreturnValnTypeFlag write FreturnValnTypeFlag;
    property returnValuationDate: String read FreturnValuationDate write FreturnValuationDate;
    property returnValuationNo: String read FreturnValuationNo write FreturnValuationNo;
    property returnValueThisValn: String read FreturnValueThisValn write FreturnValueThisValn;
    property returnValuedBy: String read FreturnValuedBy write FreturnValuedBy;
    property returnValuedByName: String read FreturnValuedByName write FreturnValuedByName;
    property returnValuedByUpdate: String read FreturnValuedByUpdate write FreturnValuedByUpdate;
    property returnVersionNo: String read FreturnVersionNo write FreturnVersionNo;
    property returnWIPValn: String read FreturnWIPValn write FreturnWIPValn;
    property returnWhTaxInputReqd: String read FreturnWhTaxInputReqd write FreturnWhTaxInputReqd;
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceCreateRequestDTO = class(TRemotable)
  private
    FATaxValue: String;
    FWIPValn: String;
    FactualPaySchDate: String;
    Famount1099: String;
    FbankAccountNo: String;
    FbranchCode: String;
    FcalculatedMethod: String;
    FcalculatedType: String;
    FcntrctrRefAmt: String;
    FcntrctrRefDate: String;
    FcntrctrRefNo: String;
    FcntrctrRefRcptDate: String;
    FcommType: String;
    FcontractNo: String;
    Fcontractor: String;
    FcopyPrevValnFlag: String;
    FextInvAsInv: String;
    FfinalValn: String;
    FhandleCode: String;
    FhdrLevelATaxCode: String;
    FhdrLevelATaxValue: String;
    ForiginalRefNo: String;
    FprePayment: String;
    FreclaimPrePaid: String;
    FrequiredAttributes: ValuationsServiceCreateRequiredAttributesDTO;
    FstatDecSuppDate: String;
    Ftype1099: String;
    FvalnTypeFlag: String;
    FvaluationDate: String;
    FvaluedBy: String;
  public
    destructor Destroy; override;
  published
    property ATaxValue: String read FATaxValue write FATaxValue;
    property WIPValn: String read FWIPValn write FWIPValn;
    property actualPaySchDate: String read FactualPaySchDate write FactualPaySchDate;
    property amount1099: String read Famount1099 write Famount1099;
    property bankAccountNo: String read FbankAccountNo write FbankAccountNo;
    property branchCode: String read FbranchCode write FbranchCode;
    property calculatedMethod: String read FcalculatedMethod write FcalculatedMethod;
    property calculatedType: String read FcalculatedType write FcalculatedType;
    property cntrctrRefAmt: String read FcntrctrRefAmt write FcntrctrRefAmt;
    property cntrctrRefDate: String read FcntrctrRefDate write FcntrctrRefDate;
    property cntrctrRefNo: String read FcntrctrRefNo write FcntrctrRefNo;
    property cntrctrRefRcptDate: String read FcntrctrRefRcptDate write FcntrctrRefRcptDate;
    property commType: String read FcommType write FcommType;
    property contractNo: String read FcontractNo write FcontractNo;
    property contractor: String read Fcontractor write Fcontractor;
    property copyPrevValnFlag: String read FcopyPrevValnFlag write FcopyPrevValnFlag;
    property extInvAsInv: String read FextInvAsInv write FextInvAsInv;
    property finalValn: String read FfinalValn write FfinalValn;
    property handleCode: String read FhandleCode write FhandleCode;
    property hdrLevelATaxCode: String read FhdrLevelATaxCode write FhdrLevelATaxCode;
    property hdrLevelATaxValue: String read FhdrLevelATaxValue write FhdrLevelATaxValue;
    property originalRefNo: String read ForiginalRefNo write ForiginalRefNo;
    property prePayment: String read FprePayment write FprePayment;
    property reclaimPrePaid: String read FreclaimPrePaid write FreclaimPrePaid;
    property requiredAttributes: ValuationsServiceCreateRequiredAttributesDTO read FrequiredAttributes write FrequiredAttributes;
    property statDecSuppDate: String read FstatDecSuppDate write FstatDecSuppDate;
    property type1099: String read Ftype1099 write Ftype1099;
    property valnTypeFlag: String read FvalnTypeFlag write FvalnTypeFlag;
    property valuationDate: String read FvaluationDate write FvaluationDate;
    property valuedBy: String read FvaluedBy write FvaluedBy;
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceCreateReplyDTO = class(TRemotable)
  private
    FATaxComponent: String;
    FATaxInclPrice: String;
    FATaxValue: String;
    FCAAASW: String;
    FCAAPSW: String;
    FCVUPSW: String;
    FPPaidYetToReclaim: String;
    FWIPValn: String;
    Faccountant: String;
    FaccountantName: String;
    FactualPaySchDate: String;
    FaddComplPayment: String;
    FadjustedContractPrice: String;
    Famount1099: String;
    FamountDue: String;
    FamtToContractor: String;
    Fapplies1099: String;
    FauthSecSW: String;
    FauthorisedBy: String;
    FbankAccountNo: String;
    FbranchCode: String;
    FcalculatedMethod: String;
    FcalculatedType: String;
    FcntrctrRefAmt: String;
    FcntrctrRefDate: String;
    FcntrctrRefNo: String;
    FcntrctrRefRcptDate: String;
    FcommType: String;
    FcommonATaxCode: String;
    FcontractNo: String;
    FcontractNoDescription: String;
    FcontractValue: String;
    Fcontractor: String;
    FcontractorName: String;
    FcopyPrevValnFlag: String;
    FdisplayLDFlag: String;
    FdistrictCode: String;
    FdocTypeDescription: String;
    FdueDate: String;
    FextComment: String;
    FextCommentExists: String;
    FextInvAsInv: String;
    FfinalValn: String;
    FfinalValnDescription: String;
    FhandleCode: String;
    FhdrLevelATaxCode: String;
    FhdrLevelATaxValue: String;
    FintComment: String;
    FintCommentExists: String;
    FlastModDate: String;
    FlastModTime: String;
    FlastModUser: String;
    FliqDamThisValn: String;
    FnetAmount: String;
    ForiginalRefNo: String;
    FpaidByClientFlg: String;
    FpaySchDueDate: String;
    FprePayment: String;
    FprePaymentAvail: String;
    FpreviouslyPaid: String;
    FpriceInclTax: String;
    FprojectNo: String;
    FrctiFlag: String;
    FreclaimPrePaid: String;
    FretenThisValn: String;
    FstatDecSuppDate: String;
    FtotalAddComplPay: String;
    FtotalLiqDam: String;
    FtotalRetention: String;
    FtotalValuation: String;
    Ftype1099: String;
    FvalnStatus: String;
    FvalnStatusDescription: String;
    FvalnTypeFlag: String;
    FvaluationDate: String;
    FvaluationNo: String;
    FvalueThisValn: String;
    FvaluedBy: String;
    FvaluedByName: String;
    FvaluedByUpdate: String;
    FversionNo: String;
    FwhTaxInputReqd: String;
  published
    property ATaxComponent: String read FATaxComponent write FATaxComponent;
    property ATaxInclPrice: String read FATaxInclPrice write FATaxInclPrice;
    property ATaxValue: String read FATaxValue write FATaxValue;
    property CAAASW: String read FCAAASW write FCAAASW;
    property CAAPSW: String read FCAAPSW write FCAAPSW;
    property CVUPSW: String read FCVUPSW write FCVUPSW;
    property PPaidYetToReclaim: String read FPPaidYetToReclaim write FPPaidYetToReclaim;
    property WIPValn: String read FWIPValn write FWIPValn;
    property accountant: String read Faccountant write Faccountant;
    property accountantName: String read FaccountantName write FaccountantName;
    property actualPaySchDate: String read FactualPaySchDate write FactualPaySchDate;
    property addComplPayment: String read FaddComplPayment write FaddComplPayment;
    property adjustedContractPrice: String read FadjustedContractPrice write FadjustedContractPrice;
    property amount1099: String read Famount1099 write Famount1099;
    property amountDue: String read FamountDue write FamountDue;
    property amtToContractor: String read FamtToContractor write FamtToContractor;
    property applies1099: String read Fapplies1099 write Fapplies1099;
    property authSecSW: String read FauthSecSW write FauthSecSW;
    property authorisedBy: String read FauthorisedBy write FauthorisedBy;
    property bankAccountNo: String read FbankAccountNo write FbankAccountNo;
    property branchCode: String read FbranchCode write FbranchCode;
    property calculatedMethod: String read FcalculatedMethod write FcalculatedMethod;
    property calculatedType: String read FcalculatedType write FcalculatedType;
    property cntrctrRefAmt: String read FcntrctrRefAmt write FcntrctrRefAmt;
    property cntrctrRefDate: String read FcntrctrRefDate write FcntrctrRefDate;
    property cntrctrRefNo: String read FcntrctrRefNo write FcntrctrRefNo;
    property cntrctrRefRcptDate: String read FcntrctrRefRcptDate write FcntrctrRefRcptDate;
    property commType: String read FcommType write FcommType;
    property commonATaxCode: String read FcommonATaxCode write FcommonATaxCode;
    property contractNo: String read FcontractNo write FcontractNo;
    property contractNoDescription: String read FcontractNoDescription write FcontractNoDescription;
    property contractValue: String read FcontractValue write FcontractValue;
    property contractor: String read Fcontractor write Fcontractor;
    property contractorName: String read FcontractorName write FcontractorName;
    property copyPrevValnFlag: String read FcopyPrevValnFlag write FcopyPrevValnFlag;
    property displayLDFlag: String read FdisplayLDFlag write FdisplayLDFlag;
    property districtCode: String read FdistrictCode write FdistrictCode;
    property docTypeDescription: String read FdocTypeDescription write FdocTypeDescription;
    property dueDate: String read FdueDate write FdueDate;
    property extComment: String read FextComment write FextComment;
    property extCommentExists: String read FextCommentExists write FextCommentExists;
    property extInvAsInv: String read FextInvAsInv write FextInvAsInv;
    property finalValn: String read FfinalValn write FfinalValn;
    property finalValnDescription: String read FfinalValnDescription write FfinalValnDescription;
    property handleCode: String read FhandleCode write FhandleCode;
    property hdrLevelATaxCode: String read FhdrLevelATaxCode write FhdrLevelATaxCode;
    property hdrLevelATaxValue: String read FhdrLevelATaxValue write FhdrLevelATaxValue;
    property intComment: String read FintComment write FintComment;
    property intCommentExists: String read FintCommentExists write FintCommentExists;
    property lastModDate: String read FlastModDate write FlastModDate;
    property lastModTime: String read FlastModTime write FlastModTime;
    property lastModUser: String read FlastModUser write FlastModUser;
    property liqDamThisValn: String read FliqDamThisValn write FliqDamThisValn;
    property netAmount: String read FnetAmount write FnetAmount;
    property originalRefNo: String read ForiginalRefNo write ForiginalRefNo;
    property paidByClientFlg: String read FpaidByClientFlg write FpaidByClientFlg;
    property paySchDueDate: String read FpaySchDueDate write FpaySchDueDate;
    property prePayment: String read FprePayment write FprePayment;
    property prePaymentAvail: String read FprePaymentAvail write FprePaymentAvail;
    property previouslyPaid: String read FpreviouslyPaid write FpreviouslyPaid;
    property priceInclTax: String read FpriceInclTax write FpriceInclTax;
    property projectNo: String read FprojectNo write FprojectNo;
    property rctiFlag: String read FrctiFlag write FrctiFlag;
    property reclaimPrePaid: String read FreclaimPrePaid write FreclaimPrePaid;
    property retenThisValn: String read FretenThisValn write FretenThisValn;
    property statDecSuppDate: String read FstatDecSuppDate write FstatDecSuppDate;
    property totalAddComplPay: String read FtotalAddComplPay write FtotalAddComplPay;
    property totalLiqDam: String read FtotalLiqDam write FtotalLiqDam;
    property totalRetention: String read FtotalRetention write FtotalRetention;
    property totalValuation: String read FtotalValuation write FtotalValuation;
    property type1099: String read Ftype1099 write Ftype1099;
    property valnStatus: String read FvalnStatus write FvalnStatus;
    property valnStatusDescription: String read FvalnStatusDescription write FvalnStatusDescription;
    property valnTypeFlag: String read FvalnTypeFlag write FvalnTypeFlag;
    property valuationDate: String read FvaluationDate write FvaluationDate;
    property valuationNo: String read FvaluationNo write FvaluationNo;
    property valueThisValn: String read FvalueThisValn write FvalueThisValn;
    property valuedBy: String read FvaluedBy write FvaluedBy;
    property valuedByName: String read FvaluedByName write FvaluedByName;
    property valuedByUpdate: String read FvaluedByUpdate write FvaluedByUpdate;
    property versionNo: String read FversionNo write FversionNo;
    property whTaxInputReqd: String read FwhTaxInputReqd write FwhTaxInputReqd;
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceModItemsRequiredAttributesDTO = class(TRemotable)
  private
    FreturnATaxInclPrice: String;
    FreturnATaxValue: String;
    FreturnActualPcQuantity: String;
    FreturnActualValue: String;
    FreturnApprPcQuantity: String;
    FreturnApprValue: String;
    FreturnCalculatedMethod: String;
    FreturnCalculatedType: String;
    FreturnCategoryNo: String;
    FreturnCategoryNoDescription: String;
    FreturnCategoryType: String;
    FreturnCategoryTypeDescription: String;
    FreturnCommonATaxCode: String;
    FreturnContractNo: String;
    FreturnCostModified: String;
    FreturnCumPcQuantity: String;
    FreturnCumValue: String;
    FreturnElementNo: String;
    FreturnElementNoDescription: String;
    FreturnExpandATax: String;
    FreturnExpandATaxCode: String;
    FreturnExpandATaxCodeDescription: String;
    FreturnLastModDate: String;
    FreturnLastModTime: String;
    FreturnLastModUser: String;
    FreturnNewItem: String;
    FreturnOriginalAmount: String;
    FreturnPortionNo: String;
    FreturnPortionNoDescription: String;
    FreturnPortionType: String;
    FreturnPortionTypeDescription: String;
    FreturnPriceInclTax: String;
    FreturnProtectApprove: String;
    FreturnRetenVoucherNo: String;
    FreturnTenderedATaxCode: String;
    FreturnTenderedATaxCodeDescription: String;
    FreturnTenderedATaxRate: String;
    FreturnTenderedPrice: String;
    FreturnTenderedPriceRate: String;
    FreturnTenderedQuantity: String;
    FreturnTenderedRate: String;
    FreturnTenderedUnit: String;
    FreturnTenderedValue: String;
    FreturnValnTypeFlag: String;
    FreturnValuationNo: String;
    FreturnVoucherNo: String;
    FreturnWhTaxCode: String;
  published
    property returnATaxInclPrice: String read FreturnATaxInclPrice write FreturnATaxInclPrice;
    property returnATaxValue: String read FreturnATaxValue write FreturnATaxValue;
    property returnActualPcQuantity: String read FreturnActualPcQuantity write FreturnActualPcQuantity;
    property returnActualValue: String read FreturnActualValue write FreturnActualValue;
    property returnApprPcQuantity: String read FreturnApprPcQuantity write FreturnApprPcQuantity;
    property returnApprValue: String read FreturnApprValue write FreturnApprValue;
    property returnCalculatedMethod: String read FreturnCalculatedMethod write FreturnCalculatedMethod;
    property returnCalculatedType: String read FreturnCalculatedType write FreturnCalculatedType;
    property returnCategoryNo: String read FreturnCategoryNo write FreturnCategoryNo;
    property returnCategoryNoDescription: String read FreturnCategoryNoDescription write FreturnCategoryNoDescription;
    property returnCategoryType: String read FreturnCategoryType write FreturnCategoryType;
    property returnCategoryTypeDescription: String read FreturnCategoryTypeDescription write FreturnCategoryTypeDescription;
    property returnCommonATaxCode: String read FreturnCommonATaxCode write FreturnCommonATaxCode;
    property returnContractNo: String read FreturnContractNo write FreturnContractNo;
    property returnCostModified: String read FreturnCostModified write FreturnCostModified;
    property returnCumPcQuantity: String read FreturnCumPcQuantity write FreturnCumPcQuantity;
    property returnCumValue: String read FreturnCumValue write FreturnCumValue;
    property returnElementNo: String read FreturnElementNo write FreturnElementNo;
    property returnElementNoDescription: String read FreturnElementNoDescription write FreturnElementNoDescription;
    property returnExpandATax: String read FreturnExpandATax write FreturnExpandATax;
    property returnExpandATaxCode: String read FreturnExpandATaxCode write FreturnExpandATaxCode;
    property returnExpandATaxCodeDescription: String read FreturnExpandATaxCodeDescription write FreturnExpandATaxCodeDescription;
    property returnLastModDate: String read FreturnLastModDate write FreturnLastModDate;
    property returnLastModTime: String read FreturnLastModTime write FreturnLastModTime;
    property returnLastModUser: String read FreturnLastModUser write FreturnLastModUser;
    property returnNewItem: String read FreturnNewItem write FreturnNewItem;
    property returnOriginalAmount: String read FreturnOriginalAmount write FreturnOriginalAmount;
    property returnPortionNo: String read FreturnPortionNo write FreturnPortionNo;
    property returnPortionNoDescription: String read FreturnPortionNoDescription write FreturnPortionNoDescription;
    property returnPortionType: String read FreturnPortionType write FreturnPortionType;
    property returnPortionTypeDescription: String read FreturnPortionTypeDescription write FreturnPortionTypeDescription;
    property returnPriceInclTax: String read FreturnPriceInclTax write FreturnPriceInclTax;
    property returnProtectApprove: String read FreturnProtectApprove write FreturnProtectApprove;
    property returnRetenVoucherNo: String read FreturnRetenVoucherNo write FreturnRetenVoucherNo;
    property returnTenderedATaxCode: String read FreturnTenderedATaxCode write FreturnTenderedATaxCode;
    property returnTenderedATaxCodeDescription: String read FreturnTenderedATaxCodeDescription write FreturnTenderedATaxCodeDescription;
    property returnTenderedATaxRate: String read FreturnTenderedATaxRate write FreturnTenderedATaxRate;
    property returnTenderedPrice: String read FreturnTenderedPrice write FreturnTenderedPrice;
    property returnTenderedPriceRate: String read FreturnTenderedPriceRate write FreturnTenderedPriceRate;
    property returnTenderedQuantity: String read FreturnTenderedQuantity write FreturnTenderedQuantity;
    property returnTenderedRate: String read FreturnTenderedRate write FreturnTenderedRate;
    property returnTenderedUnit: String read FreturnTenderedUnit write FreturnTenderedUnit;
    property returnTenderedValue: String read FreturnTenderedValue write FreturnTenderedValue;
    property returnValnTypeFlag: String read FreturnValnTypeFlag write FreturnValnTypeFlag;
    property returnValuationNo: String read FreturnValuationNo write FreturnValuationNo;
    property returnVoucherNo: String read FreturnVoucherNo write FreturnVoucherNo;
    property returnWhTaxCode: String read FreturnWhTaxCode write FreturnWhTaxCode;
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceModItemsRequestDTO = class(TRemotable)
  private
    FactualPcQuantity: String;
    FactualValue: String;
    FcalculatedMethod: String;
    FcalculatedType: String;
    FcategoryNo: String;
    FcontractNo: String;
    FcostModified: String;
    FcumPcQuantity: String;
    FcumValue: String;
    FelementNo: String;
    FportionNo: String;
    FrequiredAttributes: ValuationsServiceModItemsRequiredAttributesDTO;
    FvalnTypeFlag: String;
    FvaluationNo: String;
    FwhTaxCode: String;
  public
    destructor Destroy; override;
  published
    property actualPcQuantity: String read FactualPcQuantity write FactualPcQuantity;
    property actualValue: String read FactualValue write FactualValue;
    property calculatedMethod: String read FcalculatedMethod write FcalculatedMethod;
    property calculatedType: String read FcalculatedType write FcalculatedType;
    property categoryNo: String read FcategoryNo write FcategoryNo;
    property contractNo: String read FcontractNo write FcontractNo;
    property costModified: String read FcostModified write FcostModified;
    property cumPcQuantity: String read FcumPcQuantity write FcumPcQuantity;
    property cumValue: String read FcumValue write FcumValue;
    property elementNo: String read FelementNo write FelementNo;
    property portionNo: String read FportionNo write FportionNo;
    property requiredAttributes: ValuationsServiceModItemsRequiredAttributesDTO read FrequiredAttributes write FrequiredAttributes;
    property valnTypeFlag: String read FvalnTypeFlag write FvalnTypeFlag;
    property valuationNo: String read FvaluationNo write FvaluationNo;
    property whTaxCode: String read FwhTaxCode write FwhTaxCode;
  end;



  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceModItemsReplyDTO = class(TRemotable)
  private
    FATaxInclPrice: String;
    FATaxValue: String;
    FactualPcQuantity: String;
    FactualValue: String;
    FapprPcQuantity: String;
    FapprValue: String;
    FcalculatedMethod: String;
    FcalculatedType: String;
    FcategoryNo: String;
    FcategoryNoDescription: String;
    FcategoryType: String;
    FcategoryTypeDescription: String;
    FcommonATaxCode: String;
    FcontractNo: String;
    FcostModified: String;
    FcumPcQuantity: String;
    FcumValue: String;
    FelementNo: String;
    FelementNoDescription: String;
    FexpandATax: String;
    FexpandATaxCode: String;
    FexpandATaxCodeDescription: String;
    FlastModDate: String;
    FlastModTime: String;
    FlastModUser: String;
    FnewItem: String;
    ForiginalAmount: String;
    FportionNo: String;
    FportionNoDescription: String;
    FportionType: String;
    FportionTypeDescription: String;
    FpriceInclTax: String;
    FprotectApprove: String;
    FretenVoucherNo: String;
    FtenderedATaxCode: String;
    FtenderedATaxCodeDescription: String;
    FtenderedATaxRate: String;
    FtenderedPrice: String;
    FtenderedPriceRate: String;
    FtenderedQuantity: String;
    FtenderedRate: String;
    FtenderedUnit: String;
    FtenderedValue: String;
    FvalnTypeFlag: String;
    FvaluationNo: String;
    FvoucherNo: String;
    FwhTaxCode: String;
  published
    property ATaxInclPrice: String read FATaxInclPrice write FATaxInclPrice;
    property ATaxValue: String read FATaxValue write FATaxValue;
    property actualPcQuantity: String read FactualPcQuantity write FactualPcQuantity;
    property actualValue: String read FactualValue write FactualValue;
    property apprPcQuantity: String read FapprPcQuantity write FapprPcQuantity;
    property apprValue: String read FapprValue write FapprValue;
    property calculatedMethod: String read FcalculatedMethod write FcalculatedMethod;
    property calculatedType: String read FcalculatedType write FcalculatedType;
    property categoryNo: String read FcategoryNo write FcategoryNo;
    property categoryNoDescription: String read FcategoryNoDescription write FcategoryNoDescription;
    property categoryType: String read FcategoryType write FcategoryType;
    property categoryTypeDescription: String read FcategoryTypeDescription write FcategoryTypeDescription;
    property commonATaxCode: String read FcommonATaxCode write FcommonATaxCode;
    property contractNo: String read FcontractNo write FcontractNo;
    property costModified: String read FcostModified write FcostModified;
    property cumPcQuantity: String read FcumPcQuantity write FcumPcQuantity;
    property cumValue: String read FcumValue write FcumValue;
    property elementNo: String read FelementNo write FelementNo;
    property elementNoDescription: String read FelementNoDescription write FelementNoDescription;
    property expandATax: String read FexpandATax write FexpandATax;
    property expandATaxCode: String read FexpandATaxCode write FexpandATaxCode;
    property expandATaxCodeDescription: String read FexpandATaxCodeDescription write FexpandATaxCodeDescription;
    property lastModDate: String read FlastModDate write FlastModDate;
    property lastModTime: String read FlastModTime write FlastModTime;
    property lastModUser: String read FlastModUser write FlastModUser;
    property newItem: String read FnewItem write FnewItem;
    property originalAmount: String read ForiginalAmount write ForiginalAmount;
    property portionNo: String read FportionNo write FportionNo;
    property portionNoDescription: String read FportionNoDescription write FportionNoDescription;
    property portionType: String read FportionType write FportionType;
    property portionTypeDescription: String read FportionTypeDescription write FportionTypeDescription;
    property priceInclTax: String read FpriceInclTax write FpriceInclTax;
    property protectApprove: String read FprotectApprove write FprotectApprove;
    property retenVoucherNo: String read FretenVoucherNo write FretenVoucherNo;
    property tenderedATaxCode: String read FtenderedATaxCode write FtenderedATaxCode;
    property tenderedATaxCodeDescription: String read FtenderedATaxCodeDescription write FtenderedATaxCodeDescription;
    property tenderedATaxRate: String read FtenderedATaxRate write FtenderedATaxRate;
    property tenderedPrice: String read FtenderedPrice write FtenderedPrice;
    property tenderedPriceRate: String read FtenderedPriceRate write FtenderedPriceRate;
    property tenderedQuantity: String read FtenderedQuantity write FtenderedQuantity;
    property tenderedRate: String read FtenderedRate write FtenderedRate;
    property tenderedUnit: String read FtenderedUnit write FtenderedUnit;
    property tenderedValue: String read FtenderedValue write FtenderedValue;
    property valnTypeFlag: String read FvalnTypeFlag write FvalnTypeFlag;
    property valuationNo: String read FvaluationNo write FvaluationNo;
    property voucherNo: String read FvoucherNo write FvoucherNo;
    property whTaxCode: String read FwhTaxCode write FwhTaxCode;
  end;

  ArrayOfValuationsServiceModItemsRequestDTO = array of ValuationsServiceModItemsRequestDTO;   { "http://valuations.ellipse.enterpriseservice.mincom.com" }
  ArrayOfValuationsServiceModItemsReplyDTO = array of ValuationsServiceModItemsReplyDTO;   { "http://valuations.ellipse.enterpriseservice.mincom.com" }


  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // ************************************************************************ //
  ValuationsServiceModItemsReplyCollectionDTO = class(TRemotable)
  private
    FreplyElements: ArrayOfValuationsServiceModItemsReplyDTO;
  public
    destructor Destroy; override;
  published
    property replyElements: ArrayOfValuationsServiceModItemsReplyDTO read FreplyElements write FreplyElements;
  end;


  // ************************************************************************ //
  // Namespace : http://valuations.ellipse.enterpriseservice.mincom.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : ValuationsServiceHttpBinding
  // service   : ValuationsService
  // port      : ValuationsServiceHttpPort
  // URL       : http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/ValuationsService
  // ************************************************************************ //
  Valuations = interface(IInvokable)
  ['{83CE72DC-6378-1185-A252-71FF68FB1E47}']
    function  multipleModItems(const context: OperationContext; const requestParameters: ArrayOfValuationsServiceModItemsRequestDTO): ValuationsServiceModItemsReplyCollectionDTO; stdcall;
    function  delete(const context: OperationContext; const requestParameters: ValuationsServiceDeleteRequestDTO): ValuationsServiceDeleteReplyDTO; stdcall;
    function  create(const context: OperationContext; const requestParameters: ValuationsServiceCreateRequestDTO): ValuationsServiceCreateReplyDTO; stdcall;
  end;

function GetValuations(UseWSDL: Boolean=System.False; Addr: string=''): Valuations;


implementation
  uses SOAPHTTPClient;

function GetValuations(UseWSDL: Boolean; Addr: string): Valuations;
const
  defWSDL = 'http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/ValuationsService?WSDL&op=create&op=delete&op=multipleModItems';
  defURL  = 'http://ellipse-el8desa.lmnerp03.cerrejon.com/ews/services/vba/ValuationsService';
  defSvc  = 'ValuationsService';
  defPrt  = 'ValuationsServiceHttpPort';
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
    Result := (RIO as Valuations);
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

destructor ValuationsServiceDeleteRequestDTO.Destroy;
begin
  if Assigned(FrequiredAttributes) then
    FrequiredAttributes.Free;
  inherited Destroy;
end;

destructor ValuationsServiceCreateRequestDTO.Destroy;
begin
  if Assigned(FrequiredAttributes) then
    FrequiredAttributes.Free;
  inherited Destroy;
end;

destructor ValuationsServiceModItemsRequestDTO.Destroy;
begin
  if Assigned(FrequiredAttributes) then
    FrequiredAttributes.Free;
  inherited Destroy;
end;

destructor ValuationsServiceModItemsReplyCollectionDTO.Destroy;
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
  InvRegistry.RegisterInterface(TypeInfo(Valuations), 'http://valuations.ellipse.enterpriseservice.mincom.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Valuations), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Valuations), ioDocument);
  RemClassRegistry.RegisterXSClass(RunAs, 'http://connectivity.service.ews.mincom.com', 'RunAs');
  RemClassRegistry.RegisterXSClass(OperationContext, 'http://connectivity.service.ews.mincom.com', 'OperationContext');
  RemClassRegistry.RegisterXSClass(ValuationsServiceDeleteRequiredAttributesDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceDeleteRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceDeleteRequestDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceDeleteRequestDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceDeleteReplyDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceDeleteReplyDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceCreateRequiredAttributesDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceCreateRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceCreateRequestDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceCreateRequestDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceCreateReplyDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceCreateReplyDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceModItemsRequiredAttributesDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceModItemsRequiredAttributesDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceModItemsRequestDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceModItemsRequestDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceModItemsReplyDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceModItemsReplyDTO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfValuationsServiceModItemsRequestDTO), 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ArrayOfValuationsServiceModItemsRequestDTO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfValuationsServiceModItemsReplyDTO), 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ArrayOfValuationsServiceModItemsReplyDTO');
  RemClassRegistry.RegisterXSClass(ValuationsServiceModItemsReplyCollectionDTO, 'http://valuations.ellipse.enterpriseservice.mincom.com', 'ValuationsServiceModItemsReplyCollectionDTO');

end.