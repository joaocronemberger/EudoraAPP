unit assemblerAmortizacao;

interface

uses
  dtoAmortizacao, modelAmortizacao, Contnrs, enumAmortizacao;

type
  TAssemblerAmortizacao = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOAmortizacao; var aModel: TModelAmortizacao);
      class procedure ModelToDTO(const aModel: TModelAmortizacao; var aDTO: TDTOAmortizacao);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerAmortizacao }

class procedure TAssemblerAmortizacao.DTOToModel(
  const aDTO: TDTOAmortizacao; var aModel: TModelAmortizacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodAmortizacao := aDTO.CodAmortizacao;
    aModel.CodCarteira := aDTO.CodCarteira;
    aModel.DtaAmortizacao := aDTO.DtaAmortizacao;
    aModel.TpoAmortizacao := aDTO.TpoAmortizacao;
    aModel.ValAmortizacao := aDTO.ValAmortizacao;
    aModel.ValCotaAmortizacao := aDTO.ValCotaAmortizacao;
    aModel.TpoCotaAmortizacao := TpoCotaAmortizacao[aDTO.TpoCotaAmortizacao];

  end;
end;

class procedure TAssemblerAmortizacao.ModelToDTO(
  const aModel: TModelAmortizacao; var aDTO: TDTOAmortizacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodAmortizacao := aModel.CodAmortizacao;
    aDTO.CodCarteira := aModel.CodCarteira;
    aDTO.DtaAmortizacao := aModel.DtaAmortizacao;
    aDTO.TpoAmortizacao := aModel.TpoAmortizacao;
    aDTO.ValAmortizacao := aModel.ValAmortizacao;
    aDTO.ValCotaAmortizacao := aModel.ValCotaAmortizacao;
    aDTO.TpoCotaAmortizacao := enumAmortizacao.LocateBy(aModel.TpoCotaAmortizacao);

  end;
end;

class procedure TAssemblerAmortizacao.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOAmortizacao;
  vModel: TModelAmortizacao;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelAmortizacao(aListModel[i]);
      vDTO := TDTOAmortizacao.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


