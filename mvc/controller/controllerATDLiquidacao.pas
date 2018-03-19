unit controllerATDLiquidacao;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoATDLiquidacao,  
  dtoATDLiquidacao, 
  assemblerATDLiquidacao, 
  modelATDLiquidacao;

type
  TControllerATDLiquidacao = class
  private
    FDAO: TDAOATDLiquidacao;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTOATDLiquidacao);
    procedure Delete(const aDTO: TDTOATDLiquidacao);
  end;

implementation

uses
  mvcTypes;

{ TControllerATDLiquidacao }

constructor TControllerATDLiquidacao.Create;
begin
  FDAO := TDAOATDLiquidacao.Create;
end;

procedure TControllerATDLiquidacao.Delete(const aDTO: TDTOATDLiquidacao);
var
  vModel: TModelATDLiquidacao;
begin
  vModel := TModelATDLiquidacao.Create;
  try
    TAssemblerATDLiquidacao.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerATDLiquidacao.Destroy;
begin
  SafeFree(FDAO);
end;

procedure TControllerATDLiquidacao.Save(const aDTO: TDTOATDLiquidacao);
var
  vModel: TModelATDLiquidacao;
begin
  vModel := TModelATDLiquidacao.Create;
  try
    TAssemblerATDLiquidacao.DTOToModel(aDTO, vModel);

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


