unit dtoCarteira;

interface

uses
  Classes, dtoBase;

type
  TDTOCarteira = class(TDTOBase)
  private
    FCodCarteira: Integer;
    FValCotaInicial: Double;
    FNomFantasiaProduto: String;
    FTpoApurarCota: String;
    FDtaCriacao: TDateTime;
  published
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property ValCotaInicial: Double read FValCotaInicial write FValCotaInicial;
      property NomFantasiaProduto: String read FNomFantasiaProduto write FNomFantasiaProduto;
      property TpoApurarCota: String read FTpoApurarCota write FTpoApurarCota;
      property DtaCriacao: TDateTime read FDtaCriacao write FDtaCriacao;
  end;

implementation

initialization
  Registerclass(TDTOCarteira);

end.


