unit controllerCotaGerencAmort;

interface

uses
  Contnrs,
  Classes, 
  daoCotaGerencAmort,  
  modelCotaGerencAmort,
  modelCota,
  daoCota,
  FDUConstantes,
  SysUtils,
  mvcReferenceManipulator,
  daoCarteira,
  daoAmortizacao,
  modelAmortizacao,
  modelAmortizacaoOperacao,
  daoAmortizacaoOperacao,
  daoOperacao,
  modelOperacao, Math;

type
  TControllerCotaGerencAmort = class
  private
    FDAO: TDAOCotaGerencAmort;
    FDAOCota: TDAOCota;
    FDAOCarteira: TDAOCarteira;
    FDAOAmortizacao: TDAOAmortizacao;
    FDAOAmortizacaoOperacao: TDAOAmortizacaoOperacao;
    FDAOOperacao: TDAOOperacao;

    function GetOperacoesAplicacoes(const aCodCarteira: Integer; const aDtaProcesso: TDateTime): TObjectList;

    procedure GravarPrimeiraCotaGerencial(const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
    procedure CalcularCotaGerencial(const aCotaGerencAnterior: TModelCotaGerencAmort; const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
  public
    constructor Create;
    destructor Destroy;

    procedure CalcularCotaGerencialPorDia(const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
  end;

const
  aAssinaturaMsg = 'Cálc. da Cota Gerencial: ';
implementation

uses
  mvcTypes, FDO_LogProcessamento;

{ TControllerCotaGerencAmort }

procedure TControllerCotaGerencAmort.CalcularCotaGerencial(
  const aCotaGerencAnterior: TModelCotaGerencAmort;
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
var
  vCotaDia,
  vCotaDiaAnterior: TModelCota;
  vPrimeiraCotaGerencial,
  vModel: TModelCotaGerencAmort;
  vAmortizacao: TModelAmortizacao;
  vListOperacoes: TObjectList;

  vValorAmortizacao: Currency;

  i: Integer;

  vValorRendimento, vVariacao: Double;
  vQuantidadeAplicado: Currency;
begin
  try

    { Busca operações de aplicação para }
    vListOperacoes := GetOperacoesAplicacoes(aCodCarteira, aDtaProcesso);
    vQuantidadeAplicado := 0;
    for i := 0 to vListOperacoes.Count -1 do
    begin
      vQuantidadeAplicado := vQuantidadeAplicado + TModelOperacao(vListOperacoes.Items[i]).QtdCotaOperacao;
    end;

    { Busca a cota do dia }
    vCotaDia := FDAOCota.GetCotaDia(aCodCarteira, aDtaProcesso);
    if not Assigned(vCotaDia) then
    begin
      TLogProcessamento.GetInstancia().AddWarning(aCodCarteira, Format(aAssinaturaMsg + 'Cota do dia %s não foi encontrada.',[FormatDateTime('dd/mm/yyyy',aDtaProcesso)]));
      Exit;
    end;

    { Busca a cota do dia anterior }
    vCotaDiaAnterior := FDAOCota.GetCotaAnterior(aCodCarteira, aDtaProcesso);
    if not Assigned(vCotaDiaAnterior) then
    begin
      TLogProcessamento.GetInstancia().AddWarning(aCodCarteira, Format(aAssinaturaMsg + 'Cota do dia anterior ao dia %s não foi encontrada.',[FormatDateTime('dd/mm/yyyy',aDtaProcesso)]));
      Exit;
    end;

    vPrimeiraCotaGerencial := FDAO.GetPrimeiraCotaGerencial(aCodCarteira);
    if not Assigned(vPrimeiraCotaGerencial) then
    begin
      TLogProcessamento.GetInstancia().AddWarning(aCodCarteira, Format(aAssinaturaMsg + 'Não foi encontrada primeira Cota Gerencial da Carteira.',[aCodCarteira]));
      Exit;
    end;

    vAmortizacao := FDAOAmortizacao.GetAmortizacaoByDataCarteira(aDtaProcesso, aCodCarteira);
    if Assigned(vAmortizacao)
      then vValorAmortizacao := vAmortizacao.ValAmortizacao
      else vValorAmortizacao := 0;

    { Calcula e grava a cota gerencial do dia }
    vModel := FDAO.GetCotaGerencialDia(aCodCarteira, aDtaProcesso);
    if not Assigned(vModel)
      then vModel := TModelCotaGerencAmort.Create;

    vModel.CodCarteira := aCodCarteira;
    vModel.DtaCotaGerenc := aDtaProcesso;

    vValorRendimento := ((vQuantidadeAplicado * vCotaDia.ValCota) + vValorAmortizacao) - (vQuantidadeAplicado * vCotaDiaAnterior.ValCota);
    vVariacao := vValorRendimento / (vQuantidadeAplicado * vCotaDiaAnterior.ValCota);

    // Se vQuantidadeAplicado = 0 então resultado acima = NAN ( Not a Number );
    if IsNan(vVariacao)
      then vVariacao := 0;

    vModel.ValCotaGerenc := aCotaGerencAnterior.ValCotaGerenc * (1 + vVariacao);
    vModel.RendtoAcum := (vModel.ValCotaGerenc / vPrimeiraCotaGerencial.ValCotaGerenc) - 1;

    { Update or Insert cota gerencial do dia }
    if (vModel.CodCotaGerencAmort > 0)
      then FDAO.DoUpdate(vModel)
      else FDAO.DoInsert(vModel);

  finally
    SafeFree(vCotaDia);
    SafeFree(vCotaDiaAnterior);
    SafeFree(vPrimeiraCotaGerencial);
    SafeFree(vAmortizacao);
    SafeFree(vListOperacoes);
    SafeFree(vModel);
  end;
end;

procedure TControllerCotaGerencAmort.CalcularCotaGerencialPorDia(
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
var
  vCotaGerencialDiaAnterior: TModelCotaGerencAmort;
begin
  FDAO.StartTransaction;
  try

    if FDAOCarteira.GetStaFundoFehcadoByCarteira(aCodCarteira) then
    begin
      try
        { Busca a cota gerencial do dia anterior.
          Se não encontrar significa que é o primeiro processamento, insere um cota e encerra o calculo
          Se encontrar, processa normalmente }
        vCotaGerencialDiaAnterior := FDAO.GetCotaGerencialDiaAnterior(aCodCarteira, aDtaProcesso);

        if Assigned(vCotaGerencialDiaAnterior)
          then Self.CalcularCotaGerencial(vCotaGerencialDiaAnterior, aCodCarteira, aDtaProcesso)
          else Self.GravarPrimeiraCotaGerencial(aCodCarteira, aDtaProcesso);

      finally
        SafeFree(vCotaGerencialDiaAnterior)
      end;
    end;
    
    FDAO.CommitTransaction;
  except
    FDAO.RollbackTransaction;
    raise;
  end;
end;

constructor TControllerCotaGerencAmort.Create;
begin
  FDAO := TDAOCotaGerencAmort.Create;
  FDAOCota := TDAOCota.Create;
  FDAOCarteira := TDAOCarteira.Create;
  FDAOAmortizacao := TDAOAmortizacao.Create;
  FDAOAmortizacaoOperacao := TDAOAmortizacaoOperacao.Create;
  FDAOOperacao := TDAOOperacao.Create;
end;

destructor TControllerCotaGerencAmort.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOCota);
  SafeFree(FDAOCarteira);
  SafeFree(FDAOAmortizacao);
  SafeFree(FDAOAmortizacaoOperacao);
  SafeFree(FDAOOperacao);
end;

function TControllerCotaGerencAmort.GetOperacoesAplicacoes(
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime): TObjectList;
var
  vListaAmortizacaoOperacao: TObjectList;
  i, index: integer;
  vStrLst: TStringList;
begin
  { Recupera lista de amortização operação com o ValorAplicadoDescontado }
  vListaAmortizacaoOperacao := FDAOAmortizacaoOperacao.GetUltimasAmortizacoesPorCarteira(aCodCarteira, aDtaProcesso);
  try
    vStrLst := TStringList.Create;
    vStrLst.Delimiter := ',';
    vStrLst.Add('0');

    for i := 0 to vListaAmortizacaoOperacao.Count -1 do
    begin
      if not vStrLst.Find(IntToStr(TModelAmortizacaoOperacao(vListaAmortizacaoOperacao.Items[i]).NumOperacao), index) then
        vStrLst.Add(IntToStr(TModelAmortizacaoOperacao(vListaAmortizacaoOperacao.Items[i]).NumOperacao));
    end;

    Result := FDAOOperacao.GetOperacoesPorNumOperacoes(vStrLst.DelimitedText);

  finally
    SafeFree(vStrLst);
    SafeFree(vListaAmortizacaoOperacao);
  end;
end;

procedure TControllerCotaGerencAmort.GravarPrimeiraCotaGerencial(
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
var
  vModel: TModelCotaGerencAmort;
begin
  try
  
    vModel := FDAO.GetCotaGerencialDia(aCodCarteira, aDtaProcesso);
    if not Assigned(vModel)
      then vModel := TModelCotaGerencAmort.Create;

    vModel.CodCarteira := aCodCarteira;
    vModel.DtaCotaGerenc := aDtaProcesso;
    vModel.ValCotaGerenc := FDAOCarteira.GetValCotaInicialByCarteira(aCodCarteira);
    vModel.RendtoAcum := 0;

    { Update or Insert cota gerencial do dia }
    if (vModel.CodCotaGerencAmort > 0)
      then FDAO.DoUpdate(vModel)
      else FDAO.DoInsert(vModel);
      
  finally
    SafeFree(vModel);
  end;
end;

end.


