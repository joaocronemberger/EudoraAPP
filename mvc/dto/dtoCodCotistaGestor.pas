unit dtoCodCotistaGestor;

interface

uses
  Classes, dtoBase, mvcTypes;

type
  TDTOCodCotistaGestor = class(TDTOBase)
  private
    FCodCotista: Integer;
    FCodGestor: Integer;
    FCodCotistaGestor: Integer;
    FCodAdministrador: Integer;

  published
      property CodCotista: Integer read FCodCotista write FCodCotista;
      property CodGestor: Integer read FCodGestor write FCodGestor;
      property CodCotistaGestor: Integer read FCodCotistaGestor write FCodCotistaGestor;
      property CodAdministrador: Integer read FCodAdministrador write FCodAdministrador;

  public
    function GetClone(): TDTOCodCotistaGestor; overload;
    function GetClone(aStatus: TStatusDTO): TDTOCodCotistaGestor; overload;
  end;

implementation

{ TDTOCodCotistaGestor }

{ TDTOCodCotistaGestor }

function TDTOCodCotistaGestor.GetClone(
  aStatus: TStatusDTO): TDTOCodCotistaGestor;
begin
  Result := TDTOCodCotistaGestor.Create( aStatus );
  Result.CodCotista := FCodCotista;
  Result.CodGestor := FCodGestor;
  Result.CodCotistaGestor := FCodCotistaGestor;
  Result.CodAdministrador := FCodAdministrador;
end;

function TDTOCodCotistaGestor.GetClone: TDTOCodCotistaGestor;
begin
  Result := Self.GetClone( Self.Status );
end;

initialization
  Registerclass(TDTOCodCotistaGestor);

end.


