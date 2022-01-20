unit SAQ301001;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, DBGrids, StdCtrls, ExtCtrls, MCTypes, Buttons, ComCtrls,
  SAQTypes,
  //RefCodesService, ValuationsService , SOAPHTTPClient, Rio,
  MCObjcts;

type
  TfrmSAQ301001Main = class(TForm)
    MainMenu1: TMainMenu;
    MTDocuments: TMenuItem;
    MDNew: TMenuItem;
    MDOpen: TMenuItem;
    MDPutNull: TMenuItem;
    MDApprove: TMenuItem;
    MDPrint: TMenuItem;
    N1: TMenuItem;
    MDExit: TMenuItem;
    MTReports: TMenuItem;
    MRRep01: TMenuItem;
    MRRep02: TMenuItem;
    MRRep03: TMenuItem;
    MTHelp: TMenuItem;
    MHAbout: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EdtSupplierCode: TEdit;
    EdtContractCode: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EdtActPaidNo: TEdit;
    CmbStatus: TComboBox;
    BtnSearch: TButton;
    GrdActsPaid: TDBGrid;
    BtnSuppliers: TSpeedButton;
    MHMIMS: TMenuItem;
    MHApplications: TMenuItem;
    MHActsPaid: TMenuItem;
    N2: TMenuItem;
    BtnNewSearch: TButton;
    StbStatus: TStatusBar;
    MDSend: TMenuItem;
    MRRep04: TMenuItem;
    anmFindActs: TAnimate;
    MDUnApprove: TMenuItem;
    N3: TMenuItem;
    MRAPSummary: TMenuItem;
    CkBxTodaJerarquia: TCheckBox;
    procedure MRRep01Click(Sender: TObject);
    procedure MRRep03Click(Sender: TObject);
    procedure MDPrintClick(Sender: TObject);
    procedure MDExitClick(Sender: TObject);
    procedure GrdActsPaidDblClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSuppliersClick(Sender: TObject);
    procedure MDNewClick(Sender: TObject);
    procedure BtnNewSearchClick(Sender: TObject);
    procedure MDApproveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MDPutNullClick(Sender: TObject);
    procedure MDSendClick(Sender: TObject);
    procedure MTDocumentsClick(Sender: TObject);
    procedure StbStatusDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure MHAboutClick(Sender: TObject);
    procedure MRRep02Click(Sender: TObject);
    procedure MRRep04Click(Sender: TObject);
    procedure MHMIMSClick(Sender: TObject);
    procedure MHApplicationsClick(Sender: TObject);
    procedure MHActsPaidClick(Sender: TObject);
    procedure MDUnApproveClick(Sender: TObject);
    procedure MRAPSummaryClick(Sender: TObject);
    procedure MTReportsClick(Sender: TObject);
    //Procedure DeleteRefCode(ValnNo : String);
    //procedure HTTPRIO1BeforeExecute(const MethodName: String;
    //  var SOAPRequest: WideString);
    //Function SetAuthenticationHeader(var SOAPRequest : WideString):String;
    //function DeleteValn(AContract : String): boolean;
  private
    { Private declarations }
    FStatusCode:        String;     { Ordinal value of the Status Code as string }
    FSearchOptions:     TActPaidDef;{ Input User for Search }
    FMIMSVersion:       TInfoVersion;{ MIMS Version parameters }
    FNoTieneSubourdinados : Boolean;
    FCCPositives:       TCCSummaryList; { Cost Centers of Positive Elements }
    FCCNegatives:       TCCSummaryList; { Cost Centers of Negative Elements }
    TotalNegativeValue: Currency;
    TotalPositiveValue: Currency;
    Function HasRecords:Boolean;
    Function CanPutNull:Boolean;
    Function CanSend:Boolean;
    Function CanApprove:Boolean;
    Function CanUnApprove:Boolean;
    Function GetStatusCode:TActStatus;
    Function GetSearchingCode:TSearchingCode;
    Procedure SetDblClickOnTheGrid;
    Procedure UpdateCurrentSelection;
    Procedure SetTotalResults;
    procedure RetrieveRecords(SearchBy:TSearchingCode);
    procedure SearchActs;
    procedure ExecHelpFile(AName:String);
    procedure ExecSendCommand;
    procedure InitMainWindowStructures;
  public
    { Public declarations }
    MimsUsername :String;
    MimsPassword :String;
    MimsDistrict :String;
    MimsPosition :String;
    Opening :String;
    Property StatusCode:  String Read FStatusCode  Write FStatusCode;
  end;

var
  frmSAQ301001Main: TfrmSAQ301001Main;


implementation
uses MCDMActs, MCConnct, MCUtils, MCAbout,
  SAQ301002, SAQ301004, SAQ301005, SAQ301007, SAQ301008,
  SAQ301010, SAQ301011, SAQ301012, SAQ301013, SAQ301014, SAQ301015,
  SAQUtils, DB;

{$R *.DFM}

{ Check if there are records avalaibles }
Function TfrmSAQ301001Main.HasRecords:Boolean;
Begin
     With dmActs.tblSearch Do Begin
          { In spite of tblSearch is ever active, we check it to avoid
            errors }
          HasRecords := Active And (RecordCount > 0);
     End;
End;
{ Check if the user can put the current act paid in the Null state }
Function TfrmSAQ301001Main.CanPutNull:Boolean;
Begin
     CanPutNull := (dmActs.UserRights = urFullAccess) And
                   ((dmActs.tblSearchSTATUS.Value = StrStatusOf(asPendent)) Or
                    (dmActs.tblSearchSTATUS.Value = StrStatusOf(asSent)));
End;
{ Check if the user can send the current act paid to the payment authorizer }
Function TfrmSAQ301001Main.CanSend:Boolean;
Begin
     CanSend := (dmActs.UserRights = urFullAccess) And
                (dmActs.tblSearchSTATUS.Value = StrStatusOf(asPendent));
End;
{ Check if the user can unapprove the current act paid }
Function TfrmSAQ301001Main.CanUnApprove:Boolean;
Begin
     CanUnApprove := (dmActs.UserRights = urFullAccess) And
                     (dmActs.tblSearchSTATUS.Value = StrStatusOf(asApproved)) And
                     (dmActs.tblSearchAPPROVED_BY.AsString = Trim(dmActs.CurrentUser));
    {2004-03-30 De Moya. El caso reportado por el cliente se da porque a nivel
    de pruebas el usuario entra al programa como Aprobador y también como
    Administrador.  Este caso no se dará en productivo}
End;
{ Check if the user can approve acts }
Function TfrmSAQ301001Main.CanApprove:Boolean;
Begin
     CanApprove := (dmActs.UserRights = urFullAccess) And
                   (dmActs.MaxToApprove > 1);
