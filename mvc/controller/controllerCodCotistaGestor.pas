unit controllerCodCotistaGestor;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoCodCotistaGestor,  
  dtoCodCotistaGestor, 
  assemblerCodCotistaGestor, 
  modelCodCotistaGestor, daoCliente;

type
  TControllerCodCotistaGestor = class
  private
    FDAO: TDAOCodCotistaGestor;
    FDAOCliente: TDAOCliente;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aCodCotista: Integer; const aListDTO: TObjectList);

    function GetListaCodigoByCotista(const aCodCotista: Integer): TObjectList;
    function GetListaGestor(): TObjectList;
    function GetListaAdministrador(): TObjectList;
  end;

implementation

uses
  mvcTypes, assemblerCliente;

{ TControllerCodCotistaGestor }

constructor TControllerCodCotistaGestor.Create;
begin
  FDAO := TDAOCodCotistaGestor.Create;
  FDAOCliente := TDAOCliente.Create;
end;

destructor TControllerCodCotistaGestor.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOCliente);
end;

function TControllerCodCotistaGestor.GetListaAdministrador: TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCliente.GetAllAdministradores();
  try

    Result := TObjectList.Create(True);
    TAssemblerCliente.ListModelToListDTO(vListModel, Result);

  finally
    vListModel.Free;
  end;
end;

function TControllerCodCotistaGestor.GetListaCodigoByCotista(
  const aCodCotista: Integer): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAO.GetListaCodigoByCotista( aCodCotista );
  try

    Result := TObjectList.Create(True);
    TAssemblerCodCotistaGestor.ListModelToListDTO(vListModel, Result);

  finally
    vListModel.Free;
  end;
end;

function TControllerCodCotistaGestor.GetListaGestor: TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCliente.GetAllGestores();
  try

    Result := TObjectList.Create(True);
    TAssemblerCliente.ListModelToListDTO(vListModel, Result);

  finally
    vListModel.Free;
  end;
end;

procedure TControllerCodCotistaGestor.Save(const aCodCotista: Integer; const aListDTO: TObjectList);
var
  vModel: TModelCodCotistaGestor;
  vDTO: TDTOCodCotistaGestor;
  i: integer;
begin

  for i := 0 to pred(aListDTO.Count) do
  begin

    vDTO := TDTOCodCotistaGestor(aListDTO[i]);
    vDTO.CodCotista := aCodCotista;

    vModel := TModelCodCotistaGestor.Create;
    try
      TAssemblerCodCotistaGestor.DTOToModel(vDTO, vModel);

      case vDTO.Status of
        sdtoInsert: FDAO.DoInsert(vModel);
        sdtoEdit: FDAO.DoUpdate(vModel);
        sdtoDelete: FDAO.DoDelete(vModel);
      end;

    finally
      SafeFree( vModel );
    end;
  end;
  
end;

end.


