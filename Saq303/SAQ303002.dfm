?
 TDMSAQ303002DATAMODULE 0DH  TPF0TdmSAQ303002DataModuledmSAQ303002DataModuleOldCreateOrderOnCreatedmSAQ303002DataModuleCreate	OnDestroydmSAQ303002DataModuleDestroyLeft}Top? Height
WidthW TSession
SsnInvoiceActive	SessionName
SsnInvoiceLeftTop  	TDatabase	dbActPaid	AliasNameMIMSACTDatabaseName	dbActPaidLoginPromptParams.StringsUSER NAME=moe431 SessionName
SsnInvoiceLeftPTop  TQuerySQLPendentsDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings0Select A.CONTRACT_NO,A.PORTION_NO,A.ACT_PAID_NO,)           A.ACT_PAID_DATE,A.APPROVED_BY,(           B.SUPPLIER_NO,B.CURRENCY_TYPE!           From SAF3A0 A,MSF384 BWhere (A.STATUS='5') And)           (A.CONTRACT_NO=B.CONTRACT_NO)             Left? Top TStringFieldSQLPendentsCONTRACT_NO	FieldNameCONTRACT_NOSize  TStringFieldSQLPendentsPORTION_NO	FieldName
PORTION_NOSize  TStringFieldSQLPendentsACT_PAID_NO	FieldNameACT_PAID_NOSize
  TStringFieldSQLPendentsACT_PAID_DATE	FieldNameACT_PAID_DATESize  TStringFieldSQLPendentsAPPROVED_BY	FieldNameAPPROVED_BYSize
  TStringFieldSQLPendentsSUPPLIER_NODisplayWidth	FieldNameSUPPLIER_NOSize  TStringFieldSQLPendentsCURRENCY_TYPE	FieldNameCURRENCY_TYPESize   TTabletblPaysCachedUpdates	
BeforePosttblPaysBeforePostOnCalcFieldstblPaysCalcFieldsDatabaseNamedbLocalSessionName
SsnInvoice	FieldDefsNameCONTRACT_NO
Attributes
faRequired DataTypeftStringSize Name
PORTION_NO
Attributes
faRequired DataTypeftStringSize NameACT_PAID_NO
Attributes
faRequired DataTypeftStringSize
 NameACT_PAID_CRR
