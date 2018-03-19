unit controllerATDPedidos;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoATDPedidos,  
  dtoATDPedidos, 
  assemblerATDPedidos, 
  modelATDPedidos;

type
  TControllerATDPedidos = class
  private
    FDAO: TDAOATDPedidos;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTOATDPedidos);
    procedure Delete(const aDTO: TDTOATDPedidos);
  end;

implementation

uses
  mvcTypes;

{ TControllerATDPedidos }

constructor TControllerATDPedidos.Create;
begin
  FDAO := TDAOATDPedidos.Create;
end;

procedure TControllerATDPedidos.Delete(const aDTO: TDTOATDPedidos);
var
  vModel: TModelATDPedidos;
begin
  vModel := TModelATDPedidos.Create;
  try
    TAssemblerATDPedidos.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerATDPedidos.Destroy;
begin
  SafeFree(FDAO);
end;

procedure TControllerATDPedidos.Save(const aDTO: TDTOATDPedidos);
var
  vModel: TModelATDPedidos;
begin
  vModel := TModelATDPedidos.Create;
  try
    TAssemblerATDPedidos.DTOToModel(aDTO, vModel);

    case aDTO.Status of
      sdtoInsert: FDAO.DoInsert(vModel);
      sdtoEdit: FDAO.DoUpdate(vModel);
      sdtoDelete: FDAO.DoDelete(vModel);
    end;
      
  finally
    SafeFree(vModel);
  end;
end;

end.


