unit SAQ300007;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Registry, Rio, SOAPHTTPClient,
  AuthenticatorService,
  SecurityService,
  TableService,
  ComCtrls, ExtCtrls, OleCtrls, SHDocVw,
  xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TfrmSAQ00007ProfileConnection = class(TForm)
    gbxMimsLogin: TGroupBox;
    edtMimsUser: TEdit;
    edtMimsPassword: TEdit;
    lblMimsUser: TLabel;
    lblMimsPassword: TLabel;
    lblMimsDistrict: TLabel;
    lblMimsPosition: TLabel;
    lblHostname: TLabel;
    edtHostName: TEdit;
    StatusBar1: TStatusBar;
    HTTPRIO1: THTTPRIO;
    HTTPRIO2: THTTPRIO;
    Label1: TLabel;
    cbProfileName: TComboBox;
    btnSave: TBitBtn;
    btnClear: TBitBtn;
    btnDelete: TBitBtn;
    BitBtn1: TBitBtn;
    btnClose: TBitBtn;
    HTTPRIO3: THTTPRIO;
    cbMimsDistricts: TComboBox;
    cbMimsPositions: TComboBox;
    procedure SaveProfileToRegistry;
    procedure GetProfileValue;
    procedure GetProfileValues;
    procedure btnSaveClick(Sender: TObject);
    procedure cbProfileNameChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure HTTPRIO1BeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    Function SetAuthenticationHeader(var SOAPRequest : WideString):String;
    procedure HTTPRIO2BeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    procedure cbMimsDistrictsEnter(Sender: TObject);
    procedure cbMimsPositionsEnter(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    LevelAccess :String;{ Public declarations }
    FOracleUserPassword :String;
    xdoc : IXMLDocument;
    ApplicationPath : String;
  end;

var
  frmSAQ00007ProfileConnection: TfrmSAQ00007ProfileConnection;

implementation

//Uses amq68b00;

{$R *.DFM}

procedure TfrmSAQ00007ProfileConnection.GetProfileValues;
var
  OrderChilds: IXMLNode;
  i : integer;
begin
  cbProfileName.Items.Clear;
  for i := 0 to xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes.Count - 1 do
  begin
    OrderChilds := xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes[i];
    cbProfileName.Items.Add( OrderChilds.Attributes['NAME']);
  end;
end;

procedure TfrmSAQ00007ProfileConnection.GetProfileValue;
var
 i,j : integer;
 OrderChilds: IXMLNode;
begin

  for i := 0 to xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes.Count - 1 do
  begin
    OrderChilds := xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes[i];
    if OrderChilds.Attributes['NAME'] = cbProfileName.Text then begin

      try
        edtHostName.Text := OrderChilds.ChildNodes['HOST'].NodeValue ;
      except
        on e: Exception do edtHostName.Text := '';
      end;

      try
        edtMimsPassword.Text := OrderChilds.ChildNodes['PASSWORD'].NodeValue;
      except
        on e: Exception do edtMimsPassword.Text := '';
      end;

      try
        edtMimsUser.Text := OrderChilds.ChildNodes['USERNAME'].NodeValue ;
      except
        on e: Exception do edtMimsUser.Text := '';
      end;

      try
        cbMimsDistricts.Text := OrderChilds.ChildNodes['DISTRICT'].NodeValue ;
      except
        on e: Exception do cbMimsDistricts.Text := '';
      end;

      try
        cbMimsPositions.Text := OrderChilds.ChildNodes['POSITION'].NodeValue ;
      except
        on e: Exception do cbMimsPositions.Text := '';
      end;

    end;
  end;
end;

procedure TfrmSAQ00007ProfileConnection.SaveProfileToRegistry;
var
 i,j : integer;
 OrderChilds: IXMLNode;
 NewChild: IXMLNode;
begin

  for i := 0 to xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes.Count - 1 do
  begin
    OrderChilds := xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes[i];
    if OrderChilds.Attributes['NAME'] = cbProfileName.Text then begin
       xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes.Delete(i);
       xdoc.SaveToFile(ApplicationPath + 'profiles.xml');
       break;       
    end;
  end;

  NewChild := xdoc.ChildNodes.Nodes['PROFILES'].AddChild('PROFILE');
  NewChild.SetAttributeNS('NAME','',cbProfileName.Text);
  NewChild.AddChild('HOST').Text := edtHostName.Text;
  NewChild.AddChild('PASSWORD').Text := ' ';
  NewChild.AddChild('USERNAME').Text := edtMimsUser.Text;
  NewChild.AddChild('DISTRICT').Text := cbMimsDistricts.Text;
  NewChild.AddChild('POSITION').Text := cbMimsPositions.Text;

  xdoc.SaveToFile(ApplicationPath + 'profiles.xml');
  GetProfileValues;
end;

procedure TfrmSAQ00007ProfileConnection.btnSaveClick(Sender: TObject);
begin
  SaveProfileToRegistry;
end;

procedure TfrmSAQ00007ProfileConnection.cbProfileNameChange(Sender: TObject);
begin
  GetProfileValue;
end;

procedure TfrmSAQ00007ProfileConnection.btnClearClick(Sender: TObject);
begin
  cbProfileName.Text   := '';
  edtHostName.Text     := '';
  edtMimsUser.Text     := '';
  edtMimsPassword.Text := '';
  cbMimsDistricts.Items.Clear;
  cbMimsPositions.Items.Clear;
end;

procedure TfrmSAQ00007ProfileConnection.btnDeleteClick(Sender: TObject);
var
 i,j : integer;
 OrderChilds: IXMLNode;
begin

  for i := 0 to xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes.Count - 1 do
  begin
    OrderChilds := xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes[i];
    if OrderChilds.Attributes['NAME'] = cbProfileName.Text then begin
      xdoc.ChildNodes.Nodes['PROFILES'].ChildNodes.Delete(i);
    end;
  end;

  xdoc.SaveToFile(ApplicationPath + 'profiles.xml');
  GetProfileValues;

  cbProfileName.Text   := '';
  edtHostName.Text     := '';
  edtMimsUser.Text     := '';
  edtMimsPassword.Text := '';
  cbMimsDistricts.Items.Clear;
  cbMimsPositions.Items.Clear;
end;

procedure TfrmSAQ00007ProfileConnection.FormCreate(Sender: TObject);
var
  myFile : TextFile;
begin
  try
    ApplicationPath  := ExtractFilePath(Application.ExeName);
    xdoc := LoadXMLDocument(ApplicationPath + 'profiles.xml');
  except
    On e: Exception do begin
      AssignFile(myFile, ApplicationPath + 'profiles.xml');
      ReWrite(myFile);

      WriteLn(myFile, '<?xml version="1.0" encoding="UTF-8"?>');
      WriteLn(myFile, '<PROFILES>');
      WriteLn(myFile, '</PROFILES>');
                                                         
      CloseFile(myFile);

      xdoc := LoadXMLDocument(ApplicationPath + 'profiles.xml');
    end;
  end;

  GetProfileValues;
  StatusBar1.Panels[0].Text := '';
end;

procedure TfrmSAQ00007ProfileConnection.BitBtn1Click(Sender: TObject);
var
  Context : AuthenticatorService.OperationContext;
  GeneralPtr : Pointer;
  position : string;
  district : string;
  index : integer;
begin
  StatusBar1.Panels[0].Text := '';
  Context := AuthenticatorService.OperationContext.Create;

  position := cbMimsPositions.Text;
  index := AnsiPos('-',position);
  if (index > 0) then
    position := Copy(position,1, index - 1);
  Context.position := trim(position);

  district := cbMimsDistricts.Text;
  index := AnsiPos('-',district);
  if (index > 0) then
    district := Copy(district,1, index - 1);
  Context.district := trim(district);

  if (Length(edtMimsUser.Text) = 0) then begin
    StatusBar1.Panels[0].Text := 'USER PROFILE NOT FOUND';
    Exit;
  end;

  if (Length(cbMimsDistricts.Text) = 0) then begin
    StatusBar1.Panels[0].Text := 'FAVOR LLENE TODOS CAMPOS';
    Exit;
  end;

  if (Length(cbMimsPositions.Text) = 0) then begin
    StatusBar1.Panels[0].Text := 'FAVOR LLENE TODOS CAMPOS';
    Exit;
  end;

  if (Length(district) > 4) then begin
    district := Copy(district,1,4);
    Context.district := district;
    cbMimsDistricts.Text := district;
  end;

  try
    HTTPRIO1.WSDLLocation := edtHostName.Text +
      '/ews/services/vba/AuthenticatorService?WSDL&op=authenticate';

    (HTTPRIO1 as Authenticator).authenticate(Context);

    Self.Close;
  except
    On E1: Exception do begin
      try
        StatusBar1.Panels[0].Text := E1.Message;
      except
        On E: EAccessViolation do begin

        end;
      end;
    end;
  end;
end;

procedure TfrmSAQ00007ProfileConnection.HTTPRIO1BeforeExecute(
  const MethodName: String; var SOAPRequest: WideString);
begin
  SetAuthenticationHeader(SOAPRequest);
end;

procedure TfrmSAQ00007ProfileConnection.HTTPRIO2BeforeExecute(
  const MethodName: String; var SOAPRequest: WideString);
begin
  SetAuthenticationHeader(SOAPRequest);
end;

Function TfrmSAQ00007ProfileConnection.SetAuthenticationHeader(var SOAPRequest : WideString):String;
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
        '                        xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">'+edtMimsUser.Text+'</wsse:Username>  ' +
        '                        <wsse:Password                                                                                                           ' +
        '                        Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText"                   ' +
        '                        xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">'+edtMimsPassword.Text+'</wsse:Password>  ' +
        '                </wsse:UsernameToken> ' +
        '        </wsse:Security>              ' +
        '</SOAP-ENV:Header> ' +  stringToFind;

    SOAPRequest := StringReplace(SOAPRequest,
      StringToFind, HeaderAuthentication, [RfReplaceAll] );
  except
    on E : Exception do
      //ShowMessage(E.ClassName + ' error raised, with message : ' + E.Message);
  end;
End;

procedure TfrmSAQ00007ProfileConnection.cbMimsDistrictsEnter(
  Sender: TObject);
var
  Context : AuthenticatorService.OperationContext;
  arrayOfDistricts : ArrayOfNameValuePair;
  i : integer;
begin
  StatusBar1.Panels[0].Text := '';
  Context := AuthenticatorService.OperationContext.Create;
  Context.position := '';
  Context.district := '';

  try
    if (Length( edtHostName.Text ) > 0) then begin
      if (cbMimsDistricts.Items.Count <= 1) then begin
        HTTPRIO1.WSDLLocation := edtHostName.Text +
          '/ews/services/vba/AuthenticatorService?WSDL&op=authenticate';
        arrayOfDistricts := (HTTPRIO1 as Authenticator).getDistricts(Context);
        cbMimsDistricts.Items.Clear;
        for i := 0 to Length(arrayOfDistricts) do begin
          cbMimsDistricts.Items.Add(arrayOfDistricts[i].name + ' - ' + arrayOfDistricts[i].value);
        end;
      end;
    end else begin
      StatusBar1.Panels[0].Text := 'Por favor ingrese el campo HostName ID';
    end;
  except
    On E: Exception do begin
      //StatusBar1.Panels[0].Text := 'Imposible conectar con el servidor';
    end;
  end;
end;

procedure TfrmSAQ00007ProfileConnection.cbMimsPositionsEnter(
  Sender: TObject);
var
  Context : AuthenticatorService.OperationContext;
  arrayOfPositions : ArrayOfNameValuePair;
  i : integer;
begin
  StatusBar1.Panels[0].Text := '';
  Context := AuthenticatorService.OperationContext.Create;
  Context.position := '';
  Context.district := '';

  try
    if (Length( edtHostName.Text ) > 0) then begin
        HTTPRIO1.WSDLLocation := edtHostName.Text +
          '/ews/services/vba/AuthenticatorService?WSDL&op=authenticate';
        arrayOfPositions := (HTTPRIO1 as Authenticator).getPositions(Context);
        cbMimsPositions.Items.Clear;
        for i := 0 to Length(arrayOfPositions) do begin
          if (copy(arrayOfPositions[i].name,1,1) = 'A') then begin
            cbMimsPositions.Items.Add(arrayOfPositions[i].name + ' - ' + arrayOfPositions[i].value);
          end;
        end;
    end else begin
      StatusBar1.Panels[0].Text := 'Por favor ingrese el campo HostName ID';
    end;
  except
    On E: Exception do begin
      //StatusBar1.Panels[0].Text := E.Message;
    end;
  end;
end;

procedure TfrmSAQ00007ProfileConnection.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
