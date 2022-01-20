unit MCObjcts;

{ This unit define the classes for the auxiliary Objects used in the Acts
  Paid module }
interface
Uses classes,SysUtils,Windows,Registry,MCTypes,Qdialogs;



Type
     { Forward declarations }

     TElementVals = Class;

     { Memory version of the Configuration System for the current user,
       defined in the table SAF3A5 and controlled by SAQ305 }
     TUserConfig = Class
     Private
        FCCTypeDstrb:     TCCTypeDstrb;
        FCCDefaultDstrb:  TCCDefaultDstrb;
        FTypeComments:    TTypeComments;
        FTypeCntrctExt:   TTypeCntrctExt;
        FLoadInvType:     TLoadInvType;
        FActValidation:   TActValidation;
        FInvValidation:   TInvValidation;
        FTypeCntLimit:    TTypeCntLimit;
        FAPInfoAtax:      TAPInfoAtax;
        FAPRight:         TAPRight;
        FDCCDefaultDstrb: TCCDefaultDstrb;
        FDTypeComments:   TTypeComments;
        FDTypeCntrctExt:  TTypeCntrctExt;
        FDCCTypeDstrb:    TCCTypeDstrb;
        FDAPInfoAtax:     TAPInfoAtax;
        FAPSecuence:      TAPSecuence;
     Public               
        Constructor Create;
        { District Configuration for the current user }
        Property CCTypeDstrb:     TCCTypeDstrb    Read FCCTypeDstrb     Write FCCTypeDstrb;
        Property CCDefaultDstrb:  TCCDefaultDstrb Read FCCDefaultDstrb  Write FCCDefaultDstrb;
        Property TypeComments:    TTypeComments   Read FTypeComments    Write FTypeComments;
        Property TypeCntrctExt:   TTypeCntrctExt  Read FTypeCntrctExt   Write FTypeCntrctExt;
        Property LoadInvType:     TLoadInvType    Read FLoadInvType     Write FLoadInvType;
        Property ActValidation:   TActValidation  Read FActValidation   Write FActValidation;
        Property InvValidation:   TInvValidation  Read FInvValidation   Write FInvValidation;
        Property TypeCntLimit:    TTypeCntLimit   Read FTypeCntLimit    Write FTypeCntLimit;
        Property APInfoAtax:      TAPInfoAtax     Read FAPInfoAtax      Write FAPInfoAtax;
        Property APRight:         TAPRight        Read FAPRight         Write FAPRight;
        Property APSecuence:      TAPSecuence     Read FAPSecuence      Write FAPSecuence;
        { Preferences in the current document }
        Property DCCDefaultDstrb: TCCDefaultDstrb Read FDCCDefaultDstrb Write FDCCDefaultDstrb;
        Property DTypeComments:   TTypeComments   Read FDTypeComments   Write FDTypeComments;
        Property DTypeCntrctExt:  TTypeCntrctExt  Read FDTypeCntrctExt  Write FDTypeCntrctExt;
        Property DCCTypeDstrb:    TCCTypeDstrb    Read FDCCTypeDstrb    Write FDCCTypeDstrb;
        Property DAPInfoAtax:     TAPInfoAtax     Read FDAPInfoAtax     Write FDAPInfoAtax;
     End;
     { General supplier information }
     TSupplierDef = Class
     Private
        FSupplierCode:  String;
        FSupplierId:    String;
        FSupplierName:  String;
     Public
        Property SupplierCode:String Read FSupplierCode Write FSupplierCode;
        Property SupplierId:String   Read FSupplierId   Write FSupplierId;
        Property SupplierName:String Read FSupplierName Write FSupplierName;
     End;
     { Contracts definition for the Select Contracts in the Rep02 }
     TContractNode = Class
     Private
        FContractNo:    String;
        FContractDate:  String;
        FContractDesc:  String;
        Function GetKey:String;
     Public
        Property ContractNo:   String Read FContractNo   Write FContractNo;
        Property ContractDate: String Read FContractDate Write FContractDate;
        Property ContractDesc: String Read FContractDesc Write FContractDesc;
        Property Key:          String Read GetKey;
     End;
     { Basic Element definition in MSF010 plus execution in the contract }
     TElementDef = Class
     Private
        FElementCode:     String;   { Element Code in MSF010 for ElementNo }
        FElementName:     String;   { Element Description in MSF010 for ElementCode }
     Public
        Property ElementCode:   String Read FElementCode Write FElementCode;
        Property ElementName:   String Read FElementName Write FElementName;
     End;
     { Class TEleNoDef

       Use this class to store the extended definition for Element No.

       This is a definition to have a knowledge about characteristics
       of the Element No used by the Act Paid module. Check the following,
       the characteristics are for the Element No, NOT for the Element Code.

       This extended definition is defined in the +DES table of MSF010
       as follow :

       The Element No  in the TABLE_CODE field
       The Flags       in the ASSOC_REC field

       Actually, there are two flags, values yes (Y) and not (N) as
       secuential positions into the field; for instance, a value YN
       in ASSOCREC is equivalent to have YES for the first flag and NOT
       for the second flag.

       The first flag say if the Element is supposed to store Discount.
       The second flag say if the Element is supposed to store Third
       Party Invoices.

       If an Element must have both flags off, then is not necessary to
       include it into the table; therefore, usually the table +DES only
       will have elements with at least one flag On

       April, 2002 : Add the following Flag

       Percents on Elements : This flag is used when an Element is supposed
       to be a percent applied to the current value of another elements in
       the Act. The flag is the third position in the ASSOCREC field

       November, 2002 : Add the following Flag

       Cost Element : This flag is used when an Element is supposed
       to be a cost (positive value). The flag is the forth position in
       the ASSOCREC field. This flag work together to the discount flag,
       both flags decide the sign of the value of an element in the following
       way :

       If only the discount flag is On, then the user is not able to type
       negative values for the element; but, the value is used by the system
       as negative

       If only the cost flag is On, then the user is not able to type
       negative values for the element and the value is used by the system
       as positive

       If both flags are On, or both flags are Off, then the element is an
       special element used by both funtions : Cost & discount. The user
       is able to type both positive and negative values, and the system use
       the sign typed by user for its operations

       Note: The cost flag has a default value different to the standard for
             the other flags in +DES. The usual default value is 'N'; but in
             this case, the default value is 'Y'; therefore, only the elements
             authorized to work as both, discount and normal, need to  be into
             the +DES table}
     TEleNoDef = Class
     Private
        FElementNo:     String;
        FFlags:         String;     { Flags in "+DES" }
        FDiscount:      Boolean;    { True = It's a Discount Element }
        FThirdPartyInv: Boolean;    { True = It's a Third Party Invoice }
        FPercent:       Boolean;    { True = It's a Percent over a Cost Element }
        FNormalCost:    Boolean;    { True = It's a normal Cost Element }
        FPreserveSign:  Boolean;    { True = Support Both Cost and Discount }
     Public
        Constructor Create(ACode,AValue:String);
        Property Flags:String          Read FFlags;
        Property ElementNo:String      Read FElementNo;
        Property Discount:Boolean      Read FDiscount;
        Property ThirdPartyInv:Boolean Read FThirdPartyInv;
        Property Percent:Boolean       Read FPercent;
        Property NormalCost:Boolean    Read FNormalCost;
        Property PreserveSign:Boolean  Read FPreserveSign;
     End;

     { This class is used only by the Elements Combo Box List in the Act
       Paid Window to store the definition of the the elements in that list.
       It's necessary because an Element Code can be associated with several
       Elements No }
     TEleNoEleCode = Class
     Private
        FElementNo:     String;
        FElement:       TElementDef;
        Function GetElementNoName:String;
     Public
        Property ElementNo:String      Read FElementNo Write FElementNo;
        Property Element:TElementDef   Read FElement   Write FElement;
        Property ElementNoName: String Read GetElementNoName;
     End;
     { This class contains the links between each Element No and the definition
       of its Element Code }
     TEleNoEleCodes = Class(TStringList)
     Private
        Function GetElementNoBase(AnElementCode:String):String;
        Function GetElementDef(AnIndex:String):TEleNoEleCode;
        Function GetElementAt(AnIndex:Integer):TEleNoEleCode;
     Public
        Function HasGroup(AnElementCode:String):Boolean;
        Property ElementNoBase[AnElementCode:String]:String Read GetElementNoBase;
        Property ElementDef[AnElement:String]:TEleNoEleCode Read GetElementDef;
        Property ElementAt[AnIndex:Integer]:TEleNoEleCode   Read GetElementAt;
     End;
     { This class is used to store the execution values of an element in the
       current Act Paid }
     TElementVal = Class
     Private
        FElementNo:       String;   { Element Number in the Contract-Portion }
        FElementValCnt:   Currency; { Element Value in the Contract }
        FElementEdtAct:   Currency; { Element Edited Value in the Act }
        FElementExeAct:   Currency; { Element Value executed in the Act }
        FElementExeCnt:   Currency; { Element Value executed in the Contract }
        FElementValCC:    Currency; { Cost Centers Value assigned to the element }
        FCCPercents:      Integer;  { Sum of the percents assigned to the Cost Centers }
     Public
        Property ElementNo:String       Read FElementNo     Write FElementNo ;
        Property ElementValCnt:Currency Read FElementValCnt Write FElementValCnt ;
        Property ElementEdtAct:Currency Read FElementEdtAct Write FElementEdtAct ;
        Property ElementExeAct:Currency Read FElementExeAct Write FElementExeAct ;
        Property ElementExeCnt:Currency Read FElementExeCnt Write FElementExeCnt ;
        Property ElementValCC:Currency  Read FElementValCC  Write FElementValCC ;
        Property CCPercents:Integer     Read FCCPercents    Write FCCPercents ;
     End;
     TActPaidDef = Class
     Private
        FActPaidCode:     String;
        FActPaidContract: String;
        FActPaidPortion:  String;
        FActPaidElement:  String;
        FActPaidSupplier: String;
        FActPaidDate:     String;
        FActPaidValue:    Currency;
        FActPaidValnNo:   String;
        { For a more clear code, we use an enumerated type for the act paid
          status; but, we also need an string version because it's required
          by the search condition and the database routines }
        FActPaidStatus:   TActStatus;
        Function GetActPaidStatusS:String;
        Procedure SetActPaidStatusS(AValue:String);
     Public
        Property ActPaidCode:     String     Read FActPaidCode     Write FActPaidCode;
        Property ActPaidContract: String     Read FActPaidContract Write FActPaidContract;
        Property ActPaidPortion:  String     Read FActPaidPortion  Write FActPaidPortion;
        Property ActPaidElement:  String     Read FActPaidElement  Write FActPaidElement;
        Property ActPaidSupplier: String     Read FActPaidSupplier Write FActPaidSupplier;
        Property ActPaidDate:     String     Read FActPaidDate     Write FActPaidDate;
        Property ActPaidStatus:   TActStatus Read FActPaidStatus   Write FActPaidStatus;
        Property ActPaidValue:    Currency   Read FActPaidValue    Write FActPaidValue;
        //Property ActPaidValnNo:   String     Read FActPaidValnNo   Write FActPaidValnNo;
        { String view of ActPaidStatus used for search and DB formats }
        Property ActPaidStatusS:  String Read GetActPaidStatusS Write SetActPaidStatusS;
     End;
     { Definition of a Custom Category Name }
     TCstmCatName = Class
     Private
        FValue:         String;
     Public
        Property Value:String Read FValue Write FValue;
     End;
     {  List of the Custom Category Names }
     TCstmCtgNms = Class(TStringList)
     Private
        FContract:      String;
        FPortion:       String;
        FElement:       String;
        FCategory:      String;
        FLoaded:        TStringList;
        Function Key:String;
        Function GetCategoryName:String;
        Procedure SetContract(AValue:String);
        Procedure SetPortion(AValue:String);
        Procedure SetElement(AValue:String);
        Procedure SetCategory(AValue:String);
     Public
        Constructor Create;
        Destructor Destroy;
        Function IsPortionLoaded(AContract,APortion:String):Boolean;
        Function GetCategoryNameAt(AContract,APortion,AnElement,ACategory:String):String;
        Procedure AddCategoryName(AKey,AValue:String);
        Procedure SetLoadFlagFor(AContract,APortion:String);
        Property Contract:     String Read FContract Write SetContract;
        Property Portion:      String Read FPortion  Write SetPortion;
        Property Element:      String Read FElement  Write SetElement;
        Property Category:     String Read FCategory Write SetCategory;
        Property CategoryName: String Read GetCategoryName;
     End;
     { This class is used to save in memory the original definition of
       every possible category in every possible element of the
       Contract-Portion. The term "Category Definition" is used in the
       Acta Paid module to refer to codes, names and values associated to
       a category in an element in an the Contract-Portion corresponding
       to an Act Paid; this is different to the global category definition
       avalaible from MSF010 TABLE_TYPE = 'CE' }
     TCategoryDef = Class
     Private
        FCategoryElement:  String;
        FCategoryElementCode : String;
        FCategoryEleName:  String;
        FCategoryNro:      String;
        FCategoryCode:     String;
        FCategoryByGlobal: Boolean;
        FCategoryRate:     Currency;
        FCategoryMeasure:  String;
        FCategoryDesc:     String;
        FCategoryQuantity: Double;
        FCategoryTopValue: Currency; { Value authorized for the category in the contract }
        FCategoryGlobal:   Currency; { Value in the act }
        FCategoryValue:    Currency; { Edited value of the category }
        FCategoryInAct:    Boolean;  { TRUE = Already included in the act }
        Function GetItemName:String;
     Public
        Function IsNodeAt(AnElement,ACategory:String):Boolean;
        Property CategoryElement:String     Read FCategoryElement     Write FCategoryElement;
        Property CategoryElementCode:String Read FCategoryElementCode Write FCategoryElementCode;
        Property CategoryEleName:String     Read FCategoryEleName  Write FCategoryEleName;
        Property CategoryNro:String         Read FCategoryNro      Write FCategoryNro;
        Property CategoryCode:String        Read FCategoryCode     Write FCategoryCode;
        Property CategoryByGlobal:Boolean   Read FCategoryByGlobal Write FCategoryByGlobal;
        Property CategoryRate:Currency      Read FCategoryRate     Write FCategoryRate;
        Property CategoryMeasure:String     Read FCategoryMeasure  Write FCategoryMeasure;
        Property CategoryDesc:String        Read FCategoryDesc     Write FCategoryDesc;
        Property CategoryQuantity:Double    Read FCategoryQuantity Write FCategoryQuantity;
        Property CategoryTopValue:Currency  Read FCategoryTopValue Write FCategoryTopValue;
        Property CategoryGlobal:Currency    Read FCategoryGlobal   Write FCategoryGlobal;
        Property CategoryValue:Currency     Read FCategoryValue    Write FCategoryValue;
        Property CategoryInAct:Boolean      Read FCategoryInAct    Write FCategoryInAct;
        Property ItemName:String Read GetItemName;
     End;

     { This class is used to have in memory the current values in the SAF3A1
       table for the current act paid. Check the following, when the act is
       being edited, the "edited values" are in the temporal table tblDetails ;
       therefore, the information in our class can be used to compare the
       "edited values" against the original values }
     TCategoryList = Class(TList)
     Private
        FSortedByNames: Boolean;
        Function GetValue:Currency;
        Function GetEditedValue:Currency;
        Function GetCategoryAt(AnIndex:Integer):TCategoryDef;
        Function GetValueOfElementNo(AnElementNo:String):Currency;
        Procedure SetSortedByNames(AValue:Boolean);
     Public
        Function FindNode(AnElement,ACategory:String):TCategoryDef;
        Procedure FreeItems;
        Property Value:Currency        Read GetValue;
        Property EditedValue:Currency  Read GetEditedValue;
        Property SortedByNames:Boolean Read FSortedByNames Write SetSortedByNames;
        Property CategoryAt[AnIndex:Integer]:TCategoryDef Read GetCategoryAt;
        Property ValueOfElementNo[AnElementNo:String]:Currency Read GetValueOfElementNo;
     End;
     { This class contains a cache list of all the elements defined in the
       system }
     TElementList = Class(TStringList)
     Private
        FCacheCode:     String;     { Code of the last element found in the list}
        FCacheName:     String;     { Name of the last element found in the list}
        Function GetElementName(ACode:String):String;
        Function GetDefinitionOf(ACode:String):TElementDef;
     Public
        Constructor Create;
        Property ElementName[ACode:String]:String Read GetElementName;
        Property DefinitionOf[ACode:String]:TElementDef Read GetDefinitionOf;
     End;
     { This class contains a cache list for the Element No definitions }
     TElementNoDefs = Class(TStringList)
     Private
        Function GetDefinitionOf(AValue:String):TEleNoDef;
        Function GetIsDiscount(AValue:String):Boolean;
        Function GetIsCost(AValue:String):Boolean;
        Function GetPreserveSign(AValue:String):Boolean;
        Function GetIsThirdPartyInv(AValue:String):Boolean;
        Function GetIsPercent(AValue:String):Boolean;
        Function GetDiscountFlag(AValue:String):String;
        Function GetTPIFlag(AValue:String):String;
        Function GetPercentFlag(AValue:String):String;
     Public
        Procedure AddDefinition(ANode:TEleNoDef);
        Property DefinitionOf[AnElementNo:String]:TEleNoDef  Read GetDefinitionOf;
        Property IsDiscount[AnElementNo:String]:Boolean      Read GetIsDiscount;
        Property IsCost[AnElementNo:String]:Boolean          Read GetIsCost;
        Property PreserveSign[AnElementNo:String]:Boolean    Read GetPreserveSign;
        Property IsThirdPartyInv[AnElementNo:String]:Boolean Read GetIsThirdPartyInv;
        Property IsPercent[AnElementNo:String]:Boolean       Read GetIsPercent;
        Property DiscountFlag[AnElementNo:String]:String     Read GetDiscountFlag;
        Property TPIFlag[AnElementNo:String]:String          Read GetTPIFlag;
        Property PercentFlag[AnElementNo:String]:String      Read GetPercentFlag;
     End;
     { This class define a percent to applied to an element if the element
       value is into a range. This percent is defined as a category, and
       the category can be applied to several Elements. The property Total
       store the sum of the current values of all the elements includes in
       the range and the property Value is a value of the percent to be
       applied (Property Total multiplied by the Property Percent }
     TPercentRange = Class
     Private
        FCategoryNo:    String;       { Category No }
        FCategoryName:  String;       { Category Name }
        FPercent:       Double;       { Percent to be applied }
        FLowRange:      Double;       { Value of Low Range in the category }
        FHighRange:     Double;       { Value of High Range in the category }
        FLComparation:  TComparation; { Comparation kind for the Low Range }
        FHComparation:  TComparation; { Comparation kind for the Low Range }
        FElements:      TStringList;  { Elements No valid for the percent }
        FCharCount:     Integer;      { Length of the Category Name }
        FCharIndex:     Integer;      { Index of the current char in Category Name }
        FTotal:         Double;       { Total Value of the all elements in the Category }
        Function IsADigit(AValue:Char):Boolean;
        Function IsANumeric(AValue:Char):Boolean;
        Function IsValueInRange(AValue:Currency):Boolean;
        Function GetValue:Double;
        Procedure AddElement(AnElementNo:String);
        Procedure GetValueLimit(Var ALimit:Double;AnIndex:Integer;Var ANewPos:Integer);
        Procedure SetAComparator(FirstChar,SecondChar:Char;ALimit:Double);
        Procedure CheckSingleElement;
        Procedure CheckElementRange;
        Procedure CheckALimit(AValue1,AValue2:Char);
        Procedure SetCategoryName(AValue:String);
     Public
        Constructor Create;
        Destructor Destroy; Override;
       { Procedure ApplyTo(AnElementNo:String;AValue:Currency);  }
        Function IsElementNoMember(AnElementNo:String):Boolean;
        Function GetValueForElementByPercent(AnElementValues:TElementVals):Currency;
        Property CategoryNo:String    Read FCategoryNo   Write FCategoryNo;
        Property CategoryName:String  Read FCategoryName Write SetCategoryName;
        Property Percent:Double       Read FPercent      Write FPercent;
        Property Total:Double         Read FTotal        Write FTotal;
        Property Value:Double         Read GetValue;
        Property Elements:TStringList Read FElements;
     End;
     TCCCBItem = Class
     Private
        FGLAccount:     String;
        FDocumentType:  String;
        FDocumentNo:    String;
        FEquipNo:       String;
        FPercent:       String;
     Public
        Property GLAccount:String    Read FGLAccount    Write FGLAccount;
        Property DocumentType:String Read FDocumentType Write FDocumentType;
        Property DocumentNo:String   Read FDocumentNo   Write FDocumentNo;
        Property EquipNo:String      Read FEquipNo      Write FEquipNo;
        Property Percent:String      Read FPercent      Write FPercent;
     End;
     TCCCBList = Class(TStringList)
     Private
        Function GetCCCBItemAt(AnIndex:Integer):TCCCBItem;
     Public
        Procedure AddCBItem(ACCCBItem:TCCCBItem);
        Property CCCBItemAt[AnIndex:Integer]:TCCCBItem Read GetCCCBItemAt;
     End;
     { This class define the Cost Centers for elements "calculated by
       percents". These Cost Center correspond to an equivalent percent
       to the cost centers of the original elements. The value depends on
       the method used for the Cost Centers distribution. If the method
       is by value, then the property Total has the corresponding value
       for the cost center; if the method is by percent, the value is
       supplired by the property Percent100. This property store the
       percent multiplied by 100; therefore, the values are integers
       between 0 and 10000: this format is intended to be used to
       save the value in the Cost Center table (SAF3A3)  }

     TCCByPercent = Class
     Private
        FPercent100:    Integer;
        FTotal:         Currency;
        FCCCode:        String;
        FCCDocumentType:String;
        FCCDocumentNo:  String;
        FCCEquip:       String;
        Function GetCCKey:String;
     Public
        Property CCKey:String          Read GetCCKey;
        Property Percent100:Integer    Read FPercent100     Write FPercent100;
        Property Total:Currency        Read FTotal          Write FTotal;
        Property CCCode:String         Read FCCCode         Write FCCCode;
        Property CCDocumentType:String Read FCCDocumentType Write FCCDocumentType;
        Property CCDocumentNo:String   Read FCCDocumentNo   Write FCCDocumentNo;
        Property CCEquip:String        Read FCCEquip        Write FCCEquip;
     End;
     TCCsByPercent = Class(TStringList)
     Private
        Function GetCCAt(AnIndex:Integer):TCCByPercent;
        Function GetCCDefinitionOf(ACC,ADocType,ADocNo,AnEquip:String):TCCByPercent;
        Function GetTotal:Currency;
     Public
        Property CCAt[AnIndex:Integer]:TCCByPercent Read GetCCAt;
        Property CCDefinitionOf[ACC,ADocType,ADocNo,AnEquip:String]:TCCByPercent Read GetCCDefinitionOf;
        Property Total:Currency Read GetTotal;
     End;
     { List of Percents to be applied to one Element according to a range }
     TPercentList = Class(TList)
     Private
        Function GetCategoryAt(AnIndex:Integer):TPercentRange;
     Public
        Property CategoryAt[AnIndex:Integer]:TPercentRange Read GetCategoryAt;
     End;
     { This class define the extended attributes for an element used to
       define percents to be applied to other elements according to a
       range of values }
     TElementPercent = Class
     Private
        FElementNo:     String;
        FElementName:   String;
        FCCs:           TCCsByPercent;
        FCategories:    TPercentList;
     Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure ClearCategoryValues;
        Procedure ProcessCC(ACCCode,
                            ACCDocumentType,
                            ACCDocumentNo,
                            ACCEquip:String;
                            AValue:Currency);
        Procedure AddCategory(ACategoryNo,ACategoryName:String;APercent:Double);
       { Procedure ApplyTo(AnElementNo:String;AValue:Currency); }
        Procedure CalcCCPercents;
        Procedure CalcValuesByPercent(AnElementValues:TElementVals);
        Property ElementNo:String        Read FElementNo   Write FElementNo;
        Property ElementName:String      Read FElementName Write FElementName;
        Property Categories:TPercentList Read FCategories;
        Property CCs:TCCsByPercent       Read FCCs;
     End;
     { This class contains all the elements "calculated by percent"
       (i.e  objects TElementPercent, key ElementNo }
     TEleXPercent = Class(TStringList)
     Private
        Function GetElement(AnElementNo:String):TElementPercent;
        Function GetElementAt(AnIndex:Integer):TElementPercent;
     Public
        Property Element[AnElementNo:String]:TElementPercent Read GetElement;
        Property ElementAt[AnIndex:Integer]:TElementPercent Read GetElementAt;
     End;
     { This class is a link between an element used by the contract module
       and the general definition (MSF010 table) of that element. The key
       property is used to identify the link in the TElementActs class }
     TElementLink = Class
     Private
        FContractNo:    String;
        FPortionNo:     String;
        FElementNo:     String;
        FElementCode:   String;
        Function GetKey:String;
     Public
        Property ContractNo:  String Read FContractNo  Write FContractNo;
        Property PortionNo:   String Read FPortionNo   Write FPortionNo;
        Property ElementNo:   String Read FElementNo   Write FElementNo;
        Property ElementCode: String Read FElementCode Write FElementCode;
        Property Key:         String Read GetKey;
     End;
     { This class is used by the reports to store the definition of the elements
       used by the acts }
     TElementActs = Class(TStringList)
     Private
        FElements:      TElementList;
     Public
        Constructor Create(AList:TElementList);
        Function ExistsContractPortion(AContract,APortion:String):Boolean;
        Function GetElementName(AContract,APortion,AnElementNo:String):String;
        Procedure AddElement(AContract,APortion,AnElementNo,AnElementCode:String);
     End;
     TElementVals = Class(TStringList)
     Private
        Function GetElementPaid(AnElement:String):Currency;
        Function GetElementValue(AnElement:String):Currency;
        Function GetCCValues(AnElement:String):Currency;
        Function GetElementDef(AnElement:String):TElementVal;
        Function GetElementAt(AnIndex:Integer):TElementVal;
        Procedure SetElementPaid(AnElement:String;AValue:Currency);
        Procedure SetElementValue(AnElement:String;AValue:Currency);
     Public
        Procedure ClearAndFree;
        Procedure ClearTotalElementValues;
        Procedure ClearCCValues;
        Procedure ValidateElementTops;
        Procedure AddToCCValues(AnElement:String;AValue:Currency);
        Property ElementValue[AnElement:String]:Currency Read GetElementValue Write SetElementValue;
        Property ElementPaid[AnElement:String]:Currency Read GetElementPaid Write SetElementPaid;
        Property CCValues[AnElement:String]:Currency Read GetCCValues;
        Property ElementDef[AnElement:String]:TElementVal Read GetElementDef;
        Property ElementAt[AnIndex:Integer]:TElementVal Read GetElementAt;
     End;
     { Class for the memory representation of the lines of reports avalaible
       in the Acts module  }
     TBaseLine = Class
        Kind:           TKindLine;
        ContractNo:     String;
        PortionNo:      String;
        ContractDate:   String;
        PaidValue:      Currency;
     End;
     TLine01 = Class(TBaseLine)
     Private
        Function GetKey:String;
     Public
        ElementNo:      String;
        ElementName:    String;
        CategoryName:   String;
        ItemValue:      Currency;
        ContractQty:    Double;
        PaidQty:        Double;
        Property Key:String Read GetKey;
     End;
     { Although the line for Rep02 is really the same line of Rep01, by
       methodology and a most easy update, we prefer to create its own class }
     TLine02 = Class(TLine01)

     End;
     TLine03 = Class(TBaseLine)
        ContractValue:  Currency;
        ContractDesc:   String;
        ContractFDate:  String;
        SupplierId:     String;
        SupplierName:   String;
     End;
     TLine04 = Class(TBaseLine)
        ActPaidNo:      String;
        ActPaidDate:    String;
        ActPaidStatus:  TActStatus;
        ItemValue:      Currency;
     End;
     TMIMSRegistry = Class
     Private
        FVersion:       String;
        FBinDirectory:  String;
        FHelpDirectory: String;
     Public
        Constructor Create;
        Property Version:       String Read FVersion;
        Property BinDirectory:  String Read FBinDirectory;
        Property HelpDirectory: String Read FHelpDirectory;
     End;
     TCCCurrent = Class
     Private
        FElementNo:    String;
        FGLAccount:    String;
        FDocumentType: String;
        FDocumentNo:   String;
        FEquipNo:      String;
        FPercent:      String;
        FIsOld:        Boolean;
        Function GetKey:String;
     Public
        Property ElementNo:    String  Read FElementNo    Write FElementNo;
        Property GLAccount:    String  Read FGLAccount    Write FGLAccount;
        Property DocumentType: String  Read FDocumentType Write FDocumentType;
        Property DocumentNo:   String  Read FDocumentNo   Write FDocumentNo;
        Property EquipNo:      String  Read FEquipNo      Write FEquipNo;
        Property Percent:      String  Read FPercent      Write FPercent;
        Property IsOld:        Boolean Read FIsOld        Write FIsOld;
        Property Key:          String  Read GetKey;
     End;
     TCCCList = Class(TStringList)
     Private
        Function GetCostCenterAt(AnIndex:Integer):TCCCurrent;
        Function GetExistsElement(AnElement:String):Boolean;
     Public
        Procedure ClearAndFree;
        Procedure MarkAsOld;
        Property CostCenterAt[AnIndex:Integer]:TCCCurrent Read GetCostCenterAt;
        Property ExistsElement[AnElement:String]:Boolean  Read GetExistsElement;
     End;
     { Class for the description of a Cost Center in  TCCSummaryList }
     TCCSummary = Class
     Private
        FValue:         Currency;
        FPercent:       Integer;
        FDocumentType:  String;
        FDocumentNo:    String;
        Function GetPercentAsText:String;
     Public
        Property PercentAsText:String Read GetPercentAsText;
        Property Value:Currency  Read FValue   Write FValue;
        Property Percent:Integer Read FPercent Write FPercent;
{IC658} Property DocumentType:String Read FDocumentType Write FDocumentType;
{IC658} Property DocumentNo:String Read FDocumentNo Write FDocumentNo;
     End;
     { Class for the list of Cost Centers printables used by the Act Paid
       Summary Report }
     TCCSummaryList = Class(TStringList)
     Private
        Function GetCostCenterAt(AnIndex:Integer):TCCSummary;
        Function GetCostCenter(ACostCenter:String):TCCSummary;
        Function GetValue:Currency;
     Public
        {Procedure AddCC(ACC:String;AValue:Currency);}
{IC658} Procedure AddCC(ACC:String;AValue:Currency;ADocType:String;ADocNo:String);
        Procedure CalculatePercents;
        Property CostCenterAt[AnIndex:Integer]:TCCSummary Read GetCostCenterAt;
        Property CostCenter[ACostCenter:String]:TCCSummary Read GetCostCenter;
        Property Value:Currency Read GetValue;
     End;
     { Class for the Atax Definition }
     TAtaxDfntn = Class
     Private
        FAtaxCode:      String;
        FDescription:   String;
        FGroup:         Boolean;
        FPercent:       Double;
     Public
        Property AtaxCode:      String  Read FAtaxCode    Write FAtaxCode;
        Property Description:   String  Read FDescription Write FDescription;
        Property Group:         Boolean Read FGroup       Write FGroup;
        Property Percent:       Double  Read FPercent     Write FPercent;
     End;
     { Mapping Item No in MS389 to Element No - Category No . This is
       necessary because}
     TItem389Map = Class
     Private
        FElementNo:     String;
        FCategoryNo:    String;
     Public
        Property ElementNo:String Read FElementNo write FElementNo;
        Property CategoryNo:String Read FCategoryNo write FCategoryNo;
     End;
implementation
Uses MCUtils;

{ Local function for the Sort method of TCategoryList }
Function SortByNames(Item1,Item2:Pointer):Integer;
Var
   Name1:               String;     { Name of Item1 }
   Name2:               String;     { Name of Item2 }
Begin
     Name1 := TCategoryDef(Item1).ItemName;
     Name2 := TCategoryDef(Item2).ItemName;
     If Name1 = Name2 Then Begin
        SortByNames := 0; End
     Else Begin
        If Name1 < Name2 Then Begin
           SortByNames := -1; End
        Else Begin
           SortByNames := 1;
        End;
     End;
End;
{ Class TUserConfig : Methods }
Constructor TUserConfig.Create;
Begin
     Inherited;
     CCTypeDstrb    := cctdPercent;
     CCDefaultDstrb := ccddContract;
     TypeComments   := tcNone;
     TypeCntrctExt  := tceNone;
     LoadInvType    := litCategory;
     ActValidation  := avElement;
     InvValidation  := ivNone;
     DTypeComments  := tcNone;
     DTypeCntrctExt := tceNone;
     TypeCntLimit   := tclNone;
     DCCTypeDstrb   := cctdPercent;
End;
{ Class TContractNode : Methods }
Function TContractNode.GetKey:String;
Begin
     GetKey := Format('%8s %s %s',[ContractNo,
                                   Date8ToDisplayFormat(ContractDate),
                                   ContractDesc]);
End;
{ Class TActPaidDef : Methods }
Function TActPaidDef.GetActPaidStatusS:String;
Begin
     GetActPaidStatusS := IntToStr(Ord(FActPaidStatus));
End;
Procedure TActPaidDef.SetActPaidStatusS(AValue:String);
Begin
     FActPaidStatus := TActStatus(Ord(StrToInt(AValue)));
End;

{ Class TCstmCtgNms : Methods }
Constructor TCstmCtgNms.Create;
Begin
     Inherited;
     FLoaded := TStringList.Create;
     FLoaded.Sorted := True;
End;
Destructor TCstmCtgNms.Destroy;
Begin
     FLoaded.Free;
     Inherited;
End;
Function TCstmCtgNms.Key:String;
Begin
     Key := FContract + FPortion + FElement + FCategory;
End;
Function TCstmCtgNms.GetCategoryName:String;
Var
   AIndex:              Integer;
Begin
     If Find(Key,AIndex) Then Begin
        GetCategoryName := (Objects[AIndex] As TCstmCatName).Value; End
     Else Begin
        GetCategoryName := '';
     End;
End;

Procedure TCstmCtgNms.SetContract(AValue:String);
Begin
     If AValue <> FContract Then Begin
        FContract := GetFullMIMSKey(AValue,8);
     End;
End;
Procedure TCstmCtgNms.SetPortion(AValue:String);
Begin
     If AValue <> FPortion Then Begin
        FPortion := GetFullMIMSKey(AValue,2);
     End;
End;
Procedure TCstmCtgNms.SetElement(AValue:String);
Begin
     If AValue <> FElement Then Begin
        FElement := GetFullMIMSKey(AValue,2);
     End;
End;
Procedure TCstmCtgNms.SetCategory(AValue:String);
Begin
     If AValue <> FCategory Then Begin
        FCategory := GetFullMIMSKey(AValue,2);
     End;
End;
Function TCstmCtgNms.GetCategoryNameAt(AContract,APortion,AnElement,ACategory:String):String;
Begin
     Contract := AContract;
     Portion  := APortion;
     Element  := AnElement;
     Category := ACategory;
     GetCategoryNameAt := CategoryName;
End;
Procedure TCstmCtgNms.AddCategoryName(AKey,AValue:String);
Var
   AIndex:              Integer;
   Node:                TCstmCatName;
Begin
     If Length(AKey) <> 14 Then Begin
        raise Exception.CreateFmt(ME_090,[AKey]);
     End;
     If Find(AKey,AIndex) Then Begin
        (Objects[AIndex] As TCstmCatName).Value := AValue; End
     Else Begin
        Node := TCstmCatName.Create;
        Node.Value := AValue;
        AddObject(AKey,Node);
     End;
End;
{ True = Custom Names for the Portion APortion of the Contract AContract are
  loaded in the cache list of custom category names }
Function TCstmCtgNms.IsPortionLoaded(AContract,APortion:String):Boolean;
Var
   AIndex:              Integer;
   PortionKey:          String;
Begin
     PortionKey      := GetMIMSKey(AContract,8) + GetMIMSKey(APortion,2);
     IsPortionLoaded := Find(PortionKey,AIndex);
End;
{ Call this routine after a successful load of the portion identified by
  AContract-APortion. The routine includes this pair in the internal list
  of the portions already loaded used to improve performance by checking
  if a portion is loaded before a request by using IsPortionLoaded }
Procedure TCstmCtgNms.SetLoadFlagFor(AContract,APortion:String);
Var
   PortionKey:          String;
Begin
     If Not IsPortionLoaded(AContract,APortion) Then Begin
        PortionKey := GetMIMSKey(AContract,8) + GetMIMSKey(APortion,2);
        FLoaded.Add(PortionKey);
     End;
End;
{ Class TCategoryDef : Methods }

Function TCategoryDef.IsNodeAt(AnElement,ACategory:String):Boolean;
Begin
     IsNodeAt:=(CategoryElement = AnElement) And (CategoryNro = ACategory);
End;
Function TCategoryDef.GetItemName:String;
Begin
     GetItemName := CategoryEleName + CategoryDesc;
End;
{ Class TCategoryList : Methods }

{ Use this routine the Act Value }
Function TCategoryList.GetValue:Currency;
Var
   CategoryIndex:       Integer;    { Index of the current category }
   Sum:                 Currency;   { Sum of the values of every category }
Begin
     CategoryIndex := 0;
     Sum           := 0;
     While CategoryIndex < Count Do Begin
           Sum := Sum + TCategoryDef(Items[CategoryIndex]).CategoryGlobal;
           Inc(CategoryIndex);
     End;
     GetValue := Sum;
End;
{ Use this routine to get the edited value of the Act. The edited value is
  the value in memory still no saved to disk }
Function TCategoryList.GetEditedValue:Currency;
Var
   CategoryIndex:       Integer;    { Index of the current category }
   Sum:                 Currency;   { Sum of the values of every category }
Begin
     CategoryIndex := 0;
     Sum           := 0;
     While CategoryIndex < Count Do Begin
        Sum := Sum + TCategoryDef(Items[CategoryIndex]).CategoryValue;
        Inc(CategoryIndex);
     End;
     GetEditedValue := Sum;
End;
Function TCategoryList.GetCategoryAt(AnIndex:Integer):TCategoryDef;
Begin
     GetCategoryAt := TCategoryDef(Items[AnIndex]);
End;
Function TCategoryList.GetValueOfElementNo(AnElementNo:String):Currency;
Var
   TheValue:            Currency;
   TheIndex:            Integer;
Begin
     TheValue := 0;
     TheIndex := 0;
     While TheIndex < Count Do Begin
           With CategoryAt[TheIndex] Do Begin
                If CategoryElement = AnElementNo Then Begin
                   TheValue := TheValue + CategoryGlobal;
                End;
           End;
           Inc(TheIndex);
     End;
     GetValueOfElementNo := TheValue;
End;
Procedure TCategoryList.SetSortedByNames(AValue:Boolean);
Begin
     If AValue And Not FSortedByNames Then Begin
        Sort(SortByNames);
     End;
     FSortedByNames := AValue;
End;
{ Use this routine to locate the definition of the couple AnElement-ACategory
  in the list }
Function TCategoryList.FindNode(AnElement,ACategory:String):TCategoryDef;
Var
   CategoryIndex:         Integer;    { Index of the current Category in the detail list }
   Node:                  TCategoryDef;{ Definition of the current Category }
Begin
     FindNode       := Nil;
     CategoryIndex  := 0;
     While CategoryIndex<Count Do Begin
           Node := Items[CategoryIndex];
           If Node.IsNodeAt(AnElement,ACategory) Then Begin
              FindNode      := Node;
              CategoryIndex := Count;
           End;
           Inc(CategoryIndex);
     End;
End;
{ This routine Free the categories in the list. It's necessary because the
  standard procedure Free for TList don't free the objects in the TList }
Procedure TCategoryList.FreeItems;
Var
   CategoryIndex:         Integer;    { Index of the current Category in the detail list }
   Node:                TCategoryDef; { Definition of the current Category }
Begin
     CategoryIndex  := 0;
     While CategoryIndex<Count Do Begin
           Node := Items[CategoryIndex];
           Node.Free;
           Items[CategoryIndex] := Nil;
           Inc(CategoryIndex);
     End;
End;

Constructor TElementList.Create;
Begin
     Inherited Create;
     FCacheCode := '';
     FCacheName := '';
End;
{ Class TElementList : Methods }
{ This method get the Name of the Element with code ACode. To improve
  performance, we save Code and Name in a cache after a successful
  search. This is useful because the majority of the contiguos records in
  the detail of the Act Paid have the same element code }
Function TElementList.GetElementName(ACode:String):String;
Var
   ElementIndex:        Integer;    { Index of the current element }
Begin
     GetElementName := '';
     If ACode = FCacheCode Then Begin
        GetElementName := FCacheName; End
     Else Begin
        ElementIndex := IndexOf(ACode);
        If ElementIndex >= 0 Then Begin
           FCacheCode := ACode;
           FCacheName := (Objects[ElementIndex] As TElementDef).ElementName;
           GetElementName := FCacheName;
        End;
     End;
End;
{ Class TElementNoDefs methods }
Function GetElementCode(ElementNo:String):String;
begin
     ElementNo := Trim(ElementNo);
     If Length(ElementNo) > 2 Then begin
         GetElementCode :=  Copy(ElementNo,3,Length(ElementNo) - 2);
     end
     Else begin
         GetElementCode := ElementNo;
     end;
end;

Function TElementNoDefs.GetDefinitionOf(AValue:String):TEleNoDef;
Var
   TheIndex:            Integer;
Begin
     AValue := GetElementCode(AValue);

     TheIndex := IndexOf(AValue);
     If TheIndex < 0 Then Begin
        GetDefinitionOf := Nil; End
     Else Begin
        GetDefinitionOf := Objects[TheIndex] As TEleNoDef;
     End;
End;
Function TElementNoDefs.GetIsDiscount(AValue:String):Boolean;
Var
   ElementIndex:        Integer;
   ElementCode:         String;
Begin
     AValue := GetElementCode(AValue);

     GetIsDiscount := False;
     ElementIndex  := IndexOf(AValue);

     If ElementIndex >= 0 Then Begin                //+DES
        GetIsDiscount := (Objects[ElementIndex] As TEleNoDef).Discount;
     End;
End;
Function TElementNoDefs.GetIsCost(AValue:String):Boolean;
Var
   ElementIndex:        Integer;
Begin
     AValue := GetElementCode(AValue);

     GetIsCost    := False;
     ElementIndex := IndexOf(AValue);
     If ElementIndex >= 0 Then Begin
        GetIsCost := (Objects[ElementIndex] As TEleNoDef).NormalCost;
     End;
End;
Function TElementNoDefs.GetPreserveSign(AValue:String):Boolean;
Var
   ElementIndex:        Integer;
Begin
     AValue := GetElementCode(AValue);

     GetPreserveSign := True;
     ElementIndex    := IndexOf(AValue);
     If ElementIndex >= 0 Then Begin
        GetPreserveSign := (Objects[ElementIndex] As TEleNoDef).PreserveSign;
     End;
End;
Function TElementNoDefs.GetIsThirdPartyInv(AValue:String):Boolean;
Var
   ElementIndex:        Integer;
Begin
     AValue := GetElementCode(AValue);

     GetIsThirdPartyInv := False;
     ElementIndex       := IndexOf(AValue);
     If ElementIndex >= 0 Then Begin
        GetIsThirdPartyInv := (Objects[ElementIndex] As TEleNoDef).ThirdPartyInv;
     End;
End;
Function TElementNoDefs.GetIsPercent(AValue:String):Boolean;
Var
   ElementIndex:        Integer;
   AValue2:String;
Begin
     AValue2 := GetElementCode(AValue);

     GetIsPercent := False;
     ElementIndex := IndexOf(AValue2);
     If ElementIndex >= 0 Then Begin
        GetIsPercent := (Objects[ElementIndex] As TEleNoDef).Percent;
     end else begin
        AValue2 := copy(AValue,1,2);
        ElementIndex := IndexOf(AVAlue2);
        If ElementIndex >= 0 Then
          GetIsPercent := (Objects[ElementIndex] As TEleNoDef).Percent
        else
          GetIsPercent := false;
     End;
End;
Function TElementNoDefs.GetDiscountFlag(AValue:String):String;
Begin
     If IsDiscount[AValue] Then Begin
        GetDiscountFlag := 'Y'; End
     Else Begin
        GetDiscountFlag := 'N';
     End;
End;
Function TElementNoDefs.GetTPIFlag(AValue:String):String;
Begin
     If IsThirdPartyInv[AValue] Then Begin
        GetTPIFlag := 'Y'; End
     Else Begin
        GetTPIFlag := 'N';
     End;
End;
Function TElementNoDefs.GetPercentFlag(AValue:String):String;
Begin
     If IsPercent[AValue] Then Begin
        GetPercentFlag := 'Y'; End
     Else Begin
        GetPercentFlag := 'N';
     End;
End;
Procedure TElementNoDefs.AddDefinition(ANode:TEleNoDef);
Begin
     AddObject(ANode.ElementNo,ANode);
End;

{ Class TPercentRange : Methods }

Constructor TPercentRange.Create;
Begin
     Inherited Create;
     FTotal    := 0;
     FPercent  := 0;
     FElements := TStringList.Create;
     FElements.Sorted := True;
End;
Destructor TPercentRange.Destroy;
Begin
     FElements.Free;
     Inherited Destroy;
End;
Function TPercentRange.IsADigit(AValue:Char):Boolean;
Begin
     IsADigit := AValue In ['0'..'9'];
End;
Function TPercentRange.IsANumeric(AValue:Char):Boolean;
Begin
     IsANumeric := AValue In ['0'..'9','-','.'];
End;
{ Use this routine to know if the current value is into the range
  defined for the category }
Function TPercentRange.IsValueInRange(AValue:Currency):Boolean;
Var
   IsOk:                Boolean;
Begin
     IsOk := True;
     { Check the Low Range }
     Case FLComparation Of
     cGreat      : IsOk := AValue > FLowRange;
     cGreatEqual : IsOk := AValue >= FLowRange;
     End;
     { Check the High Range }
     Case FHComparation Of
     cLess      : IsOk := IsOk And (AValue < FHighRange);
     cLessEqual : IsOk := IsOk And (AValue <= FHighRange);
     End;
     IsValueInRange := IsOk;
End;
Function TPercentRange.GetValue:Double;
Begin
     GetValue := (FPercent / 100.0) * FTotal;
End;
Procedure TPercentRange.AddElement(AnElementNo:String);
Begin
     If Not IsElementNoMember(AnElementNo) Then Begin
        FElements.Add(AnElementNo);
     End;
End;
Procedure TPercentRange.GetValueLimit(Var ALimit:Double;AnIndex:Integer;Var ANewPos:Integer);
Var
   TheLimit:            String;
Begin
     ANewPos := AnIndex;
     While (ANewPos <= FCharCount) And IsANumeric(FCategoryName[ANewPos]) Do Begin
           Inc(ANewPos);
     End;
     TheLimit := Copy(FCategoryName,AnIndex,ANewPos-AnIndex);
     Try
        ALimit := StrToFloat(TheLimit);
     Except
        On E:Exception Do Begin
           raise Exception.CreateFmt(ME_044,[TheLimit]);
        End;
     end;
     If ANewPos <= FCharCount Then Begin
        If FCategoryName[ANewPos] = 'M' Then Begin
           ALimit := 1000000*ALimit;
           Inc(ANewPos);
        End;
     End;
End;
Procedure TPercentRange.SetAComparator(FirstChar,SecondChar:Char;ALimit:Double);
Var
   Comparator:          TComparation;
Begin
     Case FirstChar Of
     '>' : Begin
                If SecondChar = '=' Then Begin
                   Comparator := cGreatEqual; End
                Else Begin
                   Comparator := cGreat;
                End;
           End;
     '<' : Begin
                If SecondChar = '='  Then Begin
                   Comparator := cLessEqual; End
                Else Begin
                   Comparator := cLess;
                End;
           End;
     '=' : Begin
                If SecondChar = '<' Then Begin
                   Comparator := cLessEqual; End
                Else Begin
                   Comparator := cGreatEqual;
                End;
           End;
     End;
     If Comparator >= cGreat Then Begin
        If FLComparation <> cUndefined Then Begin
           raise Exception.CreateFmt(ME_198,['Inferior']);
        End;
        FLComparation := Comparator;
        FLowRange     := ALimit; End
     Else Begin
        If FHComparation <> cUndefined Then Begin
           raise Exception.CreateFmt(ME_198,['Superior']);
        End;
        FHComparation := Comparator;
        FHighRange     := ALimit;
     End;
End;
Procedure TPercentRange.CheckSingleElement;
Var
   ElementNo:           String;
   IsAElement:          Boolean;
Begin
     If (FCharIndex + 4) <= FCharCount Then Begin
        IsAElement := FCategoryName[FCharIndex+1] = 'L';
        IsAElement := IsAElement And (FCategoryName[FCharIndex+2] = ':');
        If IsAElement Then Begin
           IsAElement := FCategoryName[FCharIndex+3] <> ' ';
           IsAElement := IsAElement And (FCategoryName[FCharIndex+4] <> ' ');
           If Not IsAElement Then Begin
              raise Exception.CreateFmt(ME_197,['EL:',FCharIndex]);
           End;
           ElementNo := Copy(FCategoryName,FCharIndex+3,2);
           AddElement(ElementNo);
           Inc(FCharIndex,5);
        End; End
     Else Begin
        Inc(FCharIndex,1);
     End;
End;
Procedure TPercentRange.CheckElementRange;
Var
   LowElementNo:        Integer;
   HighElementNo:       Integer;
   ElementNo:           Integer;
   IsARange:            Boolean;
Begin
     If (FCharIndex + 8) <= FCharCount Then Begin
        IsARange := FCategoryName[FCharIndex+1] = 'N';
        IsARange := IsARange And (FCategoryName[FCharIndex+2] = 'G');
        IsARange := IsARange And (FCategoryName[FCharIndex+3] = ':');
        If IsARange Then Begin
           IsARange := IsADigit(FCategoryName[FCharIndex+4]);
           IsARange := IsARange And IsADigit(FCategoryName[FCharIndex+5]);
           IsARange := IsARange And (FCategoryName[FCharIndex+6] = '-');
           IsARange := IsARange And IsADigit(FCategoryName[FCharIndex+7]);
           IsARange := IsARange And IsADigit(FCategoryName[FCharIndex+8]);
           If Not IsARange Then Begin
              raise Exception.CreateFmt(ME_197,['RNG:',FCharIndex]);
           End;
           LowElementNo  := StrToInt(Copy(FCategoryName,FCharIndex+4,2));
           HighElementNo := StrToInt(Copy(FCategoryName,FCharIndex+7,2));
           If LowElementNo > HighElementNo Then Begin
              raise Exception.CreateFmt(ME_197,['RNG:',FCharIndex]);
           End;
           For ElementNo := LowElementNo To HighElementNo Do Begin
               AddElement(Format('%2.2d',[ElementNo]));
           End;
           Inc(FCharIndex,9);
        End;End
     Else Begin
        Inc(FCharIndex,1);
     End;
End;

Procedure TPercentRange.CheckALimit(AValue1,AValue2:Char);
Var
   FirstChar:           Char;
   SecondChar:          Char;
   ALimit:              Double;
   ANewPos:             Integer;
Begin
     If (FCharIndex + 1) <= FCharCount Then Begin
        FirstChar  := FCategoryName[FCharIndex];
        SecondChar := FCategoryName[FCharIndex+1];
        If (SecondChar = AValue1) Or (SecondChar = AValue2) Then Begin
           GetValueLimit(ALimit,FCharIndex+2,ANewPos); End
        Else Begin
           If FirstChar = '=' Then Begin
              raise Exception.CreateFmt(ME_197,['=',FCharIndex]);
           End;
           GetValueLimit(ALimit,FCharIndex+1,ANewPos);
        End;
        SetAComparator(FirstChar,SecondChar,ALimit);
        FCharIndex := ANewPos; End
     Else Begin
        Inc(FCharIndex,1);
     End;
End;
Procedure TPercentRange.SetCategoryName(AValue:String);
Begin
     FCategoryName := Uppercase(AValue);
     FLComparation := cUndefined;
     FHComparation := cUndefined;
     FElements.Clear;
     FCharCount := Length(AValue);
     FCharIndex := 1;
     {De Moya : 2002-08-21.  Verifico que sea AValue sea un string que pueda tener
     los pseudo-comandos del AIU}
     {MessageDlg('Categoria: '+Avalue, mtInformation,
      [mbOk], 0, mbOk);}
     if (Pos('>',AValue) > 0) or
        (Pos('<',AValue) > 0) or
        (Pos(':',AValue) > 0) then
     begin
        While FCharIndex <= FCharCount Do Begin
              Case FCategoryName[FCharIndex] Of
              'E' : CheckSingleElement;
              'R' : CheckElementRange;
              '>' : CheckALimit('=',Chr(0));
              '<' : CheckALimit('=',Chr(0));
              '=' : CheckALimit('<','>');
              Else  Inc(FCharIndex);
              End;
        End;
     end;
End;
Function TPercentRange.IsElementNoMember(AnElementNo:String):Boolean;
Begin
     IsElementNoMember := FElements.IndexOf(AnElementNo) >= 0;
End;
{ Use this routine to get the value to be used to decide if the tax of a
  category "calculated by percent" will be applied to the elements in the
  category. The value is the sum of the values of all the elements included
  in the category }
Function TPercentRange.GetValueForElementByPercent(AnElementValues:TElementVals):Currency;
Var
   ElementIndex:        Integer;
   ElementVal:          TElementVal;
   TheValue:            Currency;
Begin
     TheValue     := 0;
     ElementIndex := 0;
     While ElementIndex < AnElementValues.Count Do Begin
           ElementVal := AnElementValues.ElementAt[ElementIndex];
           If IsElementNoMember(ElementVal.ElementNo) Then Begin
              TheValue := TheValue + ElementVal.ElementEdtAct;
           End;
           Inc(ElementIndex);
     End;
     GetValueForElementByPercent:= TheValue;
End; {
Procedure TPercentRange.ApplyTo(AnElementNo:String;AValue:Currency);
Var
   TheIndex:            Integer;
   Category:            TPercentRange;
Begin
     TheIndex := 0;
     While TheIndex < FElements.Count Do Begin
           If FElements[TheIndex] = AnElementNo Then Begin
              If IsValueInRange(AValue) Then Begin
                 FTotal := FTotal + AValue;
              End;
           End;
           Inc(TheIndex);
     End;
End;     }

{  Class TCCCBList : Methods }

Function TCCCBList.GetCCCBItemAt(AnIndex:Integer):TCCCBItem;
Begin
     GetCCCBItemAt := Objects[AnIndex] As TCCCBItem;
End;
Procedure TCCCBList.AddCBItem(ACCCBItem:TCCCBItem);
Begin
     AddObject(IntToStr(Count),ACCCBItem);
End;
{  Class TCCByPercent : Methods }

Function TCCByPercent.GetCCKey:String;
Begin
     GetCCKey := FCCCode + FCCDocumentType + FCCDocumentNo + FCCEquip;
End;

{  Class TCCsByPercent : Methods }
Function TCCsByPercent.GetCCAt(AnIndex:Integer):TCCByPercent;
Begin
     GetCCAt := Objects[AnIndex] As TCCByPercent;
End;
Function TCCsByPercent.GetCCDefinitionOf(ACC,ADocType,ADocNo,AnEquip:String):TCCByPercent;
Var
   TheIndex:            Integer;
Begin
     GetCCDefinitionOf := Nil;
     TheIndex          := IndexOf(ACC+ADocType+ADocNo+AnEquip);
     If TheIndex >= 0 Then Begin
        GetCCDefinitionOf := CCAt[TheIndex];
     End;
End;
Function TCCsByPercent.GetTotal:Currency;
Var
   TheTotal:            Currency;
   ListIndex:           Integer;
Begin
     TheTotal  := 0;
     ListIndex := 0;
     While ListIndex < Count Do Begin
           TheTotal := TheTotal + CCAt[ListIndex].Total;
           Inc(ListIndex);
     End;
     GetTotal := TheTotal;
End;

{ Class TPercentList : Methods }

Function TPercentList.GetCategoryAt(AnIndex:Integer):TPercentRange;
Begin
     GetCategoryAt := TPercentRange(Items[AnIndex]);
End;

{ Class TElementPercent : Methods }
Constructor TElementPercent.Create;
Begin
     Inherited Create;
     FCategories := TPercentList.Create;
     FCCs        := TCCsByPercent.Create;
End;
Destructor TElementPercent.Destroy;
Var
   ListIndex:           Integer;
   Category:            TPercentRange;
Begin
     FCCs.Free;
     ListIndex := 0;
     While ListIndex < FCategories.Count Do Begin
           Category := FCategories.CategoryAt[ListIndex];
           Category.Free;
           FCategories[ListIndex] := Nil;
           Inc(ListIndex);
     End;
     FCategories.Free;
     Inherited Destroy;
End;
Procedure TElementPercent.ClearCategoryValues;
Var
   ListIndex:           Integer;
   Category:            TPercentRange;
Begin
     ListIndex := 0;
     While ListIndex < FCategories.Count Do Begin
           Category := TPercentRange(FCategories[ListIndex]);
           Category.Total := 0;
           Inc(ListIndex);
     End;
End;
Procedure TElementPercent.ProcessCC(ACCCode,
                                    ACCDocumentType,
                                    ACCDocumentNo,
                                    ACCEquip:String;
                                    AValue:Currency);
Var
   CCDefinition:        TCCByPercent;
Begin
     CCDefinition := CCs.CCDefinitionOf[ACCCode,ACCDocumentType,
                                        ACCDocumentNo,ACCEquip];
     If Not Assigned(CCDefinition) Then Begin
        CCDefinition                := TCCByPercent.Create;
        CCDefinition.CCCode         := ACCCode;
        CCDefinition.CCDocumentType := ACCDocumentType;
        CCDefinition.CCDocumentNo   := ACCDocumentNo;
        CCDefinition.CCEquip        := ACCEquip;
        CCs.AddObject(CCDefinition.CCKey,CCDefinition)
     End;
     CCDefinition.Total := CCDefinition.Total + AValue/100.0;
End;
Procedure TElementPercent.AddCategory(ACategoryNo,ACategoryName:String;APercent:Double);
Var
   Category:            TPercentRange;
Begin
     Category := TPercentRange.Create;
     Category.CategoryNo   := ACategoryNo;
     Category.CategoryName := ACategoryName;
     Category.Percent      := APercent;
     FCategories.Add(Category);
End;     {
Procedure TElementPercent.ApplyTo(AnElementNo:String;AValue:Currency);
Var
   TheIndex:            Integer;
   Category:            TPercentRange;
Begin
     TheIndex := 0;
     While TheIndex < FCategories.Count Do Begin
           Category := TPercentRange(FCategories[TheIndex]);
           Category.ApplyTo(AnElementNo,AValue);
           Inc(TheIndex);
     End;
End;       }
Procedure TElementPercent.CalcCCPercents;
Var
   ElementValue:        Currency;
   CurrentCC:           TCCByPercent;
   TotalPercent:        Integer;
   ListIndex:           Integer;
   LastIndex:           Integer;
Begin
     ElementValue := CCs.Total;
     ListIndex    := 0;
     TotalPercent := 0;
     LastIndex    := CCs.Count - 1;
     While ListIndex < LastIndex Do Begin
           CurrentCC := CCs.CCAt[ListIndex];
{De Moya 2002-06-24....Sometimes the ElementValue is calculated with Zero
value.  An if-else if added to this code}
           if ElementValue > 0 then
             CurrentCC.Percent100 := Round(10000*CurrentCC.Total/ElementValue)
           else
             CurrentCC.Percent100 := 0;

           TotalPercent         := TotalPercent + CurrentCC.Percent100;
           Inc(ListIndex);
     End;
     If LastIndex >= 0 Then Begin
        CurrentCC := CCs.CCAt[ListIndex];
        CurrentCC.Percent100 := 10000 - TotalPercent;
     End;
End;

Procedure TElementPercent.CalcValuesByPercent(AnElementValues:TElementVals);
Var
   ListIndex:           Integer;
   Category:            TPercentRange;
   DecisionValue:       Currency;   { Value for decide if the Tax apply to the category }
Begin
     ListIndex := 0;
     While ListIndex < FCategories.Count Do Begin
           Category := TPercentRange(FCategories[ListIndex]);
           DecisionValue := Category.GetValueForElementByPercent(AnElementValues);
           Category.Total := 0;
           If Category.IsValueInRange(DecisionValue) Then Begin
              Category.Total := DecisionValue;
           End;
           Inc(ListIndex);
     End;
End;
{ Class TEleXPercent : Methods }
Function TEleXPercent.GetElement(AnElementNo:String):TElementPercent;
Var
   TheIndex:            Integer;
Begin
     TheIndex := IndexOf(AnElementNo);
     If TheIndex < 0 Then Begin
        GetElement := Nil; End
     Else Begin
        GetElement := Objects[TheIndex] As TElementPercent;
     End;
End;
Function TEleXPercent.GetElementAt(AnIndex:Integer):TElementPercent;
Begin
     GetElementAt := Objects[AnIndex] As TElementPercent;
End;
{ Class TElementLink : Methods }
Function TElementLink.GetKey:String;
Begin
     GetKey := ContractNo + PortionNo + ElementNo;
End;
Constructor TElementActs.Create(AList:TElementList);
Begin
     Inherited Create;
     FElements := AList
End;
Function TElementActs.ExistsContractPortion(AContract,APortion:String):Boolean;
Var
   ElementIndex:        Integer;    { Index of the found element }
   Node:                TElementLink;
Begin
     ExistsContractPortion := False;
     ElementIndex          := 0;
     While ElementIndex < Count Do Begin
           Node := Objects[ElementIndex] As TElementLink;
           If (Node.ContractNo = AContract) And (Node.PortionNo = APortion) Then Begin
              ExistsContractPortion := True;
              ElementIndex          := Count;
           End;
           Inc(ElementIndex);
     End;
End;
Function TElementActs.GetElementName(AContract,APortion,AnElementNo:String):String;
Var
   ElementIndex:        Integer;    { Index of the found element }
   Node:                TElementLink;
   ElementKey:          String;
Begin
     ElementKey   := AContract + APortion + AnElementNo;
     ElementIndex := IndexOf(ElementKey);
     If ElementIndex >= 0 Then Begin
        Node := Objects[ElementIndex] As TElementLink;
        GetElementName := FElements.ElementName[Trim(Node.ElementCode)];End
     Else Begin
        GetElementName := '';
     End;
End;
Procedure TElementActs.AddElement(AContract,APortion,AnElementNo,AnElementCode:String);
Var
   Node:                TElementLink;
Begin
     Node := TElementLink.Create;
     Node.ContractNo  := AContract;
     Node.PortionNo   := APortion;
     Node.ElementNo   := AnElementNo;
     Node.ElementCode := AnElementCode;
     AddObject(Node.Key,Node);
End;
Function TElementList.GetDefinitionOf(ACode:String):TElementDef;
Var
   ElementIndex:        Integer;    { Index of the current element }
Begin
     If Find(ACode,ElementIndex) Then Begin
        GetDefinitionOf := Objects[ElementIndex] As TElementDef;End
     Else Begin
        GetDefinitionOf := Nil;
     End;
End;

{ Class TEleNoDef  : Methods }

Constructor TEleNoDef.Create(ACode,AValue:String);
Begin
     Inherited Create;
     FElementNo     := ACode;
     FFlags         := AValue;
     FDiscount      := UpCase(AValue[1]) = 'Y';
     FThirdPartyInv := UpCase(AValue[2]) = 'Y';
     FPercent       := UpCase(AValue[3]) = 'Y';
     FNormalCost    := UpCase(AValue[4]) = 'Y';
     FPreserveSign  := Not (FDiscount xor FNormalCost);
End;

{ Class TEleNoEleCode : Methods }

Function TEleNoEleCode.GetElementNoName:String;
Begin
     GetElementNoName := ElementNo + '-' + Element.ElementName;
End;

{ Class TEleNoEleCodes : Methods }

Function TEleNoEleCodes.GetElementDef(AnIndex:String):TEleNoEleCode;
Var
   TheIndex:            Integer;
Begin
     TheIndex := IndexOf(AnIndex);
     If TheIndex < 0 Then Begin
        GetElementDef := Nil; End
     Else Begin
        GetElementDef := Objects[TheIndex] As TEleNoEleCode;
     End;

End;
Function TEleNoEleCodes.GetElementAt(AnIndex:Integer):TEleNoEleCode;
Begin
     GetElementAt := Objects[AnIndex] As TEleNoEleCode;
End;
Function TEleNoEleCodes.HasGroup(AnElementCode:String):Boolean;
Var
   InGroup:             Integer;
   ListIndex:           Integer;
   TheElement:          TEleNoEleCode;
Begin
     HasGroup  := False;
     InGroup   := 0;
     ListIndex := 0;
     While ListIndex < Count Do Begin
           TheElement := ElementAt[ListIndex];
           If TheElement.Element.ElementCode = AnElementCode Then Begin
              Inc(InGroup);
              If InGroup > 1 Then Begin
                 HasGroup  := True;
                 ListIndex := Count;
              End;
           End;
           Inc(ListIndex);
     End;
End;
Function TEleNoEleCodes.GetElementNoBase(AnElementCode:String):String;
Var
   TheElementNo:        String;
   ListIndex:           Integer;
   TheElement:          TEleNoEleCode;
Begin
     TheElementNo := 'zz';
     ListIndex    := 0;
     While ListIndex < Count Do Begin
           TheElement := ElementAt[ListIndex];
           If TheElement.Element.ElementCode = AnElementCode Then Begin
              If TheElementNo > TheElement.ElementNo Then Begin
                 TheElementNo := TheElement.ElementNo;
              End;
           End;
           Inc(ListIndex);
     End;
     GetElementNoBase := TheElementNo;
End;
{ Class TElementVals : Methods }

Function TElementVals.GetElementPaid(AnElement:String):Currency;
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := IndexOf(AnElement);
     If ElementIndex < 0 Then Begin
        GetElementPaid := 0; End
     Else Begin
        GetElementPaid := (Objects[ElementIndex] As TElementVal).ElementExeCnt;
     End;
End;
Function TElementVals.GetElementValue(AnElement:String):Currency;
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := IndexOf(AnElement);
     If ElementIndex < 0 Then Begin
        GetElementValue := 0; End
     Else Begin
        GetElementValue := (Objects[ElementIndex] As TElementVal).ElementExeAct;
     End;
End;
Function TElementVals.GetCCValues(AnElement:String):Currency;
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := IndexOf(AnElement);
     If ElementIndex < 0 Then Begin
        GetCCValues := 0; End
     Else Begin
        GetCCValues := (Objects[ElementIndex] As TElementVal).ElementValCC;
     End;
End;
Function TElementVals.GetElementDef(AnElement:String):TElementVal;
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := IndexOf(AnElement);
     If ElementIndex < 0 Then Begin
        GetElementDef := Nil; End
     Else Begin
        GetElementDef := Objects[ElementIndex] As TElementVal;
     End;
End;
Function TElementVals.GetElementAt(AnIndex:Integer):TElementVal;
Begin
     GetElementAt := Objects[AnIndex] As TElementVal;
End;
Procedure TElementVals.AddToCCValues(AnElement:String;AValue:Currency);
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := IndexOf(AnElement);
     If ElementIndex >= 0 Then Begin
        With (Objects[ElementIndex] As TElementVal) Do Begin
             ElementValCC := ElementValCC + AValue;
        End;
     End;
End;
Procedure TElementVals.SetElementValue(AnElement:String;AValue:Currency);
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := IndexOf(AnElement);
     If ElementIndex >= 0 Then Begin
        (Objects[ElementIndex] As TElementVal).ElementExeAct := AValue;
     End;
End;
Procedure TElementVals.SetElementPaid(AnElement:String;AValue:Currency);
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := IndexOf(AnElement);
     If ElementIndex >= 0 Then Begin
        (Objects[ElementIndex] As TElementVal).ElementExeCnt := AValue;
     End;
End;
{ This routine is used to replace the Clear standard routine. It's necessary
  because the standard Clear don't free the object in the list, only clear the
  list }
Procedure TElementVals.ClearAndFree;
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := 0;
     While ElementIndex < Count Do Begin
           Objects[ElementIndex].Free;
           Objects[ElementIndex] := Nil;
           Inc(ElementIndex);
     End;
     Clear;
End;
Procedure TElementVals.ClearTotalElementValues;
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := 0;
     While ElementIndex < Count Do Begin
           With Objects[ElementIndex] As TElementVal Do Begin
                ElementEdtAct := 0;
           End;
           Inc(ElementIndex);
     End;
End;
Procedure TElementVals.ClearCCValues;
Var
   ElementIndex:        Integer;    { Index of the current Element }
Begin
     ElementIndex := 0;
     While ElementIndex < Count Do Begin
           With Objects[ElementIndex] As TElementVal Do Begin
                ElementValCC := 0;
                CCPercents   := 0;
           End;
           Inc(ElementIndex);
     End;
End;
Procedure TElementVals.ValidateElementTops;
Var
   ElementIndex:        Integer;    { Index of the current Element }
   NewExeValue:         Currency;
Const
   EpsMin = -0.0001;
Begin
     ElementIndex := 0;
     While ElementIndex < Count Do Begin
           With Objects[ElementIndex] As TElementVal Do Begin
                NewExeValue := ElementExeAct + ElementExeCnt;
                If (ElementValCnt - NewExeValue) < EpsMin Then Begin
                   raise Exception.CreateFmt(ME_098,
                                   [ElementNo,ElementValCnt,ElementExeCnt,
                                              NewExeValue]);
                End;
           End;
           Inc(ElementIndex);
     End;
End;
{ Because MIMS accept different elements into a portion using the same
  Element_Code, it's possible to have different element with the same name
  into a portion. We work around it including ElementNo as a key field }
Function TLine01.GetKey:String;
Begin
     GetKey := ContractNo + PortionNo + ElementNo + CategoryName;
End;
Constructor TMIMSRegistry.Create;
Var
   ValueNames:          TStringList;
   ApplicationKey:      String;
Begin
     Try
        FHelpDirectory := '';//ExtractFilePath(Application.ExeName);
        FBinDirectory  := '';//ExtractFilePath(Application.ExeName);
     Finally
        ValueNames.Free;
     End;
End;
{ Class TCCCurrent : Methods }
Function TCCCurrent.GetKey:String;
Begin
     { Versión original :
       GetKey := ElementNo + GLAccount;

       Rolando Celedón 2003/06/05. Se extiende para discriminar incluso a
       nivel de Equipo }
     GetKey := ElementNo + GLAccount + DocumentType+ DocumentNo + EquipNo;
End;
{ Class TCCCList : Methods }

Function TCCCList.GetCostCenterAt(AnIndex:Integer):TCCCurrent;
Begin
     GetCostCenterAt := Objects[AnIndex] As TCCCurrent;
End;
{ Read function for the ExistsElement property. Return True if the Element
  AnElement has at least one cost center assigned in the default Cost Center
  list for the current Act Paid }
Function TCCCList.GetExistsElement(AnElement:String):Boolean;
Var
   CCIndex:             Integer;    { Index of the current Cost Center }
Begin
     GetExistsElement := False;
     CCIndex := 0;
     While CCIndex < Count Do Begin
           If CostCenterAt[CCIndex].ElementNo = AnElement Then Begin
              GetExistsElement := True;
              CCIndex := Count;
           End;
           Inc(CCIndex);
     End;
End;
{ This routine is used to replace the Clear standard routine. It's necessary
  because the standard Clear don't free the object in the list, only clear the
  list }
Procedure TCCCList.ClearAndFree;
Var
   CCIndex:             Integer;    { Index of the current Cost Center }
Begin
     CCIndex := 0;
     While CCIndex < Count Do Begin
           Objects[CCIndex].Free;
           Objects[CCIndex] := Nil;
           Inc(CCIndex);
     End;
     Clear;
End;
{ Use this routine to Mark all the original Cost Centers as "Old" before
  to save a new Cost Center distribution to SAF3A6. The update operations
  must mark its original Cost Centers as "Not Old" , in that way, after
  the update operations, the "Old" Cost Centers can be identified by using
  the IsOld flag and it will be possible to delete them }
Procedure TCCCList.MarkAsOld;
Var
   CCIndex:             Integer;    { Index of the current Cost Center }
Begin
     CCIndex := 0;
     While CCIndex < Count Do Begin
           CostCenterAt[CCIndex].IsOld := True;
           Inc(CCIndex);
     End;
End;

{ Class TCCSummary : Methods }

Function TCCSummary.GetPercentAsText:String;
Var
   IntegerDigits:       Integer;
   DecimalDigits:       Integer;
   TheText:             String;
begin
     Try
        IntegerDigits    := Percent Div 100;
        DecimalDigits    := Percent Mod 100;
        TheText          := IntToStr(IntegerDigits) + '.' ;
        TheText          := TheText + Format('%2.2d',[DecimalDigits]);
        GetPercentAsText := TheText + '%';
     Except
        On Exception Do GetPercentAsText := '0.00%';
     End;
end;
{ Class TCCSummaryList : Methods }

Function TCCSummaryList.GetCostCenterAt(AnIndex:Integer):TCCSummary;
Begin
     GetCostCenterAt := Objects[AnIndex] As TCCSummary;
End;
Function TCCSummaryList.GetCostCenter(ACostCenter:String):TCCSummary;
Var
   CCIndex:             Integer;
Begin
     GetCostCenter := Nil;
     CCIndex       := IndexOf(ACostCenter);
     If CCIndex >= 0 Then Begin
        GetCostCenter := CostCenterAt[CCIndex];
     End;
End;
Function TCCSummaryList.GetValue:Currency;
Var
   CCIndex:             Integer;
   TheValue:            Currency;
Begin
     TheValue := 0;
     CCIndex  := 0;
     While CCIndex < Count Do Begin
           TheValue := TheValue + CostCenterAt[CCIndex].Value;
           Inc(CCIndex);
     End;
     GetValue := TheValue;
End;
Procedure TCCSummaryList.AddCC(ACC:String;AValue:Currency;ADocType:String;ADocNo:String);
Var
   TheCC:               TCCSummary;
Begin
     {De Moya 2006-09-13 IC845 -Agrego el string '%#'+ADocType+ADocNo para que sumarice por
     centro de costos - tipo de documento y número de documento en lugar de hacer sólo
     por el centro de costos}
     TheCC := CostCenter[ACC+'%#'+ADocType+ADocNo];
     If Not Assigned(TheCC) Then Begin
        TheCC := TCCSummary.Create;
        {De Moya 2006-09-13 IC845 - Igual agrego string}
        AddObject(ACC+'%#'+ADocType+ADocNo,TheCC);
        TheCC.Value := 0;
{IC658} TheCC.DocumentType := ADocType;
{IC658} TheCC.DocumentNo   := ADocNo;
     End;
     TheCC.Value := TheCC.Value + AValue;
End;
{ Use this method to set the Percent property of the CC in the list when the
  CC distribution is by value. Note : You must ever use ONLY the method
  AddCC to add Cost Centers to the list because by using that method it's
  guarantee the property Value of the list is > 0 }
Procedure TCCSummaryList.CalculatePercents;
Var
   CCIndex:             Integer;
   TheCC:               TCCSummary;
   PercentSum:          Integer;
   TheValue:            Currency;
Begin
     PercentSum := 0;
     TheValue   := Value;
     CCIndex    := 0;
     While CCIndex < Count Do Begin
           TheCC         := CostCenterAt[CCIndex];
           TheCC.Percent := Round(10000*(TheCC.Value/TheValue));
           If (PercentSum + TheCC.Percent) > 10000 Then Begin
              TheCC.Percent := 10000 - PercentSum;
           End;
           PercentSum := PercentSum + TheCC.Percent;
           Inc(CCIndex);
     End;
End;
end.
