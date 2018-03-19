unit enumLogProcessamento;

interface

type
  TStaCalculoProcessamento = ( staCalcSucesso, staCalcWarning, staCalcError );

const
  StaCalculoProcessamento : array [TStaCalculoProcessamento] of String = (
    'S',
    'W',
    'E'
  );

  function LocateBySta(aSta: String): TStaCalculoProcessamento;

implementation

function LocateBySta(aSta: String): TStaCalculoProcessamento;
var
  I: TStaCalculoProcessamento;
begin
  Result := staCalcSucesso;
  for i := Low(TStaCalculoProcessamento) to High(TStaCalculoProcessamento) do
  begin
    if (StaCalculoProcessamento[i] = aSta) then
      Result := i;
  end;
end;

end.
 