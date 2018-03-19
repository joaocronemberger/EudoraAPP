unit assemblerCarteira;

interface

uses
  dtoCarteira, modelCarteira, Contnrs;

type
  TAssemblerCarteira = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOCarteira; var aModel: TModelCarteira);
      class procedure ModelToDTO(const aModel: TModelCarteira; var aDTO: TDTOCarteira);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerCarteira }

class procedure TAssemblerCarteira.DTOToModel(
  const aDTO: TDTOCarteira; var aModel: TModelCarteira);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodCarteira        := aDTO.CodCarteira;
    aModel.ValCotaInicial := aDTO.ValCotaInicial;
    aModel.NomFantasiaProduto := aDTO.NomFantasiaProduto;
    aModel.TpoApurarCota := aDTO.TpoApurarCota;
    aModel.DtaCriacao := aDTO.DtaCriacao;
  end;
end;

class procedure TAssemblerCarteira.ModelToDTO(const aModel: TModelCarteira;
  var aDTO: TDTOCarteira);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodCarteira        := aModel.CodCarteira;
    aDTO.ValCotaInicial := aModel.ValCotaInicial;
    aDTO.NomFantasiaProduto := aModel.NomFantasiaProduto;
    aDTO.TpoApurarCota := aModel.TpoApurarCota;
    aDTO.DtaCriacao := aModel.DtaCriacao;
  end;
end;

class procedure TAssemblerCarteira.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOCarteira;
  vModel: TModelCarteira;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelCarteira(aListModel[i]);
      vDTO := TDTOCarteira.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


