{
  Author: Marlon Souza
  Componentes: ClassBuilder que lê uma estrutura Json via Builder:
  Ex. Utilização:

  var
    vJsonStr: String;
  begin
    vJsonStr :=
      TJson
        .Init(memoPost.Text) // Inicia o json no método Init passando o JsonString
        .Tag('errors')       // Separa o conteudo da tag passada...
        .Tag('detail',1)     // Separa o conteudo da tag passada, porém no index 1 em um grupo de repetição...
        .Value;              // Retorna o valor como String
  end;
}

unit mvcJsonStructure;

interface

uses
  Classes, IniFiles, Math;

type
  IJsonValue = interface
    procedure _SetJsonStr(const aValue: String);
    function Value: String;
    function Tag(const aTag: String; const aIndex: Integer = 0): IJsonValue;
  end;

  IJson = interface
    procedure _SetJsonStr(const aValue: String);
    function TagExists(const aTag: String): Boolean;
    function Tag(const aTag: String): IJsonValue;
  end;

  TJsonValue = Class(TInterfacedObject, IJsonValue)
  private
    FJsonValueString: String;
    procedure _SetJsonStr(const aValue: String);
    class function Init(const aJsonValueStr: String): IJsonValue;
    function Value: String;
    function Tag(const aTag: String; const aIndex: Integer = 0): IJsonValue;
  end;

  TJson = Class(TInterfacedObject, IJson)
  private
    FJsonString: String;
    procedure _SetJsonStr(const aValue: String);
    function TagExists(const aTag: String): Boolean;
    function Tag(const aTag: String): IJsonValue;
  public
    class function Init(const aJsonStr: String): IJson;
  end;


implementation

uses SysUtils;


{ TJsonValue }

class function TJsonValue.Init(const aJsonValueStr: String): IJsonValue;
begin
  Result := TJsonValue.Create;
  Result._SetJsonStr(aJsonValueStr);
end;

function TJsonValue.Tag(const aTag: String; const aIndex: Integer = 0): IJsonValue;
var
  vPos, vPosSub: String;
  i: integer;
begin
  Result := Self;

  for i := 0 to aIndex do
  begin
    if Pos('"'+aTag+'"', Self.FJsonValueString) = 0
      then Self.FJsonValueString := ''
      else Self.FJsonValueString := Trim(Copy(Self.FJsonValueString, Pos('"'+aTag+'"', Self.FJsonValueString) + Length('"'+aTag+'"') +1, Length(Self.FJsonValueString)));
  end;
    
  vPosSub := ',';
  vPos := ',';
  if ((Pos('[',Self.FJsonValueString) < Pos(vPos,Self.FJsonValueString)) or (Pos(vPos,Self.FJsonValueString) = 0)) and (Pos('[',Self.FJsonValueString) > 0) then
  begin
    vPos := '[';
    vPosSub := ']';
  end;

  if ((Pos('{',Self.FJsonValueString) < Pos(vPos,Self.FJsonValueString)) or (Pos(vPos,Self.FJsonValueString) = 0)) and (Pos('{',Self.FJsonValueString) > 0) then
  begin
    vPos := '{';
    vPosSub := '}';
  end;

  if Pos(vPos,Self.FJsonValueString) > 0
    then Self.FJsonValueString := Copy(Self.FJsonValueString, 0, Pos(vPosSub,Self.FJsonValueString) - IfThen(vPosSub = ',',1,0));
end;

function TJsonValue.Value: String;
begin
  Result := Trim(StringReplace(Self.FJsonValueString,'"','',[rfReplaceAll]));
end;

procedure TJsonValue._SetJsonStr(const aValue: String);
begin
  Self.FJsonValueString := aValue;
end;

{ TJson }

class function TJson.Init(const aJsonStr: String): IJson;
begin
  Result := TJson.Create;
  Result._SetJsonStr(aJsonStr);
end;

function TJson.Tag(const aTag: String): IJsonValue;
begin
  Result := TJsonValue.Init(FJsonString).Tag(aTag);
end;

function TJson.TagExists(const aTag: String): Boolean;
begin
  Result := (Pos('"'+aTag+'"', Self.FJsonString) > 0);
end;

procedure TJson._SetJsonStr(const aValue: String);
begin
  Self.FJsonString := aValue;
end;

end.