End;
{ Get what Status was the user choice checking the text in CmbStatus }
Function TfrmSAQ301001Main.GetStatusCode:TActStatus;
Var
   StatusName:          String;     { Input: Status Name in Upper Case }
   StatusOk:            Boolean;    { Check if Status Name is valid }
   StatusIndex:         TActStatus; { Index of Status }
Begin
     GetStatusCode := asNone;
     StatusName := UpperCase(CmbStatus.Text);
     If StatusName <> '' Then Begin
        StatusOk := False;
        For StatusIndex := Low(TActStatus) To High(TActStatus) Do Begin
            If StatusName = UpperCase(StatusNames[StatusIndex]) Then Begin
               GetStatusCode := StatusIndex;
               StatusOk := True;
            End;
        End;
        If Not StatusOk Then Begin
           ShowMessage(ME_005);
           Abort;
        End;
     End;
End;
{ Get the code for the search method }
Function TfrmSAQ301001Main.GetSearchingCode:TSearchingCode;
Var
   DefActPaid:          Boolean; { True: Act Paid is specified }
   DefContract:         Boolean; { True: Contract is specified }
   DefSupplier:         Boolean; { True: Supplier is specified }
   DefStatus:           Boolean; { True: Status is specified }
Begin
     With FSearchOptions Do Begin
          { Fill Search Options }
          ActPaidCode     := EdtActPaidNo.Text;
          ActPaidContract := EdtContractCode.Text;
          ActPaidSupplier := EdtSupplierCode.Text;
          ActPaidStatus   := GetStatusCode;
          { Get as string the ordinal value of the Status code to use in
            the SQL condition }
          FStatusCode     := ActPaidStatusS;
          { Check what options are specified }
          DefActPaid  := ActPaidCode <> '';
          DefContract := ActPaidContract <> '';
          DefSupplier := ActPaidSupplier <> '';
          DefStatus   := ActPaidStatus <> asNone;
     End;

     { Set Searching Code for each possible case. Default : Search all }

     GetSearchingCode := scAll;
     If DefActPaid And Not (DefContract Or DefSupplier Or DefStatus) Then Begin
        GetSearchingCode := scByAct;
     End;
     { In this case, don't care about DefSupplier Or DefStatus }
     If DefActPaid And DefContract Then Begin
        GetSearchingCode := scByContractAct;
     End;
     If DefActPaid And DefSupplier And Not (DefContract Or DefStatus) Then Begin
        GetSearchingCode := scBySupplierAct;
     End;
     If DefActPaid And DefSupplier And DefStatus And Not DefContract Then Begin
        GetSearchingCode := scBySupplierActStatus;
     End;
     { In this case, don't care about DefSupplier }
     If DefContract And Not (DefActPaid Or DefStatus) Then Begin
        GetSearchingCode := scByContract;
     End;
     { In this case, don't care about DefSupplier }
     If DefContract And DefStatus And Not DefActPaid Then Begin
        GetSearchingCode := scByContractStatus;
     End;
     If DefSupplier And Not (DefContract Or DefStatus Or DefActPaid) Then Begin
        GetSearchingCode := scBySupplier;
     End;
     If DefSupplier And DefStatus And Not (DefContract Or DefActPaid) Then Begin
        GetSearchingCode := scBySupplierStatus;
     End;
     If DefStatus And Not (DefContract Or DefSupplier Or DefActPaid) Then Begin
        GetSearchingCode := scByStatus;
     End;
End;
{ Use this routine to exec the SQL statement required by the kind of
  search specified in the parameter SearchBy. The records retrieved
  are in the DataSet SQLActs. The right access work as follow :
  If the user rights are from the portion; the system must be read
  MSF385 to know if the user is one of the four able to access the
  portion; however, this is true only if the user has full access to
  the portion because, if the access is only review, the user is able
  to access ALL the acts in system; therefore, it's not necessary to
  read information from MSF385. The same last reason apply if the
  user rights are from the contract; therefore, the system only add
  the condition "USER MUST BE ONE OF THE RESPONS_CODE IN MSF384, OR
  MSF385", if the user has full access }
procedure TfrmSAQ301001Main.RetrieveRecords(SearchBy:TSearchingCode);
Var
   SelectLine:          String;         { SQL Fields for Select statement }
   Condition:           String;         { SQL Condition for Select statement }
   UseMSF385:           Boolean;        { Flag to know if the query use MSF385 }
   Pos_Subordinados:    Array [1..200] of string[10];
   Max_Sub, Act_Sub, i:    Integer;
   condicion_ext:        String;
Begin
     { Get Selection Line and Condition for the select statement }
     SelectLine := SQLSearch[SearchBy,slsSelection];
     {SelectLine := SelectLine + ', A.EMP_APROBADOR, A.POS_APROBADOR ';   }
     SelectLine := SelectLine + ', A.EMP_APROBADOR, A.POS_APROBADOR, A.EXT_INV_NO ';
     SelectLine := Format(SQLCommonSelection01,[SelectLine]);
     UseMSF385  := dmActs.UserConfig.APRight = aprPortion;
     If UseMSF385 Then Begin
        SelectLine := SelectLine + SQLCommonSelection02;
     End;

     //SelectLine := SelectLine + SQLCommonSelection03;

     Condition := SQLCommonCondition01;
     If UseMSF385 Then Begin
        //Condition := Condition + SQLCommonCondition02;
     End;

     {De Moya 2004-04-20. Para las posiciones que tienen como valores de
     aprobación 0 en la msf872 tipo ACCP permite acceso de lectura}
     With dmacts.SQLValMinMaxACCP Do Begin
       Try
         Active:=False;
         Params[0].AsString:=dmActs.MimsPosition;
         Params[1].AsString:=dmActs.CurrentDistrict;
         If Not Prepared Then Begin
           Prepare;
         End;
         Active:=True;
         {If Fields[0].IsNull Then Begin
           raise Exception.Create(ME_010);
         End;}
       Except
         On E:Exception Do Begin
            raise Exception.CreateFmt(ME_011,[' ',E.Message]);
         End;
       End;
     End;

     {2004-04-06. Busco si la posición tiene subordinados. En caso de no tener
     dejo en la condición del query la validación del respons_code, en caso de
     tener subordinados esta validación no es necesaria.}
     With dmacts.SQLBuscaSub Do Begin
       Try
         Active:=False;
         {Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;}
         Params[0].AsString:='I001';
         Params[1].AsString:=dmActs.MimsPosition;
         If Not Prepared Then Begin
            Prepare;
         End;
         Active:=True;
         {If Fields[0].IsNull Then Begin
            raise Exception.Create(ME_010);
         End;}
       Except
          On E:Exception Do Begin
               raise Exception.CreateFmt(ME_011,[' ',E.Message]);
             End;
       End;
     End;
     //showmessage('dmActs.MimsPosition=' + dmActs.MimsPosition);
     if dmActs.SQLBuscaSub.Fields[0].IsNull then  begin
        //showmessage('No tiene subordinados...');
        FNoTieneSubourdinados := True;
     end
     else
        FNoTieneSubourdinados := False;


     If (dmActs.UserRights = urFullAccess) and
        (dmActs.SQLBuscaSub.Fields[0].IsNull) and
        (dmActs.SQLValMinMaxACCP.Fields[0].IsNull) Then Begin
        Case dmActs.UserConfig.APRight Of
        aprContract : Condition := Condition + SQLCommonUserOwner01;
        aprPortion  : Condition := Condition + SQLCommonUserOwner02;
        Else raise Exception.Create(ME_172);
        End;


        Condition  := Format(Condition,[dmActs.CurrentUser,
                                        dmActs.CurrentUser,
                                        dmActs.CurrentUser,
                                        dmActs.CurrentUser]);
     End;
     Condition  := Condition + SQLSearch[SearchBy,slsCondition];
     Case SearchBy Of
     scByAct               : Condition := Format(Condition,[EdtActPaidNo.Text]);
     scByContract          : Condition := Format(Condition,[EdtContractCode.Text]);
     scByContractAct       : Condition := Format(Condition,[EdtContractCode.Text,
                                                            EdtActPaidNo.Text]);
     scByContractStatus    : Condition := Format(Condition,[EdtContractCode.Text,
                                                            Statuscode]);
     scBySupplier          : Condition := Format(Condition,[EdtSupplierCode.Text]);
     scBySupplierAct       : Condition := Format(Condition,[EdtSupplierCode.Text,
                                                            EdtActPaidNo.Text]);
     scBySupplierStatus    : Condition := Format(Condition,[EdtSupplierCode.Text,
                                                            Statuscode]);
     scBySupplierActStatus : Condition := Format(Condition,[EdtSupplierCode.Text,
                                                            EdtActPaidNo.Text,
                                                            Statuscode]);
     scByStatus            : Condition := Format(Condition,[Statuscode]);

     End;
     { Get Records }
     {De Moya 2004-02-12 Aqui incluyo código para recuperar registros del
     aprobador actual}
     Max_Sub:=1;;
     Act_Sub:=1;
     pos_subordinados[1]:=dmActs.MimsPosition;
     if CkBxTodaJerarquia.Checked then
     begin
       While Act_Sub <= Max_Sub do
       begin
         With dmActs.SQLCurrentHier Do Begin
              Try
                 Active:=False;
                 If Not Prepared Then Begin
                    Prepare;
                 End;
                 Active:=True;
                 If Fields[0].IsNull Then Begin
                    raise Exception.Create(ME_010);
                 End;
              Except
                 On E:Exception Do Begin
                    raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                 End;
              End;
         End;
         With dmacts.SQLBuscaSub Do Begin
           Try
             Active:=False;
             {Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;}
             Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;
             Params[1].AsString:=pos_subordinados[Act_Sub];
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             {If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;}
           Except
              On E:Exception Do Begin
                   raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                 End;
           End;
         End;

         With dmacts.SQLBuscaSub do
         begin
           while not eof do
           begin
             Max_Sub:=Max_Sub+1;
             Pos_Subordinados[Max_Sub]:=Fields[0].AsString;
             {showmessage(inttostr(max_sub)+'&&'+inttostr(act_sub)+'&&'+fields[0].AsString);}
             next;
           end;
         end;
         Act_Sub:=Act_Sub+1;
       end;
     end
     else
     begin
       With dmacts.SQLBuscaSub Do Begin
         Try
           Active:=False;
           {Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;}
           Params[0].AsString:='I001';
           Params[1].AsString:=pos_subordinados[Act_Sub];
           If Not Prepared Then Begin
              Prepare;
           End;
           Active:=True;
           {If Fields[0].IsNull Then Begin
              raise Exception.Create(ME_010);
           End;}
         Except
            On E:Exception Do Begin
                 raise Exception.CreateFmt(ME_011,[' ',E.Message]);
               End;
            End;
       End;

       With dmacts.SQLBuscaSub do
       begin
         while not eof do
         begin
           Max_Sub:=Max_Sub+1;
           Pos_Subordinados[Max_Sub]:=Fields[0].AsString;
           {showmessage(inttostr(max_sub)+'&&'+inttostr(act_sub)+'&&'+fields[0].AsString);}
           next;
         end;
       end;
     end; //Fin ELSE

{     if SearchBy = scByStatus then
     begin}
         i:=2;
         {De Moya 2006-09-05 - IC816 Coloco el string constante MIGRACION para que
         tome las actas que fueron migradas y no tenían posición válida en ese campo.
         Adiconalmente agrego trim al campo POS_ENVIADOR para que tome aquellos campos
         que eran varchar y ahora son char}
         {De Moya 2006-10-09 - Suprimo el string MIGRACION para que los contratos solo
         se muestren al usuario que esta en la jerarquia}
         condicion_ext:=' AND (trim(POS_ENVIADOR) IN (';
         while i <= Max_Sub do
         begin
           condicion_ext:=condicion_ext + '''' + pos_subordinados[i] + ''', ';
           i:=i+1;
         end;
         if Max_Sub > 1 then
         begin
           delete(condicion_ext,length(condicion_ext)-1,2);
           condicion_ext:=condicion_ext + '))';
           Condition:=Condition + condicion_ext;
         end;
{     end;}
     if (FNoTieneSubourdinados) and (CkBxTodaJerarquia.Visible = True) then
        Condition:=Condition + ' AND (POS_ENVIADOR = ''IC645'') ';

     Condition := Condition + ' ORDER BY A.PORTION_NO ASC, A.ACT_PAID_NO ASC';
     dmActs.GetActsPaid(SelectLine,Condition);
End;
{ Use this routine to set the OnDblClick event. It must be able only if
  there are records avalaibles }
Procedure TfrmSAQ301001Main.SetDblClickOnTheGrid;
Begin
     If HasRecords Then Begin
        GrdActsPaid.OnDblClick:=GrdActsPaidDblClick;End
     Else Begin
        GrdActsPaid.OnDblClick:=Nil;
     End;
End;
{ Use this routine to set the current Act Paid data in memory with
  the record selected in the Search Window. }
Procedure TfrmSAQ301001Main.UpdateCurrentSelection;
Var ContractNo : String;
 strActPaidCode : String;
 strActPaidPortion : String;
 strActPaidSupplier : String;
 strActPaidDate : String;
 strActPaidStatusS : String;
Begin
     With dmActs,CurrentActPaid Do Begin
         {De Moya 2006-03-02}
          ContractNo:=GetMimsKey(tblSearchCONTRACT_NO.AsString,8);
          ActPaidContract := tblSearchCONTRACT_NO.AsString;
          ActPaidContract := ContractNo;
          ActPaidCode     := tblSearchACT_PAID_NO.AsString;
          ActPaidPortion  := tblSearchPORTION_NO.AsString;
          ActPaidSupplier := tblSearchSUPPLIER_NO.AsString;
          ActPaidDate     := tblSearchACT_PAID_DATE.AsString;
          ActPaidStatusS  := tblSearchSTATUS.AsString;
          //ActPaidValnNo   := tblSearchVALN_NO.AsString;
          strActPaidCode     := tblSearchACT_PAID_NO.AsString;
          strActPaidPortion  := tblSearchPORTION_NO.AsString;
          strActPaidSupplier := tblSearchSUPPLIER_NO.AsString;
          strActPaidDate     := tblSearchACT_PAID_DATE.AsString;
          strActPaidStatusS  := tblSearchSTATUS.AsString;
     End;
End;
{ Use this routine to set fields relatives to the number of records
  avalaibles in the Search grid }
Procedure TfrmSAQ301001Main.SetTotalResults;
Begin
     { Update status bar }
     StbStatus.Panels[0].Text:=Format(MI_001,[dmActs.tblSearch.RecordCount]);
     StbStatus.Panels[1].Text:='';
     { Enable operations on the records in the grid }
     SetDblClickOnTheGrid;
End;

procedure TfrmSAQ301001Main.GrdActsPaidDblClick(Sender: TObject);
begin
     frmSAQ301001Main.Opening := 'S';
     { First, Fill the description of the record selected }
     UpdateCurrentSelection;
     { Get information about the corresponding Contract-Portion }
     With dmActs,CurrentActPaid Do Begin
          {De Moya 2003-06-02}
          ActPaidContract:=GetMimsKey(ActPaidContract,8);
          GetContractDefinition(ActPaidContract);
          GetPortionDefinition(ActPaidContract,ActPaidPortion);
     End;
     { Now, edit the record. The routine also verify the read only cases }
     dmActs.NewAct := False; { Rolando Celedón 2003-06-19 Check for New act }
     EditActPaid(Self);
     {De Moya 2004-04-22 Refresca la búsqueda}
     BtnSearchClick(Self);
end;
{ This routine retrieve the acts paid according to the search conditions
  and display them on the grid }
procedure TfrmSAQ301001Main.SearchActs;
Var
   SearchBy:            TSearchingCode; { Kind of Search }
begin
     { Get Kind of Search }
     SearchBy := GetSearchingCode;
     If SearchBy = scAll Then Begin
        If Not OperationOk(MC_001) Then Begin
           Abort;
        End;
     End;
     { Active the FindComputer avi before to init the searching }
     anmFindActs.Active  := True;
     { Retrieve records according to the search conditions }
     StbStatus.Panels[1].Text := MI_002;
     StbStatus.Refresh;
     RetrieveRecords(SearchBy);
     { To locate each Field retrieved, first, get the corresponding
       object fields }
     dmActs.GetFieldsDefinitionForActs;
     { Create List }
     dmActs.SearchResultsToAuxiliaryTable(FSearchOptions);
     { Refresh Total Results in Search Window }
     SetTotalResults;
end;

procedure TfrmSAQ301001Main.StbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin        {
     with StatusBar.Canvas Do begin
          Brush.Color := clRed;
          FillRect(Rect);
          Font.Color := clYellow;
          ImageList1.Draw(StatusBar.Canvas,Rect.Left,Rect.Top,Panel.Index);
          TextOut(Rect.left + 30, Rect.top + 2, 'Panel' + IntToStr(Panel.Index));
     end;   }
end;

{ Create and Destroy events for the main form }

procedure TfrmSAQ301001Main.InitMainWindowStructures;
Var
   StatusIndex:         TActStatus; { Status avalaibles for Search }
begin
     { Set MIMS Version parameters for the application }
     FMIMSVersion.Project    := MIMSActPaidProject;
     FMIMSVersion.VersionNo  := MIMSActPaidVersionNo;
     FMIMSVersion.RevisionNo := MIMSActPaidRevisionNo;
     FMIMSVersion.ModuleNo   := MIMSActPaidModuleNo;
     { Set Search Options }
     FSearchOptions := TActPaidDef.Create;
     { Load Status names }
     For StatusIndex := Low(TActStatus) To High(TActStatus) Do Begin
         CmbStatus.Items.Add(StatusNames[StatusIndex]);
     End;
     {De Moya 2003-11-24 Coloca Default para Aprobadores en el CmbSatus}
          With dmacts.SQLValMinMaxACCP Do Begin
          Try
             Active:=False;
             Params[0].AsString:=dmActs.MimsPosition;
             Params[1].AsString:=dmActs.CurrentDistrict;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             {If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;}
             Except
                On E:Exception Do Begin
                   raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                End;
             End;
     End;
     if not dmActs.SQLValMinMaxACCP.Fields[0].IsNull then
     begin
       if dmActs.SQLValMinMaxACCP.Fields[1].AsFloat > 0 then
       begin
         CmbStatus.Text:='Enviado';
         CkBxTodaJerarquia.Visible:=True;
       end;
     end
     else
     {De Moya 2004-02-27 La posición administradora no debe tener acceso al
     Radio Button de toda la jerarquía. Por lo tanto incluyo el presente
     ELSE y aseguro que el radio button sea visible en el IF}
     begin
       CkBxTodaJerarquia.Visible:=False;
     end;
     { Load Cache List for Elements }
     dmActs.LoadElements;
     { Load Cache List for Elements No definitions }
     dmActs.LoadElementNoDefinitions;
     {De Moya 2003-11-24 Dispara la búsqueda}
     if not dmActs.SQLValMinMaxACCP.Fields[0].IsNull then
     begin
       if dmActs.SQLValMinMaxACCP.Fields[1].AsFloat > 0 then
       begin
         btnSearch.Click;
       end;
     end;
end;
procedure TfrmSAQ301001Main.FormCreate(Sender: TObject);
Begin
     If Application.ShowMainForm Then Begin
        If dmActs.ConnectToDBMIMS then begin

            MimsUsername := Trim(dmActs.CurrentUserID);
            MimsPosition := dmActs.MimsPosition;
            MimsDistrict := dmActs.CurrentDistrict;
            MimsPassword := dmActs.CurrentPassword;
            Caption := Caption + ' - ' + dmActs.CurrentEnv;

            InitMainWindowStructures;
        end;
     End;
End;
procedure TfrmSAQ301001Main.FormDestroy(Sender: TObject);
begin
     FSearchOptions.Free;
     If Application.ShowMainForm Then Begin
        dmActs.DeleteTemporalTables;
     End;
end;

{ Buttons avalaibles }

procedure TfrmSAQ301001Main.BtnSuppliersClick(Sender: TObject);
begin
     Try
        EdtSupplierCode.Text := frmSAQ301008Suppliers.SelectSupplierCode(EdtSupplierCode.Text);
     Except
        On E:Exception Do Begin
           ShowMessage(Format(ME_008,[E.Message]));
        End;
     End;
end;

procedure TfrmSAQ301001Main.BtnSearchClick(Sender: TObject);
Begin
     Try
        Try
           {De Moya 2006-03-02 Cambio GetMimsKey a GetMimsKey2}
           EdtSupplierCode.Text := GetMIMSKey2(EdtSupplierCode.Text,6);
           EdtContractCode.Text := GetMIMSKey2(UpperCase(EdtContractCode.Text),8);
           EdtActPaidNo.Text    := GetMIMSKey2(EdtActPaidNo.Text,10);
           SearchActs;
        Finally
           anmFindActs.Active   := False;
        End;
     Except
        On E:Exception Do Begin
           ShowMessage(Format(ME_002,[E.Message]));
           GrdActsPaid.OnDblClick:=Nil;
           StbStatus.Panels[0].Text:=Format(MI_001,[0]);
           StbStatus.Panels[1].Text:='';
           dmActs.tblSearch.CancelUpdates;
        End;
     End;
End;

procedure TfrmSAQ301001Main.BtnNewSearchClick(Sender: TObject);
begin
     EdtSupplierCode.Text:='';
     EdtContractCode.Text:='';
     EdtActPaidNo.Text:='';
     CmbStatus.Text:='';
     StbStatus.Panels[0].Text:=Format(MI_001,[0]);
     StbStatus.Panels[1].Text:='';
end;

{ Top Menu options }

procedure TfrmSAQ301001Main.MTDocumentsClick(Sender: TObject);
begin
     MDOpen.Enabled      := HasRecords;
     MDNew.Enabled       := dmActs.UserRights = urFullAccess;
     MDPutNull.Enabled   := MDOpen.Enabled And CanPutNull;
     MDSend.Enabled      := MDOpen.Enabled And CanSend;
     MDPrint.Enabled     := MDOpen.Enabled;
     MDUnApprove.Enabled := MDOpen.Enabled And CanUnApprove;
     MDApprove.Enabled   := CanApprove;
     {2003-10-14 Impide aprobar como lo hacía la versión anterior}
     MDApprove.Enabled   := Not CanApprove;
     {2004-03-18 Nadie puede aprobar como lo hacía la versión anterior}
     MDApprove.Enabled   := False;

     {De Moya 2003-12-09 No permite crear actas a los aprobadores}
     With dmacts.SQLValMinMaxACCP Do Begin
          Try
             Active:=False;
             Params[0].AsString:=dmActs.MimsPosition;
             Params[1].AsString:=dmActs.CurrentDistrict;
             If Not Prepared Then Begin
                Prepare;
             End;
             Active:=True;
             {If Fields[0].IsNull Then Begin
                raise Exception.Create(ME_010);
             End;}
             Except
                On E:Exception Do Begin
                   raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                End;
             End;
     End;
     if not dmActs.SQLValMinMaxACCP.Fields[0].IsNull then
     begin
       if dmActs.SQLValMinMaxACCP.Fields[1].AsFloat > 0 then
       begin
         MDNew.Enabled:=false;
       end;
     end;
end;

{ Documents Menu : Options Avalaibles }

procedure TfrmSAQ301001Main.MDNewClick(Sender: TObject);
begin
     //CreateNewActPaid(Self);
     CreateNewActPaid(Self, MimsUsername);
end;

procedure TfrmSAQ301001Main.MDPutNullClick(Sender: TObject);
begin
   If  (MessageDlg('Realmente desea anular el Acta.',
     mtCustom,[mbYes,mbNo], 0)) = mrYes  Then begin

       With dmActs Do Begin
            SetActPaidStatus(tblSearchCONTRACT_NO.AsString,
                             tblSearchACT_PAID_NO.AsString,
                             StrStatusOf(asNull),
                             tblSearchSTATUS.AsString );
            If FSearchOptions.ActPaidStatus <> asNone Then Begin
               { Refresh Search Window }
               tblSearch.Delete;
               { Refresh Total Results in Search Window }
               SetTotalResults;
            End;
       End;
   End;
end;

procedure TfrmSAQ301001Main.ExecSendCommand;
var Mns, ContractNo,ActPaidNo : string;
    //ValorPagado : real;
    //Jafeth 24/11/2016
    //Variables creada para la suma  entre el valor pagado y el valor de la suma de las actas.
     ValorPagado : Double;
     ValorTotal : Double;
     ValorExcedido : Double;
begin
     {2005-06-02 IC668}
     {Valido que el valor de la porción no sea excedido por la suma del
     valor del acta actual mas las actas enviadas mas las que se encuentran en
     estado aprobado o superior
     Agrego los tres siguientes queries al código}
     With dmacts do begin
          {IC668 Determino los valores del contrato-porción}
          With dmacts.SQLPortion Do Begin
              Try
                Active:=False;
                {De Moya 2006-03-02 Defino variable ContractNo}
                ContractNo:=GetMimsKey(tblSearchCONTRACT_NO.AsString,8);
                ActPaidNo:=GetMimsKey(tblSearchACT_PAID_NO.AsString,10);
                {Params[0].AsString:=tblSearchCONTRACT_NO.AsString;}
                Params[0].AsString:=ContractNo;
                Params[1].AsString:=tblSearchPORTION_NO.AsString;
                If Not Prepared Then Begin
                  Prepare;
                End;
                Active:=True;
                If Fields[0].IsNull Then Begin
                  raise Exception.Create(ME_010);
                End;
                Except
                  On E:Exception Do Begin
                  raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                End;
              End;
          End;
          {IC668 - Determino el valor pagado de las actas enviadas y en estado
          aprobado o superior}

          ValorPagado:=0;
          With dmacts.SQLValorPagado Do Begin
            Try
              Active:=False;
              Params[0].AsString:=tblSearchCONTRACT_NO.AsString;
              {De Moya 2006-03-02 Defino variable ContractNo}
              Params[0].AsString:=ContractNo;
              Params[1].AsString:=tblSearchPORTION_NO.AsString;
              If Not Prepared Then Begin
                Prepare;
              End;
              Active:=True;
              {De Moya 2005-08-30}
              {Cuando el contrato existe pero sólo tiene un acta en estado pendiente
               no encuentra registros.  Por lo tanto el valor pagado se coloca en cero}
              If Not Fields[0].IsNull Then Begin
                ValorPagado:=dmacts.SQLValorPagado.Fields[0].AsFloat;
                {raise Exception.Create(ME_010);}
              End;
              Except
                On E:Exception Do Begin
                raise Exception.CreateFmt(ME_011,[' ',E.Message]);
              End;
            End;
          End;
          {Determino el valor del acta actual a enviar}
          With dmacts.SQLValorActa do Begin
               Try
                  Active:=False;
                  Params[0].AsString:=tblSearchCONTRACT_NO.AsString;
                  {De Moya 2006-03-02 Defino variable ContractNo}
                  Params[0].AsString:=ContractNo;
                  Params[1].AsString:=tblSearchACT_PAID_NO.AsString;
                  ContractNo := tblSearchACT_PAID_NO.AsString;
                  If Not Prepared Then Begin
                     Prepare;
                  End;
                  Active:=True;
                  If Fields[0].IsNull Then Begin
                     raise Exception.Create(ME_010);
                  End;
               Except
                  On E:Exception Do Begin
                     raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                  End;
               End;
          End;
          //(Jafeth) Se suman las variables y Muestra los valores antes de hacer la validacion.
          ValorTotal   :=  SQLValorActa.Fields[0].AsFloat +ValorPagado;

              // ShowMessage(FloatToStr(ValorTotal));
              // ShowMessage(SQLPortionLIQ_DAM_LIMIT.AsString);

            //(Jafeth) se cambio la forma del condicional if
           // if (SQLPortionLIQ_DAM_LIMIT.AsFloat <
             {dmacts.SQLValorPagado.Fields[0].AsFloat + SQLValorActa.Fields[0].AsFloat then}
          //(ValorPagado + SQLValorActa.Fields[0].AsFloat)) then

        if (SQLPortionLIQ_DAM_LIMIT.AsFloat < ValorTotal) then
          begin
          //(Jafeth) Se cambio la forma de sumar las variables y mostrar el resutaldo.
             ValorExcedido := dmacts.SQLValorPagado.Fields[0].AsFloat + SQLValorActa.Fields[0].AsFloat - SQLPortionLIQ_DAM_LIMIT.AsFloat;
            // ShowMessage(FloatToStr(ValorExcedido));
             //ShowMessage(SQLValorActa.Fields[0].AsString + FloatToStr(ValorPagado));

             raise Exception.CreateFmt(ME_215,[tblSearchACT_PAID_NO.AsString,
                                               tblSearchCONTRACT_NO.AsString,
                                               //(Jafeth) dmacts.SQLValorPagado.Fields[0].AsCurrency+SQLValorActa.Fields[0].AsCurrency-SQLPortionLIQ_DAM_LIMIT.AsCurrency,
                                               FloatToCurr(ValorExcedido),
                                               SQLPortionLIQ_DAM_LIMIT.AsCurrency,
                                               SQLPortionLIQ_DAM_LIMIT.AsCurrency-dmacts.SQLValorPagado.Fields[0].AsCurrency]);

          end;

     End;

     With dmActs Do Begin
          {De Moya 2005-08-30 IC666 Comento estas líneas y las coloco al final
          del bloque para garantizar que sólo se actualice el acta si se dan
          todas las condiciones}
          {If GetActPaidValue(tblSearchCONTRACT_NO.AsString,
                             tblSearchACT_PAID_NO.AsString)=0 Then Begin
             raise Exception.CreateFmt(ME_074,[tblSearchACT_PAID_NO.AsString,
                                               tblSearchCONTRACT_NO.AsString]);
          End;
          ValidateCCDistribution(tblSearchCONTRACT_NO.AsString,
                                 tblSearchACT_PAID_NO.AsString);
          SetActPaidStatus(tblSearchCONTRACT_NO.AsString,
                           tblSearchACT_PAID_NO.AsString,
                           StrStatusOf(asSent),
                           tblSearchSTATUS.AsString );}
          {Codigo para actualizar el enviador en la saf3a0}
          {De Moya 2005-0825 IC672. Agrego ASentDate a la actualizacion siguiente}
          With dmActs.SQLupdEnviador Do Begin
             Try
                If Not Prepared Then Begin
                   Prepare;
                End;
                ParamByName('AContract').AsString   := dmacts.CurrentActPaid.ActPaidContract;
               {De Moya 2006-03-02 Defino variable ContractNo}
              //  ParamByName('AContract').AsString   := ContractNo;
               {De Moya 2006-07-07 Defino variable ActPaidNo}
                ActPaidNo:=GetMimsKey(tblSearchACT_PAID_NO.AsString,10);
                ParamByName('AnActPaidNo').AsString   := ActPaidNo;
                ParamByName('APosSender').AsString  := dmActs.MimsPosition;
                //ParamByName('ASentDate').AsString := Trim(dmActs.CurrentDate);
                //ParamByName('ASentDate').AsString := DateTimeToDate8(Date);
                ParamByName('ASentDate').AsString :=   CurrentDate;
                {De Moya 2006-Jul-06 Coloco la validación del CurrentDate para
                determinar y evitar que escriba fecha de envío en blanco}
                if trim(CurrentDate) = '' then
                begin
                  raise Exception.Create(ME_218);
                end
                else
                begin
                  ExecSQL;
                end;
                With dmActs.SQLCurrentHier Do Begin
                     Try
                        Active:=False;
                        If Not Prepared Then Begin
                           Prepare;
                        End;
                        Active:=True;
                        If Fields[0].IsNull Then Begin
                           raise Exception.Create(ME_010);
                        End;
                     Except
                        On E:Exception Do Begin
                           raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                        End;
                     End;
                End;
                With dmacts.SQLBuscaSup Do Begin
                      Try
                         Active:=False;
                         Params[0].AsString:=dmActs.SQLCurrentHier.Fields[0].AsString;
                         Params[1].AsString:=dmActs.MimsPosition;
                         If Not Prepared Then Begin
                            Prepare;
                         End;
                         Active:=True;
                         If Fields[0].IsNull Then Begin
                            raise Exception.Create(ME_010);
                         End;
                      Except
                         On E:Exception Do Begin
                            raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                         End;
                      End;
                 End;
                With dmacts.SQLGetUserIdPos Do Begin
                      Try
                         Active:=False;
                         Params[0].AsString:= Trim(dmacts.SQLBuscaSup.Fields[0].AsString);
                         If Not Prepared Then Begin
                            Prepare;
                         End;
                         Active:=True;
                         If Fields[0].IsNull Then Begin
                            raise Exception.Create(ME_010);
                         End;
                      Except
                         On E:Exception Do Begin
                            raise Exception.CreateFmt(ME_011,[' ',E.Message]);
                         End;
                      End;
                 End;
                {2004-03-29 De Moya.  Incluyo query para colocar el apellido (surname)
                y el nombre (firs_name) del empleado a quien se le redirecciona.  Me
                baso en la posición superior del usuario actual}
                With dmacts.SQLGetEmpNames Do Begin
                   Try
                       Active:=False;
                       Params[0].AsString:=Trim(dmacts.SQLBuscaSup.Fields[0].AsString);
                       Params[1].AsString:=CurrentDate;
                       If Not Prepared Then Begin
                          Prepare;
                       End;
                       Active:=True;
                       If Fields[0].IsNull Then Begin
                          raise Exception.Create(ME_216);
                       End;
                    Except
                       On E:Exception Do Begin
                          raise Exception.CreateFmt(ME_217,[' ',E.Message]);
                       End;
                    End;
                End;
                If GetActPaidValue(tblSearchCONTRACT_NO.AsString,
                                   tblSearchACT_PAID_NO.AsString)=0 Then Begin
                   raise Exception.CreateFmt(ME_074,[tblSearchACT_PAID_NO.AsString,
                                                     tblSearchCONTRACT_NO.AsString]);
                End;
                ValidateCCDistribution(tblSearchCONTRACT_NO.AsString,
                                       tblSearchACT_PAID_NO.AsString);
                SetActPaidStatus(tblSearchCONTRACT_NO.AsString,
                                 tblSearchACT_PAID_NO.AsString,
                                 StrStatusOf(asSent),
                                 tblSearchSTATUS.AsString );

                ShowMessage('Acta Enviada para aprobación a'+#13#10+
                            'Empleado: '+ SQLGetEmpNames.Fields[1].AsString+' '+
                                          SQLGetEmpNames.Fields[0].AsString+' '+#13#10+
                            {'Empleado: '+ SqlGetUserIdPos.Fields[0].AsString+#13#10+}
                            'Posición: '+ SqlBuscaSup.Fields[0].AsString);
             Except
                On E:Exception Do Begin
                   Mns:=Format(ME_116,[dmacts.CurrentActPaid.ActPaidContract,dmacts.CurrentActPaid.ActPaidCode,E.Message]);
                   raise Exception.Create(Mns);
                End;
             End;
          End;
          If FSearchOptions.ActPaidStatus <> asNone Then Begin
             { Refresh grid }
             tblSearch.Delete;
             { Refresh Total Results in Search Window }
             SetTotalResults;
          End;
     End;
end;
procedure TfrmSAQ301001Main.MDSendClick(Sender: TObject);
Begin
     Try
        If  (MessageDlg('Realmente desea enviar el Acta a Aprobacion: ',
                mtCustom,[mbYes,mbNo], 0)) = mrYes  Then begin
           dmActs.ApproveAct := true;
           //GrdActsPaidDblClick(Sender);
           //if Length(dmActs.ValnNo) > 0 then
             ExecSendCommand;
             
           dmActs.ApproveAct := false;
        end;
     Except
        On E:Exception Do Begin
           ShowMessage(Format(ME_075,[E.Message]));
        End;
     End;
End;
procedure TfrmSAQ301001Main.MDApproveClick(Sender: TObject);
begin
     ApproveActsPaid(Self);
end;

procedure TfrmSAQ301001Main.MDPrintClick(Sender: TObject);
begin
     { First, Fill the description of the record selected }
     UpdateCurrentSelection;
     { Second, get information about the corresponding Contract-Portion
       and its categories, saving them in the Detail list}
     With dmActs,CurrentActPaid Do Begin
          GetContractDefinition(ActPaidContract);
          GetPortionDefinition(ActPaidContract,ActPaidPortion);
          GetContractCategories(ActPaidContract,ActPaidPortion);
          SaveCategoriesInMemory;
          GetActCategories(ActPaidContract,ActPaidCode);
          CombineCategories2;
          CompleteLoadOfCrrEleNoDef;
          LoadElementsIn(ActPaidContract,ActPaidPortion);
     End;
     { Now, Print the record }
     PrintActPaid(Self);
end;

procedure TfrmSAQ301001Main.MDExitClick(Sender: TObject);
begin
     Close;
end;

{ Reports Menu : Options avalaibles  }

procedure TfrmSAQ301001Main.MRRep01Click(Sender: TObject);
begin
     { Get a Supplier code because this report include contracts from one
       only supplier }
     Try
        dmActs.CurrentSupplier := frmSAQ301008Suppliers.SelectSupplierCode(EdtSupplierCode.Text);
     Except
        On E:Exception Do Begin
           dmActs.CurrentSupplier := '';
           ShowMessageFmt(ME_008,[E.Message]);
        End;
     End;
     { If there is not error and the user did select a supplier, then
       perform the report }
     If Length(dmActs.CurrentSupplier)>0 Then Begin
        PrintRep01(Self);
     End;
end;

procedure TfrmSAQ301001Main.MRRep02Click(Sender: TObject);
begin                   
     ListContracts(Self,kr02);
end;

procedure TfrmSAQ301001Main.MRRep03Click(Sender: TObject);
begin
     PrintRep03(Self);
end;

procedure TfrmSAQ301001Main.MRRep04Click(Sender: TObject);
begin
     ListContracts(Self,kr04);
end;

{ Help Menu : Options avalaibles  }

procedure TfrmSAQ301001Main.ExecHelpFile(AName:String);
Var
   OldFile:             String;
Begin
     OldFile := Application.HelpFile;
     Try
        Application.HelpFile := AName;
        Application.HelpCommand(HELP_CONTENTS,0);
     Finally
        Application.HelpFile := OldFile;
     End;
End;

procedure TfrmSAQ301001Main.MHAboutClick(Sender: TObject);
begin
     ShowAbout(Self,@FMIMSVersion);
end;

procedure TfrmSAQ301001Main.MHMIMSClick(Sender: TObject);
begin
     ExecHelpFile(dmActs.MIMSHelpFile);
end;

procedure TfrmSAQ301001Main.MHApplicationsClick(Sender: TObject);
begin
     ExecHelpFile(dmActs.MIMSAppHelpFile);
end;

procedure TfrmSAQ301001Main.MHActsPaidClick(Sender: TObject);
begin
     Application.HelpCommand(HELP_CONTENTS,0);
end;

procedure TfrmSAQ301001Main.MDUnApproveClick(Sender: TObject);
Var
   AContract:           String;
   AnActPaid:           String;
   Mns:                 String;
begin
     AContract := '';
     AnActPaid := '';
     Try
        With dmActs Do Begin
             AContract := tblSearchCONTRACT_NO.AsString;
             AnActPaid := tblSearchACT_PAID_NO.AsString;
             SetActPaidStatus(AContract,AnActPaid,StrStatusOf(asPendent),
                              tblSearchSTATUS.AsString );
        End;

        {dbermdez}
        //If not DeleteValn( AContract ) then
        //    Exit;
            
        {De Moya 2003-12-09 Coloco en blanco el campo aprobador y relacionados
        para que no se presenten en el reporte de Actas}
        With dmActs.SQLUpdAppr Do Begin
           Try
              If Not Prepared Then Begin
                 Prepare;
              End;
              ParamByName('AContract').AsString   := AContract;
              ParamByName('AnActPaid').AsString   := AnActPaid;
              ParamByName('AnApprover').AsString  := ' ';
              ParamByName('APosApprover').AsString := ' ';
              ParamByName('AnApproverBy').AsString  := ' ';
              ParamByName('ADate').AsString  := ' ';
              ParamByName('AStatus').AsString     := '1';
              ExecSQL;
           Except
              On E:Exception Do Begin
                 Mns:=Format(ME_116,[dmacts.CurrentActPaid.ActPaidContract,dmacts.CurrentActPaid.ActPaidCode,E.Message]);
                 raise Exception.Create(Mns);
              End;
           End;
        End;

        BtnSearchClick(Sender);
     Except
        On E:Exception Do Begin
           ShowMessageFmt(ME_092,[E.Message,AnActPaid,AContract]);
        End;
     End;
end;

Function SortDetailsByElementKind(Item1, Item2: Pointer): Integer;
Begin
     SortDetailsByElementKind := dmActs.SortByElementKind(Item1, Item2);
End;
procedure TfrmSAQ301001Main.MRAPSummaryClick(Sender: TObject);
Begin
     { First, Fill the description of the record selected }
     UpdateCurrentSelection;
     { Second, get information about the corresponding Contract-Portion
       and its categories, saving them in the Detail list}
     With dmActs,CurrentActPaid Do Begin
          GetContractDefinition(ActPaidContract);
          GetPortionDefinition(ActPaidContract,ActPaidPortion);
          GetContractCategories(ActPaidContract,ActPaidPortion);
          SaveCategoriesInMemory;
          GetActCategories(ActPaidContract,ActPaidCode);
          CombineCategories2;
          LoadElementsIn(ActPaidContract,ActPaidPortion);
          Details.Sort(SortDetailsByElementKind);
     End;
     { Now, Print the record }
     PrintActPaidSummary(Self);
end;
procedure TfrmSAQ301001Main.MTReportsClick(Sender: TObject);
begin
     MRAPSummary.Enabled := HasRecords;
end;

{Procedure TfrmSAQ301001Main.DeleteRefCode(ValnNo : String);
var
   HTTPRIO1 : THTTPRIO;
   Context : RefCodesService.OperationContext;
   RequestModify : RefCodesServiceModifyRequestDTO;
   ReplyModify   : RefCodesServiceModifyReplyDTO;

Begin
   HTTPRIO1 := THTTPRIO.Create(nil);

   Context := RefCodesService.OperationContext.Create;
   Context.position := dmActs.MimsPosition;
   Context.district := dmActs.CurrentDistrict;

   RequestModify := RefCodesServiceModifyRequestDTO.Create;
   RequestModify.entityType := 'EV2';
   RequestModify.entityValue := dmActs.tblSearchCONTRACT_NO.AsString + dmActs.tblSearchVALN_NO.AsString;
   RequestModify.refCode := '';
   RequestModify.refNo := '001';
   RequestModify.seqNum := '001';

   HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecute;
   HTTPRIO1.Port := 'RefCodesServiceHttpPort';
   HTTPRIO1.Service := 'RefCodesService';
   HTTPRIO1.Tag := 0;

   try
     HTTPRIO1.WSDLLocation := dmActs.CurrentHost + '/ews/services/vba/RefCodesService?WSDL';
     ReplyModify := (HTTPRIO1 as RefCodes).modify(Context,RequestModify);
   except
    on E : Exception do begin
      ShowMessage(E.Message);
    end;
   end;
end;}

{procedure TfrmSAQ301001Main.HTTPRIO1BeforeExecute(
  const MethodName: String; var SOAPRequest: WideString);
begin
  SetAuthenticationHeader(SOAPRequest);
end;

Function TfrmSAQ301001Main.SetAuthenticationHeader(var SOAPRequest : WideString):String;
var
  stringToFind : String;
  headerAuthentication : String;
begin
  try

    StringToFind := '<SOAP-ENV:Body>';
    HeaderAuthentication :=
        '<SOAP-ENV:Header>' +
        '        <wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" SOAP-ENV:mustUnderstand="1">' +
        '                <wsse:UsernameToken                                                                                                              ' +
        '                xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"                                   ' +
        '                wsu:Id="UsernameToken-3862294"                                                                                                   ' +
        '                xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">                                  ' +
        '                        <wsse:Username                                                                                                           ' +
        '                        xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">'+MimsUsername+'</wsse:Username>  ' +
        '                        <wsse:Password                                                                                                           ' +
        '                        Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText"                   ' +
        '                        xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">'+MimsPassword+'</wsse:Password>  ' +
        '                </wsse:UsernameToken> ' +
        '        </wsse:Security>              ' +
        '</SOAP-ENV:Header> ' +  stringToFind;

    SOAPRequest := StringReplace(SOAPRequest,
      StringToFind, HeaderAuthentication, [RfReplaceAll] );
  except
    on E : Exception do
      //ShowMessage(E.ClassName + ' error raised, with message : ' + E.Message);
  end;
End;}

{function TfrmSAQ301001Main.DeleteValn(AContract : String): boolean;
var
   HTTPRIO1 : THTTPRIO;
   Context : ValuationsService.OperationContext;
   RequestDelete : ValuationsServiceDeleteRequestDTO;
   ReplyDelete   : ValuationsServiceDeleteReplyDTO;
Begin

   HTTPRIO1 := THTTPRIO.Create(nil);
   Context := ValuationsService.OperationContext.Create;
   Context.position := dmActs.MimsPosition;
   Context.district := dmActs.CurrentDistrict;
   RequestDelete := ValuationsServiceDeleteRequestDTO.Create;
   RequestDelete.contractNo := AContract;
   RequestDelete.valuationNo := dmActs.tblSearchVALN_NO.AsString;

   HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecute;
   HTTPRIO1.Port := 'ValuationsServiceHttpPort';
   HTTPRIO1.Service := 'ValuationsService';
   HTTPRIO1.Tag := 0;

   try
     HTTPRIO1.WSDLLocation := dmActs.CurrentHost + '/ews/services/vba/ValuationsService?WSDL';
     ReplyDelete := (HTTPRIO1 as Valuations).delete(Context,RequestDelete);
     //DeleteRefCode( dmActs.tblSearchVALN_NO.AsString );
     DeleteValn := true;
   except
    on E : Exception do begin
      ShowMessage(E.Message);
      DeleteValn := false;
    end;
   end;
end;}

Procedure InitMultiInstanceSupport;
Const
     SAQ301MutexID = 'SAQ301MutexID';
Var
   MIError:             Integer;
Begin
     MIError := OpenMultiInstanceSupport(SAQ301MutexID);
     If MIError <> 0 Then Begin
        ShowMessageFmt(ME_180,[MIError]);
        Application.Terminate;
     End;
End;

Initialization
   InitMultiInstanceSupport;
Finalization
   CloseMultiInstanceSupport;
end.
