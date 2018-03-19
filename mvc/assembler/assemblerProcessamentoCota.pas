unit assemblerProcessamentoCota;

interface

uses
  dtoProcessamentoCota, modelProcessamentoCota, Contnrs;

type
  TAssemblerProcessamentoCota = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOProcessamentoCota; var aModel: TModelProcessamentoCota);
      class procedure ModelToDTO(const aModel: TModelProcessamentoCota; var aDTO: TDTOProcessamentoCota);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerProcessamentoCota }

class procedure TAssemblerProcessamentoCota.DTOToModel(
  const aDTO: TDTOProcessamentoCota; var aModel: TModelProcessamentoCota);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodCarteira := aDTO.CodCarteira;
    aModel.DtaUltProcessamento := aDTO.DtaUltProcessamento;
    aModel.StaCotaProcessada := aDTO.StaCotaProcessada;
    aModel.NomUsuario := aDTO.NomUsuario;
    aModel.StaIntegPortal := aDTO.StaIntegPortal;
    aModel.StaProcessando := aDTO.StaProcessando;
    aModel.StaUsaProcessoAutomatico := aDTO.StaUsaProcessoAutomatico;

  end;
end;

class procedure TAssemblerProcessamentoCota.ModelToDTO(
  const aModel: TModelProcessamentoCota; var aDTO: TDTOProcessamentoCota);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodCarteira := aModel.CodCarteira;
    aDTO.DtaUltProcessamento := aModel.DtaUltProcessamento;
    aDTO.StaCotaProcessada := aModel.StaCotaProcessada;
    aDTO.NomUsuario := aModel.NomUsuario;
    aDTO.StaIntegPortal := aModel.StaIntegPortal;
    aDTO.StaProcessando := aModel.StaProcessando;
    aDTO.StaUsaProcessoAutomatico := aModel.StaUsaProcessoAutomatico;

  end;
end;

class procedure TAssemblerProcessamentoCota.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOProcessamentoCota;
  vModel: TModelProcessamentoCota;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelProcessamentoCota(aListModel[i]);
      vDTO := TDTOProcessamentoCota.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


