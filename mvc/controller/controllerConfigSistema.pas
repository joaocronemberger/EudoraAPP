unit controllerConfigSistema;

interface

uses
  Contnrs,
  SysUtils, 
  mvcReferenceManipulator, 
  daoConfigSistema,  
  dtoConfigSistema, 
  assemblerConfigSistema, 
  modelConfigSistema, enumConfigSistema;

type
  TControllerConfigSistema = class
  private
    FDAO: TDAOConfigSistema;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTOConfigSistema);
    procedure Delete(const aDTO: TDTOConfigSistema);

    function GetConfiguracao(const aEnumConfig: TTpoConfigSistema): TDTOConfigSistema;
    function GetValorConfiguracao(const aEnumConfig: TTpoConfigSistema): String;
    procedure SetValorConfiguracao(const aEnumConfig: TTpoConfigSistema; const aValue: String);

    function ExisteSistemaCFF: Boolean;
  end;

implementation

uses
  mvcTypes;

{ TControllerConfigSistema }

constructor TControllerConfigSistema.Create;
begin
  FDAO := TDAOConfigSistema.Create;
end;

procedure TControllerConfigSistema.Delete(const aDTO: TDTOConfigSistema);
var
  vModel: TModelConfigSistema;
begin
  vModel := TModelConfigSistema.Create;
  try
    TAssemblerConfigSistema.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerConfigSistema.Destroy;
begin
  SafeFree(FDAO);
end;

function TControllerConfigSistema.ExisteSistemaCFF: Boolean;
begin
  Result := FDAO.GetTemaSistema('CFF') > 0;
end;

function TControllerConfigSistema.GetConfiguracao(
  const aEnumConfig: TTpoConfigSistema): TDTOConfigSistema;
var
  vModel: TModelConfigSistema;
begin
  Result := TDTOConfigSistema.Create;
  vModel := FDAO.GetConfiguracao(aEnumConfig);
  try
    TAssemblerConfigSistema.ModelToDTO(vModel, Result);
  finally
    SafeFree(vModel);
  end;
end;

function TControllerConfigSistema.GetValorConfiguracao(
  const aEnumConfig: TTpoConfigSistema): String;
var
  vModel: TModelConfigSistema;
begin
  Result := EmptyStr;
  vModel := FDAO.GetConfiguracao(aEnumConfig);
  if Assigned(vModel) then
    Result := vModel.ValConfig;
end;

procedure TControllerConfigSistema.Save(const aDTO: TDTOConfigSistema);
var
  vModel: TModelConfigSistema;
begin
  vModel := TModelConfigSistema.Create;
  try
    TAssemblerConfigSistema.DTOToModel(aDTO, vModel);

    case aDTO.Status of
      sdtoInsert: FDAO.DoInsert(vModel);
      sdtoEdit: FDAO.DoUpdate(vModel);
      sdtoDelete: FDAO.DoDelete(vModel);
    end;
      
  finally
    SafeFree(vModel);
  end;
end;

procedure TControllerConfigSistema.SetValorConfiguracao(
  const aEnumConfig: TTpoConfigSistema; const aValue: String);
var
  vModel: TModelConfigSistema;
begin
  vModel := FDAO.GetConfiguracao(aEnumConfig);
  try
    if Assigned(vModel) then
    begin
       vModel.ValConfig := aValue;
       FDAO.DoUpdate(vModel);
    end
    else
    begin
       vModel := TModelConfigSistema.Create;
       vModel.NomConfig := TpoConfigSistema[aEnumConfig];
       vModel.ValConfig := aValue;
       FDAO.DoInsert(vModel);
    end;
  finally
    SafeFree(vModel);
  end;
end;

end.


