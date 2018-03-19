unit controllerLogProcessamento;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoLogProcessamento,  
  dtoLogProcessamento, 
  assemblerLogProcessamento, 
  modelLogProcessamento, daoCarteira;

type
  TControllerLogProcessamento = class
  private
    FDAO: TDAOLogProcessamento;
    FDAOCarteira: TDAOCarteira;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(var aDTO: TDTOLogProcessamento);
    procedure Delete(const aDTO: TDTOLogProcessamento);

    function GetListaDeCarteiras(): TObjectList;
    
  end;

implementation

uses
  mvcTypes, assemblerCarteira;

{ TControllerLogProcessamento }

constructor TControllerLogProcessamento.Create;
begin
  FDAO := TDAOLogProcessamento.Create;
  FDAOCarteira := TDAOCarteira.Create;
end;

procedure TControllerLogProcessamento.Delete(const aDTO: TDTOLogProcessamento);
var
  vModel: TModelLogProcessamento;
begin
  vModel := TModelLogProcessamento.Create;
  try
    TAssemblerLogProcessamento.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerLogProcessamento.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOCarteira);
end;

function TControllerLogProcessamento.GetListaDeCarteiras: TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCarteira.GetListaDeTodasCarteiras();
  try
    Result := TObjectList.Create(True);
    TAssemblerCarteira.ListModelToListDTO(vListModel, Result);
  finally
    vListModel.Clear;
    SafeFree(vListModel);
  end;
end;

procedure TControllerLogProcessamento.Save(var aDTO: TDTOLogProcessamento);
var
  vModel: TModelLogProcessamento;
begin
  if (aDTO.CodCarteira > 0) then
  begin
    vModel := TModelLogProcessamento.Create;
    try
      TAssemblerLogProcessamento.DTOToModel(aDTO, vModel);

      case aDTO.Status of
        sdtoInsert: FDAO.DoInsert(vModel);
        sdtoEdit: FDAO.DoUpdate(vModel);
        sdtoDelete: FDAO.DoDelete(vModel);
      end;

      TAssemblerLogProcessamento.ModelToDTO(vModel, aDTO);
      
    finally
      SafeFree(vModel);
    end;
  end;
end;

end.


