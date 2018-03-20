{
  Author: Marlon Souza
  Componentes: Indy10 (o compoennte indy padrão do delphi7 é a versão 9, favor atualizar!)
  mvcRESTRequest é uma unit que trata a requisição de métodos REST com retorno;
}

unit mvcRESTRequest;

interface

uses
  Classes, IdBaseComponent, IdComponent, IdHeaderList,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdSSLOpenSSL, IdIOHandlerStack, IdSSL, IniFiles, mvcTypes;

type
  TRESTRequest = class
    private
      FHTTP: TIdHTTP;
      FSSL: TIdSSLIOHandlerSocketBase;

      FMethodFDO: TMethodFDO;
      FURL: String;

      FSenha: String;
      FLogin: String;

      function GetHeader: TIdHeaderList;

      procedure LoadHTTP();
    public
      constructor Create( aMethod: TMethodFDO ); Reintroduce;

      {Properties}
      property Header: TIdHeaderList read GetHeader;

      {Send Methods}
      function Post(const aContent: String; const ArgsURL: array of const; out aAnswer: String): Boolean;
      function Get(const ArgsURL: array of const; out aAnswer: String): Boolean;
      function Delete(const aContent: String; const ArgsURL: array of const; out aAnswer: String): Boolean;

      {Result JSON}
      function GetJSON(const ArgsURL: array of const): String;

      {Converter}
      function JSONFloatToStr(aValue: Double; aFormat: String = '#0.00'): String;
      function JSONStrToFloat(aValue: String): Double;
  end;



const
  CRLF = #13#10;

  NomeMethodFDO : Array [TMethodFDO] of String = (
    'Token_GUIDE',
    'CotizacaoResgate_GUIDE',
    'CotizacaoAplicacao_GUIDE');
    
implementation

uses mvcMiscelania, SysUtils, mvcReferenceManipulator;

{ TRESTRequest }

constructor TRESTRequest.Create(aMethod: TMethodFDO);
begin
  inherited Create;

  FMethodFDO := aMethod;
  FHTTP := TIdHTTP.Create;
  Self.LoadHTTP();
end;

function TRESTRequest.Delete(const aContent: String;
  const ArgsURL: array of const; out aAnswer: String): Boolean;
begin
  Result := True;
  try
    aAnswer := FHTTP.Delete( Format(Self.FURL, ArgsURL) );
  except
    on E: EIdHTTPProtocolException do
    begin
      Result := False;
      aAnswer := e.ErrorMessage;
    end;
    on E: Exception do
    begin
      Result := False;
      aAnswer := e.Message;
    end;
  end;
end;

function TRESTRequest.Get(const ArgsURL: array of const; out aAnswer: String): Boolean;
begin
  Result := True;
  try
    aAnswer := FHTTP.Get( Format(Self.FURL, ArgsURL) );
  except
    on E: EIdHTTPProtocolException do
    begin
      Result := False;
      aAnswer := e.ErrorMessage;
    end;
    on E: Exception do
    begin
      Result := False;
      aAnswer := e.Message;
    end;
  end;
end;

function TRESTRequest.GetHeader: TIdHeaderList;
begin
  Result := FHTTP.Request.CustomHeaders;
end;

function TRESTRequest.GetJSON(const ArgsURL: array of const): String;
begin
  case FMethodFDO of
    mFDORest_Token_GUIDE :
      Result := '{ ' + CRLF +
                '  "user_name": "%s", ' + CRLF +
                '  "password": "%s" ' + CRLF +
                '}';

    mFDORest_CotizacaoResgate_GUIDE :
      Result := '{ ' + CRLF +
                '  "quota_value": "%s", ' + CRLF +
                '  "iof_value": "%s", ' + CRLF +
                '  "tax_value": "%s", ' + CRLF +
                '  "net_value": "%s", ' + CRLF +
                '  "gross_value": "%s" ' + CRLF +
                '}';

    mFDORest_CotizacaoAplicacao_GUIDE :
      Result := '{ ' + CRLF +
                '  "quota_value": "%s"' + CRLF +
                '}';
  end;

  if FMethodFDO = mFDORest_Token_GUIDE
    then Result := Format(Result, [FLogin, FSenha])
    else Result := Format(Result, ArgsURL);
    
end;

procedure TRESTRequest.LoadHTTP();
var
  vIniFile: TIniFile;
  vPath: String;
begin

  vPath := ExtractFileDir(ParamStr(0)) + '\' + 'REST.ini';
  if FileExists( vPath ) then
  begin
    vIniFile := TIniFile.Create( vPath );
    try
      FURL := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'URL', '');

      FHTTP.Request.UserAgent               := 'Mozilla/3.0 (compatible; Indy Library)';
      FHTTP.Request.Accept                  := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'Accept', 'application/json');
      FHTTP.Request.ContentType             := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'ContentType', 'application/json');
      FHTTP.Request.Connection              := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'Connection', 'keep-alive');
      FHTTP.Request.BasicAuthentication     := StrToBoolDef(vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'BasicAuthentication', 'False'), False);
      FHTTP.ProxyParams.BasicAuthentication := StrToBoolDef(vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'BasicAuthentication', 'False'), False);
      FHTTP.ProxyParams.ProxyPassword       := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'ProxyPassword', '');
      FHTTP.ProxyParams.ProxyPort           := StrToIntDef(vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'ProxyPort', '0'),0);
      FHTTP.ProxyParams.ProxyServer         := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'ProxyServer', '');
      FHTTP.ProxyParams.ProxyUsername       := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'ProxyUsername', '');

      if StrToBool(vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'SSL', 'False')) then
      begin
        FSSL := TIdSSLIOHandlerSocketBase.Create;
        FHTTP.IOHandler := FSSL;
      end;

      if FMethodFDO = mFDORest_Token_GUIDE then
      begin
        FLogin := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'Login', '');
        FSenha := vIniFile.ReadString( NomeMethodFDO[ FMethodFDO ] , 'Senha', '');
      end;

    finally
      SafeFree(vIniFile);
    end;

  end;

end;

function TRESTRequest.Post(const aContent: String; const ArgsURL: array of const; out aAnswer: String): Boolean;
var
  JSonToSend : TStringStream;
begin
  Result := True;
  try
    JsonToSend := TStringStream.Create( UTF8Encode(aContent) );
    aAnswer := FHTTP.Post( Format(Self.FURL, ArgsURL), JsonToSend );
  except
    on E: EIdHTTPProtocolException do
    begin
      Result := False;
      aAnswer := e.ErrorMessage;
    end;
    on E: Exception do
    begin
      Result := False;
      aAnswer := e.Message;
    end;
  end;
end;

function TRESTRequest.JSONFloatToStr(aValue: Double;
  aFormat: String): String;
begin
  Result := FormatFloat(aFormat, aValue);
  Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
end;

function TRESTRequest.JSONStrToFloat(aValue: String): Double;
var
  Aux: String;
begin
  Aux := StringReplace(aValue, '.', ',', [rfReplaceAll]);
  Result := StrToFloat(Aux);
end;

end.
