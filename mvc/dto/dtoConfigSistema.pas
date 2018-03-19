unit dtoConfigSistema;

interface

uses
  dtoBase;

type
  TDTOConfigSistema = class(TDTOBase)
  private
    FNomConfig: String;
    FValConfig: String;

  published
      property NomConfig: String read FNomConfig write FNomConfig;
      property ValConfig: String read FValConfig write FValConfig;
  end;

implementation

{ TDTOConfigSistema }

end.


