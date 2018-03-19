unit controllerEspecificacaoOperacao;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoEspecificacaoOperacao,  
  dtoEspecificacaoOperacao, 
  assemblerEspecificacaoOperacao, 
  modelEspecificacaoOperacao;

type
  TControllerEspecificacaoOperacao = class
  private
    FDAO: TDAOEspecificacaoOperacao;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTOEspecificacaoOperacao);
    procedure Delete(const aDTO: TDTOEspecificacaoOperacao);
  end;

implementation

uses
  mvcTypes;

{ TControllerEspecificacaoOperacao }

constructor TControllerEspecificacaoOperacao.Create;
begin
  FDAO := TDAOEspecificacaoOperacao.Create;
end;

procedure TControllerEspecificacaoOperacao.Delete(const aDTO: TDTOEspecificacaoOperacao);
var
  vModel: TModelEspecificacaoOperacao;
begin
  vModel := TModelEspecificacaoOperacao.Create;
  try
    TAssemblerEspecificacaoOperacao.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerEspecificacaoOperacao.Destroy;
begin
  SafeFree(FDAO);
end;

procedure TControllerEspecificacaoOperacao.Save(const aDTO: TDTOEspecificacaoOperacao);
var
  vModel: TModelEspecificacaoOperacao;
begin
  vModel := TModelEspecificacaoOperacao.Create;
  try
    TAssemblerEspecificacaoOperacao.DTOToModel(aDTO, vModel);

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


