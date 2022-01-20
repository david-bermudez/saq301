object dmActs: TdmActs
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = dmActsDestroy
  Left = 156
  Top = 163
  Height = 425
  Width = 1210
  object SsnActPaid: TSession
    SessionName = 'SsnActPaid'
    OnStartup = SsnActPaidStartup
    Left = 24
    Top = 13
  end
  object dbActPaid: TDatabase
    AliasName = 'E8ACT'
    DatabaseName = 'dbActPaid'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=mimsprod')
    SessionName = 'SsnActPaid'
    Left = 84
    Top = 13
  end
  object SQLActs: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select * From ELLIPSE.SAF3A0'
      'Where USER_ID=:User')
    Left = 151
    Top = 13
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'User'
        ParamType = ptUnknown
      end>
  end
  object tblDetail: TTable
    CachedUpdates = True
    BeforeInsert = tblApproveBeforeInsert
    BeforePost = tblDetailBeforePost
    AfterPost = tblDetailAfterPost
    OnCalcFields = tblDetailCalcFields
    DatabaseName = 'dbLocal'
    SessionName = 'SsnActPaid'
    FieldDefs = <
      item
        Name = 'ELEMENT_NO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CATEGORY_NO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CATEGORY_DESC'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'CATEG_BASE_UN'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'BY_GLOBAL'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'QUANTITY'
        DataType = ftFloat
      end
      item
        Name = 'UNITARIAN_VALUE'
        DataType = ftCurrency
      end
      item
        Name = 'GLOBAL_VALUE'
        DataType = ftCurrency
      end
      item
        Name = 'ELEMENT_CODE'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'tblDetailIndex1'
        Fields = 'ELEMENT_NO;CATEGORY_NO'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'SAF3AX01'
        Fields = 'ELEMENT_NO;CATEGORY_DESC'
        Options = [ixUnique, ixCaseInsensitive]
      end>
    IndexFieldNames = 'ELEMENT_NO;CATEGORY_DESC'
    StoreDefs = True
    TableName = 'SAF3AX'
    Left = 231
    Top = 194
    object tblDetailELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Required = True
      Size = 2
    end
    object tblDetailCATEGORY_NO: TStringField
      FieldName = 'CATEGORY_NO'
      Required = True
      Size = 2
    end
    object tblDetailCATEGORY_DESC: TStringField
      FieldName = 'CATEGORY_DESC'
      Required = True
      Size = 40
    end
    object tblDetailCATEG_BASE_UN: TStringField
      FieldName = 'CATEG_BASE_UN'
      Size = 4
    end
    object tblDetailBY_GLOBAL: TStringField
      FieldName = 'BY_GLOBAL'
      Required = True
      Size = 1
    end
    object tblDetailQUANTITY: TFloatField
      FieldName = 'QUANTITY'
      OnGetText = tblDetailQUANTITYGetText
      OnValidate = tblDetailQUANTITYValidate
    end
    object tblDetailUNITARIAN_VALUE: TCurrencyField
      FieldName = 'UNITARIAN_VALUE'
    end
    object tblDetailGLOBAL_VALUE: TCurrencyField
      FieldName = 'GLOBAL_VALUE'
      OnGetText = tblDetailGLOBAL_VALUEGetText
      OnValidate = tblDetailGLOBAL_VALUEValidate
    end
    object tblDetailVALUE: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'VALUE'
      Calculated = True
    end
    object tblDetailELEMENT_CODE: TStringField
      FieldName = 'ELEMENT_CODE'
      Size = 4
    end
  end
  object StblDetail: TDataSource
    DataSet = tblDetail
    Left = 152
    Top = 195
  end
  object SQLItems: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ELEMENT_NO,CATEGORY_NO,RATE_VALUE,QUANTITY,'
      
        '           PAID_VALUE,DISCOUNT_FLAG,TPI_FLAG,PERCENT_FLAG From E' +
        'LLIPSE.SAF3A1'
      'Where  (CONTRACT_NO=:AContract) And (ACT_PAID_NO=:ActPaidNo) ')
    Left = 20
    Top = 135
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ActPaidNo'
        ParamType = ptInput
      end>
    object SQLItemsELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Origin = 'ELEMENT_NO'
      Size = 2
    end
    object SQLItemsCATEGORY_NO: TStringField
      FieldName = 'CATEGORY_NO'
      Origin = 'CATEGORY_NO'
      Size = 2
    end
    object SQLItemsQUANTITY: TFloatField
      FieldName = 'QUANTITY'
      Origin = 'QUANTITY'
    end
    object SQLItemsPAID_VALUE: TFloatField
      FieldName = 'PAID_VALUE'
      Origin = 'PAID_VALUE'
    end
    object SQLItemsRATE_VALUE: TCurrencyField
      FieldName = 'RATE_VALUE'
    end
    object SQLItemsDISCOUNT_FLAG: TStringField
      FieldName = 'DISCOUNT_FLAG'
      Origin = 'SAF3A1.DISCOUNT_FLAG'
      Size = 1
    end
    object SQLItemsTPI_FLAG: TStringField
      FieldName = 'TPI_FLAG'
      Origin = 'SAF3A1.TPI_FLAG'
      Size = 1
    end
    object SQLItemsPERCENT_FLAG: TStringField
      FieldName = 'PERCENT_FLAG'
      Origin = 'DBACTPAID.SAF3A1.PERCENT_FLAG'
      Size = 1
    end
  end
  object SQLSuppliers: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select SUPPLIER_NO,SUPPLIER_NAME From ELLIPSE.MSF200'
      'Order By SUPPLIER_NAME')
    Left = 85
    Top = 259
    object SQLSuppliersSUPPLIER_NAME: TStringField
      FieldName = 'SUPPLIER_NAME'
      Origin = 'SUPPLIER_NAME'
      Size = 32
    end
    object SQLSuppliersSUPPLIER_NO: TStringField
      FieldName = 'SUPPLIER_NO'
      Origin = 'SUPPLIER_NO'
      Size = 6
    end
  end
  object SQLSupplier: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select SUPPLIER_NAME,SUP_TYPEX5 '
      'From ELLIPSE.MSF200'
      'Where SUPPLIER_NO=:Supplier')
    Left = 164
    Top = 259
    ParamData = <
      item
        DataType = ftString
        Name = 'Supplier'
        ParamType = ptInput
      end>
    object SQLSupplierSUPPLIER_NAME: TStringField
      FieldName = 'SUPPLIER_NAME'
      Origin = 'SUPPLIER_NAME'
      Size = 32
    end
    object SQLSupplierSUP_TYPEX5: TStringField
      FieldName = 'SUP_TYPEX5'
      Origin = 'DBACTPAID.MSF200.SUP_TYPEX5'
      Size = 2
    end
  end
  object SQLContract: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select CONTRACT_NO,CONTRACT_DESC,DSTRCT_CODE,SUPPLIER_NO,'
      
        '           CNTRCT_BASE_DT,CURRENCY_TYPE,CONTRACT_VAL,APPROVED_BY' +
        ','
      '           ORIG_START_DT,AMEND_START_DT, '
      '           ORIG_COMPL_DT,AMEND_COMPL_DT,FINAL_COMPL_DT,'
      '           RESPONS_CODE_1,RESPONS_CODE_2,RESPONS_CODE_3,'
      '           RESPONS_CODE_4,EMPLOY_TYPE_1,EMPLOY_TYPE_2,'
      '           EMPLOY_TYPE_3,EMPLOY_TYPE_4,PERF_GTEE_VAL, '
      '           STATUS_384'
      '  From ELLIPSE.MSF384'
      'Where  CONTRACT_NO= :Contrato')
    Left = 264
    Top = 471
    ParamData = <
      item
        DataType = ftString
        Name = 'Contrato'
        ParamType = ptInput
      end>
    object SQLContractCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Origin = 'CONTRACT_NO'
      Size = 8
    end
    object SQLContractCONTRACT_DESC: TStringField
      FieldName = 'CONTRACT_DESC'
      Origin = 'CONTRACT_DESC'
      Size = 40
    end
    object SQLContractSUPPLIER_NO: TStringField
      FieldName = 'SUPPLIER_NO'
      Origin = 'SUPPLIER_NO'
      Size = 6
    end
    object SQLContractCURRENCY_TYPE: TStringField
      FieldName = 'CURRENCY_TYPE'
      Origin = 'CURRENCY_TYPE'
      Size = 4
    end
    object SQLContractRESPONS_CODE_1: TStringField
      FieldName = 'RESPONS_CODE_1'
      Origin = 'RESPONS_CODE_1'
      Size = 10
    end
    object SQLContractRESPONS_CODE_2: TStringField
      FieldName = 'RESPONS_CODE_2'
      Origin = 'RESPONS_CODE_2'
      Size = 10
    end
    object SQLContractRESPONS_CODE_3: TStringField
      FieldName = 'RESPONS_CODE_3'
      Origin = 'RESPONS_CODE_3'
      Size = 10
    end
    object SQLContractRESPONS_CODE_4: TStringField
      FieldName = 'RESPONS_CODE_4'
      Origin = 'RESPONS_CODE_4'
      Size = 10
    end
    object SQLContractCONTRACT_VAL: TCurrencyField
      FieldName = 'CONTRACT_VAL'
    end
    object SQLContractAPPROVED_BY: TStringField
      FieldName = 'APPROVED_BY'
      Size = 10
    end
    object SQLContractEMPLOY_TYPE_1: TStringField
      FieldName = 'EMPLOY_TYPE_1'
      Origin = 'MSF384.EMPLOY_TYPE_1'
      Size = 2
    end
    object SQLContractEMPLOY_TYPE_2: TStringField
      FieldName = 'EMPLOY_TYPE_2'
      Origin = 'MSF384.EMPLOY_TYPE_2'
      Size = 2
    end
    object SQLContractEMPLOY_TYPE_3: TStringField
      FieldName = 'EMPLOY_TYPE_3'
      Origin = 'MSF384.EMPLOY_TYPE_3'
      Size = 2
    end
    object SQLContractEMPLOY_TYPE_4: TStringField
      FieldName = 'EMPLOY_TYPE_4'
      Origin = 'MSF384.EMPLOY_TYPE_4'
      Size = 2
    end
    object SQLContractDSTRCT_CODE: TStringField
      FieldName = 'DSTRCT_CODE'
      Size = 4
    end
    object SQLContractCNTRCT_BASE_DT: TStringField
      FieldName = 'CNTRCT_BASE_DT'
      Size = 8
    end
    object SQLContractORIG_START_DT: TStringField
      FieldName = 'ORIG_START_DT'
      Size = 8
    end
    object SQLContractAMEND_START_DT: TStringField
      FieldName = 'AMEND_START_DT'
      Size = 8
    end
    object SQLContractORIG_COMPL_DT: TStringField
      FieldName = 'ORIG_COMPL_DT'
      Size = 8
    end
    object SQLContractAMEND_COMPL_DT: TStringField
      FieldName = 'AMEND_COMPL_DT'
      Size = 8
    end
    object SQLContractFINAL_COMPL_DT: TStringField
      FieldName = 'FINAL_COMPL_DT'
      Size = 8
    end
    object SQLContractPERF_GTEE_VAL: TFloatField
      FieldName = 'PERF_GTEE_VAL'
      Origin = 'MSF384.PERF_GTEE_VAL'
    end
    object SQLContractSTATUS_384: TStringField
      FieldName = 'STATUS_384'
      Origin = 'MSF384.STATUS_384'
      Size = 2
    end
  end
  object SQLPortion: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select PORTION_DESC,PORTION_VAL,LIQ_DAM_LIMIT,'
      '           ORIG_START_DT,AMEND_START_DT, '
      '           ORIG_COMPL_DT,AMEND_COMPL_DT,FINAL_COMPL_DT,'
      '           RESPONS_CODE_1,RESPONS_CODE_2,RESPONS_CODE_3,'
      '           RESPONS_CODE_4,CONTRACT_LOCAT,LIQ_DAM_BASE'
      '           From ELLIPSE.MSF385'
      'Where (CONTRACT_NO=:Contrato) And (PORTION_NO=:Portion)')
    Left = 792
    Top = 260
    ParamData = <
      item
        DataType = ftString
        Name = 'Contrato'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'Portion'
        ParamType = ptInput
      end>
    object SQLPortionPORTION_DESC: TStringField
      FieldName = 'PORTION_DESC'
      Size = 40
    end
    object SQLPortionPORTION_VAL: TFloatField
      FieldName = 'PORTION_VAL'
    end
    object SQLPortionLIQ_DAM_LIMIT: TFloatField
      FieldName = 'LIQ_DAM_LIMIT'
    end
    object SQLPortionORIG_START_DT: TStringField
      FieldName = 'ORIG_START_DT'
      Size = 8
    end
    object SQLPortionAMEND_START_DT: TStringField
      FieldName = 'AMEND_START_DT'
      Origin = 'MSF385.AMEND_START_DT'
      Size = 8
    end
    object SQLPortionORIG_COMPL_DT: TStringField
      FieldName = 'ORIG_COMPL_DT'
      Size = 8
    end
    object SQLPortionAMEND_COMPL_DT: TStringField
      FieldName = 'AMEND_COMPL_DT'
      Origin = 'MSF385.AMEND_COMPL_DT'
      Size = 8
    end
    object SQLPortionFINAL_COMPL_DT: TStringField
      FieldName = 'FINAL_COMPL_DT'
      Origin = 'MSF385.FINAL_COMPL_DT'
      Size = 8
    end
    object SQLPortionRESPONS_CODE_1: TStringField
      FieldName = 'RESPONS_CODE_1'
      Origin = 'MSF385.RESPONS_CODE_1'
      Size = 10
    end
    object SQLPortionRESPONS_CODE_2: TStringField
      FieldName = 'RESPONS_CODE_2'
      Origin = 'MSF385.RESPONS_CODE_2'
      Size = 10
    end
    object SQLPortionRESPONS_CODE_3: TStringField
      FieldName = 'RESPONS_CODE_3'
      Origin = 'MSF385.RESPONS_CODE_3'
      Size = 10
    end
    object SQLPortionRESPONS_CODE_4: TStringField
      FieldName = 'RESPONS_CODE_4'
      Origin = 'MSF385.RESPONS_CODE_4'
      Size = 10
    end
    object SQLPortionCONTRACT_LOCAT: TStringField
      FieldName = 'CONTRACT_LOCAT'
      Origin = 'MSF385.CONTRACT_LOCAT'
    end
    object SQLPortionLIQ_DAM_BASE: TStringField
      FieldName = 'LIQ_DAM_BASE'
      Origin = 'MSF385.LIQ_DAM_BASE'
      Size = 4
    end
  end
  object dbLocal: TDatabase
    AliasName = 'mims'
    DatabaseName = 'dbLocal'
    SessionName = 'SsnActPaid'
    Left = 24
    Top = 71
  end
  object tblSearch: TTable
    CachedUpdates = True
    DatabaseName = 'dbLocal'
    SessionName = 'SsnActPaid'
    FieldDefs = <
      item
        Name = 'CONTRACT_NO'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'PORTION_NO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ACT_PAID_NO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ACT_PAID_DATE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'STATUS'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'SUPPLIER_NO'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'SUPPLIER_NAME'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'APPROVED_BY'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'VALN_NO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'USER_ID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'POSITION_ID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EXT_INV_NO'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <
      item
        Name = 'tblSearchIndex1'
        Fields = 'CONTRACT_NO;PORTION_NO;ACT_PAID_NO'
        Options = [ixPrimary, ixUnique]
      end>
    StoreDefs = True
    TableName = 'SAF3AY'
    Left = 293
    Top = 194
    object tblSearchCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Required = True
      Size = 8
    end
    object tblSearchPORTION_NO: TStringField
      FieldName = 'PORTION_NO'
      Required = True
      Size = 2
    end
    object tblSearchACT_PAID_NO: TStringField
      FieldName = 'ACT_PAID_NO'
      Required = True
      Size = 10
    end
    object tblSearchACT_PAID_DATE: TStringField
      FieldName = 'ACT_PAID_DATE'
      Required = True
      Size = 10
    end
    object tblSearchSTATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      OnGetText = tblSearchSTATUSGetText
      Size = 1
    end
    object tblSearchSUPPLIER_NAME: TStringField
      FieldName = 'SUPPLIER_NAME'
      Required = True
      Size = 32
    end
    object tblSearchAPPROVED_BY: TStringField
      FieldName = 'APPROVED_BY'
      Size = 10
    end
    object tblSearchSUPPLIER_NO: TStringField
      FieldName = 'SUPPLIER_NO'
      Required = True
      Size = 6
    end
    object tblSearchUSER_ID: TStringField
      FieldName = 'USER_ID'
    end
    object tblSearchPOSITION_ID: TStringField
      FieldName = 'POSITION_ID'
    end
    object tblSearchEXT_INV_NO: TStringField
      FieldName = 'EXT_INV_NO'
      Size = 30
    end
  end
  object StblSearch: TDataSource
    DataSet = tblSearch
    Left = 85
    Top = 195
  end
  object SQLCntPrtEleCat: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select A.ELEMENT_NO,C.ELEMENT_CODE,A.CATEGORY_NO,A.CATEG_CODE,'
      '           A.CATEG_BASE_PRC_RT,A.CATEG_BASE_UN,A.CATEG_BASE_VAL,'
      '           B.TABLE_DESC'
      '           From ELLIPSE.MSF387 A INNER JOIN ELLIPSE.MSF010 B ON'
      '             (B.TABLE_TYPE='#39'CE'#39' And'
      '              A.CATEG_CODE=B.TABLE_CODE)'
      '           INNER JOIN ELLIPSE.MSF386 C ON'
      '             (A.CONTRACT_NO = C.CONTRACT_NO And'
      '              A.PORTION_NO = C.PORTION_NO And'
      '              A.ELEMENT_NO = C.ELEMENT_NO )'
      'Where      (A.CONTRACT_NO=:Contract) And'
      '           (A.PORTION_NO=:Portion) And'
      '           ( A.CATEG_CODE NOT IN ('#39'VLPR'#39','#39'VLOT'#39') )'
      'Order By'
      '           A.ELEMENT_NO, A.CATEGORY_NO')
    Left = 161
    Top = 137
    ParamData = <
      item
        DataType = ftString
        Name = 'Contract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'Portion'
        ParamType = ptInput
      end>
    object SQLCntPrtEleCatELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Origin = 'ELEMENT_NO'
      Size = 2
    end
    object SQLCntPrtEleCatELEMENT_CODE: TStringField
      FieldName = 'ELEMENT_CODE'
      Origin = 'ELEMENT_CODE'
      Size = 8
    end
    object SQLCntPrtEleCatCATEGORY_NO: TStringField
      FieldName = 'CATEGORY_NO'
      Origin = 'CATEGORY_NO'
      Size = 2
    end
    object SQLCntPrtEleCatCATEG_CODE: TStringField
      FieldName = 'CATEG_CODE'
      Origin = 'CATEG_CODE'
      Size = 4
    end
    object SQLCntPrtEleCatTABLE_DESC: TStringField
      FieldName = 'TABLE_DESC'
      Origin = 'TABLE_DESC'
      Size = 50
    end
    object SQLCntPrtEleCatCATEG_BASE_UN: TStringField
      FieldName = 'CATEG_BASE_UN'
      Origin = 'CATEG_BASE_UN'
      Size = 4
    end
    object SQLCntPrtEleCatCATEG_BASE_VAL: TCurrencyField
      FieldName = 'CATEG_BASE_VAL'
    end
    object SQLCntPrtEleCatCATEG_BASE_PRC_RT: TCurrencyField
      FieldName = 'CATEG_BASE_PRC_RT'
    end
  end
  object SQLInsActPaid: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'INSERT INTO ELLIPSE.SAF3A0 '
      '              (CONTRACT_NO,PORTION_NO,ACT_PAID_NO,ACT_PAID_DATE,'
      '               CREATED_BY,LAST_CHANGE_BY,APPROVED_BY,STATUS,'
      '               PRV_EXEC_VALUE,PRV_EXEC_VALUE1,TYPE_COMMENTS,'
      '               TYPE_CNTRCT_EXT,AP_INFO_ATAX,CC_TYPE_DSTRB,'
      '               INV_CURRENCY,INV_CHANGE_RATE,INV_CHANGE_RATE_DT,'
      '               APPROVE_DATE,DISCOUNT_FLAG, TPI_FLAG,PERIOD_FROM,'
      '               PERIOD_TO,POS_ENVIADOR,'
      '               POS_APROBADOR,EMP_APROBADOR,FECHA_ENVIO)'
      'VALUES  (:AContract,:APortion,:AnActPaid,:AnActPaidDate,'
      '                 :ACreatedBy,:ALastChangeBy,'#39' '#39','#39'1'#39',0,0,'
      
        '                 :ATypeComments,:ATypeCntrctExt,:AnAPInfoAtax,:A' +
        'nCCTypeDstrb,'
      '                 :ACurrency,1,'#39'00000000'#39','#39'00000000'#39','#39' '#39','#39' '#39','
      '                 '#39'00000000'#39','#39'00000000'#39',:APosAdmin,'#39' '#39','#39' '#39','#39' '#39')')
    Left = 582
    Top = 75
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaidDate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ACreatedBy'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ALastChangeBy'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ATypeComments'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ATypeCntrctExt'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnAPInfoAtax'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnCCTypeDstrb'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ACurrency'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'APosAdmin'
        ParamType = ptUnknown
      end>
  end
  object SQLInsEleCat: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'INSERT INTO ELLIPSE.SAF3A1 '
      '              (CONTRACT_NO,ACT_PAID_NO,ELEMENT_NO,'
      '               CATEGORY_NO,RATE_VALUE,QUANTITY,PAID_VALUE,'
      '               DISCOUNT_FLAG,TPI_FLAG,PERCENT_FLAG)'
      
        'VALUES  (:AContract,:AnActPaid,:AnElement,:ACategory,:ARateValue' +
        ','
      
        '                 :AQuantity,:AValue,:ADiscountFlag,:ATPIFlag,:AP' +
        'ercentFlag)   ')
    Left = 266
    Top = 539
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnElement'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ACategory'
        ParamType = ptInput
      end
      item
        DataType = ftCurrency
        Name = 'ARateValue'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AQuantity'
        ParamType = ptInput
      end
      item
        DataType = ftCurrency
        Name = 'AValue'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADiscountFlag'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ATPIFlag'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APercentFlag'
        ParamType = ptInput
      end>
  end
  object SQLUpdEleCat: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A1 '
      'SET QUANTITY = :AQuantity,'
      '        PAID_VALUE = :AValue'
      'WHERE (CONTRACT_NO=:AContract) And '
      '              (ACT_PAID_NO=:AnActPaid) And'
      '              (ELEMENT_NO=:AnElement) And'
      '              (CATEGORY_NO=:ACategory) '
      '')
    Left = 26
    Top = 467
    ParamData = <
      item
        DataType = ftFloat
        Name = 'AQuantity'
        ParamType = ptInput
      end
      item
        DataType = ftCurrency
        Name = 'AValue'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnElement'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ACategory'
        ParamType = ptInput
      end>
  end
  object SQLLastActCode: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select Max(ACT_PAID_NO) From ELLIPSE.SAF3A0'
      'Where CONTRACT_NO=:AContract')
    Left = 620
    Top = 194
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end>
  end
  object tblCosts: TTable
    CachedUpdates = True
    BeforeInsert = tblCostsBeforeInsert
    BeforePost = tblCostsBeforePost
    OnNewRecord = tblCostsNewRecord
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    FieldDefs = <
      item
        Name = 'CONTRACT_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'ACT_PAID_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ELEMENT_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'GL_ACCOUNT'
        Attributes = [faRequired]
        DataType = ftString
        Size = 24
      end
      item
        Name = 'DOCUMENT_TYPE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DOCUMENT_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'EQUIP_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'PERCENT'
        Attributes = [faRequired]
        DataType = ftString
        Size = 5
      end
      item
        Name = 'VALUE'
        Attributes = [faRequired]
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'SAF3A3IX0'
        Fields = 'CONTRACT_NO;ACT_PAID_NO;ELEMENT_NO;GL_ACCOUNT'
        Options = [ixPrimary, ixUnique]
      end>
    IndexFieldNames = 'CONTRACT_NO;ACT_PAID_NO;ELEMENT_NO;GL_ACCOUNT'
    StoreDefs = True
    TableName = 'ELLIPSE.SAF3A3'
    Left = 366
    Top = 194
    object tblCostsCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Required = True
      Size = 8
    end
    object tblCostsACT_PAID_NO: TStringField
      FieldName = 'ACT_PAID_NO'
      Required = True
      Size = 10
    end
    object tblCostsELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Required = True
      Size = 2
    end
    object tblCostsGL_ACCOUNT: TStringField
      FieldName = 'GL_ACCOUNT'
      Required = True
      OnSetText = tblCostsGL_ACCOUNTSetText
      Size = 24
    end
    object tblCostsDOCUMENT_TYPE: TStringField
      FieldName = 'DOCUMENT_TYPE'
      OnGetText = tblCostsDOCUMENT_TYPEGetText
      OnSetText = tblCostsDOCUMENT_TYPESetText
      Size = 1
    end
    object tblCostsDOCUMENT_NO: TStringField
      FieldName = 'DOCUMENT_NO'
      OnGetText = tblCostsDOCUMENT_NOGetText
      OnSetText = tblCostsDOCUMENT_NOSetText
      Size = 8
    end
    object tblCostsEQUIP_NO: TStringField
      FieldName = 'EQUIP_NO'
      Size = 12
    end
    object tblCostsPERCENT: TStringField
      FieldName = 'PERCENT'
      OnGetText = tblCostsPERCENTGetText
      OnSetText = tblCostsPERCENTSetText
      Size = 5
    end
    object tblCostsVALUE: TCurrencyField
      FieldName = 'VALUE'
    end
  end
  object StblCosts: TDataSource
    DataSet = tblCosts
    Left = 22
    Top = 195
  end
  object SQLElements: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select TABLE_CODE,TABLE_DESC From ELLIPSE.MSF010'
      'Where TABLE_TYPE='#39'EN'#39)
    UniDirectional = True
    Left = 238
    Top = 258
    object SQLElementsTABLE_CODE: TStringField
      FieldName = 'TABLE_CODE'
      Origin = 'TABLE_CODE'
      Size = 18
    end
    object SQLElementsTABLE_DESC: TStringField
      FieldName = 'TABLE_DESC'
      Origin = 'TABLE_DESC'
      Size = 50
    end
  end
  object SQLCntPrtEle: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT DISTINCT A.ELEMENT_NO,'
      '  A.ELEMENT_CODE,'
      '  A.ELEMENT_VAL,'
      '  B.CATEG_CODE'
      'FROM ELLIPSE.MSF386 A'
      'INNER JOIN ELLIPSE.MSF387 B'
      'ON (A.CONTRACT_NO      = B.CONTRACT_NO'
      'AND A.PORTION_NO       = B.PORTION_NO '
      'AND A.ELEMENT_NO       = B.ELEMENT_NO )'
      'WHERE (A.CONTRACT_NO     = :AContract)'
      'AND (A.PORTION_NO        = :APortion)'
      'AND ( B.CATEG_CODE NOT IN ('#39'VLPR'#39','#39'VLOT'#39') )'
      'ORDER BY A.ELEMENT_NO')
    UniDirectional = True
    Left = 709
    Top = 260
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end>
    object SQLCntPrtEleELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Origin = 'ELEMENT_NO'
      Size = 2
    end
    object SQLCntPrtEleELEMENT_CODE: TStringField
      FieldName = 'ELEMENT_CODE'
      Origin = 'MSF386.ELEMENT_CODE'
      Size = 8
    end
    object SQLCntPrtEleELEMENT_VAL: TCurrencyField
      FieldName = 'ELEMENT_VAL'
    end
  end
  object SQLSetActStatus: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A0 '
      'Set STATUS = :AnStatus,'
      '      LAST_CHANGE_BY = :ALastChangeBy,'
      '      POS_ENVIADOR = :APosEnviador'
      'Where  (CONTRACT_NO=:AContract) And '
      '            (ACT_PAID_NO=:AnActPaidNo) And'
      '            (STATUS = :AOldStatus)')
    Left = 229
    Top = 138
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AnStatus'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ALastChangeBy'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APosEnviador'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaidNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'AOldStatus'
        ParamType = ptInput
      end>
  end
  object SQLRep01: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select A.CONTRACT_NO,A.PORTION_NO,A.ELEMENT_NO,'
      '           A.CATEGORY_NO,A.CATEG_CODE,A.CATEG_BASE_QTY,'
      '           A.CATEG_BASE_VAL, B.TABLE_DESC'
      '            From ELLIPSE.MSF387 A,ELLIPSE.MSF010 B'
      'Where A.CONTRACT_NO In'
      '           (Select CONTRACT_NO From ELLIPSE.MSF384 Where '
      '                     (SUPPLIER_NO=:ASupplier) And'
      '                     ( (RESPONS_CODE_1=:AUser1) Or'
      '                      (RESPONS_CODE_2=:AUser2) Or'
      '                      (RESPONS_CODE_3=:AUser3) Or'
      '                      (RESPONS_CODE_4=:AUser4) )'
      '           ) And'
      '           (B.TABLE_TYPE='#39'CE'#39') And'
      '           (A.CATEG_CODE=B.TABLE_CODE) '
      'Order By 1,2,3,4'
      ' ')
    UniDirectional = True
    Left = 969
    Top = 335
    ParamData = <
      item
        DataType = ftString
        Name = 'ASupplier'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser3'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser4'
        ParamType = ptInput
      end>
    object SQLRep01CONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Size = 8
    end
    object SQLRep01PORTION_NO: TStringField
      FieldName = 'PORTION_NO'
      Size = 2
    end
    object SQLRep01ELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Size = 2
    end
    object SQLRep01CATEGORY_NO: TStringField
      FieldName = 'CATEGORY_NO'
      Size = 2
    end
    object SQLRep01CATEG_CODE: TStringField
      FieldName = 'CATEG_CODE'
      Size = 4
    end
    object SQLRep01CATEG_BASE_VAL: TFloatField
      FieldName = 'CATEG_BASE_VAL'
    end
    object SQLRep01TABLE_DESC: TStringField
      FieldName = 'TABLE_DESC'
      Size = 50
    end
    object SQLRep01CATEG_BASE_QTY: TFloatField
      FieldName = 'CATEG_BASE_QTY'
    end
  end
  object SQLRep02: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select A.CONTRACT_NO,A.PORTION_NO,A.ELEMENT_NO,'
      '           A.CATEGORY_NO,A.CATEG_CODE,A.CATEG_BASE_QTY,'
      '           A.CATEG_BASE_VAL, B.TABLE_DESC'
      '            From ELLIPSE.MSF387 A,ELLIPSE.MSF010 B'
      'Where A.CONTRACT_NO In'
      '           (Select CONTRACT_NO From ELLIPSE.MSF384 Where '
      '                      (RESPONS_CODE_1=:AUser1) Or'
      '                      (RESPONS_CODE_2=:AUser2) Or'
      '                      (RESPONS_CODE_3=:AUser3) Or'
      '                      (RESPONS_CODE_4=:AUser4) '
      '           ) And'
      '           (B.TABLE_TYPE='#39'CE'#39') And'
      '           (A.CATEG_CODE=B.TABLE_CODE) '
      'Order By 1,2,3,4 ')
    UniDirectional = True
    Left = 389
    Top = 261
    ParamData = <
      item
        DataType = ftString
        Name = 'AUser1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser3'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser4'
        ParamType = ptInput
      end>
    object SQLRep02CONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Size = 8
    end
    object SQLRep02PORTION_NO: TStringField
      FieldName = 'PORTION_NO'
      Size = 2
    end
    object SQLRep02ELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Size = 2
    end
    object SQLRep02CATEGORY_NO: TStringField
      FieldName = 'CATEGORY_NO'
      Size = 2
    end
    object SQLRep02CATEG_CODE: TStringField
      FieldName = 'CATEG_CODE'
      Size = 4
    end
    object SQLRep02CATEG_BASE_VAL: TFloatField
      FieldName = 'CATEG_BASE_VAL'
    end
    object SQLRep02TABLE_DESC: TStringField
      FieldName = 'TABLE_DESC'
      Size = 50
    end
    object SQLRep02CATEG_BASE_QTY: TFloatField
      FieldName = 'CATEG_BASE_QTY'
    end
  end
  object SQLRep03: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select CONTRACT_NO,CONTRACT_DESC,CNTRCT_BASE_DT,'
      '           CONTRACT_VAL,SUPPLIER_NO,ORIG_COMPL_DT, '
      '           AMEND_COMPL_DT,FINAL_COMPL_DT,DSTRCT_CODE'
      '           From ELLIPSE.MSF384'
      'Where (RESPONS_CODE_1=:AUser1) Or'
      '           (RESPONS_CODE_2=:AUser2) Or'
      '           (RESPONS_CODE_3=:AUser3) Or'
      '           (RESPONS_CODE_4=:AUser4) '
      'Order By CONTRACT_NO')
    UniDirectional = True
    Left = 86
    Top = 139
    ParamData = <
      item
        DataType = ftString
        Name = 'AUser1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser3'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser4'
        ParamType = ptInput
      end>
    object SQLRep03CONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Size = 8
    end
    object SQLRep03CNTRCT_BASE_DT: TStringField
      FieldName = 'CNTRCT_BASE_DT'
      Size = 8
    end
    object SQLRep03CONTRACT_VAL: TCurrencyField
      FieldName = 'CONTRACT_VAL'
    end
    object SQLRep03SUPPLIER_NO: TStringField
      FieldName = 'SUPPLIER_NO'
      Size = 6
    end
    object SQLRep03CONTRACT_DESC: TStringField
      FieldName = 'CONTRACT_DESC'
      Size = 40
    end
    object SQLRep03ORIG_COMPL_DT: TStringField
      FieldName = 'ORIG_COMPL_DT'
      Size = 8
    end
    object SQLRep03AMEND_COMPL_DT: TStringField
      FieldName = 'AMEND_COMPL_DT'
      Size = 8
    end
    object SQLRep03FINAL_COMPL_DT: TStringField
      FieldName = 'FINAL_COMPL_DT'
      Size = 8
    end
    object SQLRep03DSTRCT_CODE: TStringField
      FieldName = 'DSTRCT_CODE'
      Size = 4
    end
  end
  object SQLRep04: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select CONTRACT_NO,PORTION_NO,ACT_PAID_NO, '
      '           ACT_PAID_DATE,STATUS,PRV_EXEC_VALUE'
      '          From ELLIPSE.SAF3A0'
      'Order By CONTRACT_NO,PORTION_NO,ACT_PAID_NO')
    UniDirectional = True
    Left = 541
    Top = 259
    object SQLRep04CONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Origin = 'CONTRACT_NO'
      Size = 8
    end
    object SQLRep04PORTION_NO: TStringField
      FieldName = 'PORTION_NO'
      Origin = 'PORTION_NO'
      Size = 2
    end
    object SQLRep04ACT_PAID_NO: TStringField
      FieldName = 'ACT_PAID_NO'
      Origin = 'ACT_PAID_NO'
      Size = 10
    end
    object SQLRep04ACT_PAID_DATE: TStringField
      FieldName = 'ACT_PAID_DATE'
      Origin = 'ACT_PAID_DATE'
      Size = 8
    end
    object SQLRep04STATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'SAF3A0.STATUS'
      Size = 1
    end
    object SQLRep04PRV_EXEC_VALUE: TCurrencyField
      FieldName = 'PRV_EXEC_VALUE'
    end
  end
  object SQLCntVal: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select Sum(PAID_VALUE) From ELLIPSE.SAF3A1'
      'Where (CONTRACT_NO=:AContract1) And'
      
        '           (ACT_PAID_NO In (Select ACT_PAID_NO From ELLIPSE.SAF3' +
        'A0'
      
        '                                            Where (CONTRACT_NO=:' +
        'AContract0) And'
      
        '                                                        (STATUS ' +
        'IN ('#39'4'#39','#39'5'#39','#39'6'#39','#39'7'#39')) '
      '                                           )'
      '           ) And'
      '           (DISCOUNT_FLAG = '#39'N'#39')'
      ''
      '      ')
    UniDirectional = True
    Left = 152
    Top = 71
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract0'
        ParamType = ptInput
      end>
  end
  object SQLLogo: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select COMPANY_LOGO From ELLIPSE.SAF3A2'
      'Where (LOGO_CODE=:ACode) And (DSTRCT_CODE=:ADistrict)')
    Left = 23
    Top = 259
    ParamData = <
      item
        DataType = ftString
        Name = 'ACode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADistrict'
        ParamType = ptInput
      end>
  end
  object SSQLLogo: TDataSource
    DataSet = SQLLogo
    Left = 24
    Top = 324
  end
  object SQLInfoUser: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select EMPLOYEE_ID From ELLIPSE.MSF020'
      'Where (ENTRY_TYPE='#39'S'#39') And (rtrim(ENTITY) = :AUser) ')
    UniDirectional = True
    Left = 270
    Top = 324
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AUser'
        ParamType = ptUnknown
      end>
  end
  object SQLEmployee: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select EMPLOYEE_ID,SURNAME,FIRST_NAME,SECOND_NAME,'
      '          THIRD_NAME From ELLIPSE.MSF810'
      'Where rtrim(EMPLOYEE_ID)=:Employee')
    Left = 965
    Top = 92
    ParamData = <
      item
        DataType = ftString
        Name = 'Employee'
        ParamType = ptInput
      end>
    object SQLEmployeeSURNAME: TStringField
      FieldName = 'SURNAME'
      Origin = 'SURNAME'
      Size = 30
    end
    object SQLEmployeeFIRST_NAME: TStringField
      FieldName = 'FIRST_NAME'
      Origin = 'FIRST_NAME'
      Size = 12
    end
    object SQLEmployeeSECOND_NAME: TStringField
      FieldName = 'SECOND_NAME'
      Origin = 'SECOND_NAME'
      Size = 12
    end
    object SQLEmployeeTHIRD_NAME: TStringField
      FieldName = 'THIRD_NAME'
      Origin = 'THIRD_NAME'
      Size = 12
    end
    object SQLEmployeeEMPLOYEE_ID: TStringField
      FieldName = 'EMPLOYEE_ID'
      Origin = 'EMPLOYEE_ID'
      Size = 10
    end
  end
  object SQLActPaidExt: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select CREATED_BY,APPROVED_BY,PRV_EXEC_VALUE,'
      '           PRV_EXEC_VALUE1,TYPE_COMMENTS,TYPE_CNTRCT_EXT,'
      '           CC_TYPE_DSTRB,AP_INFO_ATAX,INV_CURRENCY,'
      '           INV_CHANGE_RATE,INV_CHANGE_RATE_DT,APPROVE_DATE,'
      '           PERIOD_FROM,PERIOD_TO'
      '           From ELLIPSE.SAF3A0'
      'Where (CONTRACT_NO=:AContract) And (ACT_PAID_NO=:AnActPaid)')
    Left = 429
    Top = 332
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
    object SQLActPaidExtCREATED_BY: TStringField
      FieldName = 'CREATED_BY'
      Size = 10
    end
    object SQLActPaidExtAPPROVED_BY: TStringField
      FieldName = 'APPROVED_BY'
      Size = 10
    end
    object SQLActPaidExtPRV_EXEC_VALUE: TFloatField
      FieldName = 'PRV_EXEC_VALUE'
    end
    object SQLActPaidExtPRV_EXEC_VALUE1: TFloatField
      FieldName = 'PRV_EXEC_VALUE1'
    end
    object SQLActPaidExtTYPE_COMMENTS: TStringField
      FieldName = 'TYPE_COMMENTS'
      Size = 1
    end
    object SQLActPaidExtTYPE_CNTRCT_EXT: TStringField
      FieldName = 'TYPE_CNTRCT_EXT'
      Size = 1
    end
    object SQLActPaidExtCC_TYPE_DSTRB: TStringField
      FieldName = 'CC_TYPE_DSTRB'
      Origin = 'SAF3A0.CC_TYPE_DSTRB'
      Size = 1
    end
    object SQLActPaidExtAP_INFO_ATAX: TStringField
      FieldName = 'AP_INFO_ATAX'
      Origin = 'SAF3A0.AP_INFO_ATAX'
      Size = 1
    end
    object SQLActPaidExtINV_CURRENCY: TStringField
      FieldName = 'INV_CURRENCY'
      Origin = 'SAF3A0.INV_CURRENCY'
      Size = 4
    end
    object SQLActPaidExtINV_CHANGE_RATE: TFloatField
      FieldName = 'INV_CHANGE_RATE'
      Origin = 'SAF3A0.INV_CHANGE_RATE'
    end
    object SQLActPaidExtINV_CHANGE_RATE_DT: TStringField
      FieldName = 'INV_CHANGE_RATE_DT'
      Origin = 'SAF3A0.INV_CHANGE_RATE_DT'
      Size = 8
    end
    object SQLActPaidExtAPPROVE_DATE: TStringField
      FieldName = 'APPROVE_DATE'
      Size = 8
    end
    object SQLActPaidExtPERIOD_FROM: TStringField
      FieldName = 'PERIOD_FROM'
      Origin = 'SAF3A0.PERIOD_FROM'
      Size = 8
    end
    object SQLActPaidExtPERIOD_TO: TStringField
      FieldName = 'PERIOD_TO'
      Origin = 'SAF3A0.PERIOD_TO'
      Size = 8
    end
  end
  object SQLCntPrtVal: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select Sum(PAID_VALUE) From ELLIPSE.SAF3A1'
      'Where (CONTRACT_NO=:AContract1) And'
      
        '            (ACT_PAID_NO In (Select ACT_PAID_NO From ELLIPSE.SAF' +
        '3A0'
      
        '                                            Where (CONTRACT_NO=:' +
        'AContract0) And'
      
        '                                                        (PORTION' +
        '_NO=:APortion) And'
      
        '                                                        (STATUS ' +
        'in ('#39'4'#39','#39'5'#39','#39'6'#39','#39'7'#39')) '
      '                                           )'
      '             ) And'
      '             (DISCOUNT_FLAG = '#39'N'#39')'
      '           ')
    Left = 217
    Top = 14
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract0'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end>
  end
  object SQLActValue: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select Sum(PAID_VALUE) From ELLIPSE.SAF3A1'
      'Where (CONTRACT_NO=:Contract) And'
      '            (ACT_PAID_NO=:AnActPaid) And '
      '            (DISCOUNT_FLAG = '#39'N'#39') ')
    Left = 87
    Top = 324
    ParamData = <
      item
        DataType = ftString
        Name = 'Contract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
  end
  object SQLCntPrtEleCatVal: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select Sum(PAID_VALUE),Sum(QUANTITY) From ELLIPSE.SAF3A1'
      'Where (CONTRACT_NO=:AContract1) And'
      
        '            (ACT_PAID_NO In (Select ACT_PAID_NO From ELLIPSE.SAF' +
        '3A0'
      
        '                                            Where (CONTRACT_NO=:' +
        'AContract0) And'
      
        '                                                        (PORTION' +
        '_NO=:APortion) And'
      
        '                                                        (STATUS ' +
        'in ('#39'4'#39', '#39'5'#39','#39'6'#39')) '
      '                                           )'
      '             ) And'
      '            (ELEMENT_NO=:AnElement) And'
      '            (CATEGORY_NO=:ACategory)'
      '           ')
    Left = 316
    Top = 21
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract0'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnElement'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ACategory'
        ParamType = ptInput
      end>
  end
  object SQLCntDate: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select CNTRCT_BASE_DT From ELLIPSE.MSF384'
      'Where (CONTRACT_NO=:AContract)')
    Left = 709
    Top = 146
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end>
  end
  object SQLPrtDate: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ORIG_START_DT,AMEND_START_DT From ELLIPSE.MSF385'
      'Where (CONTRACT_NO=:AContract) And'
      '           (PORTION_NO=:APortion)')
    Left = 781
    Top = 475
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end>
    object SQLPrtDateORIG_START_DT: TStringField
      FieldName = 'ORIG_START_DT'
      Origin = 'ORIG_START_DT'
      Size = 8
    end
    object SQLPrtDateAMEND_START_DT: TStringField
      FieldName = 'AMEND_START_DT'
      Origin = 'AMEND_START_DT'
      Size = 8
    end
  end
  object SQLCosts: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT GL_ACCOUNT,EQUIP_NO,WORK_ORDER,PROJECT_NO,'
      '               ALLOC_PC FROM ELLIPSE.MSF232'
      'Where  (DSTRCT_CODE='#39' '#39') And (REQ_232_TYPE='#39'C'#39') And'
      '             (REQUISITION_NO=:AKey)')
    Left = 968
    Top = 148
    ParamData = <
      item
        DataType = ftString
        Name = 'AKey'
        ParamType = ptInput
      end>
    object SQLCostsGL_ACCOUNT: TStringField
      FieldName = 'GL_ACCOUNT'
      Origin = 'MSF232.GL_ACCOUNT'
      Size = 24
    end
    object SQLCostsEQUIP_NO: TStringField
      FieldName = 'EQUIP_NO'
      Origin = 'MSF232.EQUIP_NO'
      Size = 12
    end
    object SQLCostsWORK_ORDER: TStringField
      FieldName = 'WORK_ORDER'
      Origin = 'MSF232.WORK_ORDER'
      Size = 8
    end
    object SQLCostsPROJECT_NO: TStringField
      FieldName = 'PROJECT_NO'
      Origin = 'MSF232.PROJECT_NO'
      Size = 8
    end
    object SQLCostsALLOC_PC: TFloatField
      FieldName = 'ALLOC_PC'
      Origin = 'MSF232.ALLOC_PC'
    end
  end
  object SQLCCVal: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ACCOUNT_CODE From ELLIPSE.MSF966'
      'Where (DSTRCT_CODE=:ADistrict) And '
      '      (ACCOUNT_CODE =:ACenter) ')
    Left = 526
    Top = 332
    ParamData = <
      item
        DataType = ftString
        Name = 'ADistrict'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ACenter'
        ParamType = ptInput
      end>
    object SQLCCValACCOUNT_CODE: TStringField
      FieldName = 'ACCOUNT_CODE'
      Size = 24
    end
  end
  object SQLPendents: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select A.CONTRACT_NO,A.PORTION_NO,A.ACT_PAID_NO,'
      '           A.ACT_PAID_DATE,B.SUPPLIER_NO,B.CONTRACT_VAL,'
      '           B.CURRENCY_TYPE'
      '           From ELLIPSE.SAF3A0 A,ELLIPSE.MSF384 B'
      'Where (A.CONTRACT_NO in (Select CONTRACT_NO From ELLIPSE.MSF384 '
      
        '                                              Where (RESPONS_COD' +
        'E_1=:AnApprover1)  Or'
      
        '                                                         (RESPON' +
        'S_CODE_2=:AnApprover2) Or'
      
        '                                                         (RESPON' +
        'S_CODE_3=:AnApprover3) Or'
      
        '                                                         (RESPON' +
        'S_CODE_4=:AnApprover4)  '
      '                                                 )) And'
      '           (STATUS='#39'2'#39') And'
      '           (A.CONTRACT_NO=B.CONTRACT_NO) ')
    Left = 755
    Top = 82
    ParamData = <
      item
        DataType = ftString
        Name = 'AnApprover1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnApprover2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnApprover3'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnApprover4'
        ParamType = ptInput
      end>
    object SQLPendentsCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Size = 8
    end
    object SQLPendentsPORTION_NO: TStringField
      FieldName = 'PORTION_NO'
      Size = 2
    end
    object SQLPendentsACT_PAID_NO: TStringField
      FieldName = 'ACT_PAID_NO'
      Size = 10
    end
    object SQLPendentsSUPPLIER_NO: TStringField
      FieldName = 'SUPPLIER_NO'
      Size = 6
    end
    object SQLPendentsACT_PAID_DATE: TStringField
      FieldName = 'ACT_PAID_DATE'
      Size = 8
    end
    object SQLPendentsCONTRACT_VAL: TCurrencyField
      FieldName = 'CONTRACT_VAL'
    end
    object SQLPendentsCURRENCY_TYPE: TStringField
      FieldName = 'CURRENCY_TYPE'
      Size = 4
    end
  end
  object StblApprove: TDataSource
    DataSet = tblApprove
    Left = 344
    Top = 475
  end
  object tblApprove: TTable
    CachedUpdates = True
    BeforeInsert = tblApproveBeforeInsert
    BeforePost = tblApproveBeforePost
    AfterPost = tblApproveAfterPost
    DatabaseName = 'dbLocal'
    SessionName = 'SsnActPaid'
    FieldDefs = <
      item
        Name = 'CONTRACT_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'PORTION_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ACT_PAID_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ACT_PAID_DATE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'STATUS'
        Attributes = [faRequired]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CURRENCY'
        Attributes = [faRequired]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'SUPPLIER_NO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'SUPPLIER_NAME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 40
      end
      item
        Name = 'CONTRACT_VAL'
        Attributes = [faRequired]
        DataType = ftCurrency
      end
      item
        Name = 'VALUE'
        Attributes = [faRequired]
        DataType = ftCurrency
      end
      item
        Name = 'BUDGET_VALUE'
        Attributes = [faRequired]
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'tblApproveIndex1'
        Fields = 'CONTRACT_NO;PORTION_NO;ACT_PAID_NO'
        Options = [ixPrimary, ixUnique]
      end>
    StoreDefs = True
    TableName = 'SAF3AZ'
    Left = 443
    Top = 195
    object tblApproveCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Required = True
      Size = 8
    end
    object tblApprovePORTION_NO: TStringField
      FieldName = 'PORTION_NO'
      Required = True
      Size = 2
    end
    object tblApproveACT_PAID_NO: TStringField
      FieldName = 'ACT_PAID_NO'
      Required = True
      Size = 10
    end
    object tblApproveACT_PAID_DATE: TStringField
      FieldName = 'ACT_PAID_DATE'
      Required = True
      Size = 8
    end
    object tblApproveSUPPLIER_NO: TStringField
      FieldName = 'SUPPLIER_NO'
      Required = True
      Size = 6
    end
    object tblApproveSTATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      OnGetText = tblSearchSTATUSGetText
      OnSetText = tblApproveSTATUSSetText
      Size = 1
    end
    object tblApproveCURRENCY: TStringField
      FieldName = 'CURRENCY'
      Required = True
      Size = 4
    end
    object tblApproveSUPPLIER_NAME: TStringField
      FieldName = 'SUPPLIER_NAME'
      Required = True
      Size = 40
    end
    object tblApproveCONTRACT_VAL: TCurrencyField
      FieldName = 'CONTRACT_VAL'
      Required = True
    end
    object tblApproveVALUE: TCurrencyField
      FieldName = 'VALUE'
      Required = True
    end
    object tblApproveBUDGET_VALUE: TCurrencyField
      FieldName = 'BUDGET_VALUE'
      Required = True
    end
  end
  object SQLSetApproved: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A0 '
      'Set STATUS = :AnStatus,'
      '      APPROVED_BY = :AnApprover,'
      '      APPROVE_DATE = :AnApproveDate,'
      '      PRV_EXEC_VALUE = :APrtValue,'
      '      PRV_EXEC_VALUE1 = :ACntValue'
      'Where  (CONTRACT_NO=:AContract) And '
      '            (ACT_PAID_NO=:AnActPaidNo) And'
      '            (STATUS = :AOldStatus)')
    Left = 752
    Top = 20
    ParamData = <
      item
        DataType = ftString
        Name = 'AnStatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnApprover'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnApproveDate'
        ParamType = ptInput
      end
      item
        DataType = ftCurrency
        Name = 'APrtValue'
        ParamType = ptInput
      end
      item
        DataType = ftCurrency
        Name = 'ACntValue'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaidNo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AOldStatus'
        ParamType = ptInput
      end>
  end
  object SQLSupplierId: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select TAX_FILE_NO From ELLIPSE.MSF203'
      'Where (DSTRCT_CODE=:ADistrictCode) And '
      '            (SUPPLIER_NO=:ASupplierNo)')
    Left = 403
    Top = 21
    ParamData = <
      item
        DataType = ftString
        Name = 'ADistrictCode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ASupplierNo'
        ParamType = ptInput
      end>
  end
  object SQLContracts: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select CONTRACT_NO,CNTRCT_BASE_DT,CONTRACT_DESC'
      '           From ELLIPSE.MSF384 '
      'Where '
      '           (RESPONS_CODE_1=:AUser1) Or'
      '           (RESPONS_CODE_2=:AUser2) Or'
      '           (RESPONS_CODE_3=:AUser3) Or'
      '           (RESPONS_CODE_4=:AUser4) ')
    Left = 313
    Top = 260
    ParamData = <
      item
        DataType = ftString
        Name = 'AUser1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser3'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AUser4'
        ParamType = ptInput
      end>
    object SQLContractsCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Size = 8
    end
    object SQLContractsCNTRCT_BASE_DT: TStringField
      FieldName = 'CNTRCT_BASE_DT'
      Size = 8
    end
    object SQLContractsCONTRACT_DESC: TStringField
      FieldName = 'CONTRACT_DESC'
      Size = 40
    end
  end
  object SQLCompany: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select COY_NAME From ELLIPSE.MSF000_SC0001')
    Left = 400
    Top = 79
  end
  object SQLCstmCtg: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ELEMENT_NO, CATEGORY_NO, CATEG_DESC From ELLIPSE.MSF387'
      'Where (CONTRACT_NO=:AContract) And (PORTION_NO=:APortion) '
      '')
    Left = 86
    Top = 71
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APortion'
        ParamType = ptUnknown
      end>
    object SQLCstmCtgELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Size = 2
    end
    object SQLCstmCtgCATEGORY_NO: TStringField
      FieldName = 'CATEGORY_NO'
      Size = 2
    end
    object SQLCstmCtgCATEG_DESC: TStringField
      FieldName = 'CATEG_DESC'
      Size = 40
    end
  end
  object SQLCC_WO: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select WORK_ORDER,DSTRCT_ACCT_CODE, EQUIP_NO'
      ' From ELLIPSE.MSF620'
      'Where (DSTRCT_CODE=:ADistrict) And'
      '            (WORK_ORDER=:AWorkOrder) And'
      '            (FINAL_COSTS <> '#39'Y'#39')')
    Left = 496
    Top = 21
    ParamData = <
      item
        DataType = ftString
        Name = 'ADistrict'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AWorkOrder'
        ParamType = ptInput
      end>
  end
  object SQLCC_Equip: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select EQUIP_NO,ACCOUNT_CODE From ELLIPSE.MSF600'
      'Where (EQUIP_NO=:AnEquip) And'
      '            (ACTIVE_FLG='#39'Y'#39') And'
      '            (COSTING_FLG='#39'A'#39')'
      '')
    Left = 496
    Top = 79
    ParamData = <
      item
        DataType = ftString
        Name = 'AnEquip'
        ParamType = ptInput
      end>
  end
  object SQLCC_Project: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select PROJECT_NO,ACCOUNT_CODE, EQUIP_NO From ELLIPSE.MSF660'
      'Where (DSTRCT_CODE = :ADistrict) And'
      '           (PROJECT_NO = :AProject) And'
      '           (FINAL_COSTS<>'#39'Y'#39')')
    Left = 616
    Top = 258
    ParamData = <
      item
        DataType = ftString
        Name = 'ADistrict'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AProject'
        ParamType = ptInput
      end>
  end
  object SQLUserConfig: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select * From ELLIPSE.SAF3A5'
      'Where DSTRCT_CODE=:ADistrict')
    Left = 96
    Top = 467
    ParamData = <
      item
        DataType = ftString
        Name = 'ADistrict'
        ParamType = ptInput
      end>
    object SQLUserConfigDSTRCT_CODE: TStringField
      FieldName = 'DSTRCT_CODE'
      Origin = 'SAF3A5.DSTRCT_CODE'
      Size = 4
    end
    object SQLUserConfigEMPLOYEE_ID: TStringField
      FieldName = 'EMPLOYEE_ID'
      Origin = 'SAF3A5.EMPLOYEE_ID'
      Size = 10
    end
    object SQLUserConfigCC_TYPE_DSTRB: TStringField
      FieldName = 'CC_TYPE_DSTRB'
      Origin = 'SAF3A5.CC_TYPE_DSTRB'
      Size = 1
    end
    object SQLUserConfigCC_DEFAULT_DSTRB: TStringField
      FieldName = 'CC_DEFAULT_DSTRB'
      Origin = 'SAF3A5.CC_DEFAULT_DSTRB'
      Size = 1
    end
    object SQLUserConfigTYPE_COMMENTS: TStringField
      FieldName = 'TYPE_COMMENTS'
      Origin = 'SAF3A5.TYPE_COMMENTS'
      Size = 1
    end
    object SQLUserConfigTYPE_CNTRCT_EXT: TStringField
      FieldName = 'TYPE_CNTRCT_EXT'
      Origin = 'SAF3A5.TYPE_CNTRCT_EXT'
      Size = 1
    end
    object SQLUserConfigLOAD_INV_TYPE: TStringField
      FieldName = 'LOAD_INV_TYPE'
      Origin = 'SAF3A5.LOAD_INV_TYPE'
      Size = 1
    end
    object SQLUserConfigACT_VALIDATION: TStringField
      FieldName = 'ACT_VALIDATION'
      Origin = 'SAF3A5.ACT_VALIDATION'
      Size = 1
    end
    object SQLUserConfigINV_VALIDATION: TStringField
      FieldName = 'INV_VALIDATION'
      Origin = 'SAF3A5.INV_VALIDATION'
      Size = 1
    end
    object SQLUserConfigTYPE_CNT_LIMIT: TStringField
      FieldName = 'TYPE_CNT_LIMIT'
      Origin = 'SAF3A5.TYPE_CNT_LIMIT'
      Size = 1
    end
    object SQLUserConfigAP_INFO_ATAX: TStringField
      FieldName = 'AP_INFO_ATAX'
      Origin = 'SAF3A5.AP_INFO_ATAX'
      Size = 1
    end
    object SQLUserConfigAP_RIGHT: TStringField
      FieldName = 'AP_RIGHT'
      Origin = 'SAF3A5.AP_RIGHT'
      Size = 1
    end
    object SQLUserConfigAP_SECUENCE: TStringField
      FieldName = 'AP_SECUENCE'
      Origin = 'DBACTPAID.SAF3A5.AP_SECUENCE'
      Size = 1
    end
  end
  object SQLCCCurrent: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      
        'Select ELEMENT_NO,LTRIM(GL_ACCOUNT) AS GL_ACCOUNT,DOCUMENT_TYPE,' +
        'DOCUMENT_NO,'
      '           EQUIP_NO,PERCENT From ELLIPSE.SAF3A6'
      'Where (CONTRACT_NO=:AContract) And'
      '            (PORTION_NO=:APortion)')
    Left = 609
    Top = 331
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end>
    object SQLCCCurrentELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Origin = 'SAF3A6.ELEMENT_NO'
      Size = 2
    end
    object SQLCCCurrentGL_ACCOUNT: TStringField
      FieldName = 'GL_ACCOUNT'
      Origin = 'SAF3A6.GL_ACCOUNT'
      Size = 24
    end
    object SQLCCCurrentDOCUMENT_TYPE: TStringField
      FieldName = 'DOCUMENT_TYPE'
      Origin = 'SAF3A6.DOCUMENT_TYPE'
      Size = 1
    end
    object SQLCCCurrentDOCUMENT_NO: TStringField
      FieldName = 'DOCUMENT_NO'
      Origin = 'SAF3A6.DOCUMENT_NO'
      Size = 8
    end
    object SQLCCCurrentEQUIP_NO: TStringField
      FieldName = 'EQUIP_NO'
      Origin = 'SAF3A6.EQUIP_NO'
      Size = 12
    end
    object SQLCCCurrentPERCENT: TStringField
      FieldName = 'PERCENT'
      Origin = 'SAF3A6.PERCENT'
      Size = 5
    end
  end
  object SQLComments: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    RequestLive = True
    SQL.Strings = (
      'Select CONTRACT_NO,ACT_COMMENTS From ELLIPSE.SAF3A7'
      'Where (CONTRACT_NO= :AContract) And '
      '           (ACT_PAID_NO= :AnActPaid)')
    Left = 704
    Top = 404
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
    object SQLCommentsACT_COMMENTS: TMemoField
      FieldName = 'ACT_COMMENTS'
      BlobType = ftMemo
    end
    object SQLCommentsCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Origin = 'SAF3A7.CONTRACT_NO'
      Size = 8
    end
  end
  object SQLInsMemo: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'INSERT INTO ELLIPSE.SAF3A7'
      '              (CONTRACT_NO,ACT_PAID_NO,ACT_COMMENTS)'
      'VALUES  (:AContract,:AnActPaid,:AnActComments)   ')
    Left = 792
    Top = 332
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end
      item
        DataType = ftMemo
        Name = 'AnActComments'
        ParamType = ptInput
      end>
  end
  object SQLUpdMemo: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A7'
      'Set ACT_COMMENTS = :AnActComments'
      'Where (CONTRACT_NO= :AContract) And '
      '           (ACT_PAID_NO= :AnActPaid)')
    Left = 344
    Top = 412
    ParamData = <
      item
        DataType = ftMemo
        Name = 'AnActComments'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
  end
  object SQLInsCCCrr: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'INSERT INTO ELLIPSE.SAF3A6'
      '              (CONTRACT_NO,PORTION_NO,ELEMENT_NO,GL_ACCOUNT,'
      '               DOCUMENT_TYPE,DOCUMENT_NO,EQUIP_NO,PERCENT)'
      'VALUES  (:AContract,:APortion,:AnElement,:AGLAccount,'
      
        '                 :ADocumentType,:ADocument,:AnEquip,:APercent)  ' +
        ' ')
    Left = 888
    Top = 148
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnElement'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AGLAccount'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADocumentType'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADocument'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnEquip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APercent'
        ParamType = ptInput
      end>
  end
  object SQLUpdCCCrr: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A6'
      'Set PERCENT = :APercent'
      'Where (CONTRACT_NO = :AContract) And'
      '      (PORTION_NO = :APortion) And'
      '      (ELEMENT_NO = :AnElement) And'
      '      (GL_ACCOUNT = :AGLAccount) And'
      '      (DOCUMENT_TYPE = :ADocumentType) And'
      '      (DOCUMENT_NO = :ADocument) And'
      '      (EQUIP_NO = :AnEquip)'
      ''
      '')
    Left = 848
    Top = 92
    ParamData = <
      item
        DataType = ftString
        Name = 'APercent'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnElement'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AGLAccount'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADocumentType'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADocument'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnEquip'
        ParamType = ptInput
      end>
  end
  object SQLDelCCCrr: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'DELETE FROM ELLIPSE.SAF3A6'
      'Where (CONTRACT_NO=:AContract) And'
      '            (PORTION_NO=:APortion) And'
      '            (ELEMENT_NO=:AnElement) And'
      '            (GL_ACCOUNT=:AGLAccount)'
      ''
      '')
    Left = 616
    Top = 412
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnElement'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AGLAccount'
        ParamType = ptInput
      end>
  end
  object SQLUpdActPaid: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A0'
      'Set LAST_CHANGE_BY=:ALastChangeBy,'
      '      TYPE_COMMENTS= :ATypeComments,'
      '      TYPE_CNTRCT_EXT = :ATypeCntrctExt,'
      '       AP_INFO_ATAX = :AnAPInfoAtax,'
      '       INV_CURRENCY = :AnInvCurrency,'
      '       INV_CHANGE_RATE = :AnInvChangeRate,'
      '       INV_CHANGE_RATE_DT = :AnInvChangeRateDt,'
      '       PERIOD_FROM = :APeriodFrom,'
      '       PERIOD_TO = :APeriodTo'
      'Where (CONTRACT_NO=:AContract) And'
      '           (ACT_PAID_NO=:AnActPaid)'
      '                 ')
    Left = 424
    Top = 140
    ParamData = <
      item
        DataType = ftString
        Name = 'ALastChangeBy'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ATypeComments'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ATypeCntrctExt'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnAPInfoAtax'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnInvCurrency'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AnInvChangeRate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnInvChangeRateDt'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APeriodFrom'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APeriodTo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
  end
  object SQLGetInvAut: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select AUTHTY_UPP_LIM From ELLIPSE.MSF872'
      'Where (REC_872_TYPE ='#39'P'#39') And '
      '           (POSITION_ID=:APosition) And'
      '           (DSTRCT_CODE=:ADistrict) And'
      '           (AUTHTY_TYPE='#39'CPAU'#39')')
    Left = 619
    Top = 476
    ParamData = <
      item
        DataType = ftString
        Name = 'APosition'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADistrict'
        ParamType = ptInput
      end>
  end
  object SQLGetCntExt: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select * From ELLIPSE.MSF384'
      'Where (CONTRACT_NO=:AContract)')
    Left = 529
    Top = 476
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end>
  end
  object SQLCntPrtEleVal: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ELEMENT_NO,Sum(PAID_VALUE) From ELLIPSE.SAF3A1'
      'Where (CONTRACT_NO=:AContract1) And'
      
        '            (ACT_PAID_NO In (Select ACT_PAID_NO From ELLIPSE.SAF' +
        '3A0'
      
        '                                            Where (CONTRACT_NO=:' +
        'AContract0) And'
      
        '                                                        (PORTION' +
        '_NO=:APortion) And'
      
        '                                                        (STATUS ' +
        'in ('#39'4'#39','#39'5'#39','#39'6'#39')) '
      '                                           )'
      '             ) '
      'Group By ELEMENT_NO'
      '           ')
    Left = 227
    Top = 71
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AContract0'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'APortion'
        ParamType = ptInput
      end>
  end
  object SQLValEleAct: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ELEMENT_NO,Sum(PAID_VALUE) From ELLIPSE.SAF3A1'
      'Where (CONTRACT_NO=:AContract) And'
      '            (ACT_PAID_NO =:AnActPaid) '
      'Group By ELEMENT_NO'
      '           ')
    Left = 1104
    Top = 471
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
  end
  object SQLGetCrrRt: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select BUYING_RATE From ELLIPSE.MSF912'
      'Where (rtrim(LOCAL_CURRENCY)  = :ALocalCrr) And'
      '           (rtrim(FOREIGN_CURR)        = :AForeignCrr) And'
      '           (rtrim(DATE_PER_REVSD) >= :ADate)'
      'Order By DATE_PER_REVSD')
    Left = 272
    Top = 405
    ParamData = <
      item
        DataType = ftString
        Name = 'ALocalCrr'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AForeignCrr'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADate'
        ParamType = ptInput
      end>
  end
  object SQLGetLocCrr: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select LOCAL_CURRENCY From ELLIPSE.MSF000_DC0001'
      'Where DSTRCT_CODE = UPPER(:ADistrict)')
    Left = 438
    Top = 405
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADistrict'
        ParamType = ptUnknown
      end>
  end
  object SQLInfoAtax: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select * From ELLIPSE.SAF3A8'
      'Where (CONTRACT_NO=:AContract) And (ACT_PAID_NO=:AnActPaid)')
    Left = 1072
    Top = 29
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
    object SQLInfoAtaxCONTRACT_NO: TStringField
      FieldName = 'CONTRACT_NO'
      Origin = 'SAF3A8.CONTRACT_NO'
      Size = 8
    end
    object SQLInfoAtaxACT_PAID_NO: TStringField
      FieldName = 'ACT_PAID_NO'
      Origin = 'SAF3A8.ACT_PAID_NO'
      Size = 10
    end
    object SQLInfoAtaxATAX_CODE: TStringField
      FieldName = 'ATAX_CODE'
      Origin = 'SAF3A8.ATAX_CODE'
      Size = 4
    end
    object SQLInfoAtaxATAX_RATE: TFloatField
      FieldName = 'ATAX_RATE'
      Origin = 'SAF3A8.ATAX_RATE'
    end
    object SQLInfoAtaxATAX_BASE: TFloatField
      FieldName = 'ATAX_BASE'
      Origin = 'SAF3A8.ATAX_BASE'
    end
    object SQLInfoAtaxATAX_VALUE: TFloatField
      FieldName = 'ATAX_VALUE'
      Origin = 'SAF3A8.ATAX_VALUE'
    end
  end
  object tblInfoAtax: TTable
    CachedUpdates = True
    BeforePost = tblInfoAtaxBeforePost
    OnCalcFields = tblInfoAtaxCalcFields
    OnNewRecord = tblInfoAtaxNewRecord
    DatabaseName = 'dbLocal'
    SessionName = 'SsnActPaid'
    FieldDefs = <
      item
        Name = 'ATAX_CODE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ATAX_RATE'
        Attributes = [faRequired]
        DataType = ftFloat
      end
      item
        Name = 'ATAX_BASE'
        Attributes = [faRequired]
        DataType = ftCurrency
      end
      item
        Name = 'ATAX_VALUE'
        Attributes = [faRequired]
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'tblInfoAtaxIndex1'
        Fields = 'ATAX_CODE'
        Options = [ixPrimary, ixUnique]
      end>
    StoreDefs = True
    TableName = 'SAF3AT'
    Left = 968
    Top = 205
    object tblInfoAtaxATAX_CODE: TStringField
      FieldName = 'ATAX_CODE'
      Required = True
      OnChange = tblInfoAtaxATAX_CODEChange
      Size = 4
    end
    object tblInfoAtaxATAX_RATE: TFloatField
      FieldName = 'ATAX_RATE'
      Required = True
      OnChange = tblInfoAtaxATAX_RATEChange
    end
    object tblInfoAtaxATAX_BASE: TCurrencyField
      FieldName = 'ATAX_BASE'
      Required = True
      OnChange = tblInfoAtaxATAX_RATEChange
    end
    object tblInfoAtaxATAX_VALUE: TCurrencyField
      FieldName = 'ATAX_VALUE'
      Required = True
    end
    object tblInfoAtaxATAX_LK_CODE: TStringField
      FieldKind = fkLookup
      FieldName = 'ATAX_LK_CODE'
      LookupDataSet = SQLAtaxCodes010
      LookupKeyFields = 'TABLE_CODE'
      LookupResultField = 'TABLE_CODE'
      KeyFields = 'ATAX_CODE'
      Required = True
      Size = 4
      Lookup = True
    end
    object tblInfoAtaxATAX_LK_DESC: TStringField
      FieldKind = fkLookup
      FieldName = 'ATAX_LK_DESC'
      LookupDataSet = SQLAtaxCodes010
      LookupKeyFields = 'TABLE_CODE'
      LookupResultField = 'TABLE_DESC'
      KeyFields = 'ATAX_CODE'
      Size = 16
      Lookup = True
    end
    object tblInfoAtaxATAX_CALC_VALUE: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ATAX_CALC_VALUE'
      Calculated = True
    end
  end
  object StblInfoAtax: TDataSource
    DataSet = tblInfoAtax
    Left = 348
    Top = 325
  end
  object SQLAtaxCodes010: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select TABLE_CODE,TABLE_DESC,ASSOC_REC From ELLIPSE.MSF010'
      'Where TABLE_TYPE = '#39'+TAX'#39)
    Left = 781
    Top = 406
    object SQLAtaxCodes010TABLE_CODE: TStringField
      FieldName = 'TABLE_CODE'
      Origin = 'MSF010.TABLE_CODE'
      Size = 18
    end
    object SQLAtaxCodes010TABLE_DESC: TStringField
      FieldName = 'TABLE_DESC'
      Origin = 'MSF010.TABLE_DESC'
      Size = 50
    end
    object SQLAtaxCodes010ASSOC_REC: TStringField
      FieldName = 'ASSOC_REC'
      Origin = 'MSF010.ASSOC_REC'
      Size = 50
    end
  end
  object SQLGetCrr: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select DISTINCT LOCAL_CURRENCY  From ELLIPSE.MSF912'
      'Union'
      'Select DISTINCT FOREIGN_CURR From ELLIPSE.MSF912')
    Left = 29
    Top = 398
  end
  object SQLInsInfAtx: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Insert Into ELLIPSE.SAF3A8(CONTRACT_NO,ACT_PAID_NO,ATAX_CODE,'
      '                              ATAX_RATE,ATAX_BASE, ATAX_VALUE)'
      
        '                Values(:AContract,:AnActPaid,:AnAtaxCode,:AnAtax' +
        'Rate,'
      '                            :AnAtaxBase,:AnAtaxValue)')
    Left = 536
    Top = 542
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnAtaxCode'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'AnAtaxRate'
        ParamType = ptInput
      end
      item
        DataType = ftCurrency
        Name = 'AnAtaxBase'
        ParamType = ptInput
      end
      item
        DataType = ftCurrency
        Name = 'AnAtaxValue'
        ParamType = ptInput
      end>
  end
  object SQLDelInfAtx: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Delete From ELLIPSE.SAF3A8'
      'Where (CONTRACT_NO=:AContract) And'
      '           (ACT_PAID_NO=:AnActPaid)')
    Left = 703
    Top = 542
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
  end
  object SQLPrvAPCode: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ACT_PAID_DATE,ACT_PAID_NO from ELLIPSE.SAF3A0'
      'Where (CONTRACT_NO = :AContract) And'
      '           (ACT_PAID_DATE < :AnActPaidDate)'
      'Order By ACT_PAID_DATE DESC')
    Left = 1096
    Top = 405
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'AnActPaidDate'
        ParamType = ptInput
      end>
  end
  object SQLActBdgVal: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select Sum(PAID_VALUE) From ELLIPSE.SAF3A1'
      'Where (CONTRACT_NO=:Contract) And'
      '            (ACT_PAID_NO=:AnActPaid) And '
      '            (DISCOUNT_FLAG = '#39'N'#39')')
    Left = 845
    Top = 28
    ParamData = <
      item
        DataType = ftString
        Name = 'Contract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
  end
  object SQLToday: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select SYSDATE from DUAL')
    Left = 614
    Top = 542
  end
  object SQLEleNoDefs: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select TABLE_CODE, ASSOC_REC from ELLIPSE.MSF010 '
      'Where TABLE_TYPE='#39'+DES'#39)
    Left = 576
    Top = 21
    object SQLEleNoDefsTABLE_CODE: TStringField
      FieldName = 'TABLE_CODE'
      Origin = 'MSF010.TABLE_CODE'
      Size = 18
    end
    object SQLEleNoDefsASSOC_REC: TStringField
      FieldName = 'ASSOC_REC'
      Origin = 'MSF010.ASSOC_REC'
      Size = 50
    end
  end
  object SQLThrdPrtyInv: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select AR_INV_NO From ELLIPSE.MSF560'
      'Where (DSTRCT_CODE = :ADistrict) And'
      '            (AR_INV_NO = :AnOP)')
    Left = 709
    Top = 197
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADistrict'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnOP'
        ParamType = ptUnknown
      end>
  end
  object SQLCntOriCod: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select STD_STATIC_1 From ELLIPSE.MSF096_STD_STATIC'
      'Where (STD_TEXT_CODE = '#39'AD'#39') And'
      '            (STD_KEY = :AContract) And'
      '           (STD_LINE_NO = '#39'0000'#39')')
    Left = 656
    Top = 21
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end>
  end
  object SQLValCCDst: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ELEMENT_NO,GL_ACCOUNT,DOCUMENT_TYPE,DOCUMENT_NO'
      '           From ELLIPSE.SAF3A3'
      '           Where (CONTRACT_NO=:AContract) And '
      '                       (ACT_PAID_NO=:AnActPaid)')
    Left = 461
    Top = 261
    ParamData = <
      item
        DataType = ftString
        Name = 'AContract'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'AnActPaid'
        ParamType = ptInput
      end>
    object SQLValCCDstELEMENT_NO: TStringField
      FieldName = 'ELEMENT_NO'
      Origin = 'SAF3A3.ELEMENT_NO'
      Size = 2
    end
    object SQLValCCDstGL_ACCOUNT: TStringField
      FieldName = 'GL_ACCOUNT'
      Origin = 'SAF3A3.GL_ACCOUNT'
      Size = 24
    end
    object SQLValCCDstDOCUMENT_TYPE: TStringField
      FieldName = 'DOCUMENT_TYPE'
      Origin = 'SAF3A3.DOCUMENT_TYPE'
      OnGetText = tblCostsDOCUMENT_TYPEGetText
      Size = 1
    end
    object SQLValCCDstDOCUMENT_NO: TStringField
      FieldName = 'DOCUMENT_NO'
      Origin = 'SAF3A3.DOCUMENT_NO'
      Size = 8
    end
  end
  object SQLElementPlus: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      
        'select table_code, table_desc, assoc_rec from ELLIPSE.msf010 whe' +
        're '
      'table_type = '#39'+ELE'#39' ')
    Left = 880
    Top = 470
  end
  object SQLAIUXPrc: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select AUTHTY_GIVEN From ELLIPSE.MSF872'
      'Where (REC_872_TYPE ='#39'P'#39') And '
      '           (POSITION_ID=:APosition) And'
      '           (DSTRCT_CODE=:ADistrict) And'
      '           (AUTHTY_TYPE='#39'+AIU'#39')')
    Left = 887
    Top = 199
    ParamData = <
      item
        DataType = ftString
        Name = 'APosition'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADistrict'
        ParamType = ptInput
      end>
  end
  object SQLValSppAct: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select SUP_STATUS From ELLIPSE.MSF200'
      'Where SUPPLIER_NO=:ASupplierNo')
    Left = 196
    Top = 405
    ParamData = <
      item
        DataType = ftString
        Name = 'ASupplierNo'
        ParamType = ptInput
      end>
  end
  object SQLValCCMims: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select ACCOUNT_IND, ACTIVE_STATUS,'
      'WO_ENTRY_IND,PROJ_ENTRY_IND,EQUIP_ENTRY_IND'
      'From ELLIPSE.MSF966'
      'Where (DSTRCT_CODE=:ADistrict) And '
      '      (rtrim(ACCOUNT_CODE) =:ACenter)')
    Left = 1072
    Top = 206
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADistrict'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'ACenter'
        ParamType = ptInput
      end>
  end
  object SQLValGLMims: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select COST_CTRE_SEG, ACTIVE_STATUS from ELLIPSE.MSF920 '
      'where DSTRCT_CODE=:ADistrict and'
      'COST_CTRE_SEG=:ACostCentre')
    Left = 109
    Top = 542
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADistrict'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'ACostCentre'
        ParamType = ptInput
      end>
  end
  object SQLCurrentHier: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select current_hier from ELLIPSE.msf000_sc0001')
    Left = 984
    Top = 405
  end
  object SQLActEnviadoPor: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select pos_enviador from ELLIPSE.saf3a0 where'
      'contract_no = :AContract and'
      'act_paid_no = :AActPaid')
    Left = 173
    Top = 324
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AActPaid'
        ParamType = ptUnknown
      end>
  end
  object SQLValMinMaxACCP: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select authty_low_lim, authty_upp_lim from ELLIPSE.msf872'
      'where rec_872_type = '#39'P'#39' and'
      'rtrim(position_id) = :APosEnviador and'
      'dstrct_code = :ADistrito and'
      'authty_type = '#39'ACCP'#39)
    Left = 525
    Top = 195
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'APosEnviador'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ADistrito'
        ParamType = ptUnknown
      end>
  end
  object SQLBuscaSup: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select superior_id from ELLIPSE.msf875 where'
      'rtrim(hier_details) = :AHierarchy and'
      'rtrim(position_id) = :APosition')
    Left = 23
    Top = 542
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AHierarchy'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APosition'
        ParamType = ptUnknown
      end>
  end
  object SQLGetSecCurr: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select SECOND_CURR From ELLIPSE.MSF000_DC0001'
      'Where DSTRCT_CODE = :ADistrict')
    Left = 704
    Top = 473
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADistrict'
        ParamType = ptUnknown
      end>
  end
  object SQLGetCurrType: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select CURRENCY_TYPE from ELLIPSE.msf384'
      'where contract_no = :AContract')
    Left = 792
    Top = 147
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end>
  end
  object SQLUpdAppr: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A0'
      'Set EMP_APROBADOR=:AnApprover,'
      '      APPROVED_BY=:AnApproverBy,'
      '      POS_APROBADOR=:APosApprover,'
      '      APPROVE_DATE=:ADate,'
      '      STATUS=:AStatus'
      'Where (CONTRACT_NO=:AContract) And'
      '           (ACT_PAID_NO=:AnActPaid)')
    Left = 622
    Top = 141
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AnApprover'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnApproverBy'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APosApprover'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ADate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AStatus'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaid'
        ParamType = ptUnknown
      end>
  end
  object SQLupdEnviador: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'UPDATE ELLIPSE.SAF3A0'
      'Set  POS_ENVIADOR = :APosSender,'
      '       FECHA_ENVIO = :ASentDate'
      'Where  (CONTRACT_NO=:AContract) And '
      '             (ACT_PAID_NO=:AnActPaidNo)')
    Left = 662
    Top = 77
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'APosSender'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ASentDate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaidNo'
        ParamType = ptUnknown
      end>
  end
  object SQLGetCurrStatus: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select status from ELLIPSE.saf3a0 where'
      'contract_no = :AContract and'
      'act_paid_no = :AnActPaidNo')
    Left = 1073
    Top = 94
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaidNo'
        ParamType = ptUnknown
      end>
  end
  object SQLGetUserIdPos: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select employee_id from ELLIPSE.msf878 where'
      'rtrim(position_id) = :APosition')
    Left = 793
    Top = 198
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'APosition'
        ParamType = ptUnknown
      end>
  end
  object SQLGetPosApprover: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select pos_aprobador from ELLIPSE.saf3a0 where'
      'contract_no = :AContractNo and'
      'act_paid_no = :AActPaidNo')
    Left = 776
    Top = 542
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContractNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AActPaidNo'
        ParamType = ptUnknown
      end>
  end
  object SQLBuscaSub: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select trim(position_id) from ELLIPSE.msf875 where'
      'hier_details = :AHierarchy and'
      'rtrim(superior_id) = :APosition')
    Left = 704
    Top = 333
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AHierarchy'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APosition'
        ParamType = ptUnknown
      end>
  end
  object SQLDelCCA3Zero: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'delete from ELLIPSE.saf3a3'
      'where'
      'contract_no = :contract_no and'
      'act_paid_no = :act_paid_no and'
      'value = 0 and'
      'percent = '#39'00000'#39)
    Left = 349
    Top = 541
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'contract_no'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'act_paid_no'
        ParamType = ptUnknown
      end>
  end
  object SQLDelCCA6Zero: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'delete from ELLIPSE.saf3a6'
      'where'
      'contract_no = :contract_no and'
      'percent = '#39'00000'#39)
    Left = 528
    Top = 413
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'contract_no'
        ParamType = ptUnknown
      end>
  end
  object SQLGetEmpNames: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select surname, first_name from ELLIPSE.msf810'
      'where'
      'rtrim(employee_id) in'
      '(select rtrim(employee_id)'
      'from ELLIPSE.msf878'
      'where '
      '(rtrim(position_id) = :Aposition_app) and'
      '(TO_CHAR(99999999 - INV_STR_DATE) <= :AValidDate ) and'
      '((pos_stop_date >= :AValidDate) or '
      '(pos_stop_date = '#39'00000000'#39')))')
    Left = 1069
    Top = 266
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Aposition_app'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AValidDate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AValidDate'
        ParamType = ptUnknown
      end>
  end
  object SQLValorPrevio: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      
        'select prv_exec_value from ELLIPSE.saf3a0 where contract_no = :A' +
        'Contract and'
      'act_paid_no in (select max(act_paid_no) '
      'from ELLIPSE.saf3a0 where contract_no = :AContract1 and'
      'prv_exec_value <> 0)')
    Left = 992
    Top = 540
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AContract1'
        ParamType = ptUnknown
      end>
  end
  object SQLValorActa: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select'
      '  --sum(paid_value) '
      '  nvl(sum(paid_value),0)'
      'from'
      ' ELLIPSE.saf3a1 '
      'where'
      ' contract_no = :AContract and'
      ' act_paid_no = :AnActPaid and'
      ' discount_flag = '#39'N'#39)
    Left = 1075
    Top = 149
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaid'
        ParamType = ptUnknown
      end>
  end
  object UpdValorPevio: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'update ELLIPSE.saf3a0 set prv_exec_value = :AValue where'
      'contract_no = :AContract and'
      'act_paid_no = :AnActPaid')
    Left = 184
    Top = 541
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AValue'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaid'
        ParamType = ptUnknown
      end>
  end
  object SQLRestaValor: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select sum(paid_value) from ELLIPSE.saf3a1 a, ELLIPSE.saf3a0 b'
      'where a.contract_no = :AContract'
      'and b.status in ('#39'4'#39','#39'5'#39','#39'6'#39','#39'7'#39') and'
      'a.contract_no = b.contract_no and'
      'a.act_paid_no = b.act_paid_no and'
      'a.act_paid_no < :AActPaid and'
      'b.portion_no = :APortion and'
      'a.discount_flag = '#39'N'#39)
    Left = 880
    Top = 334
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AActPaid'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APortion'
        ParamType = ptUnknown
      end>
  end
  object SQLGetAnalista: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select employ_type_1, respons_code_1, '
      'employ_type_2, respons_code_2, '
      'employ_type_3, respons_code_3, '
      'employ_type_4, respons_code_4'
      'from ELLIPSE.msf385 where contract_no = :AContract_no and'
      'portion_no = :APortion_no')
    Left = 1112
    Top = 542
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract_no'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APortion_no'
        ParamType = ptUnknown
      end>
  end
  object SQLGetElemAI: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select element_no from '
      'ELLIPSE.saf3a1 a, ELLIPSE.saf3a0 b'
      'where'
      'a.contract_no = :AContract and'
      'a.element_no = '#39'AI'#39' and'
      'a.contract_no = b.contract_no and'
      'a.act_paid_no <> :AnActPaidNo')
    Left = 880
    Top = 262
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaidNo'
        ParamType = ptUnknown
      end>
  end
  object SQLGetLastChg: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select last_change_by from ELLIPSE.saf3a0 where'
      'contract_no = :AContract and'
      'act_paid_no = :AnActPaid')
    Left = 181
    Top = 470
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaid'
        ParamType = ptUnknown
      end>
  end
  object SQLValorPagado: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      
        'select sum(paid_value) from ELLIPSE.saf3a0 a, ELLIPSE.saf3a1 b w' +
        'here'
      'a.contract_no = :AContract and'
      'a.contract_no = b.contract_no and'
      'a.act_paid_no = b.act_paid_no and'
      'a.portion_no = :APortion and'
      'a.status <> '#39'1'#39' and'
      'a.status <> '#39'3'#39)
    Left = 888
    Top = 401
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APortion'
        ParamType = ptUnknown
      end>
  end
  object SQLGetSentDate: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select fecha_envio from ELLIPSE.saf3a0 where '
      'contract_no = :AContract and'
      'act_paid_no = :AnActPaid and'
      'portion_no = :APortion')
    Left = 440
    Top = 472
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AnActPaid'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APortion'
        ParamType = ptUnknown
      end>
  end
  object SQLGetContractAdministrator: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select'
      '    EMPLOY_TYPE_1,'
      '    EMPLOY_TYPE_2,'
      '    EMPLOY_TYPE_3,'
      '    EMPLOY_TYPE_4,'
      '    RESPONS_CODE_1,'
      '    RESPONS_CODE_2,'
      '    RESPONS_CODE_3,'
      '    RESPONS_CODE_4'
      'From'
      '    ELLIPSE.MSF385'
      'Where '
      '    (CONTRACT_NO=:Contract_no ) And (PORTION_NO=:Portion_no)')
    Left = 960
    Top = 25
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Contract_no'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Portion_no'
        ParamType = ptUnknown
      end>
  end
  object SQLGetAtaxDesc010: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select TABLE_CODE,TABLE_DESC,ASSOC_REC From ELLIPSE.MSF010'
      'Where TABLE_TYPE = '#39'+TAX'#39' and Trim(TABLE_CODE) = :Atax')
    Left = 93
    Top = 398
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Atax'
        ParamType = ptUnknown
      end>
    object StringField1: TStringField
      FieldName = 'TABLE_CODE'
      Origin = 'MSF010.TABLE_CODE'
      Size = 18
    end
    object StringField2: TStringField
      FieldName = 'TABLE_DESC'
      Origin = 'MSF010.TABLE_DESC'
      Size = 50
    end
    object StringField3: TStringField
      FieldName = 'ASSOC_REC'
      Origin = 'MSF010.ASSOC_REC'
      Size = 50
    end
  end
  object SQLGetAuthyValue: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'Select authty_given From ELLIPSE.MSF872'
      'Where (REC_872_TYPE ='#39'P'#39') And '
      '           (trim(POSITION_ID) = :Position ) And'
      '           (trim(DSTRCT_CODE) = :Dstrct ) And'
      '           (trim(AUTHTY_TYPE) = :AuthTy )')
    Left = 872
    Top = 540
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Position'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Dstrct'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AuthTy'
        ParamType = ptUnknown
      end>
  end
  object SQLGetMinPorEle: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT MIN (A.ELEMENT_NO)'
      'FROM ELLIPSE.MSF386 A'
      'INNER JOIN ELLIPSE.MSF387 B'
      'ON (A.CONTRACT_NO      = B.CONTRACT_NO'
      'AND A.PORTION_NO       = B.PORTION_NO '
      'AND A.ELEMENT_NO       = B.ELEMENT_NO )'
      'WHERE (trim(A.CONTRACT_NO)     = trim(:AContract))'
      'AND (trim(A.PORTION_NO)        = trim(:APortion))'
      'AND ( B.CATEG_CODE IN ('#39'VLPR'#39','#39'VLOT'#39') )'
      'ORDER BY A.ELEMENT_NO')
    Left = 443
    Top = 532
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContract'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APortion'
        ParamType = ptUnknown
      end>
  end
  object SQLValnNo: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT '
      'trim(Max(substr(entity_value, 9,4 ) )) as valnno'
      'FROM MSF071 WHERE entity_type = '#39'EV2'#39' '
      'and ref_no = '#39'001'#39' '
      'and seq_num = '#39'001'#39' '
      'and Trim(entity_value) > Trim(:ContractNo)'
      'and Trim(REF_CODE) = Trim(:ActPaidNo)')
    Left = 963
    Top = 261
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ContractNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ActPaidNo'
        ParamType = ptUnknown
      end>
  end
  object SQLSearchUserPositionID: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT '
      'b.SUPERIOR_ID as SUPERIOR_ID, c.EMPLOYEE_ID as EMPLOYEE_ID '
      
        'FROM ellipse.saf3a0 a, ellipse.msf875 b, ellipse.msf878 c WHERE ' +
        'rpad(a.pos_enviador,10,'#39' '#39') = b.position_id '
      'and b.superior_id = c.position_id '
      
        'and (c.pos_stop_date = '#39'00000000'#39' OR c.pos_stop_date>=TO_CHAR(sy' +
        'sdate,'#39'YYYYMMDD'#39')) '
      'and Trim(a.contract_no) = Trim(:ContractNo) '
      'and Trim(a.act_paid_no) = Trim(:ActPaidNo) '
      'and rownum < 2')
    Left = 989
    Top = 470
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ContractNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ActPaidNo'
        ParamType = ptUnknown
      end>
  end
  object SQLLevelAccess: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT '
      '  GLOBAL_PROFILE '
      'FROM ellipse.MSF870 '
      'WHERE trim(POSITION_ID) = trim(:MimsPosition)')
    Left = 315
    Top = 71
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MimsPosition'
        ParamType = ptUnknown
      end>
  end
  object SQLLevelAccessReal: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT '
      '  DISTINCT(ACCESS_LEVEL) '
      'FROM ellipse.MSF870, ellipse.MSF02A '
      'WHERE trim(POSITION_ID) = trim(:MimsPosition) '
      'AND trim(GLOBAL_PROFILE)=trim(ENTITY) '
      'AND trim(APPLICATION_NAME) = '#39'SAQ301'#39)
    Left = 519
    Top = 138
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MimsPosition'
        ParamType = ptUnknown
      end>
  end
  object SQLDeleteSpecialChar: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT '
      
        'REGEXP_REPLACE(trim(:MimsFieldValue), '#39'[^A-Za-z0-9'#193#201#205#211#218#225#233#237#243#250' ]'#39',' +
        #39#39') AS FIELD_VALUE '
      'FROM DUAL')
    Left = 328
    Top = 138
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MimsFieldValue'
        ParamType = ptUnknown
      end>
  end
  object SQLDeleteZeroPaidValue: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'DELETE FROM '
      'ELLIPSE.SAF3A1 '
      'WHERE '
      '  CONTRACT_NO = :ContractNo AND '
      '  ACT_PAID_NO = :ActPaidNo AND '
      '  PAID_VALUE = 0')
    Left = 1069
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ContractNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ActPaidNo'
        ParamType = ptUnknown
      end>
  end
  object SQLCheckCCList: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'select portion_no,ELEMENT_NO, sum(percent) total'
      'FROM ELLIPSE.SAF3A6'
      'WHERE CONTRACT_NO = :ContractNo AND PORTION_NO = :PortionNo'
      'group by portion_no, ELEMENT_NO'
      '')
    Left = 848
    Top = 92
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ContractNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PortionNo'
        ParamType = ptUnknown
      end>
  end
  object SQLElementCode: TQuery
    DatabaseName = 'dbActPaid'
    SessionName = 'SsnActPaid'
    SQL.Strings = (
      'SELECT ELEMENT_CODE FROM ELLIPSE.MSF386 '
      'Where'
      'CONTRACT_NO = :AContractNo and'
      'Portion_No = :APortionNo And'
      'ELEMENT_NO = :AElementNo')
    Left = 140
    Top = 378
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AContractNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APortionNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AElementNo'
        ParamType = ptUnknown
      end>
  end
end
