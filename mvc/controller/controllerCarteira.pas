unit controllerCarteira;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoCarteira,  
  dtoCarteira, 
  assemblerCarteira, 
  modelCarteira, daoConfigSistema;

type
  TControllerCarteira = class
  private
    FDAO: TDAOCarteira;
    FDAOConfig: TDAOConfigSistema;
  public
    constructor Create;
    destructor Destroy;

    function ExisteSistemaRTW(): Boolean;
    function GetCarteira(const aCodCarteira: Integer): TDTOCarteira;
  end;

implementation

uses
  mvcTypes, Variants, SysUtils;

{ TControllerCarteira }

constructor TControllerCarteira.Create;
begin
  FDAO := TDAOCarteira.Create;
  FDAOConfig := TDAOConfigSistema.Create;
end;

destructor TControllerCarteira.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOConfig);
end;

function TControllerCarteira.ExisteSistemaRTW: Boolean;
begin
  Result := FDAOConfig.GetTemaSistema('RTW') > 0;
end;

function TControllerCarteira.GetCarteira(
  const aCodCarteira: Integer): TDTOCarteira;
var
  vModel: TModelCarteira;
begin
  Result := TDTOCarteira.Create;
  vModel := FDAO.GetCarteira(aCodCarteira);
  try
    TAssemblerCarteira.ModelToDTO(vModel,Result);
  finally                                    
    SafeFree(vModel);
  end;
end;

end.


