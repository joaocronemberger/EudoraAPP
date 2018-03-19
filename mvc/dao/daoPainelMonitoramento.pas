unit daoPainelMonitoramento;

interface

uses
  daoBase, Contnrs, mvcTypes, DBTables, SqlExpr;

type
  TDAOPainelMonitoramento = class(TDAOBase)
  private
    function GetSQLPainelMonitoramento(): String;
  public
    function GetPainelMonitoramento(const aDtaPainel: TDateTime): TSQLQuery;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOPainelMonitoramento }

function TDAOPainelMonitoramento.GetPainelMonitoramento(const aDtaPainel: TDateTime): TSQLQuery;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'pDtaPainel';
  vListParametros[0].Valor := FormatDateTime('yyyy-mm-dd',aDtaPainel);

  Result := Self.OpenQuery(GetSQLPainelMonitoramento, vListParametros);
end;

function TDAOPainelMonitoramento.GetSQLPainelMonitoramento: String;
begin
  Result := 'EXEC SPT_FDO_API_PainelMonitoramento :pDtaPainel';
end;

end.


