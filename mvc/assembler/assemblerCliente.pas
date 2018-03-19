unit assemblerCliente;

interface

uses
  dtoCliente, modelCliente, Contnrs;

type
  TAssemblerCliente = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOCliente; var aModel: TModelCliente);
      class procedure ModelToDTO(const aModel: TModelCliente; var aDTO: TDTOCliente);
      class procedure DTOToDTO(const aDTOOrigem: TDTOCliente; var aDTO: TDTOCliente);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; aListDTO: TObjectList);
      class procedure ListDTOToListDTO(const aListDTOOrigem: TObjectList; aListDTO: TObjectList);
  end;

implementation

uses dtoBase;

{ TAssemblerCliente }

class procedure TAssemblerCliente.DTOToModel(
  const aDTO: TDTOCliente; var aModel: TModelCliente);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodCliente := aDTO.CodCliente;
    aModel.NomCliente := aDTO.NomCliente;
    aModel.NomCompCliente := aDTO.NomCompCliente;

  end;
end;

class procedure TAssemblerCliente.ModelToDTO(
  const aModel: TModelCliente; var aDTO: TDTOCliente);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodCliente := aModel.CodCliente;
    aDTO.NomCliente := aModel.NomCliente;
    aDTO.NomCompCliente := aModel.NomCompCliente;

  end;
end;

class procedure TAssemblerCliente.ListModelToListDTO(
  const aListModel: TObjectList; aListDTO: TObjectList);
var
  vDTO: TDTOCliente;
  vModel: TModelCliente;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelCliente(aListModel[i]);
      vDTO := TDTOCliente.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

class procedure TAssemblerCliente.ListDTOToListDTO(
  const aListDTOOrigem: TObjectList; aListDTO: TObjectList);
var
  vDTOOrigem, vDTO: TDTOCliente;
  vModel: TModelCliente;
  i: Integer;
begin
  if (Assigned(aListDTOOrigem)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListDTOOrigem.Count -1 do
    begin
      vDTOOrigem := TDTOCliente(aListDTOOrigem[i]);
      vDTO := TDTOCliente.Create;
      DTOToDTO(vDTOOrigem,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

class procedure TAssemblerCliente.DTOToDTO(const aDTOOrigem: TDTOCliente;
  var aDTO: TDTOCliente);
begin
  if (Assigned(aDTOOrigem)) and (Assigned(aDTO)) then
  begin
    aDTO.CodCliente := aDTOOrigem.CodCliente;
    aDTO.NomCliente := aDTOOrigem.NomCliente;
    aDTO.NomCompCliente := aDTOOrigem.NomCompCliente;
    aDTO.Check := aDTOOrigem.Check;
    aDTO.Status := aDTOOrigem.Status;
  end;
end;

end.


