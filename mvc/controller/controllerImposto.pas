unit controllerImposto;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoImposto,  
  modelImposto;

type
  TControllerImposto = class
  private
    FDAO: TDAOImposto;
  public
    constructor Create;
    destructor Destroy;
  end;

implementation

uses
  mvcTypes;

{ TControllerImposto }

constructor TControllerImposto.Create;
begin
  FDAO := TDAOImposto.Create;
end;

destructor TControllerImposto.Destroy;
begin
  SafeFree(FDAO);
end;

end.


