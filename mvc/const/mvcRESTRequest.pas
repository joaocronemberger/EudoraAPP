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

      function GetHeader: TIdHeaderList;

      procedure LoadHTTP();
    public
      constructor Create( aMethod: TMethodFDO ); Reintroduce;

      property Header: TIdHeaderList read GetHeader;

      function Post(const aContent: String; out aAnswer: String): Boolean;
      function Get(out aAnswer: String): Boolean;
      function Delete(const aContent: String; out aAnswer: String): Boolean;

      function GetJSON( const Args: array of const ): String;
  end;

const
  CRLF = #13#10;

  NomeMethodFDO : Array [TMethodFDO] of String = (
    'Token_GUIDE',
    'CotizacaoResgate_GUIDE',
    'CotizacaoAplicacao_GUIDE');
    
implementation                                                          

uses mvcMiscelania, SysUtils;

{ TRESTRequest }

constructor TRESTRequest.Create(aMethod: TMethodFDO);
begin
  inherited Create;

  FMethodFDO := aMethod;
  FHTTP := TIdHTTP.Create;
  Self.LoadHTTP();
end;

function TRESTRequest.Delete(const aContent: String;
  out aAnswer: String): Boolean;
begin
  Result := True;
  try
    aAnswer := FHTTP.Delete( Self.FURL );
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

function TRESTRequest.Get(out aAnswer: String): Boolean;
begin
  Result := True;
  try
    aAnswer := FHTTP.Get( Self.FURL );
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

function TRESTRequest.GetJSON( const Args: array of const ): String;
begin
  case FMethodFDO of
    mFDORest_Token_GUIDE :
      Result := '{ ' + CRLF +
                '  "user_name": "%s", ' + CRLF +
                '  "password": "%s" ' + CRLF +
                '}';

    mFDORest_CotizacaoResgate_GUIDE :
      Result := '{ ' + CRLF +
                '  "quota_value": "%d", ' + CRLF +
                '  "iof_value": "%d", ' + CRLF +
                '  "tax_value": "%d", ' + CRLF +
                '  "net_value": "%d" ' + CRLF +
                '}';

    mFDORest_CotizacaoAplicacao_GUIDE :
      Result := '{ ' + CRLF +
                '  "quota_value": "%d"' + CRLF +
                '}';
  end;

  Result := Format(Result, Args);
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

  end;

end;

function TRESTRequest.Post(const aContent: String; out aAnswer: String): Boolean;
var
  JSonToSend : TStringStream;
begin
  Result := True;
  try
    JsonToSend := TStringStream.Create( UTF8Encode(aContent) );
    aAnswer := FHTTP.Post( Self.FURL, JsonToSend );
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

end.
