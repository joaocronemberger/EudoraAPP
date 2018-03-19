unit assemblerCodCotistaGestor;

interface

uses
  dtoCodCotistaGestor, modelCodCotistaGestor, Contnrs;

type
  TAssemblerCodCotistaGestor = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOCodCotistaGestor; var aModel: TModelCodCotistaGestor);
      class procedure ModelToDTO(const aModel: TModelCodCotistaGestor; var aDTO: TDTOCodCotistaGestor);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerCodCotistaGestor }

class procedure TAssemblerCodCotistaGestor.DTOToModel(
  const aDTO: TDTOCodCotistaGestor; var aModel: TModelCodCotistaGestor);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodCotista := aDTO.CodCotista;
    aModel.CodGestor := aDTO.CodGestor;
    aModel.CodCotistaGestor := aDTO.CodCotistaGestor;
    aModel.CodAdministrador := aDTO.CodAdministrador;

  end;
end;

class procedure TAssemblerCodCotistaGestor.ModelToDTO(
  const aModel: TModelCodCotistaGestor; var aDTO: TDTOCodCotistaGestor);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodCotista := aModel.CodCotista;
    aDTO.CodGestor := aModel.CodGestor;
    aDTO.CodCotistaGestor := aModel.CodCotistaGestor;
    aDTO.CodAdministrador := aModel.CodAdministrador;

  end;
end;

class procedure TAssemblerCodCotistaGestor.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOCodCotistaGestor;
  vModel: TModelCodCotistaGestor;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelCodCotistaGestor(aListModel[i]);
      vDTO := TDTOCodCotistaGestor.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


