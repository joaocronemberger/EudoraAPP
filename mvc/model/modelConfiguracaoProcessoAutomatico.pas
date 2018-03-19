unit modelConfiguracaoProcessoAutomatico;

interface

uses
  modelBase, mvcTypes;

type
  TModelConfiguracaoProcessoAutomatico = class(TModelBase)
  private
    FStaProcessoAutomatico: String;
    FIntervaloProcessamento: Integer;
    FPeriodoExecucao: String;
    FStaServicoAtivado: String;

  published
      property StaProcessoAutomatico: String read FStaProcessoAutomatico write FStaProcessoAutomatico;
      property IntervaloProcessamento: Integer read FIntervaloProcessamento write FIntervaloProcessamento;
      property PeriodoExecucao: String read FPeriodoExecucao write FPeriodoExecucao;
      property StaServicoAtivado: String read FStaServicoAtivado write FStaServicoAtivado;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelConfiguracaoProcessoAutomatico }

function TModelConfiguracaoProcessoAutomatico.GetIdentity: String;
begin
  Result := '';
end;

function TModelConfiguracaoProcessoAutomatico.GetPKFields: TArrayStrings;
begin
  SetLength(Result,0);

end;

function TModelConfiguracaoProcessoAutomatico.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,0);

end;

function TModelConfiguracaoProcessoAutomatico.GetTableName: String;
begin
  Result := 'FDO_ConfiguracaoProcessoAutomatico';
end;

end.


