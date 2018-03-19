unit assemblerProcessoAutomatico;

interface

uses
  dtoProcessoAutomatico, modelProcessoAutomatico, Contnrs;

type
  TAssemblerProcessoAutomatico = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOProcessoAutomatico; var aModel: TModelProcessoAutomatico);
      class procedure ModelToDTO(const aModel: TModelProcessoAutomatico; var aDTO: TDTOProcessoAutomatico);
  end;

implementation

{ TAssemblerProcessoAutomatico }

class procedure TAssemblerProcessoAutomatico.DTOToModel(
  const aDTO: TDTOProcessoAutomatico; var aModel: TModelProcessoAutomatico);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodCarteira := aDTO.CodCarteira;
    aModel.DtaProcesso := aDTO.DtaProcesso;
    aModel.Cota := aDTO.Cota;
    aModel.ValPatrimonio := aDTO.ValPatrimonio;
  end;
end;

class procedure TAssemblerProcessoAutomatico.ModelToDTO(const aModel: TModelProcessoAutomatico;
  var aDTO: TDTOProcessoAutomatico);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodCarteira := aModel.CodCarteira;
    aDTO.DtaProcesso := aModel.DtaProcesso;
    aDTO.Cota := aModel.Cota;
    aDTO.ValPatrimonio := aModel.ValPatrimonio;
  end;
end;

end.


