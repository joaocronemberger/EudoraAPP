unit enumConfiguracaoProcessoAutomatico;

interface

type
  TProcessoAutomatico = ( paDesligado, paLigado );

const
  ProcessoAutomatico : array [TProcessoAutomatico] of String = (
    'N',
    'S'
  );

  function LocateBySta(aSta: String): TProcessoAutomatico;

implementation

function LocateBySta(aSta: String): TProcessoAutomatico;
var
  I: TProcessoAutomatico;
begin
  Result := paDesligado;
  for i := Low(TProcessoAutomatico) to High(TProcessoAutomatico) do
  begin
    if (ProcessoAutomatico[i] = aSta) then
      Result := i;
  end;
end;

end.
 