unit dtoAmortizacao;

interface

uses
  dtoBase, enumAmortizacao;

type
  TDTOAmortizacao = class(TDTOBase)
  private
    FCodAmortizacao: Integer;
    FCodCarteira: Integer;
    FDtaAmortizacao: TDateTime;
    FTpoAmortizacao: SmallInt;
    FValAmortizacao: Double;
    FValCotaAmortizacao: Double;
    FTpoCotaAmortizacao: TTpoCotaAmortizacao;

  published
      property CodAmortizacao: Integer read FCodAmortizacao write FCodAmortizacao;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property DtaAmortizacao: TDateTime read FDtaAmortizacao write FDtaAmortizacao;
      property TpoAmortizacao: SmallInt read FTpoAmortizacao write FTpoAmortizacao;
      property ValAmortizacao: Double read FValAmortizacao write FValAmortizacao;
      property ValCotaAmortizacao: Double read FValCotaAmortizacao write FValCotaAmortizacao;
      property TpoCotaAmortizacao: TTpoCotaAmortizacao read FTpoCotaAmortizacao write FTpoCotaAmortizacao;

  protected
    function Memento_GetNowSnapshot(): Variant; override;
  end;

implementation

uses Variants;

{ TDTOAmortizacao }

function TDTOAmortizacao.Memento_GetNowSnapshot: Variant;
begin
  Result :=
    VarArrayOf([
      'Código da Carteira', Self.FCodCarteira,
      'Data da Amortização', Self.FDtaAmortizacao,
      'Tipo de Amortização', Self.FTpoAmortizacao,
      'Valor', Self.FValAmortizacao,
      'Valor da Cota', Self.FValCotaAmortizacao,
      'Tipo de Cota', Self.FTpoCotaAmortizacao
    ]);
end;

end.


