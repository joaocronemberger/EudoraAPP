unit controllerProcessamentoCota;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoProcessamentoCota,  
  dtoProcessamentoCota, 
  assemblerProcessamentoCota, 
  modelProcessamentoCota;

type
  TControllerProcessamentoCota = class
  private
    FDAO: TDAOProcessamentoCota;
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTOProcessamentoCota);
    procedure Delete(const aDTO: TDTOProcessamentoCota);

    function GetProcessamentoCotaByCarteira(const aCodCarteira: Integer): TDTOProcessamentoCota;
  end;

implementation

uses
  mvcTypes;

{ TControllerProcessamentoCota }

constructor TControllerProcessamentoCota.Create;
begin
  FDAO := TDAOProcessamentoCota.Create;
end;

procedure TControllerProcessamentoCota.Delete(const aDTO: TDTOProcessamentoCota);
var
  vModel: TModelProcessamentoCota;
begin
  vModel := TModelProcessamentoCota.Create;
  try
    TAssemblerProcessamentoCota.DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TControllerProcessamentoCota.Destroy;
begin
  SafeFree(FDAO);
end;

function TControllerProcessamentoCota.GetProcessamentoCotaByCarteira(
  const aCodCarteira: Integer): TDTOProcessamentoCota;
var
  vModel: TModelProcessamentoCota;
begin
  Result := nil;

  vModel := FDAO.GetProcessamentoCota(aCodCarteira);
  if Assigned(vModel) then
  try
    Result := TDTOProcessamentoCota.Create;
    TAssemblerProcessamentoCota.ModelToDTO(vModel,Result);
  finally
    SafeFree(vModel);
  end;
end;

procedure TControllerProcessamentoCota.Save(const aDTO: TDTOProcessamentoCota);
var
  vModel: TModelProcessamentoCota;
begin
  vModel := TModelProcessamentoCota.Create;
  try
    TAssemblerProcessamentoCota.DTOToModel(aDTO, vModel);

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


