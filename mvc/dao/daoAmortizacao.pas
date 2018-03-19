unit daoAmortizacao;

interface

uses
  daoBase, Contnrs, modelAmortizacao, modelCarteira, mvcTypes, DBTables;

type
  TDAOAmortizacao = class(TDAOBase)
  private
    function GetSQLListaCarteira(): String;
    function GetSQLAmortizacao(): String;
  public
    function GetAmortizacaoByDataCarteira(const aDataProcesso: TDateTime; const aCodCarteira: Integer): TModelAmortizacao;

    procedure DoInsert(const aModel: TModelAmortizacao);
    procedure DoUpdate(const aModel: TModelAmortizacao);
    procedure DoDelete(const aModel: TModelAmortizacao);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOAmortizacao }

procedure TDAOAmortizacao.DoDelete(const aModel: TModelAmortizacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOAmortizacao.DoInsert(const aModel: TModelAmortizacao);
begin
  aModel.CodAmortizacao := Self.GetNextSequence(aModel, 'CodAmortizacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOAmortizacao.DoUpdate(const aModel: TModelAmortizacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOAmortizacao.GetAmortizacaoByDataCarteira(
  const aDataProcesso: TDateTime;
  const aCodCarteira: Integer): TModelAmortizacao;
var
  vListParametros: TArrayFields;
  vQry: TQuery;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'pDtaAmortizacao';
  vListParametros[0].Valor := FormatDateTime('yyyy-mm-dd',aDataProcesso);
  vListParametros[1].Nome := 'pCodCarteira';
  vListParametros[1].Valor := aCodCarteira;

  Result := TModelAmortizacao(Self.OpenQueryToModel(GetSQLAmortizacao, vListParametros, TModelAmortizacao));
end;

function TDAOAmortizacao.GetSQLAmortizacao: String;
begin
  Result :=
    'select CodAmortizacao, CodCarteira, DtaAmortizacao, TpoAmortizacao, '+
    '       ValAmortizacao, ValCotaAmortizacao, TpoCotaAmortizacao '+
    '  from FDO_Amortizacao '+
    ' where CodCarteira = :pCodCarteira '+
    '   and DtaAmortizacao = :pDtaAmortizacao ';
end;

function TDAOAmortizacao.GetSQLListaCarteira: String;
begin
  Result :=
    'select FDO_Carteira.CodCarteira, '+
    '       CLI_Produto.NomFantasiaProduto '+
    '  from FDO_Carteira '+
    '  join CLI_Produto '+
    '    on CLI_Produto.CodCliente = FDO_Carteira.CodCarteira '+
    ' where StaFdoCondFechado = ''S'' '+
    '   and DtaCriacao <= :pDtaCriacao ';
end;

end.


