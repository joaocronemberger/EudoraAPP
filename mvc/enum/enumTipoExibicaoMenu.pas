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
    'Vis�o cota informada',
    'Vis�o cota calculada',
    'Ambos'
  );

implementation

end.
