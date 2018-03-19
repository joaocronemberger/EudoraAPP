unit enumAmortizacao;

interface

type
  TTpoCotaAmortizacao = ( tcaCalculada, tcaInformada );

const
  TpoCotaAmortizacao : array [TTpoCotaAmortizacao] of String = (
    'C',
    'I'
  );

  DescricaoTpoCotaAmortizacao : array [TTpoCotaAmortizacao] of String = (
    'Calculada',
    'Informada'
  );

  function LocateBy(a: String): TTpoCotaAmortizacao;

implementation

function LocateBy(a: String): TTpoCotaAmortizacao;
var
  I: TTpoCotaAmortizacao;
begin
  Result := tcaCalculada;
  for i := Low(TTpoCotaAmortizacao) to High(TTpoCotaAmortizacao) do
  begin
    if (TpoCotaAmortizacao[i] = a) or (DescricaoTpoCotaAmortizacao[i] = a) then
      Result := i;
  end;
end;

end.
 