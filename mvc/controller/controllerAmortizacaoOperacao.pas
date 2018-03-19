unit controllerAmortizacaoOperacao;

interface

uses
  Contnrs,
  Classes,
  StrUtils, 
  mvcReferenceManipulator, 
  daoAmortizacaoOperacao,
  daoAmortizacao,
  daoOperacao,
  daoResgate,
  daoImposto,
  daoCota,
  modelAmortizacaoOperacao,
  modelAmortizacao,
  modelOperacao,
  modelResgate,
  modelImposto,
  modelCota;

type
  TControllerAmortizacaoOperacao = class
  private
    FDAO: TDAOAmortizacaoOperacao;
    FDAOAmortizacao: TDAOAmortizacao;
    FDAOOperacao: TDAOOperacao;
    FDAOResgate: TDAOResgate;
    FDAOImposto: TDAOImposto;
    FDAOCota: TDAOCota;

    function GetOperacoesPorAmortizacoes(const aListAmortizacoes: TObjectList): TObjectList;

    function LocateOperacaoInList(const aNumOperacao: Integer; const aListOperacoes: TObjectList): TModelOperacao;
    function CloneOperacao(const aOperacao: TModelOperacao): TModelOperacao;

    function RetornaValorFracionadoPrincipal(const aAmortizacao: TModelAmortizacao; const aListaAmortizacaoOperacao, aListaOperacaoAplicacao: TObjectList): Double;
    function RetornaValorFracionadoRendimento(const aAmortizacao: TModelAmortizacao; const aListaAmortizacaoOperacao, aListaOperacaoAplicacao: TObjectList): Double;

    procedure AtualizaCotaBrutaCalculadaDaAmortizacao(var aAmortizacao: TModelAmortizacao; const aListaAmortizacaoOperacao, aListaOperacaoAplicacao: TObjectList);

    procedure GravarAmortizacao(const aAmortizacao: TModelAmortizacao; const aListaAmortizacaoOperacao, aListaOperacaoAplicacao: TObjectList; const aValorFracionadoPrincipal, aValorFracionadoRendimento: Double);
    procedure DeletarAmortizacoesPosteriores(const aCodCarteira: Integer; const aDtaProcesso: TDateTime);

  public
    constructor Create;
    destructor Destroy;

    procedure ProcessarAmortizacao(const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
  end;

const
  aAssinaturaMsg = 'Cálc. da Amortização: ';

implementation

uses
  mvcTypes, SysUtils, FDUConstantes, FDO_LogProcessamento, enumAmortizacao,
  Math;

{ TControllerAmortizacaoOperacao }

constructor TControllerAmortizacaoOperacao.Create;
begin
  FDAO := TDAOAmortizacaoOperacao.Create;
  FDAOAmortizacao := TDAOAmortizacao.Create;
  FDAOOperacao := TDAOOperacao.Create;
  FDAOResgate := TDAOResgate.Create;
  FDAOImposto := TDAOImposto.Create;
  FDAOCota := TDAOCota.Create;
end;

destructor TControllerAmortizacaoOperacao.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOAmortizacao);
  SafeFree(FDAOOperacao);
  SafeFree(FDAOResgate);
  SafeFree(FDAOImposto);
  SafeFree(FDAOCota);
end;

function TControllerAmortizacaoOperacao.CloneOperacao(
  const aOperacao: TModelOperacao): TModelOperacao;
