unit controllerOperacao;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoOperacao,  
  modelOperacao;

type
  TControllerOperacao = class
  private
    FDAO: TDAOOperacao;
  public
    constructor Create;
    destructor Destroy;
  end;

implementation

uses
  mvcTypes, mvcMiscelania;

{ TControllerOperacao }

constructor TControllerOperacao.Create;
begin
  FDAO := TDAOOperacao.Create;
end;

destructor TControllerOperacao.Destroy;
begin
  SafeFree(FDAO);
end;

end.


