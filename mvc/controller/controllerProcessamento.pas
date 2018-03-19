unit controllerProcessamento;

interface

uses
  Contnrs,
  Classes,
  mvcReferenceManipulator,
  daoProcessamento;

type
  TControllerProcessamento = class
  private
    FDAO: TDAOProcessamento;
  public
    constructor Create;
    destructor Destroy;

    function GetCotistasWithStaDesmarcaCota(const aListaCotistas: TStringList): TStringList;
    procedure UpdateCotistasWithDesmarcaCota(const aValue: Boolean; const aListaCotistas: TStringList);

  end;

implementation

uses
  mvcTypes, Variants, SysUtils;

{ TControllerProcessamento }

constructor TControllerProcessamento.Create;
begin
  FDAO := TDAOProcessamento.Create;
end;

destructor TControllerProcessamento.Destroy;
begin
  SafeFree(FDAO);
end;

function TControllerProcessamento.GetCotistasWithStaDesmarcaCota(
  const aListaCotistas: TStringList): TStringList;
begin

  if Assigned(aListaCotistas) and (aListaCotistas.Count > 0) then
  begin
    aListaCotistas.Delimiter := ',';
    Result := FDAO.GetCotistasWithStaDesmarcaCota(aListaCotistas.DelimitedText);
  end;

end;

procedure TControllerProcessamento.UpdateCotistasWithDesmarcaCota(
  const aValue: Boolean; const aListaCotistas: TStringList);
begin

  if Assigned(aListaCotistas) and (aListaCotistas.Count > 0) then
  begin
    aListaCotistas.Delimiter := ',';
    FDAO.UpdateCotistasWithDesmarcaCota(aValue, aListaCotistas.DelimitedText);
  end;
  
end;

end.