begin
  Result := TModelOperacao.Create;
  Result.NumOperacao := 0;
  Result.SeqTransferencia := 0;
  Result.CodCliente := aOperacao.CodCliente;
  Result.CodCarteira := aOperacao.CodCarteira;
  Result.NumOperRetroativa := 0;
  Result.DtaOperacao := aOperacao.DtaOperacao;
  Result.TpoOperacao := IntToStr(FDUConstantes.RESGATE_BRUTO);
  Result.DtaConvCota := aOperacao.DtaConvCota;
  Result.DtaLiquidacao := aOperacao.DtaLiquidacao;
  Result.ValOperacao := aOperacao.ValOperacao;
  Result.QtdCotaOperacao := 0;
  Result.QtdCotaPagtoIR := 0;
  Result.Staoperacao := 'AM';
  Result.NumOpeMellon := 0;
  Result.StaExportaSMA := 'EXP';
  Result.StaIntSinacor := 'N';
  Result.NumIntCCCliente := 0;
  Result.NumIntCCFundo := 0;
  Result.NumIntDOC := 0;
  Result.ValLiqResgSinacor := 0;
  Result.TpoOrigem := 'AUT';
  Result.QtdCotaAI_AC := 0;
  Result.IR_AI_AC := 0;
end;

function TControllerAmortizacaoOperacao.GetOperacoesPorAmortizacoes(
  const aListAmortizacoes: TObjectList): TObjectList;
var
  i, index: integer;
  vStrLst: TStringList;
begin

  vStrLst := TStringList.Create;
  try
    vStrLst.Delimiter := ',';
    vStrLst.Add('0');

    for i := 0 to aListAmortizacoes.Count -1 do
    begin
      if not vStrLst.Find(IntToStr(TModelAmortizacaoOperacao(aListAmortizacoes.Items[i]).NumOperacao), index) then
        vStrLst.Add(IntToStr(TModelAmortizacaoOperacao(aListAmortizacoes.Items[i]).NumOperacao));
    end;

    Result := FDAOOperacao.GetOperacoesPorNumOperacoes(vStrLst.DelimitedText);
  finally
    SafeFree(vStrLst);
  end;
end;

function TControllerAmortizacaoOperacao.LocateOperacaoInList(
  const aNumOperacao: Integer;
  const aListOperacoes: TObjectList): TModelOperacao;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to aListOperacoes.Count -1 do
  begin
    if (TModelOperacao(aListOperacoes.Items[i]).NumOperacao = aNumOperacao) then
    begin
      Result := TModelOperacao(aListOperacoes.Items[i]);
      Break;
    end;
  end;
end;

