unit enumTipoExibicaoMenu;

interface

type
  TTipoExibicaoMenu = (
    temCotaInformada = 1,
    temCotaCalculada = 2,
    temAmbos = 3
  );

const
  NomeTipoExibicaoMenu : Array [TTipoExibicaoMenu] of String = (
    'Visão cota informada',
    'Visão cota calculada',
    'Ambos'
  );

implementation

end.
