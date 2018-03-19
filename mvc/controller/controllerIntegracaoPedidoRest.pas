unit controllerIntegracaoPedidoRest;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoIntegracaoPedidoRest,  
  dtoIntegracaoPedidoRest, 
  assemblerIntegracaoPedidoRest, 
  modelIntegracaoPedidoRest;

type
  TControllerIntegracaoPedidoRest = class
  private
    FDAO: TDAOIntegracaoPedidoRest;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTOIntegracaoPedidoRest);
    procedure Delete(const aDTO: TDTOIntegracaoPedidoRest);

    function GetListaPendentes(): TObjectList;
  end;

implementation

uses
  mvcTypes;

{ TControllerIntegracaoPedidoRest }

constructor TControllerIntegracaoPedidoRest.Create;
begin
  FDAO := TDAOIntegracaoPedidoRest.Create;
end;

procedure TControllerIntegracaoPedidoRest.Delete(const aDTO: TDTOIntegracaoPedidoRest);
var
  vModel: TModelIntegracaoPedidoRest;
begin
  vModel := TModelIntegracaoPedidoRest.Create;
  try
    TAssemblerIntegracaoPedidoRest.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerIntegracaoPedidoRest.Destroy;
begin
  SafeFree(FDAO);
end;

function TControllerIntegracaoPedidoRest.GetListaPendentes: TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAO.GetListaPendentes();
  try

    Result := TObjectList.Create(True);
    TAssemblerIntegracaoPedidoRest.ListModelToListDTO(vListModel, Result);

  finally
    vListModel.Free;
  end;
end;

procedure TControllerIntegracaoPedidoRest.Save(const aDTO: TDTOIntegracaoPedidoRest);
var
  vModel: TModelIntegracaoPedidoRest;
begin
  vModel := TModelIntegracaoPedidoRest.Create;
  try
    TAssemblerIntegracaoPedidoRest.DTOToModel(aDTO, vModel);
    FDAO.DoInsertIfNotExists(vModel);
  finally
    SafeFree(vModel);
  end;
end;

end.


