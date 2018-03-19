unit mvcExportadorLog;

interface

uses
  Classes, Contnrs, IniFiles, mvcMiscelania;

type
  TTipoExtensao = (tteTXT, tteINI);
  TExportador = class
  private
    FList: TStringList;
    FExtensao: TTipoExtensao;

    function IniPath(): String;
    function ThisFileExist(const aFileName: String): Boolean;
    procedure Save(const aFileName: String; const aLoad: Boolean);

    procedure CopyListToList(var aStrOrigem, aStrDestino: TStringList);

    constructor Create(const aFileName: String); reintroduce;
    destructor Destroy(); override;
  public

    { Save Methods }
    class procedure SaveFile(const aMsg: TStringList; const aFileName: String); overload;
    class procedure SaveFile(const aMsg: String; const aFileName: String); overload;

    { Delete Methods }
    class procedure DropFile(const aFileName: String);

    { Clear Methods }
    class procedure ClearFile(const aFileName: String);

    { Others Methods }
    class function GetFullPath(const aFileName: String): String;

  end;

implementation

uses SysUtils, mvcReferenceManipulator, TEUTemaObject;

{ TExportador }

class procedure TExportador.ClearFile(const aFileName: String);
begin
  with TExportador.Create(aFileName) do
  try
    FList.Clear;
    if ThisFileExist(aFileName)
      then Save(aFileName, False);
  finally
    Free;
  end;
end;

procedure TExportador.CopyListToList(var aStrOrigem,
  aStrDestino: TStringList);
var
  i: Integer;
begin
  for i := 0 to pred(aStrOrigem.Count) do
    aStrDestino.Add( aStrOrigem[i] );
end;

constructor TExportador.Create(const aFileName: String);
var
  vExt: String;
begin
  inherited Create();
  FList := TStringList.Create;


  {Sugestão de melhoria [Marlon Souza - 18/10/2017] :
    Caso necessário adicionar mais uma extensão, ao invés de colocar vários ifs, alterar o path.ini
    para que nele as chaves tenha o mesmo nome da extensão sem o "." a fim de tornar isso mais dinâmico.
    Ex:

    Antes:
    [SaveToFile]
    Path=C:\Users\marlon_souza\Desktop\Logs
    Ini=C:\Users\marlon_souza\Desktop\Inis

    Depois:
    [SaveToFile]
    txt=C:\Users\marlon_souza\Desktop\Logs
    ini=C:\Users\marlon_souza\Desktop\Inis
    doc=C:\Users\marlon_souza\Desktop\Doc
    docx=C:\Users\marlon_souza\Desktop\Doc
    cvs=C:\Users\marlon_souza\Desktop\Excel
    xls=C:\Users\marlon_souza\Desktop\Excel
    xlsx=C:\Users\marlon_souza\Desktop\Excel
    log=C:\Users\marlon_souza\Desktop\Logs

   Fim da sugestão [Marlon Souza - 18/10/2017] }
   
  vExt := ExtractFileExt(aFileName);
  if vExt = '.ini' then
    FExtensao := tteINI
  else
    FExtensao := tteTXT;
end;

destructor TExportador.Destroy;
begin
  SafeFree(FList);
  inherited Destroy();
end;

class procedure TExportador.DropFile(const aFileName: String);
begin
  with TExportador.Create(aFileName) do
  try
    if ThisFileExist(aFileName)
      then DeleteFile(IniPath() + aFileName);
  finally
    Free;
  end;
end;

function TExportador.IniPath: String;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\' + 'path.ini');
  try
    case FExtensao of
      tteTXT : Result := TMisc.PathComBarra(ArquivoIni.ReadString('SaveToFile', 'Path', ''));
      tteINI : Result := TMisc.PathComBarra(ArquivoIni.ReadString('SaveToFile', 'Ini', ''));
    end;

    if not(DirectoryExists(Result))
      then Result := TMisc.PathComBarra(ExtractFileDir(ParamStr(0)));

  finally
    SafeFree(ArquivoIni);
  end;
end;

procedure TExportador.Save(const aFileName: String; const aLoad: Boolean);
var
  vFile: String;
  vListToSave: TStringList;
begin

  vListToSave := TStringList.Create;
  try
    vFile := IniPath() + aFileName;

    if FileExists(vFile) and aLoad
      then vListToSave.LoadFromFile(vFile);

    Self.CopyListToList(FList, vListToSave);
    vListToSave.SaveToFile(vFile);

  finally
    SafeFree(vListToSave);
  end;
end;

class procedure TExportador.SaveFile(const aMsg, aFileName: String);
begin
  with TExportador.Create(aFileName) do
  try
    FList.Add(aMsg);
    Save(aFileName, True);
  finally
    Free;
  end;
end;

class procedure TExportador.SaveFile(const aMsg: TStringList;
  const aFileName: String);
begin
  with TExportador.Create(aFileName) do
  try
    FList.Text := aMsg.Text;
    Save(aFileName, True);
  finally
    Free;
  end;
end;

function TExportador.ThisFileExist(const aFileName: String): Boolean;
begin
  Result := FileExists(Self.IniPath + aFileName);
end;

class function TExportador.GetFullPath(const aFileName: String): String;
begin
  with TExportador.Create(aFileName) do
  try
    Result := IniPath() + aFileName;
  finally
    Free;
  end;
end;

initialization

end.
