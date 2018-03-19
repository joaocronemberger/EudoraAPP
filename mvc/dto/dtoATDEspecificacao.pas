unit dtoATDEspecificacao;

interface

uses
  dtoBase;

type
  TDTOATDEspecificacao = class(TDTOBase)
  private
    FSeqEspecificacao: Integer;
    FNumPedido: Integer;
    FCodCarteira: Integer;
    FTpoOperacao: String;
    FNumAplicacao: Integer;
    FValOperacao: Double;
    FNomUsuario: String;
    FStaRevisa: String;
    FTpoTransferencia: Integer;
    FCodCliDestino: Integer;
    FPercRateio: Double;
    FDtaOperacao: TDateTime;
    FQtdCotaOperacao: Double;
    FDtaCotizacao: TDateTime;
    FDtaLiquidacao: TDateTime;
    FStaOperacaoPenalty: String;
    FTpoCotizacao: String;
    FNumPedidoPenalty: Integer;

  published
      property SeqEspecificacao: Integer read FSeqEspecificacao write FSeqEspecificacao;
      property NumPedido: Integer read FNumPedido write FNumPedido;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property TpoOperacao: String read FTpoOperacao write FTpoOperacao;
      property NumAplicacao: Integer read FNumAplicacao write FNumAplicacao;
      property ValOperacao: Double read FValOperacao write FValOperacao;
      property NomUsuario: String read FNomUsuario write FNomUsuario;
      property StaRevisa: String read FStaRevisa write FStaRevisa;
      property TpoTransferencia: Integer read FTpoTransferencia write FTpoTransferencia;
      property CodCliDestino: Integer read FCodCliDestino write FCodCliDestino;
      property PercRateio: Double read FPercRateio write FPercRateio;
      property DtaOperacao: TDateTime read FDtaOperacao write FDtaOperacao;
      property QtdCotaOperacao: Double read FQtdCotaOperacao write FQtdCotaOperacao;
      property DtaCotizacao: TDateTime read FDtaCotizacao write FDtaCotizacao;
      property DtaLiquidacao: TDateTime read FDtaLiquidacao write FDtaLiquidacao;
      property StaOperacaoPenalty: String read FStaOperacaoPenalty write FStaOperacaoPenalty;
      property TpoCotizacao: String read FTpoCotizacao write FTpoCotizacao;
      property NumPedidoPenalty: Integer read FNumPedidoPenalty write FNumPedidoPenalty;

  end;

implementation

{ TDTOATDEspecificacao }

end.


