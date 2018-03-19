unit modelConfigSistema;

interface

uses
  modelBase, mvcTypes;

type
  TModelConfigSistema = class(TModelBase)
  private
    FNomConfig: String;
    FValConfig: String;

  published
      property NomConfig: String read FNomConfig write FNomConfig;
      property ValConfig: String read FValConfig write FValConfig;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelConfigSistema }

function TModelConfigSistema.GetIdentity: String;
begin
  Result := '';
end;

function TModelConfigSistema.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NomConfig';

end;

function TModelConfigSistema.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,2);
  Result[0] := 'NomConfig';
  Result[1] := 'ValConfig';

end;

function TModelConfigSistema.GetTableName: String;
begin
  Result := 'FDO_ConfigSistema';
end;

end.


