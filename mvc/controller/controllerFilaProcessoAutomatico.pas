unit controllerFilaProcessoAutomatico;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoFilaProcessoAutomatico,  
  dtoFilaProcessoAutomatico,
  assemblerFilaProcessoAutomatico,
  modelFilaProcessoAutomatico,
  enumFilaProcessoAutomatico, daoCarteira, dtoCarteira;

type
  TControllerFilaProcessoAutomatico = class
  private
    FDAO: TDAOFilaProcessoAutomatico;
    FDAOCarteira: TDAOCarteira;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(var aDTO: TDTOFilaProcessoAutomatico);
    procedure AddInFila(const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
    procedure Delete(const aDTO: TDTOFilaProcessoAutomatico);

    function GetCarteiras(): TObjectList;
    function GetFilaProcesso(const aID: Integer): TDTOFilaProcessoAutomatico;
    function GetFilaProcessoByData(const aData: TDateTime): TObjectList;
  end;

implementation

uses
  mvcTypes, assemblerCarteira;

{ TControllerFilaProcessoAutomatico }

procedure TControllerFilaProcessoAutomatico.AddInFila(
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
begin
  FDAO.AddNewInList(aCodCarteira, aDtaProcesso);
end;

constructor TControllerFilaProcessoAutomatico.Create;
begin
  FDAO := TDAOFilaProcessoAutomatico.Create;
  FDAOCarteira := TDAOCarteira.Create;
end;

procedure TControllerFilaProcessoAutomatico.Delete(const aDTO: TDTOFilaProcessoAutomatico);
var
  vModel: TModelFilaProcessoAutomatico;
begin
  vModel := TModelFilaProcessoAutomatico.Create;
  try
    TAssemblerFilaProcessoAutomatico.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerFilaProcessoAutomatico.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOCarteira);
end;

function TControllerFilaProcessoAutomatico.GetCarteiras: TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCarteira.GetListaDeTodasCarteiras();
  try

    Result := TObjectList.Create(True);
    TAssemblerCarteira.ListModelToListDTO(vListModel, Result);

  finally
    vListModel.Free;
  end;

end;

function TControllerFilaProcessoAutomatico.GetFilaProcesso(
  const aID: Integer): TDTOFilaProcessoAutomatico;
var
  vModel: TModelFilaProcessoAutomatico;
begin
  Result := nil;

  vModel := FDAO.GetFila(aID);
  if Assigned(vModel) then
  try
    Result := TDTOFilaProcessoAutomatico.Create;

    TAssemblerFilaProcessoAutomatico.ModelToDTO(vModel, Result);
  finally
    SafeFree(vModel);
  end;

end;

function TControllerFilaProcessoAutomatico.GetFilaProcessoByData(
  const aData: TDateTime): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAO.GetFilaProcessoByData(aData);
  try

    Result := TObjectList.Create(True);
    TAssemblerFilaProcessoAutomatico.ListModelToListDTO(vListModel, Result);
    
  finally
    vListModel.Free;
  end;
end;

procedure TControllerFilaProcessoAutomatico.Save(var aDTO: TDTOFilaProcessoAutomatico);
var
  vModel: TModelFilaProcessoAutomatico;
begin
  vModel := TModelFilaProcessoAutomatico.Create;
  try
    TAssemblerFilaProcessoAutomatico.DTOToModel(aDTO, vModel);

    case aDTO.Status of
      sdtoInsert: FDAO.DoInsert(vModel);
      sdtoEdit: FDAO.DoUpdate(vModel);
      sdtoDelete: FDAO.DoDelete(vModel);
    end;

    TAssemblerFilaProcessoAutomatico.ModelToDTO(vModel, aDTO);
  finally
    SafeFree(vModel);
  end;
end;

end.


