unit dtoConfiguracaoProcessoAutomatico;

interface

uses
  dtoBase, Variants;

type
  TDTOConfiguracaoProcessoAutomatico = class(TDTOBase)
  private
    FStaProcessoAutomatico: Boolean;
    FIntervaloProcessamento: Integer;
    FPeriodoExecucao: String;
    FStaServicoAtivado: Boolean;

  published
      property StaProcessoAutomatico: Boolean read FStaProcessoAutomatico write FStaProcessoAutomatico;
      property IntervaloProcessamento: Integer read FIntervaloProcessamento write FIntervaloProcessamento;
      property PeriodoExecucao: String read FPeriodoExecucao write FPeriodoExecucao;
      property StaServicoAtivado: Boolean read FStaServicoAtivado write FStaServicoAtivado;

  public

    function Memento_GetNowSnapshot(): Variant; override;

  end;

implementation

uses
  FDLib01;

{ TDTOConfiguracaoProcessoAutomatico }

function TDTOConfiguracaoProcessoAutomatico.Memento_GetNowSnapshot: Variant;
begin
  Result :=
    VarArrayOf([
      'Usa processao automático', BoolToSN(Self.FStaProcessoAutomatico),
      'Intervalo de processamento', Self.FIntervaloProcessamento,
      'Janela de execução', Self.FPeriodoExecucao
    ]);
end;

end.