Attributes
faRequired DataTypeftStringSize NameACT_PAID_DATE
Attributes
faRequired DataTypeftStringSize NameACT_PAID_VALUE
Attributes
faRequired DataType
ftCurrency NameSUPPLIER_NO
Attributes
faRequired DataTypeftStringSize NameSUPPLIER_NAME
Attributes
faRequired DataTypeftStringSize( NameAPPROVER_NAME
Attributes
faRequired DataTypeftStringSize< Name
INVOICE_NO
Attributes
faRequired DataTypeftStringSize NameINVOICE_DATE
Attributes
faRequired DataTypeftStringSize NameINVOICE_RCV_DTDataTypeftStringSize NameINVOICE_DUE_DTDataTypeftStringSize NameINVOICE_BANKDataTypeftStringSize NameINVOICE_BANK_ACCTDataTypeftStringSize NameINVOICE_CRR
Attributes
faRequired DataTypeftStringSize NameINVOICE_RT_CRR
Attributes
faRequired DataTypeftFloat NameINVOICE_TYPING_VALUE
Attributes
faRequired DataType
ftCurrency NameINVOICE_ATAX_CODEDataTypeftStringSize NameINVOICE_ATAX_VALUEDataType
ftCurrency NameINVOICE_VOUCHERDataTypeftStringSize
 NameINVOICE_HANDLE_CODEDataTypeftStringSize  	IndexDefsNametblPaysIndex1Fields"CONTRACT_NO;PORTION_NO;ACT_PAID_NOOptions	ixPrimaryixUnique   	StoreDefs		TableNameSAF3AWLeftPTop@ TStringFieldtblPaysCONTRACT_NO	FieldNameCONTRACT_NORequired	Size  TStringFieldtblPaysPORTION_NO	FieldName
PORTION_NORequired	Size  TStringFieldtblPaysACT_PAID_NO	FieldNameACT_PAID_NORequired	Size
  TStringFieldtblPaysACT_PAID_CRR	FieldNameACT_PAID_CRRRequired	Size  TStringFieldtblPaysACT_PAID_DATE	FieldNameACT_PAID_DATERequired		OnGetTexttblPaysACT_PAID_DATEGetTextSize  TCurrencyFieldtblPaysACT_PAID_VALUE	FieldNameACT_PAID_VALUERequired	  TStringFieldtblPaysSUPPLIER_NODisplayWidth	FieldNameSUPPLIER_NORequired	Size  TStringFieldtblPaysSUPPLIER_NAMEDisplayWidth(	FieldNameSUPPLIER_NAMERequired	Size(  TStringFieldtblPaysAPPROVER_NAMEDisplayWidth<	FieldNameAPPROVER_NAMESize<  TStringFieldtblPaysINVOICE_NODisplayWidth	FieldName
INVOICE_NO  TStringFieldtblPaysINVOICE_DATE	FieldNameINVOICE_DATE	OnGetTexttblPaysACT_PAID_DATEGetText	OnSetTexttblPaysINVOICE_DATESetTextSize  TStringFieldtblPaysINVOICE_RCV_DT	FieldNameINVOICE_RCV_DT	OnGetTexttblPaysACT_PAID_DATEGetText	OnSetTexttblPaysINVOICE_DATESetTextSize  TStringFieldtblPaysINVOICE_DUE_DT	FieldNameINVOICE_DUE_DT	OnGetTexttblPaysACT_PAID_DATEGetText	OnSetTexttblPaysINVOICE_DATESetTextSize  TStringFieldtblPaysINVOICE_BANK	FieldNameINVOICE_BANKSize  TStringFieldtblPaysINVOICE_BANK_ACCT	FieldNameINVOICE_BANK_ACCT  TStringFieldtblPaysINVOICE_CRR	FieldNameINVOICE_CRRRequired	Size  TFloatFieldtblPaysINVOICE_RT_CRR	FieldNameINVOICE_RT_CRRRequired	  TCurrencyFieldtblPaysINVOICE_TYPING_VALUE	FieldNameINVOICE_TYPING_VALUERequired	  TStringFieldtblPaysINVOICE_ATAX_CODE	FieldNameINVOICE_ATAX_CODESize  TCurrencyFieldtblPaysINVOICE_ATAX_VALUE	FieldNameINVOICE_ATAX_VALUE  TStringFieldtblPaysINVOICE_VOUCHER	FieldNameINVOICE_VOUCHERSize
  TStringFieldtblPaysINVOICE_HANDLE_CODE	FieldNameINVOICE_HANDLE_CODE	OnGetText!tblPaysINVOICE_HANDLE_CODEGetText	OnSetText!tblPaysINVOICE_HANDLE_CODESetTextSize  TCurrencyFieldtblPaysINVOICE_VALUE	FieldKindfkCalculated	FieldNameINVOICE_VALUE
Calculated	   TDataSourceStblPaysDataSettblPaysLeft? Top@  	TDatabasedbLocal	AliasNamemimsDatabaseNamedbLocalSessionName
SsnInvoiceLeftTop@  TQuerySQLActValueDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings"Select Sum(PAID_VALUE) From SAF3A1!Where (CONTRACT_NO=:Contract) And%            (ACT_PAID_NO=:AnActPaid)  Left? Top	ParamDataDataTypeftStringNameContract	ParamTypeptInput DataTypeftStringName	AnActPaid	ParamTypeptInput    TQuerySQLSupplierDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings Select SUPPLIER_NAME From MSF200Where SUPPLIER_NO=:Supplier Left&Top	ParamDataDataTypeftStringNameSupplier	ParamTypeptInput   TStringFieldSQLSupplierSUPPLIER_NAME	FieldNameSUPPLIER_NAMEOriginSUPPLIER_NAMESize    TQuerySQLEmployeeDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings2Select EMPLOYEE_ID,SURNAME,FIRST_NAME,SECOND_NAME,!           THIRD_NAME From MSF810Where EMPLOYEE_ID=:Employee Left? Top@	ParamDataDataTypeftStringNameEmployee	ParamTypeptInput   TStringFieldSQLEmployeeSURNAME	FieldNameSURNAMEOrigin"MSF810.DB".SURNAMESize  TStringFieldSQLEmployeeFIRST_NAME	FieldName
FIRST_NAMEOrigin"MSF810.DB".FIRST_NAMESize  TStringFieldSQLEmployeeSECOND_NAME	FieldNameSECOND_NAMEOrigin"MSF810.DB".SECOND_NAMESize  TStringFieldSQLEmployeeTHIRD_NAME	FieldName
THIRD_NAMEOrigin"MSF810.DB".THIRD_NAMESize  TStringFieldSQLEmployeeEMPLOYEE_ID	FieldNameEMPLOYEE_IDOriginEMPLOYEE_IDSize
   TQuerySQLSetActStatusDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.StringsUPDATE SAF3A0 Set STATUS = :AnStatus$Where  (CONTRACT_NO=:AContract) And *            (ACT_PAID_NO=:AnActPaidNo) And"            (STATUS = :AOldStatus) Left%Top@	ParamDataDataTypeftStringNameAnStatus	ParamTypeptInput DataTypeftStringName	AContract	ParamTypeptInput DataTypeftStringNameAnActPaidNo	ParamTypeptInput DataTypeftStringName
AOldStatus	ParamTypeptInput    TQuerySQLInsNewInvDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.StringsINSERT INTO SAF3A49              (CONTRACT_NO,ACT_PAID_NO,PORTION_NO,STATUS,:               SUPPLIER_NO,AUTHSD_BY,AUTH_DATE,INVOICE_NO,7               INVOICE_DATE,INVOICE_RCV_DT,INVOICE_CRR,,               INVOICE_RT_CRR,INVOICE_VALUE)FVALUES  (:AContractNo,:AnActPaidNo,:APortionNo,:AnStatus,:ASupplierNo,E                 :AnAuthsdBy,:AnAuthDate,:AnInvoiceNo,:AnInvoiceDate,R                 :AnInvoiceRcvDt,:AnInvoiceCrr,:AnInvoiceRtCrr,:AnInvoiceValue)    LeftvTop	ParamDataDataTypeftStringNameAContractNo	ParamTypeptInput DataTypeftStringNameAnActPaidNo	ParamTypeptInput DataTypeftStringName
APortionNo	ParamTypeptInput DataTypeftStringNameAnStatus	ParamTypeptInput DataTypeftStringNameASupplierNo	ParamTypeptInput DataTypeftStringName
AnAuthsdBy	ParamTypeptInput DataTypeftStringName
AnAuthDate	ParamTypeptInput DataTypeftStringNameAnInvoiceNo	ParamTypeptInput DataTypeftStringNameAnInvoiceDate	ParamTypeptInput DataTypeftStringNameAnInvoiceRcvDt	ParamTypeptInput DataTypeftStringNameAnInvoiceCrr	ParamTypeptInput DataTypeftFloatNameAnInvoiceRtCrr	ParamTypeptInput DataType
ftCurrencyNameAnInvoiceValue	ParamTypeptInput    TQuerySQLInfoUserDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.StringsSelect EMPLOYEE_ID From MSF020+Where (ENTRY_TYPE='S') And (ENTITY=:AUser)  UniDirectional	LeftvTop@	ParamDataDataTypeftStringNameAUser	ParamTypeptInput    TQuerySQLGetCrrRtDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.StringsSelect BUYING_RATE From MSF912+Where (LOCAL_CURRENCY  = :AnInvoiceCrr) And4           (FOREIGN_CURR        = :AContractCrr) And-           (DATE_PER_REVSD >= :AnInvoiceDate)Order By DATE_PER_REVSD Left?Top	ParamDataDataTypeftStringNameAnInvoiceCrr	ParamTypeptInput DataTypeftStringNameAContractCrr	ParamTypeptInput DataTypeftStringNameAnInvoiceDate	ParamTypeptInput    TQuery
SQLItmXEleDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings-Select ELEMENT_NO,Sum(PAID_VALUE) From SAF3A1$Where (CONTRACT_NO=:AContractNo) And&            (ACT_PAID_NO=:AnActPaidNo)Group By ELEMENT_NOOrder By ELEMENT_NO Left?Top@	ParamDataDataTypeftStringNameAContractNo	ParamTypeptInput DataTypeftStringNameAnActPaidNo	ParamTypeptInput   TStringFieldSQLItmXEleELEMENT_NO	FieldName
ELEMENT_NOOrigin"SAF3A1.DB".ELEMENT_NOSize  TFloatFieldSQLItmXElePAID_VALUE	FieldNameSUM(PAID_VALUE)   TQuerySQLCostsDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings7Select ELEMENT_NO,GL_ACCOUNT,DOCUMENT_TYPE,DOCUMENT_NO,'           EQUIP_NO,PERCENT From SAF3A3$Where (CONTRACT_NO=:AContractNo) And&            (ACT_PAID_NO=:AnActPaidNo) Left? Top? 	ParamDataDataTypeftStringNameAContractNo	ParamTypeptInput DataTypeftStringNameAnActPaidNo	ParamTypeptInput   TStringFieldSQLCostsELEMENT_NO	FieldName
ELEMENT_NOOrigin"SAF3A3.DB".ELEMENT_NOSize  TStringFieldSQLCostsGL_ACCOUNT	FieldName
GL_ACCOUNTOrigin"SAF3A3.DB".GL_ACCOUNTSize  TStringFieldSQLCostsDOCUMENT_TYPE	FieldNameDOCUMENT_TYPEOrigin"SAF3A3.DB".DOCUMENT_TYPESize  TStringFieldSQLCostsDOCUMENT_NO	FieldNameDOCUMENT_NOOrigin"SAF3A3.DB".DOCUMENT_NOSize  TStringFieldSQLCostsEQUIP_NO	FieldNameEQUIP_NOOrigin"SAF3A3.DB".EQUIP_NOSize  TStringFieldSQLCostsPERCENT	FieldNamePERCENTOrigin"SAF3A3.DB".PERCENTSize   TQuerySQLUserConfigDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.StringsSelect * From SAF3A5Where DSTRCT_CODE=:ADistrict LeftTop	ParamDataDataTypeftStringName	ADistrict	ParamTypeptInput   TStringFieldSQLUserConfigDSTRCT_CODE	FieldNameDSTRCT_CODEOriginSAF3A5.DSTRCT_CODESize  TStringFieldSQLUserConfigEMPLOYEE_ID	FieldNameEMPLOYEE_IDOriginSAF3A5.EMPLOYEE_IDSize
  TStringFieldSQLUserConfigCC_TYPE_DSTRB	FieldNameCC_TYPE_DSTRBOriginSAF3A5.CC_TYPE_DSTRBSize  TStringFieldSQLUserConfigCC_DEFAULT_DSTRB	FieldNameCC_DEFAULT_DSTRBOriginSAF3A5.CC_DEFAULT_DSTRBSize  TStringFieldSQLUserConfigTYPE_COMMENTS	FieldNameTYPE_COMMENTSOriginSAF3A5.TYPE_COMMENTSSize  TStringFieldSQLUserConfigTYPE_CNTRCT_EXT	FieldNameTYPE_CNTRCT_EXTOriginSAF3A5.TYPE_CNTRCT_EXTSize  TStringFieldSQLUserConfigLOAD_INV_TYPE	FieldNameLOAD_INV_TYPEOriginSAF3A5.LOAD_INV_TYPESize  TStringFieldSQLUserConfigACT_VALIDATION	FieldNameACT_VALIDATIONOriginSAF3A5.ACT_VALIDATIONSize  TStringFieldSQLUserConfigINV_VALIDATION	FieldNameINV_VALIDATIONOriginSAF3A5.INV_VALIDATIONSize   TQuery
SQLItmXCatDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings4Select ELEMENT_NO,CATEGORY_NO,PAID_VALUE From SAF3A1$Where (CONTRACT_NO=:AContractNo) And&            (ACT_PAID_NO=:AnActPaidNo) LeftTop@	ParamDataDataTypeftStringNameAContractNo	ParamTypeptInput DataTypeftStringNameAnActPaidNo	ParamTypeptInput   TStringFieldSQLItmXCatELEMENT_NO	FieldName
ELEMENT_NOOriginSAF3A1.ELEMENT_NOSize  TStringFieldSQLItmXCatCATEGORY_NO	FieldNameCATEGORY_NOOriginSAF3A1.CATEGORY_NOSize  TFloatFieldSQLItmXCatPAID_VALUE	FieldName
PAID_VALUEOriginSAF3A1.PAID_VALUE   TQuerySQLAtaxCodesDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings)Select ATAX_CODE,DESCRIPTION,ATAX_RATE_9,/       GRP_LEVEL_IND,EFFECTIVE_DATE From MSF013Order By ATAX_CODE Left Top?  TStringFieldSQLAtaxCodesATAX_CODE	FieldName	ATAX_CODEOriginMSF013.ATAX_CODESize  TStringFieldSQLAtaxCodesDESCRIPTION	FieldNameDESCRIPTIONOriginMSF013.DESCRIPTIONSize(  TFloatFieldSQLAtaxCodesATAX_RATE_9	FieldNameATAX_RATE_9OriginMSF013.ATAX_RATE_9  TStringFieldSQLAtaxCodesGRP_LEVEL_IND	FieldNameGRP_LEVEL_INDOriginMSF013.GRP_LEVEL_INDSize  TStringFieldSQLAtaxCodesEFFECTIVE_DATE	FieldNameEFFECTIVE_DATEOriginMSF013.EFFECTIVE_DATESize   TQuerySQLAtaxGrpsDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings*Select ATAX_CODE,REL_ATAX_CODE From MSF014Order By ATAX_CODE Left? Top?  TStringFieldSQLAtaxGrpsATAX_CODE	FieldName	ATAX_CODESize  TStringFieldSQLAtaxGrpsREL_ATAX_CODE	FieldNameREL_ATAX_CODESize   TTabletblItemsCachedUpdates	BeforeInserttblItemsBeforeInsert
BeforeEdittblItemsBeforeEdit
BeforePosttblItemsBeforePostOnNewRecordtblItemsNewRecordDatabaseNamedbLocalSessionName
SsnInvoice	FieldDefsNameELEMENT_DESC
Attributes
faRequired DataTypeftStringSize( NameCATEGORY_DESC
Attributes
faRequired DataTypeftStringSize( Name
ELEMENT_NO
Attributes
faRequired DataTypeftStringSize NameCATEGORY_NO
Attributes
faRequired DataTypeftStringSize Name
ITEM_VALUE
Attributes
faRequired DataType
ftCurrency Name	ATAX_CODEDataTypeftStringSize Name	ATAX_VIEWDataTypeftStringSize  	IndexDefsNametblItemsIndex1FieldsELEMENT_DESC;CATEGORY_DESCOptions	ixPrimaryixUnique   	StoreDefs		TableNameSAF3AVLeftPTop?  TStringFieldtblItemsELEMENT_DESC	FieldNameELEMENT_DESCRequired	Size(  TStringFieldtblItemsCATEGORY_DESC	FieldNameCATEGORY_DESCRequired	Size(  TStringFieldtblItemsELEMENT_NO	FieldName
ELEMENT_NORequired	Size  TStringFieldtblItemsCATEGORY_NO	FieldNameCATEGORY_NORequired	Size  TCurrencyFieldtblItemsITEM_VALUE	FieldName
ITEM_VALUERequired	  TStringFieldtblItemsATAX_CODE	FieldName	ATAX_CODESize  TStringFieldtblItemsATAX_VIEW	FieldName	ATAX_VIEWSize   TDataSource	StblItemsDataSettblItemsLeft? Top?   TQuerySQLElementsDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings(Select TABLE_CODE,TABLE_DESC From MSF010Where TABLE_TYPE='EN' Left$Top TStringFieldSQLElementsTABLE_CODE	FieldName
TABLE_CODEOriginMSF010.TABLE_CODESize  TStringFieldSQLElementsTABLE_DESC	FieldName
TABLE_DESCOriginMSF010.TABLE_DESCSize2   TQuerySQLCntPrtEleDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings6Select ELEMENT_NO,ELEMENT_CODE,ELEMENT_VAL From MSF3869Where (CONTRACT_NO=:AContract) And (PORTION_NO=:APortion) Left?Top? 	ParamDataDataTypeftStringName	AContract	ParamTypeptInput DataTypeftStringNameAPortion	ParamTypeptInput   TStringFieldSQLCntPrtEleELEMENT_NO	FieldName
ELEMENT_NOOriginMSF386.ELEMENT_NOSize  TStringFieldSQLCntPrtEleELEMENT_CODE	FieldNameELEMENT_CODEOriginMSF386.ELEMENT_CODESize  TFloatFieldSQLCntPrtEleELEMENT_VAL	FieldNameELEMENT_VALOriginMSF386.ELEMENT_VAL   TQuerySQLCntPrtEleCatDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings/Select A.ELEMENT_NO,A.CATEGORY_NO,A.CATEG_CODE,           B.TABLE_DESC!           From MSF387 A,MSF010 B$Where (A.CONTRACT_NO=:Contract) And &           (A.PORTION_NO=:Portion) And!          (B.TABLE_TYPE='CE') And'           (A.CATEG_CODE=B.TABLE_CODE)  LeftTop? 	ParamDataDataTypeftStringNameContract	ParamTypeptInput DataTypeftStringNamePortion	ParamTypeptInput   TStringFieldSQLCntPrtEleCatELEMENT_NO	FieldName
ELEMENT_NOOriginMSF387.ELEMENT_NOSize  TStringFieldSQLCntPrtEleCatCATEGORY_NO	FieldNameCATEGORY_NOOriginMSF387.CATEGORY_NOSize  TStringFieldSQLCntPrtEleCatCATEG_CODE	FieldName
CATEG_CODEOriginMSF387.CATEG_CODESize  TStringFieldSQLCntPrtEleCatTABLE_DESC	FieldName
TABLE_DESCOriginMSF010.TABLE_DESCSize2   TQuery
SQLCstmCtgDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings(Select TABLE_CODE,TABLE_DESC From MSF010Where (TABLE_TYPE='+CE') And&           (TABLE_CODE > :ARange1) And"           (TABLE_CODE < :ARange2) LeftvTop~	ParamDataDataTypeftStringNameARange1	ParamTypeptInput DataTypeftStringNameARange2	ParamTypeptInput   TStringFieldSQLCstmCtgTABLE_CODE	FieldName
TABLE_CODESize  TStringFieldSQLCstmCtgTABLE_DESC	FieldName
TABLE_DESCSize2   TTabletblAtaxCachedUpdates	BeforeInserttblAtaxBeforeInsertDatabaseNamedbLocalSessionName
SsnInvoice	FieldDefsName	ATAX_CODE
Attributes
faRequired DataTypeftStringSize Name	ATAX_RATE
Attributes
faRequired DataTypeftStringSize
 Name	ATAX_DESC
Attributes
faRequired DataTypeftStringSize( Name	TAX_VALUE
Attributes
faRequired DataType
ftCurrency  	IndexDefsNametblAtaxIndex1Fields	ATAX_CODEOptions	ixPrimaryixUnique   	StoreDefs		TableNameSAF3AQLeftOTop?  TStringFieldtblAtaxATAX_CODE	FieldName	ATAX_CODEOnChangetblAtaxATAX_CODEChangeSize  TStringFieldtblAtaxATAX_RATE	FieldName	ATAX_RATE	OnGetTexttblAtaxATAX_RATEGetTextSize
  TStringFieldtblAtaxATAX_DESC	FieldName	ATAX_DESCSize(  TCurrencyFieldtblAtaxTAX_VALUE	FieldName	TAX_VALUERequired	   TDataSourceStblAtaxDataSettblAtaxLeft? Top?   TQuerySQLHandleCodesDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings(Select TABLE_CODE,TABLE_DESC From MSF010Where TABLE_TYPE = 'CH' LeftxTop?   TQuerySQLVoucherStyleDatabaseName	dbActPaidSessionName
SsnInvoiceSQL.Strings&Select VCHR_NO_USED From MSF001_DC0031"Where (DSTRCT_CODE=:ADistrict) And"           (CTL_REC_TYPE='DC') And"           (CONTROL_REC_NO='0031') LeftTop? 	ParamDataDataType	ftUnknownName	ADistrict	ParamType	ptUnknown     