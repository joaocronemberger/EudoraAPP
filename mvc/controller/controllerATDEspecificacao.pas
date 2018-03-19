unit controllerATDEspecificacao;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoATDEspecificacao,  
  dtoATDEspecificacao, 
  assemblerATDEspecificacao, 
  modelATDEspecificacao;

type
  TControllerATDEspecificacao = class
  private
    FDAO: TDAOATDEspecificacao;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTOATDEspecificacao);
    procedure Delete(const aDTO: TDTOATDEspecificacao);
  end;

implementation

uses
  mvcTypes;

{ TControllerATDEspecificacao }

constructor TControllerATDEspecificacao.Create;
begin
  FDAO := TDAOATDEspecificacao.Create;
end;

procedure TControllerATDEspecificacao.Delete(const aDTO: TDTOATDEspecificacao);
var
  vModel: TModelATDEspecificacao;
begin
  vModel := TModelATDEspecificacao.Create;
  try
    TAssemblerATDEspecificacao.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerATDEspecificacao.Destroy;
begin
  SafeFree(FDAO);
end;

procedure TControllerATDEspecificacao.Save(const aDTO: TDTOATDEspecificacao);
var
  vModel: TModelATDEspecificacao;
begin
  vModel := TModelATDEspecificacao.Create;
  try
    TAssemblerATDEspecificacao.DTOToModel(aDTO, vModel);

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


