unit enumFilaProcessoAutomatico;

interface

type
  TStaFilaProcessoAutomatico = ( staAguardando, staProcessando, staConcluido );

const
  StaFilaProcessoAutomatico : array [TStaFilaProcessoAutomatico] of String = (
    'A',
    'P',
    'C'
  );

  StaFilaProcessoAutomaticoTexto : array [TStaFilaProcessoAutomatico] of String = (
    'Aguardando',
    'Processando',
    'Concluído'
  );

  function LocateBySta(aSta: String): TStaFilaProcessoAutomatico;

implementation

function LocateBySta(aSta: String): TStaFilaProcessoAutomatico;
var
  I: TStaFilaProcessoAutomatico;
begin
  Result := staAguardando;
  for i := Low(TStaFilaProcessoAutomatico) to High(TStaFilaProcessoAutomatico) do
  begin
    if (StaFilaProcessoAutomatico[i] = aSta) then
      Result := i;
  end;
end;

end.

