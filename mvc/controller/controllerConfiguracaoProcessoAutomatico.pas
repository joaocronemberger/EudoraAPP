unit controllerConfiguracaoProcessoAutomatico;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoConfiguracaoProcessoAutomatico,  
  dtoConfiguracaoProcessoAutomatico, 
  assemblerConfiguracaoProcessoAutomatico, 
  modelConfiguracaoProcessoAutomatico;

type
  TControllerConfiguracaoProcessoAutomatico = class
  private
    FDAO: TDAOConfiguracaoProcessoAutomatico;
  public
    constructor Create;
    destructor Destroy;

    function GetConfiguracaoProcessoAutomatico(): TDTOConfiguracaoProcessoAutomatico;

    procedure Save(const aDTO: TDTOConfiguracaoProcessoAutomatico);
    procedure Delete(const aDTO: TDTOConfiguracaoProcessoAutomatico);
  end;

implementation

uses
  mvcTypes;

{ TControllerConfiguracaoProcessoAutomatico }

constructor TControllerConfiguracaoProcessoAutomatico.Create;
begin
  FDAO := TDAOConfiguracaoProcessoAutomatico.Create;
end;

procedure TControllerConfiguracaoProcessoAutomatico.Delete(const aDTO: TDTOConfiguracaoProcessoAutomatico);
var
  vModel: TModelConfiguracaoProcessoAutomatico;
begin
  vModel := TModelConfiguracaoProcessoAutomatico.Create;
  try
    TAssemblerConfiguracaoProcessoAutomatico.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerConfiguracaoProcessoAutomatico.Destroy;
begin
  SafeFree(FDAO);
end;

function TControllerConfiguracaoProcessoAutomatico.GetConfiguracaoProcessoAutomatico: TDTOConfiguracaoProcessoAutomatico;
var
  vModel: TModelConfiguracaoProcessoAutomatico;
begin
  Result := nil;
  vModel := FDAO.GetConfiguracaoProcessoAutomatico();
  if Assigned(vModel) then
  try
    Result := TDTOConfiguracaoProcessoAutomatico.Create;
    TAssemblerConfiguracaoProcessoAutomatico.ModelToDTO(vModel,Result);
  finally
    SafeFree(vModel);
  end;
end;

procedure TControllerConfiguracaoProcessoAutomatico.Save(const aDTO: TDTOConfiguracaoProcessoAutomatico);
var
  vModel: TModelConfiguracaoProcessoAutomatico;
begin
  vModel := TModelConfiguracaoProcessoAutomatico.Create;
  try
    TAssemblerConfiguracaoProcessoAutomatico.DTOToModel(aDTO, vModel);

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


