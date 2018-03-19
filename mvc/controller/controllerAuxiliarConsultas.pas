unit controllerAuxiliarConsultas;

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  daoCliente,
  dtoCliente,
  assemblerCliente,
  modelCliente,
  daoCarteira,
  modelCarteira,
  dtoCarteira,
  assemblerCarteira;

type
  TControllerAuxiliarConsulta = class
  private
    FDAOCliente: TDAOCliente;
    FDAOCarteira: TDAOCarteira;
  public
    constructor Create;
    destructor Destroy;

    function GetCotista(const aValue: String; const aWhere: String = ''): TObjectList;
    function GetCarteira(const aValue: String; const aWhere: String = ''): TObjectList;
    function GetAdministrador(const aValue: String; const aWhere: String = ''): TObjectList;
    function GetGestor(const aValue: String; const aWhere: String = ''): TObjectList;
  end;

implementation

uses
  mvcTypes, Variants, SysUtils;

{ TControllerAuxiliarConsulta }

constructor TControllerAuxiliarConsulta.Create;
begin
  FDAOCliente := TDAOCliente.Create;
  FDAOCarteira := TDAOCarteira.Create;
end;

destructor TControllerAuxiliarConsulta.Destroy;
begin
  SafeFree(FDAOCliente);
  SafeFree(FDAOCarteira);
end;

function TControllerAuxiliarConsulta.GetAdministrador(
  const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCliente.GetAdministradorByValue(aValue, aWhere);
  try

    Result := TObjectList.Create(True);
    TAssemblerCliente.ListModelToListDTO(vListModel, Result);

  finally
    SafeFree( vListModel );
  end;
end;

function TControllerAuxiliarConsulta.GetCarteira(
  const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCarteira.GetCarteiraByValue(aValue, aWhere);
  try

    Result := TObjectList.Create(True);
    TAssemblerCarteira.ListModelToListDTO(vListModel, Result);
    
  finally
    SafeFree( vListModel );
  end;
end;

function TControllerAuxiliarConsulta.GetCotista(
  const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCliente.GetCotistaByValue(aValue, aWhere);
  try

    Result := TObjectList.Create(True);
    TAssemblerCliente.ListModelToListDTO(vListModel, Result);

  finally
    SafeFree( vListModel );
  end;
end;

function TControllerAuxiliarConsulta.GetGestor(
  const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCliente.GetGestorByValue(aValue, aWhere);
  try

    Result := TObjectList.Create(True);
    TAssemblerCliente.ListModelToListDTO(vListModel, Result);

  finally
    SafeFree( vListModel );
  end;
end;

end.


