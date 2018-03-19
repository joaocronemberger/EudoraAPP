unit controllerProcessoAutomatico;

interface

uses
  Contnrs,
  Controls,
  SysUtils,
  FDLib01,
  mvcReferenceManipulator,
  daoProcessoAutomatico,
  dtoProcessoAutomatico,
  modelProcessoAutomatico,
  daoCota,
  assemblerProcessoAutomatico,
  daoCarteira,
  daoFilaProcessoAutomatico,
  dtoFilaProcessoAutomatico;

type
  TControllerProcessoAutomatico = class
  private
    FDAO: TDAOProcessoAutomatico;
    FDAOCota: TDAOCota;
    FDAOCarteira: TDAOCarteira;
  public
    constructor Create;
    destructor Destroy;

    procedure CompleteDTO(var aDTO: TDTOProcessoAutomatico; const aDTOFila: TDTOFilaProcessoAutomatico);
  end;

implementation

uses
  mvcTypes, modelCota, modelCarteira, Variants;

{ TControllerProcessoAutomatico }

procedure TControllerProcessoAutomatico.CompleteDTO(
  var aDTO: TDTOProcessoAutomatico; const aDTOFila: TDTOFilaProcessoAutomatico);
var
  vModelCota: TModelCota;
  vModelCarteira: TModelCarteira;
  vDataCota: TDate;
begin
  try
    aDTO.ValPatrimonio := 0; { Não utilizado... }

    if Assigned(aDTOFila) then
    begin
      aDTO.CodCarteira := aDTOFila.CodCarteira;
      aDTO.DtaProcesso := aDTOFila.DtaCotaProcessamento;
    end;

    vModelCarteira := FDAOCarteira.GetCarteira(aDTO.CodCarteira);
    if Assigned(vModelCarteira)
      then aDTO.TpoApurarCota := vModelCarteira.TpoApurarCota
      else aDTO.TpoApurarCota := 'A'; { Fundo de Fechamento = 'A' }

    vModelCota := FDAOCota.GetCotaDia(aDTO.CodCarteira, aDTO.DtaProcesso);
    if Assigned(vModelCota)
      then aDTO.Cota := vModelCota.ValCota
      else aDTO.Cota := 0;

    aDTO.StaUsaProcessoAutomatico := SNToBool(FDAO.GetUsaProcessoAutomatico(aDTO.CodCarteira));

  finally
    SafeFree(vModelCota);
    SafeFree(vModelCarteira);
  end;
end;

constructor TControllerProcessoAutomatico.Create;
begin
  FDAO := TDAOProcessoAutomatico.Create;
  FDAOCota := TDAOCota.Create;
  FDAOCarteira := TDAOCarteira.Create;
end;

destructor TControllerProcessoAutomatico.Destroy;
begin
  SafeFree(FDAO);
  SafeFree(FDAOCota);
  SafeFree(FDAOCarteira);
end;

end.


