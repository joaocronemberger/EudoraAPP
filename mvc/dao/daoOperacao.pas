unit daoOperacao;

interface

uses
  daoBase, Contnrs, modelOperacao, mvcTypes, DBTables;

type
  TDAOOperacao = class(TDAOBase)
  private
    function SQLSelectOperacoesInNumOperacao(): String;
  public
    procedure DoInsert(const aModel: TModelOperacao);
    procedure DoUpdate(const aModel: TModelOperacao);
    procedure DoDelete(const aModel: TModelOperacao);

    function GetOperacoesPorNumOperacoes(const aListNumOperacoes: String): TObjectList;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOOperacao }

procedure TDAOOperacao.DoDelete(const aModel: TModelOperacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOOperacao.DoInsert(const aModel: TModelOperacao);
begin
  //aModel.NumOperacao := Self.GetNextSequence(aModel, 'NumOperacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOOperacao.DoUpdate(const aModel: TModelOperacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOOperacao.GetOperacoesPorNumOperacoes(
  const aListNumOperacoes: String): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'NumOperacao';
  vListParametros[0].Valor := aListNumOperacoes;

  Result := Self.OpenQueryToList(SQLSelectOperacoesInNumOperacao(), vListParametros, TModelOperacao);
end;

function TDAOOperacao.SQLSelectOperacoesInNumOperacao: String;
begin
  Result :=
    'DECLARE @SQL VARCHAR(4000); '+
    'SET @SQL = ''SELECT * '+
    '             FROM FDO_Operacao '+
    '		    WHERE NumOperacao IN (''+ :NumOperacao +'')'' '+
    'EXEC (@SQL) ';
end;

end.


