unit assemblerFilaProcessoAutomatico;

interface

uses
  dtoFilaProcessoAutomatico, modelFilaProcessoAutomatico, Contnrs,
  enumFilaProcessoAutomatico, FDLib01;

type
  TAssemblerFilaProcessoAutomatico = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOFilaProcessoAutomatico; var aModel: TModelFilaProcessoAutomatico);
      class procedure ModelToDTO(const aModel: TModelFilaProcessoAutomatico; var aDTO: TDTOFilaProcessoAutomatico);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerFilaProcessoAutomatico }

class procedure TAssemblerFilaProcessoAutomatico.DTOToModel(
  const aDTO: TDTOFilaProcessoAutomatico; var aModel: TModelFilaProcessoAutomatico);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodFilaProcessoAutomatico := aDTO.CodFilaProcessoAutomatico;
    aModel.CodCarteira := aDTO.CodCarteira;
    aModel.CodProtocoloOrdem := aDTO.CodProtocoloOrdem;
    aModel.DtaOrdemProcessamento := aDTO.DtaOrdemProcessamento;
    aModel.DtaCotaProcessamento := aDTO.DtaCotaProcessamento;
    aModel.StaSolicitacao := StaFilaProcessoAutomatico[aDTO.StaSolicitacao];
    aModel.CodLogProcessamento := aDTO.CodLogProcessamento;

  end;
end;

class procedure TAssemblerFilaProcessoAutomatico.ModelToDTO(
  const aModel: TModelFilaProcessoAutomatico; var aDTO: TDTOFilaProcessoAutomatico);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodFilaProcessoAutomatico := aModel.CodFilaProcessoAutomatico;
    aDTO.CodCarteira := aModel.CodCarteira;
    aDTO.CodProtocoloOrdem := aModel.CodProtocoloOrdem;
    aDTO.DtaOrdemProcessamento := aModel.DtaOrdemProcessamento;
    aDTO.DtaCotaProcessamento := aModel.DtaCotaProcessamento;
    aDTO.StaSolicitacao := LocateBySta(aModel.StaSolicitacao);
    aDTO.CodLogProcessamento := aModel.CodLogProcessamento;

  end;
end;

class procedure TAssemblerFilaProcessoAutomatico.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOFilaProcessoAutomatico;
  vModel: TModelFilaProcessoAutomatico;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelFilaProcessoAutomatico(aListModel[i]);
      vDTO := TDTOFilaProcessoAutomatico.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