procedure TControllerAmortizacaoOperacao.ProcessarAmortizacao(
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
var
  vAmortizacao: TModelAmortizacao;
  vListaAmortizacaoOperacao,
  vListaOperacaoAplicacao: TObjectList;
  vValorTotal: Double;

  vAuxValorFracionadoPrincipal,
  vAuxValorFracionadoRendimento: Double;
begin
  FDAO.StartTransaction;
  try

    { Deleta Operações/Resgates/Impostos/AmotizaçõesOperações posteriores }
    Self.DeletarAmortizacoesPosteriores(aCodCarteira, aDtaProcesso);

    vAmortizacao := FDAOAmortizacao.GetAmortizacaoByDataCarteira(aDtaProcesso, aCodCarteira);
    if Assigned(vAmortizacao) and (vAmortizacao.ValAmortizacao > 0) then
    begin
      try

        { Recupera lista de FDO_AmortizacaoOperacao com o ValorAplicadoDescontado }
        vListaAmortizacaoOperacao := FDAO.GetUltimasAmortizacoesPorCarteira(vAmortizacao.CodCarteira, vAmortizacao.DtaAmortizacao);

        { Recupera lista de FDO_Operacao das amortizações encontradas acima }
        vListaOperacaoAplicacao := Self.GetOperacoesPorAmortizacoes(vListaAmortizacaoOperacao);

        { Atualiza a CotaBruta para amortização, Somente se a cota for "Calculada" }
        Self.AtualizaCotaBrutaCalculadaDaAmortizacao(vAmortizacao, vListaAmortizacaoOperacao, vListaOperacaoAplicacao);
        if vAmortizacao.ValCotaAmortizacao = 0 then
        begin
          TLogProcessamento.GetInstancia().AddError(vAmortizacao.CodCarteira, Format(aAssinaturaMsg + 'Cota da Amortização não foi %s.',[IfThen(vAmortizacao.TpoCotaAmortizacao = TpoCotaAmortizacao[tcaCalculada],'calculada','informada')]));
          Exit;
        end;

        { Calcula a fração referente ao valor Principal e Rendimento }
        vAuxValorFracionadoPrincipal := Self.RetornaValorFracionadoPrincipal(vAmortizacao, vListaAmortizacaoOperacao, vListaOperacaoAplicacao);
        vAuxValorFracionadoRendimento := Self.RetornaValorFracionadoRendimento(vAmortizacao, vListaAmortizacaoOperacao, vListaOperacaoAplicacao);

        { Grava amortização do dia }
        Self.GravarAmortizacao(vAmortizacao, vListaAmortizacaoOperacao, vListaOperacaoAplicacao, vAuxValorFracionadoPrincipal, vAuxValorFracionadoRendimento);

      finally
        SafeFree(vAmortizacao);
        SafeFree(vListaAmortizacaoOperacao);
        SafeFree(vListaOperacaoAplicacao);
      end;
    end;
    
    FDAO.CommitTransaction;
  except
    on e: exception do
    begin
      FDAO.RollbackTransaction;
      TLogProcessamento.GetInstancia().AddError(aCodCarteira, 'Ocorreu um erro no cálculo do amortização: '+ e.message);
    end;
  end;
end;

procedure TControllerAmortizacaoOperacao.GravarAmortizacao(
  const aAmortizacao: TModelAmortizacao;
  const aListaAmortizacaoOperacao, aListaOperacaoAplicacao: TObjectList;
  const aValorFracionadoPrincipal, aValorFracionadoRendimento: Double);
var
  i: integer;
  vValOperacao,
  vValPrincipal,
  vValRendimento: Double;
  vAliqIR: Double;
  vAmortizacaoOperacao: TModelAmortizacaoOperacao;
  vOperacaoAplic: TModelOperacao;

  vNewOperacao: TModelOperacao;
  vNewResgate: TModelResgate;
  vNewImposto: TModelImposto;
  vNewAmortizacaoOperacao: TModelAmortizacaoOperacao;
begin

  for i := 0 to aListaAmortizacaoOperacao.Count -1 do
  begin

    try

      vAmortizacaoOperacao := TModelAmortizacaoOperacao(aListaAmortizacaoOperacao.Items[i]);
      vOperacaoAplic := LocateOperacaoInList(vAmortizacaoOperacao.NumOperacao, aListaOperacaoAplicacao);

      vValPrincipal := (vAmortizacaoOperacao.ValAplicDescontada * aValorFracionadoPrincipal);
      vValRendimento := (((vOperacaoAplic.QtdCotaOperacao * aAmortizacao.ValCotaAmortizacao) - vAmortizacaoOperacao.ValAplicDescontada) * aValorFracionadoRendimento);
      vValOperacao := (vValPrincipal + vValRendimento);


      { Grava a FDO_Operacao }
      vNewOperacao := CloneOperacao(vOperacaoAplic);
      vNewOperacao.DtaOperacao := aAmortizacao.DtaAmortizacao;
      vNewOperacao.DtaConvCota := aAmortizacao.DtaAmortizacao;
      vNewOperacao.DtaLiquidacao := aAmortizacao.DtaAmortizacao;
      vNewOperacao.ValOperacao := vValOperacao;
      vNewOperacao.ValLiqResgSinacor := vValOperacao;

      FDAOOperacao.DoInsert(vNewOperacao);


      { Grava a FDO_Resgate }
      vNewResgate := TModelResgate.Create;
      vNewResgate.NumOperacao := vNewOperacao.NumOperacao;
      vNewResgate.NumAplicacao := vOperacaoAplic.NumOperacao;
      vNewResgate.ValPremioPerformance := 0;
      vNewResgate.ValMultaSaida := 0;
      vNewResgate.ValRendtoNominal := vValRendimento;
      vNewResgate.NumAplMellon := 0;

      FDAOResgate.DoInsert(vNewResgate);


      { Grava a FDO_Imposto }
      if vValRendimento > 0 then
      begin
        vAliqIR := FDAOImposto.GetAliquotaIR(aAmortizacao.CodCarteira, vOperacaoAplic.DtaOperacao, vNewOperacao.DtaOperacao);
        if vAliqIR > 0 then
        begin
          vNewImposto := TModelImposto.Create;
          vNewImposto.NumOperacao := vNewOperacao.NumOperacao;
          vNewImposto.AnoBase := FormatDateTime('YYYY',vNewOperacao.DtaOperacao);
          vNewImposto.ValBaseIrAno := vValRendimento;
          vNewImposto.ValCompPrjAno := 0;
          vNewImposto.ValIrAno := (vValRendimento * vAliqIR) / 100;

          FDAOImposto.DoInsert(vNewImposto);
        end else
        begin
          TLogProcessamento.GetInstancia().AddWarning(aAmortizacao.CodCarteira, Format(aAssinaturaMsg + 'Alíq. de IR não encontrada.',[]));
        end;
      end;


      { Grava Amortização Operação }
      vNewAmortizacaoOperacao := TModelAmortizacaoOperacao.Create;
      vNewAmortizacaoOperacao.NumOperacao := vOperacaoAplic.NumOperacao;
      vNewAmortizacaoOperacao.DtaAmortizacao := aAmortizacao.DtaAmortizacao;
      vNewAmortizacaoOperacao.ValAplicDescontada := vAmortizacaoOperacao.ValAplicDescontada - vValPrincipal;

      FDAO.DoInsert(vNewAmortizacaoOperacao);

    finally
      SafeFree(vNewOperacao);
      SafeFree(vNewResgate);
      SafeFree(vNewImposto);
      SafeFree(vNewAmortizacaoOperacao);
    end;

  end;
end;

function TControllerAmortizacaoOperacao.RetornaValorFracionadoPrincipal(
  const aAmortizacao: TModelAmortizacao; const aListaAmortizacaoOperacao,
  aListaOperacaoAplicacao: TObjectList): Double;
var
  i: Integer;

  vQtdTotalAplicada: Double;

  vValTotalAplic,
  vValTotalAplicDescontada: Double;
begin
  Result := 0;

  vValTotalAplicDescontada := 0;
  for i := 0 to aListaAmortizacaoOperacao.Count -1 do
    vValTotalAplicDescontada := vValTotalAplicDescontada + TModelAmortizacaoOperacao(aListaAmortizacaoOperacao.Items[i]).ValAplicDescontada;

  case aAmortizacao.TpoAmortizacao of
    0 : begin // Amortização Principal
          Result := (aAmortizacao.ValAmortizacao / vValTotalAplicDescontada);
        end;

    2 : begin // Amortização Ambos
          vQtdTotalAplicada := 0;
          vValTotalAplic := 0;
          for i := 0 to aListaOperacaoAplicacao.Count -1 do
          begin
            vQtdTotalAplicada := vQtdTotalAplicada + TModelOperacao(aListaOperacaoAplicacao.Items[i]).QtdCotaOperacao;
            vValTotalAplic := vValTotalAplic + TModelOperacao(aListaOperacaoAplicacao.Items[i]).ValOperacao;
          end;

          Result := (aAmortizacao.ValAmortizacao * (vValTotalAplic /(vQtdTotalAplicada * aAmortizacao.ValCotaAmortizacao))) / vValTotalAplicDescontada
        end;
  end;
  
end;

function TControllerAmortizacaoOperacao.RetornaValorFracionadoRendimento(
  const aAmortizacao: TModelAmortizacao; const aListaAmortizacaoOperacao,
  aListaOperacaoAplicacao: TObjectList): Double;
var
  i: Integer;

  vQtdTotalAplicada: Double;

  vValTotalBruto,
  vValTotalAplic,
  vValTotalAplicDescontada: Double;
begin
  Result := 0;

  vValTotalAplicDescontada := 0;
  for i := 0 to aListaAmortizacaoOperacao.Count -1 do
    vValTotalAplicDescontada := vValTotalAplicDescontada + TModelAmortizacaoOperacao(aListaAmortizacaoOperacao.Items[i]).ValAplicDescontada;

  vQtdTotalAplicada := 0;
  vValTotalAplic := 0;
  for i := 0 to aListaOperacaoAplicacao.Count -1 do
  begin
    vQtdTotalAplicada := vQtdTotalAplicada + TModelOperacao(aListaOperacaoAplicacao.Items[i]).QtdCotaOperacao;
    vValTotalAplic := vValTotalAplic + TModelOperacao(aListaOperacaoAplicacao.Items[i]).ValOperacao;
  end;

  vValTotalBruto := (vQtdTotalAplicada * aAmortizacao.ValCotaAmortizacao);

  case aAmortizacao.TpoAmortizacao of
    1 : begin // Amortização Rendimento
          if (vValTotalBruto > vValTotalAplicDescontada) then // Só calcula se teve rendimento
            Result := (aAmortizacao.ValAmortizacao / (vValTotalBruto - vValTotalAplicDescontada));
        end;

    2 : begin // Amortização Ambos
          if (vValTotalBruto > vValTotalAplicDescontada) then // Só calcula se teve rendimento
            Result :=  aAmortizacao.ValAmortizacao * (((vValTotalBruto - vValTotalAplicDescontada) / vValTotalBruto) / (vValTotalBruto - vValTotalAplicDescontada));
        end;
  end;

end;

procedure TControllerAmortizacaoOperacao.DeletarAmortizacoesPosteriores(
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
begin
  FDAO.DeletarAmotizacaoPosterior(aCodCarteira, aDtaProcesso);
end;

procedure TControllerAmortizacaoOperacao.AtualizaCotaBrutaCalculadaDaAmortizacao(
  var aAmortizacao: TModelAmortizacao; const aListaAmortizacaoOperacao,
  aListaOperacaoAplicacao: TObjectList);
var
  vCotaDia: TModelCota;
  i: Integer;
  vQtdTotalAplicada,
  vPUAmortizacao: Double;
begin
  try
    if (aAmortizacao.TpoCotaAmortizacao = TpoCotaAmortizacao[tcaCalculada]) and
       (aAmortizacao.TpoAmortizacao <> 1) then // Diferente de Amortização por Rendimento 
    begin

      aAmortizacao.ValCotaAmortizacao := 0;

      vQtdTotalAplicada := 0;
      for i := 0 to aListaOperacaoAplicacao.Count -1 do
        vQtdTotalAplicada := vQtdTotalAplicada + TModelOperacao(aListaOperacaoAplicacao.Items[i]).QtdCotaOperacao;

      { Recupera cota do dia }
      vCotaDia := FDAOCota.GetCotaDia(aAmortizacao.CodCarteira, aAmortizacao.DtaAmortizacao);
      if not Assigned(vCotaDia) then
      begin
        TLogProcessamento.GetInstancia().AddWarning(aAmortizacao.CodCarteira, Format(aAssinaturaMsg + 'Cota do dia %s não foi encontrada.',[FormatDateTime('dd/mm/yyyy',aAmortizacao.DtaAmortizacao)]));
        Exit;
      end;

      if (vQtdTotalAplicada = 0) then
      begin
        TLogProcessamento.GetInstancia().AddError(aAmortizacao.CodCarteira, aAssinaturaMsg + 'Não é possível calcular a Cota da Amortização sem nenhuma operação de aplicação.');
        Exit;
      end;

      vPUAmortizacao := (aAmortizacao.ValAmortizacao / vQtdTotalAplicada);
      aAmortizacao.ValCotaAmortizacao := (vPUAmortizacao + vCotaDia.ValCota);
      FDAOAmortizacao.DoUpdate(aAmortizacao);

    end;
    
  finally
    SafeFree(vCotaDia);
  end
end;

end.


