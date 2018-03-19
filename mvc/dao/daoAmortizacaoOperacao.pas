unit daoAmortizacaoOperacao;

interface

uses
  daoBase, Contnrs, modelAmortizacaoOperacao, mvcTypes, DBTables;

type
  TDAOAmortizacaoOperacao = class(TDAOBase)
  private
    function SQLSelectUltimasAmortizacoesPorCarteira(): String;
    function GetSQLDeletarAmotizacaoPosterior(): String;
  public
    procedure DoInsert(const aModel: TModelAmortizacaoOperacao);
    procedure DoUpdate(const aModel: TModelAmortizacaoOperacao);
    procedure DoDelete(const aModel: TModelAmortizacaoOperacao);

    function GetUltimasAmortizacoesPorCarteira(const aCodCarteira: Integer; const aDtaAmortizacao: TDateTime): TObjectList;
    procedure DeletarAmotizacaoPosterior(const aCodCarteira: Integer; const aDtaAmortizacao: TDateTime);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOAmortizacaoOperacao }

procedure TDAOAmortizacaoOperacao.DeletarAmotizacaoPosterior(
  const aCodCarteira: Integer; const aDtaAmortizacao: TDateTime);
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'DtaAmortizacao';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaAmortizacao);

  Self.ExecuteQuery( Self.GetSQLDeletarAmotizacaoPosterior(), vListParametros);
end;

procedure TDAOAmortizacaoOperacao.DoDelete(const aModel: TModelAmortizacaoOperacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOAmortizacaoOperacao.DoInsert(const aModel: TModelAmortizacaoOperacao);
begin
  //aModel.CodAmortizacaoOperacao := Self.GetNextSequence(aModel, 'CodAmortizacaoOperacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOAmortizacaoOperacao.DoUpdate(const aModel: TModelAmortizacaoOperacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOAmortizacaoOperacao.GetSQLDeletarAmotizacaoPosterior: String;
begin
  Result :=
    'DECLARE @CodCarteira int, @DtaAmort datetime; '+
    ' '+
    'set @CodCarteira = :CodCarteira '+
    'set @DtaAmort = :DtaAmortizacao '+
    ' '+
    'create table #tmpResgates (NumOperacao int) '+
    ' '+
    'insert into #tmpResgates '+
    'select FDO_Resgate.NumOperacao '+
    '  from FDO_Resgate '+
    ' where exists ( select 1 '+
    '                  from FDO_AmortizacaoOperacao ao '+
    '                  join FDO_Operacao oAplic '+
    '                    on oAplic.NumOperacao = ao.NumOperacao '+
    '                 where FDO_Resgate.NumAplicacao = oAplic.NumOperacao '+
    '                   and ao.DtaAmortizacao >= @DtaAmort '+
    '                   and oAplic.CodCarteira = @CodCarteira ) '+
    ' '+
    'delete from FDO_EspecificacaoOperacao where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Imposto where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_RendtoNaoAuferido where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_VenctoPrejuizo where NumOperacaoPrejuizo in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Prejuizo where NumOperacaoPrejuizo in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_ResgateIOF where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_IofCompensado where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_IofVirtual where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Resgate where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_PrejuizoCompensado where NumOperacaoPrejuizo in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_PrejuizoCompensado where NumOperacaoPrejCompensado in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Transferencia where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_EspecificacaoOperacao where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_AjustePosDiaria where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_LOGPosicaoDiaria where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Incorporacao where NumOperResgInc in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Cisao where NumOperResgCisao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Penalty where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from Fdo_PrevOperProposta where NumOperacaoProposta in ( select NumOperacao from #tmpResgates ) '+
    'delete from fdo_expeasyway where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    'delete from FDO_Operacao where NumOperacao in ( select NumOperacao from #tmpResgates ) '+
    ' '+
    'delete from FDO_AmortizacaoOperacao '+
    ' where FDO_AmortizacaoOperacao.DtaAmortizacao >= @DtaAmort '+
    '   and exists ( select 1 '+
    '                  from FDO_Operacao with(nolock) '+
    '                 where FDO_Operacao.NumOperacao = FDO_AmortizacaoOperacao.NumOperacao '+
    '                   and FDO_Operacao.CodCarteira = @CodCarteira ) '+
    '   and not exists ( select 1 '+
    '                      from FDO_Operacao with(nolock) '+
    '                     where FDO_Operacao.CodCarteira = @CodCarteira '+
    '                       and FDO_Operacao.NumOperacao = FDO_AmortizacaoOperacao.NumOperacao '+
    '                       and FDO_Operacao.ValOperacao = FDO_AmortizacaoOperacao.ValAplicDescontada ) ';
end;

function TDAOAmortizacaoOperacao.GetUltimasAmortizacoesPorCarteira(
  const aCodCarteira: Integer; const aDtaAmortizacao: TDateTime): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'DtaAmortizacao';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaAmortizacao);

  Result := Self.OpenQueryToList(SQLSelectUltimasAmortizacoesPorCarteira, vListParametros, TModelAmortizacaoOperacao);
end;

function TDAOAmortizacaoOperacao.SQLSelectUltimasAmortizacoesPorCarteira: String;
begin
  Result :=
    'SELECT * '+
    '  FROM FDO_AmortizacaoOperacao AS Amort with(nolock) '+
    '  JOIN (SELECT MAX(AmortMax.DtaAmortizacao) as DtaAmortizacao, MAX(AmortMax.CodAmortizacaoOperacao) as CodAmortizacaoOperacao '+
    '          FROM FDO_AmortizacaoOperacao AS AmortMax with(nolock) '+
    '          JOIN FDO_Operacao  with(nolock) '+
    '            ON FDO_Operacao.NumOperacao = AmortMax.NumOperacao '+
    '         WHERE FDO_Operacao.CodCarteira = :CodCarteira '+
    '           AND AmortMax.DtaAmortizacao <= :DtaAmortizacao '+
    '         GROUP BY AmortMax.NumOperacao '+
    '       ) AS SubSel '+
    '    ON Amort.CodAmortizacaoOperacao = SubSel.CodAmortizacaoOperacao ';

end;

end.


