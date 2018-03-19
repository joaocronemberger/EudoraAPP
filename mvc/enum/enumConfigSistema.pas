unit enumConfigSistema;

interface

type
  TTpoConfigSistema = ( tcsTipoExibicaoMenu );

const
  TpoConfigSistema : array [TTpoConfigSistema] of String = (
    'TipoExibicaoMenu'
  );

  function LocateBy(a: String): TTpoConfigSistema;

implementation

function LocateBy(a: String): TTpoConfigSistema;
var
  I: TTpoConfigSistema;
begin
  Result := tcsTipoExibicaoMenu;
  for i := Low(TTpoConfigSistema) to High(TTpoConfigSistema) do
  begin
    if (TpoConfigSistema[i] = a) then
      Result := i;
  end;
end;

end.

