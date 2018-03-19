unit controllerResgate;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoResgate,  
  modelResgate;

type
  TControllerResgate = class
  private
    FDAO: TDAOResgate;
  public
    constructor Create;
    destructor Destroy;
  end;

implementation

uses
  mvcTypes;

{ TControllerResgate }

constructor TControllerResgate.Create;
begin
  FDAO := TDAOResgate.Create;
end;

destructor TControllerResgate.Destroy;
begin
  SafeFree(FDAO);
end;

end.


