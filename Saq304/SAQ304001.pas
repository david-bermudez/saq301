unit SAQ304001;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Menus, Db, DBTables, Buttons;

type
  TFRMSAQ304001ACT = class(TForm)
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    OpenFile: TMenuItem;
    SaveFile: TMenuItem;
    Salir1: TMenuItem;
    Opcion1: TMenuItem;
    CreateFile: TMenuItem;
    SaveAct: TMenuItem;
    Salir2: TMenuItem;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtContract: TEdit;
    EdtPortion: TEdit;
    EdtElement: TEdit;
    Panel5: TPanel;
    BtnGenerar: TButton;
    BtnCargar: TButton;
    Panel2: TPanel;
    BtnExit: TSpeedButton;
    BtnSave: TSpeedButton;
    btnopen: TSpeedButton;
    RichEdit1: TRichEdit;
    SaveDialog1: TSaveDialog;
    StbStatus: TStatusBar;
    Open: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure appmessage(var msg: tmsg; var handled: boolean);
    procedure BtnGenerarClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure btnopenClick(Sender: TObject);
    procedure BtnCargarClick(Sender: TObject);
  private
    { Private declarations }
    function FindCon      : string;
    function BuscaDesEle  : string;
    function BuscarEle    : string;
    function BuscarPor    : string;
    function check        : string;
    function checkheader  : string;
    function checkitems   : string;
    //procedure GenerarArchivo;
    procedure Header;
    procedure items;
    procedure CleanCam;
    procedure CopyItems;
    procedure formato;

  public
    { Public declarations }
     procedure filesaveasclick(sender : string);
     procedure InsertHeader;
     procedure InsertItems;
     function checkcontract : string;
  end;

var
  FRMSAQ304001ACT: TFRMSAQ304001ACT;
  Contract      : string;
  Portion       : string;
  Element       : string;
  DesContract   : string;
  DesPortion    : string;
  DesElement    : string;
  Category      : string;
  categ_base_un : string;
  desc_cat      : string;
  element_code  : string;
  paidact       : string;
  employee      : string;
  currency      : string;
  value         : double;
  pvalue        : double;
  categ_base_rt : double;
  quantity      : double;
  rate_value    : double;
  VectorItem    : array [0..4] of string;
  VectorHeader  : array [0..5] of string;
  {Incluyo archivo para el trace}
  f_out : textfile;
  sline : string;


implementation

uses MCDMActs;

{$R *.DFM}

procedure TFRMSAQ304001ACT.FormCreate(Sender: TObject);
//procedimiento crear formulario
begin
     {JDF}
     assignfile(f_out,'debugsql.txt');
     rewrite(f_out);
     application.Onmessage:=appmessage;
     CleanCam;
end;

procedure TFRMSAQ304001ACT.BtnGenerarClick(Sender: TObject);
//procedimiento principal
var
   valcheck,bc,cc,bp,be,bde : string;
begin
     //Validación campos en blanco
     valcheck := check;
     if valcheck = 'ok' then
     begin
          //Validación de contrato existente
          Contract := trim(EdtContract.text);
          bc := FindCon;
          if bc = 'ok' then
          begin
               //Validación que el usuario tenga acceso al contrato
               cc := checkcontract;
               if cc = 'ok' then
               begin
                    //Validación de Porción existente
                    bp := BuscarPor;
                    if bp = 'ok' then
                    begin
                         //Validación de Elemento existente
                         be := BuscarEle;
                         if be = 'ok' then
                         begin
                              //Buscar Descripción del Elemento
                              bde := BuscaDesEle;
                              if bde = 'ok' then
                              begin
                                   //Copiar header
                                   richedit1.Clear;
                                   header;
                                   richedit1.Lines.Add(VectorHeader[0]+VectorHeader[1]+VectorHeader[2]+VectorHeader[3]+VectorHeader[4]+VectorHeader[5]+chr(13));
                                   items;
                                   messagedlg('El Archivo se ha generado satisfactoriamente, ahora es momento de guardarlo',mtinformation,[mbok],0);
                                   btnsave.Enabled := true;
                                   savefile.Enabled := true;
                                   createfile.Enabled := false;
                                   btngenerar.enabled := false;
                                   savedialog1.FileName := '';
                              end;
                         end;
                    end;
               end
               else
               begin
                    messagedlg('El Usuario no tiene acceso sobre ese contrato',mtinformation,[mbok],0);
                    cleancam;
               end;
          end;
     end;
end;

procedure TFRMSAQ304001ACT.CleanCam;
//procedimiento limpiar campos
begin
     EdtContract.text := '';
     EdtPortion.text  := '';
     EdtElement.Text := '';
     richedit1.Clear ;
End;

procedure TFRMSAQ304001ACT.appmessage(var msg: Tmsg; var handled: boolean);
//procedimiento enter
var actual : twincontrol;
begin
     if msg.message=wm_keydown then
        if msg.wparam=vk_return then
        begin
             actual:=screen.activecontrol;
             if (actual is tedit) or (actual is TButton) then
                msg.wparam:=vk_tab;
        end;
end;

function TFRMSAQ304001ACT.check;
//Función para validar campos en blanco
begin
     check := 'no';
     If trim(EdtContract.text) = '' then
     begin
          messagedlg('No ha digitado el número del Contrato',mtinformation,[mbok],0);
          EdtContract.SetFocus;
     end
     else
     begin
          if trim(EdtPortion.Text) = '' then
          begin
               messagedlg('No ha digitado la Porción',mtinformation,[mbok],0);
               EdtPortion.SetFocus;
          end
          else
          begin
               if trim(EdtElement.Text) = '' then
               begin
                    messagedlg('No ha digitado el Elemento',mtinformation,[mbok],0);
                    EdtElement.SetFocus;
               end
               else
               begin
                    check := 'ok'
               end;
          end;
     end;
