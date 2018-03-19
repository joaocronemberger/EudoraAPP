unit controllerAmortizacao;

interface

uses
  daoAmortizacao, mvcReferenceManipulator, Contnrs, assemblerCarteira,
  dtoAmortizacao, dtoCarteira, modelCarteira, assemblerAmortizacao,
  modelAmortizacao, daoCarteira, daoCota, modelCota;

type
  TControllerAmortizacao = class
  private
    FDAO: TDAOAmortizacao;
    FDAOCarteira: TDAOCarteira;
    FDAOCota: TDAOCota;
  public
    constructor Create;
    destructor Destroy;

    function GetListaDeCarteiras(const aDataProcesso: TDateTime): TObjectList;
    function GetAmortizacaoByDataCarteira(const aDataProcesso: TDateTime; const aCodCarteira: Integer): TDTOAmortizacao;
    function GetCotaDia(const aDataProcesso: TDateTime; const aCodCarteira: Integer): Double;

    procedure Save(const aDTO: TDTOAmortizacao);
    procedure Delete(const aDTO: TDTOAmortizacao);
  end;

implementation

uses
  mvcTypes;

{ TControllerAmortizacao }

constructor TControllerAmortizacao.Create;
begin
  FDAO := TDAOAmortizacao.Create;
  FDAOCarteira := TDAOCarteira.Create;
  FDAOCota := TDAOCota.Create;
end;

procedure TControllerAmortizacao.Delete(const aDTO: TDTOAmortizacao);
var
  vModel: TModelAmortizacao;
begin
  vModel := TModelAmortizacao.Create;
  try
    aDTO.Status := sdtoDelete;
    TAssemblerAmortizacao.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerAmortizacao.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOCarteira);
  SafeFree(FDAOCota);
end;

function TControllerAmortizacao.GetAmortizacaoByDataCarteira(
  const aDataProcesso: TDateTime;
  const aCodCarteira: Integer): TDTOAmortizacao;
var
  vModel: TModelAmortizacao;
begin
  Result := TDTOAmortizacao.Create;
  vModel := FDAO.GetAmortizacaoByDataCarteira(aDataProcesso, aCodCarteira);
  try
    TAssemblerAmortizacao.ModelToDTO(vModel,Result);
  finally
    SafeFree(vModel);
  end;
end;

function TControllerAmortizacao.GetCotaDia(const aDataProcesso: TDateTime;
  const aCodCarteira: Integer): Double;
var
  vModel: TModelCota;
begin
  Result := 0;
  vModel := FDAOCota.GetCotaDia(aCodCarteira, aDataProcesso);
  try
    if Assigned(vModel) then
      Result := vModel.ValCota;
  finally
    SafeFree(vModel);
  end;
end;

function TControllerAmortizacao.GetListaDeCarteiras(
  const aDataProcesso: TDateTime): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCarteira.GetListaDeCarteiras(aDataProcesso);
  try

    Result := TObjectList.Create(True);
    TAssemblerCarteira.ListModelToListDTO(vListModel, Result);
    
  finally
    vListModel.Free;
  end;
  
end;

procedure TControllerAmortizacao.Save(const aDTO: TDTOAmortizacao);
var
  vModel: TModelAmortizacao;
begin
  vModel := TModelAmortizacao.Create;
  try
    TAssemblerAmortizacao.DTOToModel(aDTO, vModel);

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


