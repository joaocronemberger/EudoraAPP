unit assemblerConfigSistema;

interface

uses
  dtoConfigSistema, modelConfigSistema, Contnrs;

type
  TAssemblerConfigSistema = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOConfigSistema; var aModel: TModelConfigSistema);
      class procedure ModelToDTO(const aModel: TModelConfigSistema; var aDTO: TDTOConfigSistema);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerConfigSistema }

class procedure TAssemblerConfigSistema.DTOToModel(
  const aDTO: TDTOConfigSistema; var aModel: TModelConfigSistema);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.NomConfig := aDTO.NomConfig;
    aModel.ValConfig := aDTO.ValConfig;

  end;
end;

class procedure TAssemblerConfigSistema.ModelToDTO(
  const aModel: TModelConfigSistema; var aDTO: TDTOConfigSistema);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.NomConfig := aModel.NomConfig;
    aDTO.ValConfig := aModel.ValConfig;

  end;
end;

class procedure TAssemblerConfigSistema.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOConfigSistema;
  vModel: TModelConfigSistema;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelConfigSistema(aListModel[i]);
      vDTO := TDTOConfigSistema.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


