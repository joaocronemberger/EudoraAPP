unit dtoFilaProcessoAutomatico;

interface

uses
  Classes, dtoBase, enumFilaProcessoAutomatico;

type
  TDTOFilaProcessoAutomatico = class(TDTOBase)
  private
    FCodFilaProcessoAutomatico: Integer;
    FCodCarteira: Integer;
    FCodProtocoloOrdem: Integer;
    FDtaOrdemProcessamento: TDateTime;
    FDtaCotaProcessamento: TDateTime;
    FStaSolicitacao: TStaFilaProcessoAutomatico;
    FCodLogProcessamento: Integer;

    function GetStaSolicitacaoText: String;

  published
      property CodFilaProcessoAutomatico: Integer read FCodFilaProcessoAutomatico write FCodFilaProcessoAutomatico;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property CodProtocoloOrdem: Integer read FCodProtocoloOrdem write FCodProtocoloOrdem;
      property DtaOrdemProcessamento: TDateTime read FDtaOrdemProcessamento write FDtaOrdemProcessamento;
      property DtaCotaProcessamento: TDateTime read FDtaCotaProcessamento write FDtaCotaProcessamento;
      property StaSolicitacao: TStaFilaProcessoAutomatico read FStaSolicitacao write FStaSolicitacao;
      property CodLogProcessamento: Integer read FCodLogProcessamento write FCodLogProcessamento;

      property StaSolicitacaoText: String read GetStaSolicitacaoText;

  end;

implementation

{ TDTOFilaProcessoAutomatico }

function TDTOFilaProcessoAutomatico.GetStaSolicitacaoText: String;
begin
  Result := StaFilaProcessoAutomaticoTexto[ FStaSolicitacao ];
end;

initialization
  RegisterClass(TDTOFilaProcessoAutomatico);

end.


