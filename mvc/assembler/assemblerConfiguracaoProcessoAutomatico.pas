unit assemblerConfiguracaoProcessoAutomatico;

interface

uses
  dtoConfiguracaoProcessoAutomatico, modelConfiguracaoProcessoAutomatico, Contnrs, FDLib01;

type
  TAssemblerConfiguracaoProcessoAutomatico = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOConfiguracaoProcessoAutomatico; var aModel: TModelConfiguracaoProcessoAutomatico);
      class procedure ModelToDTO(const aModel: TModelConfiguracaoProcessoAutomatico; var aDTO: TDTOConfiguracaoProcessoAutomatico);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerConfiguracaoProcessoAutomatico }

class procedure TAssemblerConfiguracaoProcessoAutomatico.DTOToModel(
  const aDTO: TDTOConfiguracaoProcessoAutomatico; var aModel: TModelConfiguracaoProcessoAutomatico);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.StaProcessoAutomatico := BoolToSN(aDTO.StaProcessoAutomatico);
    aModel.IntervaloProcessamento := aDTO.IntervaloProcessamento;
    aModel.PeriodoExecucao := aDTO.PeriodoExecucao;
    aModel.StaServicoAtivado := BoolToSN(aDTO.StaServicoAtivado);

  end;
end;

class procedure TAssemblerConfiguracaoProcessoAutomatico.ModelToDTO(
  const aModel: TModelConfiguracaoProcessoAutomatico; var aDTO: TDTOConfiguracaoProcessoAutomatico);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.StaProcessoAutomatico := SNToBool(aModel.StaProcessoAutomatico);
    aDTO.IntervaloProcessamento := aModel.IntervaloProcessamento;
    aDTO.PeriodoExecucao := aModel.PeriodoExecucao;
    aDTO.StaServicoAtivado := SNToBool(aModel.StaServicoAtivado);
  end;
end;

class procedure TAssemblerConfiguracaoProcessoAutomatico.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOConfiguracaoProcessoAutomatico;
  vModel: TModelConfiguracaoProcessoAutomatico;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelConfiguracaoProcessoAutomatico(aListModel[i]);
      vDTO := TDTOConfiguracaoProcessoAutomatico.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


