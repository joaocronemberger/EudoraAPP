unit modelATDEspecificacao;

interface

uses
  modelBase, mvcTypes;

type
  TModelATDEspecificacao = class(TModelBase)
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

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelATDEspecificacao }

function TModelATDEspecificacao.GetIdentity: String;
begin
  Result := 'SeqEspecificacao';
end;

function TModelATDEspecificacao.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'SeqEspecificacao';

end;

function TModelATDEspecificacao.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,7);
  Result[0] := 'SeqEspecificacao';
  Result[1] := 'NumPedido';
  Result[2] := 'CodCarteira';
  Result[3] := 'TpoOperacao';
  Result[4] := 'ValOperacao';
  Result[5] := 'StaOperacaoPenalty';
  Result[6] := 'TpoCotizacao';

end;

function TModelATDEspecificacao.GetTableName: String;
begin
  Result := 'ATD_Especificacao';
end;

end.