end;

function TFRMSAQ304001ACT.FindCon;
//Función para buscar contrato
var lencon,i : integer;
    digite,caracter : string;
begin
     FindCon := 'no';
     contract:=trim(contract);
     //Colocar contrato en  formato válido
     lencon := length(contract);
     //showmessage('FindCon:contract=' + contract + ' lencon=' + IntToStr(lencon));
     if lencon < 8 then
     begin
          caracter := 'no';
          for i := 0 to lencon - 1 do
          begin
               digite:=copy(Contract,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
                  caracter := 'ok';
          end;
          for i := lencon to 7 do
          begin
               if caracter <> 'ok' then
                  contract := '0' + contract;
          end;
          //showmessage('FindCon:contract=' + contract + ' caracter=' + caracter);
     end;
     dmActs.sqlbuscon.sql.clear;
     dmActs.sqlbuscon.sql.add('select contract_no,contract_desc from MSF384 where contract_no = :a');
     dmActs.sqlbuscon.params[0].asstring := Contract;
     dmActs.sqlbuscon.execsql;
     dmActs.dsbuscon.dataset := dmActs.sqlbuscon;
     dmActs.dsbuscon.dataset.open;
     //showmessage('FindCon:fields_0=' + dmActs.sqlbuscon.fields[0].asstring);

     if dmActs.sqlbuscon.fields[0].asstring <>'' then
     begin
          DesContract := dmActs.sqlbuscon.fields[1].asstring;
          FindCon := 'ok';
     end
     else
     begin
          messagedlg('El número del contrato no existe',mtinformation,[mbok],0);
          EdtContract.SetFocus;
     end;
end;

function TFRMSAQ304001ACT.BuscarPor;
//Función para buscar Porción
var lenpor,i : integer;
    digite,caracter : string;
begin
     BuscarPor := 'no';
     Portion := trim(EdtPortion.text);
     //Colocar Porcion en  formato válido
     lenpor := length(Portion);
     if lenpor < 2 then
     begin
          caracter := 'no';
          for i := 0 to lenpor - 1 do
          begin
               digite:=copy(Portion,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
                  caracter := 'ok';
          end;
          for i := lenpor to 1 do
          begin
               if caracter <> 'ok' then
                  portion := '0' + portion;
          end;
     end;
     dmActs.sqlbuspor.sql.clear;
     dmActs.sqlbuspor.sql.add('select contract_no,portion_no,portion_desc from MSF385 where contract_no = :a and portion_no = :b');
     dmActs.sqlbuspor.params[0].asstring := Contract;
     dmActs.sqlbuspor.params[1].asstring := Portion;
     dmActs.sqlbuspor.ExecSql;
     dmActs.dsbuspor.dataset := dmActs.sqlbuspor;
     dmActs.dsbuspor.dataset.open;
     if (dmActs.sqlbuspor.fields[0].asstring = Contract) and (dmActs.sqlbuspor.fields[1].asstring = Portion) then
     begin
          DesPortion := dmActs.sqlbuspor.fields[2].asstring;
          BuscarPor := 'ok';
     end
     else
     begin
          messagedlg('No existe esa Porción para el Contrato especificado',mtinformation,[mbok],0);
          EdtPortion.SetFocus;
     end;
end;

function TFRMSAQ304001ACT.BuscarEle;
//Función para buscar Element
var lenele,i : integer;
    digite,caracter : string;
begin
     BuscarEle := 'no';
     Element := trim(EdtElement.text);
     //Colocar elemento en  formato válido
     lenele := length(element);
     if lenele < 2 then
     begin
          caracter := 'no';
          for i := 0 to lenele - 1 do
          begin
               digite:=copy(Element,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
                  caracter := 'ok';
          end;
          for i := lenele to 1 do
          begin
               if caracter <> 'ok' then
                  Element := '0' + Element;
          end;
     end;
     dmActs.sqlbusele.sql.clear;
     dmActs.sqlbusele.sql.add('select contract_no,portion_no,element_no,element_code from MSF386 where (contract_no = :a) and (portion_no = :b) and (element_no = :c)');
     dmActs.sqlbusele.params[0].asstring := Contract;
     dmActs.sqlbusele.params[1].asstring := Portion;
     dmActs.sqlbusele.params[2].asstring := Element;
     dmActs.sqlbusele.ExecSql;
     dmActs.dsbusele.dataset := dmActs.sqlbusele;
     dmActs.dsbusele.dataset.open;
     if (dmActs.sqlbusele.fields[0].asstring = Contract) and (dmActs.sqlbusele.fields[1].asstring = Portion) and (dmActs.sqlbusele.fields[2].asstring = Element) then
     begin
          BuscarEle := 'ok';
          element_code := dmActs.sqlbusele.fields[3].asstring;
     end
     else
     begin
          messagedlg('No existe ese Elemento para la Porción especificada',mtinformation,[mbok],0);
          EdtElement.SetFocus;
     end;
end;

Function TFRMSAQ304001ACT.BuscaDesEle;
//Procedimiento para buscar descripción de Element
begin
     BuscaDesEle := 'no';
     dmActs.sqldesele.sql.clear;
     dmActs.sqldesele.sql.add('select table_desc from MSF010 where (table_type= :a) and (table_code = :b)');
     dmActs.sqldesele.params[0].asstring := 'EN';
     dmActs.sqldesele.params[1].asstring := element_code;
     dmActs.sqldesele.ExecSql;
     dmActs.dsdesele.dataset := dmActs.sqldesele;
     dmActs.dsdesele.dataset.open;
     if trim(dmActs.sqldesele.fields[0].asstring) <> '' then
     begin
          DesElement :=  trim(dmActs.sqldesele.fields[0].asstring);
          BuscaDesEle := 'ok';
     end
     else
     begin
          messagedlg('No existe la descripción de ese Elemento',mtinformation,[mbok],0);
          EdtElement.SetFocus;
     end;
end;

Procedure TFRMSAQ304001ACT.Header;
//Procedimiento par copiar el encabezado del archivo plano
var
   caracter,digite : string;
   lencontract,lenportion,lenelement,i : integer;
   lendescontract,lendesportion,lendeselement : integer;
begin

     //Buscar longitud de los campos
     lencontract:=   length(Contract);     lenportion:=     length(Portion);
     lenelement:=    length(Element);      lendescontract:= length(descontract);
     lendesportion:= length(DesPortion);   lendeselement:=  length(deselement);

     //Asignar los campos a un vector
     VectorHeader[0] := Contract;      VectorHeader[1] := Portion;
     VectorHeader[2] := Element;      VectorHeader[3] := DesContract;
     VectorHeader[4] := DesPortion;    VectorHeader[5] := DesElement;

     //Insertar contrato
     if lencontract < 8 then
     begin
          caracter := 'no';
          //Determinar si contrato es numérico o caracter
          for i := 0 to lencontract - 1 do
          begin
               digite:=copy(Contract,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
               begin
                    caracter := 'ok';
               end;
          end;
          for i := lencontract to 7 do
          begin
               if caracter = 'ok' then
               begin
                    VectorHeader[0] := VectorHeader[0] + ' ';
               end
               else
               begin
                    VectorHeader[0] := '0' + VectorHeader[0];
               end;
          end;
     end;

     //Insertar Portion
     if lenportion < 2 then
     begin
          caracter := 'no';
          //Obtener si Portion es numérico o caracter
          for i := 0 to lenportion - 1 do
          begin
               digite:=copy(Portion,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
               begin
                    caracter := 'ok';
               end;
          end;
          for i := lenportion to 1 do
          begin
               if caracter = 'ok' then
               begin
                    VectorHeader[1] := VectorHeader[1] + ' ';
               end
               else
               begin
                    VectorHeader[1] := '0' + VectorHeader[1];
               end;
          end;
     end;

     //Insertar Elemento
     if lenelement < 2 then
     begin
          caracter := 'no';
          //Obtener si Elemento es numérico o caracter
          for i := 0 to lenelement - 1 do
          begin
               digite:=copy(Element,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
               begin
                    caracter := 'ok';
               end;
          end;
          for i := lenelement to 1 do
          begin
               if caracter = 'ok' then
               //El Element en caracter
               begin
                    VectorHeader[2] := VectorHeader[2] + ' ';
               end
               else
               //El Elemento es numérico
               begin
                    VectorHeader[2] := '0' + VectorHeader[2];
               end;
          end;
     end;

     //Insertar descripcion de contrato
     if lendescontract < 40 then
     begin
          for i := lendescontract to 39 do
          begin
               VectorHeader[3] := VectorHeader[3] + ' ';
          end;
     end;

     //Insertar descripcion de la porción
     if lendesportion < 40 then
     begin
          for i := lendesportion to 39 do
          begin
               VectorHeader[4] := VectorHeader[4] + ' ';
          end;
     end;

     //Insertar descripcion de Elemento
     if lendeselement < 20 then
     begin
          for i := lendeselement to 19 do
          begin
               VectorHeader[5] := VectorHeader[5] + ' ';
          end;
     end;
end;

Procedure TFRMSAQ304001ACT.Items;
//Procedimiento insertar items
var descategory,caracter,digite : string;
    lencon,i : integer;
begin
     //Buscar Categoría
     dmActs.sqlbuscat.sql.clear;
     dmActs.sqlbuscat.sql.add('select category_no,categ_base_rt,categ_base_un,categ_base_val from MSF387 where (contract_no = :a) and (portion_no = :b) and (element_no = :c)');
     dmActs.sqlbuscat.params[0].asstring := contract;
     dmActs.sqlbuscat.params[1].asstring := Portion;
     dmActs.sqlbuscat.params[2].asstring := Element;
     dmActs.sqlbuscat.ExecSql;
     dmActs.dsbuscat.dataset := dmActs.sqlbuscat;
     dmActs.dsbuscat.dataset.open;
     dmActs.sqlbuscat.first;
     if  dmActs.sqlbuscat.fields[0].asstring <> '' then
     begin
          //Copiar Categorias en el Archivo
          while not dmActs.sqlbuscat.eof do
          begin
               Category := dmActs.sqlbuscat.fields[0].asstring;
               categ_base_rt := dmActs.sqlbuscat.fields[1].asfloat;
               categ_base_un := dmActs.sqlbuscat.fields[2].asstring;
               Value := dmActs.sqlbuscat.fields[3].asfloat;

               //Verificar formato del contrato
               lencon:=length(contract);
               if lencon < 8 then
               begin
                    caracter := 'no';
                    //Determinar si contrato es numérico o caracter
                    for i := 0 to lencon - 1 do
                    begin
                         digite:=copy(Contract,i,1);
                         if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
                         begin
                              caracter := 'ok';
                         end;
                    end;
                    for i := lencon to 7 do
                    begin
                         if caracter = 'ok' then
                         begin
                              contract := contract + ' ';
                         end
                         else
                         begin
                              contract := '0' + contract;
                         end;
                    end;
               end;

               //Buscar descripción de categoría
               descategory := contract + Portion + Element + Category;
               dmActs.sqldescat.sql.clear;
               dmActs.sqldescat.sql.add('select table_desc from MSF010 where table_type = :a and table_code = :b');
               dmActs.sqldescat.params[0].asstring := '+CE';
               dmActs.sqldescat.params[1].asstring := descategory;
               dmActs.sqldescat.ExecSql;
               dmActs.dsdescat.dataset := dmActs.sqldescat;
               dmActs.dsdescat.dataset.open;
               if dmActs.sqldescat.fields[0].asstring = '' then
               begin
                  //  messagedlg('No existe descripción de categoría',mtinformation,[mbok],0);
               end
               else
               begin
                    desc_cat:= dmActs.sqldescat.fields[0].asstring;
                    CopyItems;
                    richedit1.Lines.Add(VectorItem[0]+VectorItem[1]+VectorItem[2]+VectorItem[3]+VectorItem[4]+chr(13));
               end;
               dmActs.sqlbuscat.next;
          end;
     end
     else
     begin
          messagedlg('No existe ninguna Categoria para ese Contrato',mtinformation,[mbok],0);
     end;
end;

procedure TFRMSAQ304001ACT.CopyItems;
//Procedimiento para copiar las categorias en el archivo plano
var
  caracter,cbrt,nok,digite  : string;
  LenCategory,LenDesCategory,LenCBrt,i : integer;
  lenCBun,lenValue       : integer;
  puntodecimal           : integer;
begin
     //Buscar longitud de los campos
     lencategory:= length(Category);
     lencbun:= length(categ_base_un);
     lendescategory:= length(desc_cat);

     //Asignar los campos a un vector
     VectorItem[0] := Category;
     VectorItem[1] := desc_cat;
     VectorItem[2] := floattostr(categ_base_rt);
     VectorItem[3] := categ_base_un;
     VectorItem[4] := floattostr(Value);

     //Insertar Category
     if lencategory < 2 then
     begin
          caracter := 'no';
          //Determinar si Category es numérico o caracter
          for i := 0 to lencategory - 1 do
          begin
               digite:=copy(Category,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
               begin
                    caracter := 'ok';
               end;
          end;
          for i := lencategory to 1 do
          begin
               if caracter = 'ok' then
               begin
                    VectorItem[0] := VectorItem[0] + ' ';
               end
               else
               begin
                    VectorItem[0] := '0' + VectorItem[0];
               end;
          end;
     end;

     //Insertar desc-cat
     if lendescategory < 40 then
     begin
          for i := lendescategory to 39 do
          begin
               VectorItem[1] := VectorItem[1] + ' ';
          end;
     end;

     //Insertar categ-base-rt
     nok := '';
     CBrt := floattostr(categ_base_rt);
     lencbrt := length(Cbrt);
     {JDF - Los valores terminados en .00 o .n0 les suprime el cero o
      ceros finales}
     sline:='Valor del campo 2=' + Cbrt;
     writeln(f_out,sline);
     puntodecimal:=pos('.',CBrt);
     if puntodecimal = 0 then
     begin
       puntodecimal:=pos(',',CBrt);
     end;
     if lencbrt - puntodecimal = 1 then
     begin
       CBrt := CBrt + '0';
     end;
     if puntodecimal = 0 then
     begin
       CBrt := CBrt + '.00';
     end;
     lencbrt := length(cbrt);
     sline:='Valor del campo 2 corregido=' + Cbrt;
     writeln(f_out,sline);
     {JDF}

     for i := 1 to lenCBrt do
     begin
          digite:=copy(CBrt,i,1);
          if (digite <> '.') and (digite <> ',')  then
          begin
               nok := nok + digite
          end;
     end;
     nok:= trim(nok);
     vectorItem[2]:= nok;
     lenCBrt := length(nok);

     if lenCBrt < 11 then
     begin
          for i := lenCBrt to 10 do
          begin
               VectorItem[2] := '0' + VectorItem[2];
          end;
     end;

     //Insertar categ-base-un
     if lenCBun < 4 then
     begin
          caracter := 'no';
          //Determinar si categ-base-un es numérico o caracter
          for i := 0 to lenCBun - 1 do
          begin
               digite:=copy(categ_base_un,i,1);
               if (digite <> '0') and (digite <> '1') and (digite <> '2') and (digite <> '3') and (digite <> '4') and (digite <> '5') and (digite <> '6') and (digite <> '7') and (digite <> '8') and (digite <> '9') then
               begin
                    caracter := 'ok';
               end;
          end;
          for i := lenCBun to 3 do
          begin
               if caracter = 'ok' then
               //la categ-base-un es caracter
               begin
                    VectorItem[3] := VectorItem[3] + ' ';
               end
               else
               //la categ-base-un es numérico
               begin
                    VectorItem[3] := '0' + VectorItem[3];
               end;
          end;
     end;

     //Insertar Value
     nok := '';
     CBrt := floattostr(Value);
     lenvalue := length(cbrt);
     {JDF - Los valores terminados en .00 o .n0 les suprime el cero o
      ceros finales}
     puntodecimal:=pos('.',CBrt);
     if puntodecimal = 0 then
     begin
       puntodecimal:=pos(',',CBrt);
     end;
     if lenvalue - puntodecimal = 1 then
     begin
       CBrt := CBrt + '0';
     end;
     if puntodecimal = 0 then
     begin
       CBrt := CBrt + '.00';
     end;
     lenvalue := length(cbrt);
     {JDF}

     for i := 1 to lenValue  do
     begin
          digite:=copy(CBrt,i,1);
          if (digite <> '.') and (digite <> ',')  then
          begin
               nok := nok + digite
          end;
     end;
     nok:= trim(nok);
     vectorItem[4]:= nok;
     lenValue := length(nok);
     if lenValue < 11 then
     begin
          for i := lenValue to 14 do
          begin
               VectorItem[4] := '0' + VectorItem[4];
          end;
     end;
     {JDF - Coloca en cero el campo VectorItem[4]}
     VectorItem[4]:='000000000000000';
end;

procedure TFRMSAQ304001ACT.BtnSaveClick(Sender: TObject);
var
   name:  string;
begin
     if  (savedialog1.FileName='') then
     begin
          filesaveasclick(name);
          if (savedialog1.FileName<>'') then
          begin
               messagedlg('El acta fué guardada',mtinformation,[mbok],0);
               savefile.enabled := false;
               btnsave.enabled := false;
               createfile.enabled := true;
               btngenerar.enabled := true;
               savedialog1.filename:='';
               CLEANCAM;
               btnsave.Enabled := false;
               savefile.Enabled := false;
               btngenerar.Enabled := true;
               createfile.enabled:= true;
          end
          else
              messagedlg('El acta no fué guardada',mtinformation,[mbok],0);
     end;
end;

procedure TFRMSAQ304001ACT.filesaveasclick(sender :string);
// salvar el archivo de texto del richedit1//
begin
     savedialog1.filter:=element;
     savedialog1.InitialDir :='c:\';
     savedialog1.title:='Salvar Acta de Pago Como...';
     savedialog1.filename:='CONTRATO'+'.'+element;
     if SaveDialog1.execute then
     begin
          savedialog1.filename:= 'CONTRATO'+'.'+element;
          richedit1.Lines.SaveToFile(savedialog1.filename);
          richedit1.Modified:=false;
     end
     else
     begin
          savedialog1.filename:='';
     end;
end;

procedure TFRMSAQ304001ACT.BtnExitClick(Sender: TObject);
begin
     {JDF}
     closefile(f_out);
     close;
end;

procedure TFRMSAQ304001ACT.btnopenClick(Sender: TObject);
begin
     open.filter:='v01';
     open.InitialDir :='c:\';
     open.title:='Abrir Acta de Pago...';
     open.filename:='ACTA'+'.'+'v01';
     if open.Execute then
     begin
          formato;
     end;
end;

procedure TFRMSAQ304001ACT.formato;
//procedimiento para dar formato al archivo//
var
  bloque  : textfile;
  texto: string;
begin
  //Pregunto si se ha abierto un archivo
  richedit1.Clear ;
  if open.FileName<>'' then begin
    AssignFile(bloque,FRMSAQ304001ACT.Open.FileName);
    FileMode:=2;
    reset(bloque);
    readln(bloque,texto);
    contract := copy(texto,1,8);
    If findcon = 'ok' then
    begin
         if checkcontract='ok' then
         begin
              richedit1.Lines.Add(texto);
              while not eof(bloque) do
              begin
                   readln(bloque,texto);
                   richedit1.lines.add(texto);
              end;
              btnopen.Enabled := false;
              openfile.Enabled := false;
              saveact.Enabled := true;
              btncargar.enabled := true
         end
         else
         begin
              messagedlg('El Usuario no esta autorizado para cargar esta Acta',mtinformation,[mbok],0);
              btnopen.Enabled := true;
              openfile.Enabled := true;
              saveact.Enabled := false;
              btncargar.enabled := false;
              cleancam;
         end;
    end
    else
    begin
         messagedlg('El contrato no existe',mtinformation,[mbok],0);
         btnopen.Enabled := true;
         openfile.Enabled := true;
         saveact.Enabled := false;
         btncargar.enabled := false;
         cleancam;
    end;
    closefile(bloque);
    end;
end;

procedure TFRMSAQ304001ACT.BtnCargarClick(Sender: TObject);
var
  bloque  : textfile;
  texto,p2value : string;
begin
     //header
     btncargar.Enabled :=false;
     AssignFile(bloque,FRMSAQ304001ACT.Open.FileName);
     FileMode:=2;
     reset(bloque);
     readln(bloque,texto);
     contract := copy(texto,1,8);
     portion := copy(texto,9,2);
     PaidAct := copy(texto,11,10);
     if checkheader = 'ok' then
     begin
          dmActs.dbActPaid.StartTransaction;
          InsertHeader;
          //items
          While not eof(bloque) do
          Begin
               readln(bloque,texto);
               element := copy(texto,1,2);
               category := copy(texto,3,2);
               categ_base_un := copy(texto,5,4);
               p2value := copy(texto,9,16);
               pvalue := strtofloat(p2value);
               writeln(f_out,'Valores leidos para subir' + element + ' ' + category + ' ' +
                             categ_base_un + ' ' + p2value);
               If checkitems= 'ok' then
               Begin
                    InsertItems;
               End;
          End;
          dmActs.dbActPaid.commit;
          messagedlg('El Archivo ha terminado de cargar satisfactoriamente',mtinformation,[mbok],0);
          closefile(bloque);
          btnopen.Enabled := true;
          openfile.Enabled := true;
          saveact.Enabled := false;
          btncargar.enabled := false;
          cleancam;
     end;
end;

Procedure TFRMSAQ304001ACT.insertheader;
begin
     try
        dmActs.sqlInsert.sql.clear;
        dmActs.sqlInsert.sql.add('Insert Into SAF3A0');
        {JDF - En la siguiente línea se debe suprimir el parámetro r cuando
         no se tiene el campo approve_date}
        {dmActs.sqlInsert.sql.add('values (:a,:b,:c,:d,:e,:f,:g,:h,:i,:j,:k,:l,:m,:n,:o,:p,:q,:r)');}
        dmActs.sqlInsert.sql.add('values (:a,:b,:c,:d,:e,:f,:g,:h,:i,:j,:k,:l,:m,:n,:o,:p,:q,:r,:s,:t,:u,:v,:w,:x,:y)');
        dmActs.sqlInsert.params[0].asstring := trim(Contract);
        dmActs.sqlInsert.params[1].asstring := trim(Paidact);
        dmActs.sqlInsert.params[2].asstring := trim(Portion);
        dmActs.sqlInsert.params[3].asstring := dmActs.dat;
        dmActs.sqlInsert.params[4].asstring := trim(employee);
        dmActs.sqlInsert.params[5].asstring := ' ';
        dmActs.sqlInsert.params[6].asstring := ' ';
        dmActs.sqlInsert.params[7].asstring := '1';
        dmActs.sqlInsert.params[8].asfloat := 0;
        dmActs.sqlInsert.params[9].asfloat := 0;
        dmActs.sqlInsert.params[10].asstring := '2';
        dmActs.sqlInsert.params[11].asstring := '1';
        dmActs.sqlInsert.params[12].asstring := '1';
        dmActs.sqlInsert.params[13].asstring := '0';
        dmActs.sqlInsert.params[14].asstring := currency;
        dmActs.sqlInsert.params[15].asfloat := 1;
        dmActs.sqlInsert.params[16].asstring := '00000000';
        {Insertados por Rene Tovar}
        dmActs.sqlInsert.params[17].asstring := '00000000';
        dmActs.sqlInsert.params[18].asstring := ' ';
        dmActs.sqlInsert.params[19].asstring := ' ';
        dmActs.sqlInsert.params[20].asstring := dmActs.dat;
        dmActs.sqlInsert.params[21].asstring := dmActs.dat;
        dmActs.sqlInsert.params[22].asstring := ' ';
        dmActs.sqlInsert.params[23].asstring := ' ';
        dmActs.sqlInsert.params[24].asstring := ' ';
        {JDF}
        sline:=dmActs.sqlInsert.params[0].asstring;
        writeln(f_out,'Contrato:'+sline+'&');
        sline:=dmActs.sqlInsert.params[1].asstring;
        writeln(f_out,'Acta:'+sline+'&');
        sline:=dmActs.sqlInsert.params[2].asstring;
        writeln(f_out,'Porción:'+sline+'&');
        sline:=dmActs.sqlInsert.params[3].asstring;
        writeln(f_out,'Fecha:'+sline+'&');
        sline:=dmActs.sqlInsert.params[4].asstring;
        writeln(f_out,'Creado por:'+sline+'&');
        sline:=dmActs.sqlInsert.params[5].asstring;
        writeln(f_out,'Actualizado por:'+sline+'&');
        sline:=dmActs.sqlInsert.params[6].asstring;
        writeln(f_out,'Aprobado por:'+sline+'&');
        sline:=dmActs.sqlInsert.params[7].asstring;
        writeln(f_out,'Status:'+sline+'&');
        sline:=dmActs.sqlInsert.params[8].asstring;
        writeln(f_out,'Valor:'+sline+'&');
        sline:=dmActs.sqlInsert.params[9].asstring;
        writeln(f_out,'Valor1:'+sline+'&');
        sline:=dmActs.sqlInsert.params[10].asstring;
        writeln(f_out,'Tipo Comentario:'+sline+'&');
        sline:=dmActs.sqlInsert.params[11].asstring;
        writeln(f_out,'Tipo contrato:'+sline+'&');
        sline:=dmActs.sqlInsert.params[12].asstring;
        writeln(f_out,'Ap Info Atax:'+sline+'&');
        sline:=dmActs.sqlInsert.params[13].asstring;
        writeln(f_out,'Tipo Distribución:'+sline+'&');
        sline:=dmActs.sqlInsert.params[14].asstring;
        writeln(f_out,'Moneda:'+sline+'&');
        sline:=dmActs.sqlInsert.params[15].asstring;
        writeln(f_out,'Tasa de cambio:'+sline+'&');
        sline:=dmActs.sqlInsert.params[16].asstring;
        writeln(f_out,'Fecha tasa de cambio:'+sline+'&');
     //En caso de quitar el campo approved_date debe quitar la siguiente linea
     // dmActs.sqlInsert.params[17].asstring := '00000000';
        dmActs.sqlinsert.ExecSql;
     Except
           on E: Exception do
           begin
                raise Exception.CreateFmt('Ha ocurrido un error al insertar en la tabla, el acta no ha sido cargada. Error Técnico : %s',[E.Message]);
                messagedlg('Ha ocurrido un error al insertar en la tabla, el acta no ha sido cargada',mterror,[mbok],0);
                If dmActs.dbActPaid.InTransaction Then
                Begin
                     dmActs.dbActPaid.Rollback;
                 End;
                 btnopen.Enabled := true;
                 openfile.Enabled := true;
                 saveact.Enabled := false;
                 btncargar.enabled := false;
                 cleancam;
           end;
     End;
End;

procedure TFRMSAQ304001ACT.insertitems;
begin
     Try
        dmActs.sqlInsert.sql.clear;
        dmActs.sqlInsert.sql.add('Insert Into SAF3A1');
        dmActs.sqlInsert.sql.add('values (:a,:b,:c,:d,:e,:f,:g,:h,:i,:j)');
        dmActs.sqlInsert.params[0].asstring := trim(Contract);
        dmActs.sqlInsert.params[1].asstring := trim(Paidact);
        dmActs.sqlInsert.params[2].asstring := trim(element);
        dmActs.sqlInsert.params[3].asstring := trim(category);
        dmActs.sqlInsert.params[4].asfloat := rate_value;
        dmActs.sqlInsert.params[5].asfloat := quantity;
        dmActs.sqlInsert.params[6].asfloat := value;
        dmActs.sqlInsert.params[7].asstring := 'N';
        dmActs.sqlInsert.params[8].asstring := 'N';
        dmActs.sqlInsert.params[9].asstring := 'N';

        dmActs.sqlInsert.execsql;
     Except
           On E: Exception do
           Begin
               raise Exception.CreateFmt('Ha ocurrido un error al insertar en la tabla, el acta no ha sido cargada. Error Técnico : %s',[E.Message]);
               messagedlg('Ha ocurrido un error al insertar en la tabla, el acta no ha sido cargada',mterror,[mbok],0);
               btnopen.Enabled := true;
               openfile.Enabled := true;
               saveact.Enabled := false;
               btncargar.enabled := false;
               cleancam;
               If dmActs.dbActPaid.InTransaction Then
               Begin
                    dmActs.dbActPaid.Rollback;
               End;
               btnopen.Enabled := true;
               openfile.Enabled := true;
               saveact.Enabled := false;
               btncargar.enabled := false;
               cleancam;
           End;
     End; 
End;

Function TFRMSAQ304001ACT.checkheader;
begin
     //validación de contrato  y porcion
     checkheader:='ok';
     contract := trim(contract);
     dmActs.sqlbuspor.sql.clear;
     dmActs.sqlbuspor.sql.add('select contract_no,portion_no from MSF385 where contract_no = :a and portion_no = :b');
     dmActs.sqlbuspor.params[0].asstring := Contract;
     dmActs.sqlbuspor.params[1].asstring := Portion;
     dmActs.sqlbuspor.ExecSql;
     dmActs.dsbuspor.dataset := dmActs.sqlbuspor;
     dmActs.dsbuspor.dataset.open;
     if dmActs.sqlbuspor.fields[0].asstring = '' then
     begin
          messagedlg('Archivo invalido, Número del contrato o Porcion no existe',mtinformation,[mbok],0);
          checkheader:='no';
          btnopen.Enabled := true;
          openfile.Enabled := true;
          saveact.Enabled := false;
          btncargar.enabled := false;
          cleancam;
     end
     else
     begin
          Paidact:= trim(paidact);
          dmActs.sqlactpaid.sql.clear;
          dmActs.sqlactpaid.sql.add('select act_paid_no from SAF3A0 where (contract_no = :a) and (act_paid_no= :b)');
          dmActs.sqlactpaid.params[0].asstring := Contract;
          dmActs.sqlactpaid.params[1].asstring := Paidact;
          dmActs.sqlactpaid.ExecSql;
          dmActs.dsactpaid.dataset := dmActs.sqlactpaid;
          dmActs.dsactpaid.dataset.open;
          if trim(dmActs.sqlactpaid.fields[0].asstring)<> '' then
          begin
               messagedlg('Archivo invalido, Acta de pago ya existe',mtinformation,[mbok],0);
               checkheader:='no';
               btnopen.Enabled := true;
               openfile.Enabled := true;
               saveact.Enabled := false;
               btncargar.enabled := false;
               cleancam;
          end
          else
          begin
               dmActs.sqlfindcon.sql.clear;
               {JDF - Me aseguro que el UserId esté en mayúsculas}               
               dmActs.UserId:=uppercase(dmActs.UserId);
               dmActs.sqlfindcon.sql.add('select employee_id from MSF020 where entity = :a');
               {JDF - Adiciono distrito y entry type para armar la llave de la msf020}
               dmActs.sqlfindcon.sql.add('and dstrct_code = :b');
               dmActs.sqlfindcon.sql.add('and entry_type  = :c');
               dmActs.sqlfindcon.params[0].asstring := dmacts.UserId;
               dmActs.sqlfindcon.params[1].asstring := 'ICOR';
               dmActs.sqlfindcon.params[2].asstring := 'S';
               {JDF}
               sline:='El sql para buscar el empleado es: '+dmActs.sqlfindcon.Text;
               writeln(f_out,sline);
               sline:='User_Id:'+dmActs.UserId;
               writeln(f_out,sline);
               dmActs.sqlfindcon.ExecSql;
               dmActs.dsfindcon.dataset := dmActs.sqlfindcon;
               dmActs.dsfindcon.dataset.open;
               {JDF}
               sline:='empleado encontrado es &'+dmActs.sqlfindcon.fields[0].asstring+'&';
               writeln(f_out,sline);
               if dmActs.sqlfindcon.fields[0].asstring <> '' then
               begin
                    sline:='Check Header - Entró a asignar el empleado';
                    writeln(f_out,sline);
                    employee :=dmActs.sqlfindcon.fields[0].asstring;
                    dmActs.sqlbuspor.sql.clear;
                    dmActs.sqlbuspor.sql.add('select currency_type from MSF384 where contract_no = :a');
                    dmActs.sqlbuspor.params[0].asstring := contract;
                    {JDF}
                    sline:=dmActs.sqlfindcon.text;
                    writeln(f_out,sline);
                    dmActs.sqlbuspor.ExecSql;
                    dmActs.dsbuspor.dataset := dmActs.sqlbuspor;
                    dmActs.dsbuspor.dataset.open;
                    {JDF}
                    sline:='moneda encontrada es &'+dmActs.sqlbuspor.fields[0].asstring+'&';
                    writeln(f_out,sline);
                    if dmActs.sqlbuspor.fields[0].asstring <> '' then
                    begin
                         currency:=dmActs.sqlbuspor.fields[0].asstring;
                    end;
               end;
          end;
     end;
end;

function TFRMSAQ304001ACT.checkitems;
begin
     checkitems:='ok';
     dmActs.sqlbusele.sql.clear;
     {JDF - Coloco la búsqueda con la llave de la msf387}
     dmActs.sqlbusele.sql.add('select categ_base_un,categ_base_rt from MSF387');
     dmActs.sqlbusele.sql.add('where (contract_no = :a) and (portion_no = :b)');
     dmActs.sqlbusele.sql.add('and (element_no = :c) and (category_no = :d)');
     sline:='El sql sobre la msf387:'+dmActs.sqlbusele.text;
     writeln(f_out,sline);
     sline:='Contrato:'+Contract;
     writeln(f_out,sline);
     sline:='Porción:'+Portion;
     writeln(f_out,sline);
     sline:='Elemento:'+Element;
     writeln(f_out,sline);
     sline:='Categoría:'+Category;
     writeln(f_out,sline);

     dmActs.sqlbusele.params[0].asstring := Contract;
     dmActs.sqlbusele.params[1].asstring := Portion;
     dmActs.sqlbusele.params[2].asstring := Element;
     dmActs.sqlbusele.params[3].asstring := category;
     dmActs.sqlbusele.ExecSql;
     dmActs.dsbusele.dataset := dmActs.sqlbusele;
     dmActs.dsbusele.dataset.open;
     if dmActs.sqlbusele.fields[0].asstring = '' then
     begin
          messagedlg('Archivo invalido, el elemento o la categoria no existen para ese contrato',mtinformation,[mbok],0);
          checkitems := 'no';
          btnopen.Enabled := true;
          openfile.Enabled := true;
          saveact.Enabled := false;
          btncargar.enabled := false;
          cleancam;
     end
     else
     begin
         categ_base_un:=dmActs.sqlbusele.fields[0].asstring;
         categ_base_rt:=dmActs.sqlbusele.fields[1].asfloat;
         sline:='Resultado del sql de la msf387 exitoso';
         writeln(f_out,sline);
         sline:='Categ base un:'+categ_base_un;
         writeln(f_out,sline);
         sline:='Categ base un:'+floattostr(categ_base_rt);
         writeln(f_out,sline);
         {if categ_base_un = ' ' then}
         {JDF - Aseguro que no haya nada en categ_base_un}
         if length(trim(categ_base_un)) = 0 then
         begin
              sline:='la categ base en blanco';
              writeln(f_out,sline);
              rate_value:=0 ;
              quantity:=0;
              value:= pvalue / 100 ;
         end
         else
         begin
             sline:='la categ base en blanco';
             writeln(f_out,sline);
             rate_value := categ_base_rt;
             quantity := pvalue / 100;
             value := rate_value * quantity;
         end;
     end;
end;

function TFRMSAQ304001ACT.checkcontract;
//Validar si el usuario tiene acceso a ese contrato
var
   respons1,respons2,respons3,respons4,employ1,employ2,employ3,employ4 : string;
begin
     checkcontract:='no';
     dmActs.sqlfindcon.sql.clear;
     {JDF - Me aseguro que el UserId esté en mayúsculas}
     dmActs.UserId:=uppercase(dmActs.UserId);
     dmActs.sqlfindcon.sql.add('select employee_id from MSF020 where entity = :a');
     {JDF - Adiciono distrito y entry type para armar la llave de la msf020}
     dmActs.sqlfindcon.sql.add('and dstrct_code = :b');
     dmActs.sqlfindcon.sql.add('and entry_type  = :c');
     dmActs.sqlfindcon.params[0].asstring := dmacts.UserId;
     dmActs.sqlfindcon.params[1].asstring := 'ICOR';
     dmActs.sqlfindcon.params[2].asstring := 'S';
     sline:='Chuequeo de contrato - Sql para buscar empleado:'+dmActs.sqlfindcon.Text;
     writeln(f_out,sline);
     sline:='UserId:'+dmActs.UserId;
     writeln(f_out,sline);
     dmActs.sqlfindcon.ExecSql;
     dmActs.dsfindcon.dataset := dmActs.sqlfindcon;
     dmActs.dsfindcon.dataset.open;
     if dmActs.sqlfindcon.fields[0].asstring <> '' then
     begin
          sline:='Entró a asignar el empleado';
          writeln(f_out,sline);
          employee :=dmActs.sqlfindcon.fields[0].asstring;
     end;
     dmacts.SqlCheck.SQL.clear;
     dmacts.SqlCheck.SQL.add('Select RESPONS_CODE_1,RESPONS_CODE_2,RESPONS_CODE_3,RESPONS_CODE_4,EMPLOY_TYPE_1,EMPLOY_TYPE_2,EMPLOY_TYPE_3,EMPLOY_TYPE_4 From MSF384');
     dmacts.SqlCheck.SQL.add('Where (contract_no= :a) and ((RESPONS_CODE_1=:b) Or (RESPONS_CODE_2=:c) or (RESPONS_CODE_3=:d) Or (RESPONS_CODE_4=:e))');
     dmacts.SqlCheck.params[0].asstring:=contract;
     dmacts.SqlCheck.params[1].asstring:=employee;
     dmacts.SqlCheck.params[2].asstring:=employee;
     dmacts.SqlCheck.params[3].asstring:=employee;
     dmacts.SqlCheck.params[4].asstring:=employee;
     dmacts.SqlCheck.ExecSQL ;
     dmActs.dscheck.dataset := dmActs.sqlcheck;
     dmActs.dscheck.dataset.open;
     if dmActs.sqlcheck.fields[0].asstring <> '' then
     begin
          RESPONS1:= dmActs.sqlcheck.fields[0].asstring;
          RESPONS2:= dmActs.sqlcheck.fields[1].asstring;
          RESPONS3:= dmActs.sqlcheck.fields[2].asstring;
          RESPONS4:= dmActs.sqlcheck.fields[3].asstring;
          EMPLOY1:= dmActs.sqlcheck.fields[4].asstring;
          EMPLOY2:= dmActs.sqlcheck.fields[5].asstring;
          EMPLOY3:= dmActs.sqlcheck.fields[6].asstring;
          EMPLOY4:= dmActs.sqlcheck.fields[7].asstring;
          If (respons1=employee) and ((employ1='AG')or (employ1='AA')) then
          begin
               checkcontract:='ok';
          end
          else
          begin
               If (respons2=employee) and ((employ2='AG') or (employ2='AA')) then
               begin
                    checkcontract:='ok';
               end
               else
               begin
                    If (respons3=employee) and ((employ3='AG') or (employ3='AA')) then
                    begin
                         checkcontract:='ok';
                    end
                    else
                    begin
                         If (respons4=employee) and ((employ4='AG') or (employ4='AA')) then
                         begin
                              checkcontract:='ok';
                         end;
                    end;
               end;
          end;
     end;
     //JDF - LINEA TEMPORAL PARA PERMITIR ESCRITURA DE ACTAS
     //checkcontract:='ok';
end;

end.
