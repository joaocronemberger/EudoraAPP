unit dtoCampos;

interface

uses
  mvcTypes, Classes;

type

  TDTOCampos = class(TPersistent)
  private
    FStatus: TStatusDTO;
  protected
    function getStatus: TStatusDTO;
    procedure setStatus(const Value: TStatusDTO);
  public
    property Status: TStatusDTO read getStatus write setStatus;
  end;

implementation

{ TDTOCampos }

function TDTOCampos.getStatus: TStatusDTO;
begin
  Result := FStatus;
end;

procedure TDTOCampos.setStatus(const Value: TStatusDTO);
begin
  FStatus := Value;
end;

end.


