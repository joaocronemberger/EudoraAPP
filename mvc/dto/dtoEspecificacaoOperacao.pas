unit dtoEspecificacaoOperacao;

interface

uses
  dtoBase;

type
  TDTOEspecificacaoOperacao = class(TDTOBase)
  private
    FNumOperacao: Integer;
    FSeqEspecificacao: Integer;

  published
      property NumOperacao: Integer read FNumOperacao write FNumOperacao;
      property SeqEspecificacao: Integer read FSeqEspecificacao write FSeqEspecificacao;

  end;

implementation

{ TDTOEspecificacaoOperacao }

end.


