unit controllerPainelMonitoramento;

interface

uses
  Contnrs,
  Forms, 
  mvcReferenceManipulator, 
  daoPainelMonitoramento,
  DBTables,
  DBClient,
  Provider,
  FDLib01,
  daoLogProcessamento,
  modelProcessamentoCota,
  daoProcessamentoCota;

type
  TControllerPainelMonitoramento = class
  private
    FDAO: TDAOPainelMonitoramento;
    FDAOLogProcessamento: TDAOLogProcessamento;
    FDAOProcessamentoCota: TDAOProcessamentoCota;
  public
    constructor Create;
    destructor Destroy;

    procedure GetPainelMonitoramento(const aDtaPainel: TDateTime; var aCds: TClientDataSet);
    function GetLogsByCarteiraDataCalculo(const aCodCarteira: Integer; const aDtaCalculo: TDateTime): TObjectList;

    procedure UpdateStaUsaProcessoAutomatico(const aCodCarteira: Integer; const aOnOff: Boolean);

  end;

implementation

uses
  mvcTypes, DB, assemblerLogProcessamento, SysUtils,
  InstantDBX, InstantPersistence, TEUTemaObject, TEULogAtividade,
  Variants, FDUConstantes;

{ TControllerPainelMonitoramento }

constructor TControllerPainelMonitoramento.Create;
begin
  FDAO := TDAOPainelMonitoramento.Create;
  FDAOLogProcessamento := TDAOLogProcessamento.Create;
  FDAOProcessamentoCota := TDAOProcessamentoCota.Create;
end;

destructor TControllerPainelMonitoramento.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOLogProcessamento);
  SafeFree(FDAOProcessamentoCota);
end;

function TControllerPainelMonitoramento.GetLogsByCarteiraDataCalculo(
  const aCodCarteira: Integer; const aDtaCalculo: TDateTime): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOLogProcessamento.GetLogsByCarteiraDataCalculo(aCodCarteira, aDtaCalculo);
  try

    Result := TObjectList.Create(True);
    TAssemblerLogProcessamento.ListModelToListDTO(vListModel, Result);
    
  finally
    vListModel.Free;
  end;
end;

procedure TControllerPainelMonitoramento.GetPainelMonitoramento(const aDtaPainel: TDateTime; var aCds: TClientDataSet);
var
  i: Integer;
  vDsp: TDataSetProvider;
  vCds: TClientDataSet;
begin

  vDsp := TDataSetProvider.Create(Application);
  vCds := TClientDataSet.Create(Application);

  aCds.DisableControls;
  try
    vDsp.DataSet := FDAO.GetPainelMonitoramento(aDtaPainel);
    vDsp.Name := 'vDsp';
    vCds.SetProvider(vDsp);
    vCds.Open;

    aCds.XMLData := vCds.XMLData;
    
  finally
    SafeFree(vDsp);
    SafeFree(vCds);
    aCds.EnableControls;
  end;

end;

procedure TControllerPainelMonitoramento.UpdateStaUsaProcessoAutomatico(
  const aCodCarteira: Integer; const aOnOff: Boolean);
var
  vModel: TModelProcessamentoCota;

  procedure SaveTemaLogAtividade();
  var
    vMsg: String;
    vArray: Array of Variant;
  begin
    SetLength(vArray,0); // <- Null

    if aOnOff
      then vMsg := 'Carteira ATIVADA para processamento automático.'
      else vMsg := 'Carteira DESATIVADA para processamento automático.';

    TEULogAtividade.RegistrarLogAtividade(
      TInstantDBXConnector(InstantDefaultConnector).Connection,
      'FDO',
      FDUConstantes.LogConfigProcessAutomatico,
      P_iSeqUsuario,
      aCodCarteira,
      vArray, // <- Null
      vArray, // <- Null
      vMsg );
  end;

begin
  vModel := FDAOProcessamentoCota.GetProcessamentoCota(aCodCarteira);
  if Assigned(vModel) then
  try
    vModel.StaUsaProcessoAutomatico := BoolToSN(aOnOff);
    FDAOProcessamentoCota.DoUpdate(vModel);
    SaveTemaLogAtividade;
  finally
    SafeFree(vModel);  
  end;
end;

end.


