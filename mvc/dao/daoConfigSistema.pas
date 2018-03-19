unit daoConfigSistema;

interface

uses
  daoBase, Contnrs, modelConfigSistema, mvcTypes, DBTables,
  enumConfigSistema;

type
  TDAOConfigSistema = class(TDAOBase)
  private
    function GetSQLConfigSistema(): String;
  public
    procedure DoInsert(const aModel: TModelConfigSistema);
    procedure DoUpdate(const aModel: TModelConfigSistema);
    procedure DoDelete(const aModel: TModelConfigSistema);

    function GetConfiguracao(const aEnumConfig: TTpoConfigSistema): TModelConfigSistema;
    function GetTemaSistema(const aSigla: String): Integer;
  end;

implementation

uses SysUtils, mvcMiscelania, Variants;

{ TDAOConfigSistema }

procedure TDAOConfigSistema.DoDelete(const aModel: TModelConfigSistema);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOConfigSistema.DoInsert(const aModel: TModelConfigSistema);
begin
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOConfigSistema.DoUpdate(const aModel: TModelConfigSistema);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOConfigSistema.GetConfiguracao(
  const aEnumConfig: TTpoConfigSistema): TModelConfigSistema;
var
  vListParametros: TArrayFields;
  vQry: TQuery;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'NomConfig';
  vListParametros[0].Valor := TpoConfigSistema[aEnumConfig];

  Result := TModelConfigSistema(Self.OpenQueryToModel(GetSQLConfigSistema, vListParametros, TModelConfigSistema));
end;

function TDAOConfigSistema.GetSQLConfigSistema: String;
begin
  Result :=
    'select * '+
    '  from FDO_ConfigSistema '+
    ' where NomConfig = :NomConfig ';
end;

function TDAOConfigSistema.GetTemaSistema(const aSigla: String): Integer;
var
  vListParametros: TArrayFields;

  function GetSQLTemaSistema: String;
  begin
    Result :=
      'select count(*) as qtde '+
      '  from Tema_Sistema '+
      ' where SiglaSistema = :SiglaSistema'+
      '   and StaAtivo = ''S'' ';
  end;

begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'SiglaSistema';
  vListParametros[0].Valor := aSigla;

  Result := StrToInt(VarToStrDef(Self.OpenQueryReturnField(GetSQLTemaSistema, vListParametros, 'qtde'),'0'));
end;

end.


