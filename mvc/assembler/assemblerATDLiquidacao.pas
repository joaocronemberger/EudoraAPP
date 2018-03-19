unit assemblerATDLiquidacao;

interface

uses
  dtoATDLiquidacao, modelATDLiquidacao, Contnrs;

type
  TAssemblerATDLiquidacao = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOATDLiquidacao; var aModel: TModelATDLiquidacao);
      class procedure ModelToDTO(const aModel: TModelATDLiquidacao; var aDTO: TDTOATDLiquidacao);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerATDLiquidacao }

class procedure TAssemblerATDLiquidacao.DTOToModel(
  const aDTO: TDTOATDLiquidacao; var aModel: TModelATDLiquidacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.SeqLiquidacao := aDTO.SeqLiquidacao;
    aModel.CodCarteira := aDTO.CodCarteira;
    aModel.CodCliente := aDTO.CodCliente;
    aModel.CodBeneficiario := aDTO.CodBeneficiario;
    aModel.NumPedido := aDTO.NumPedido;
    aModel.TpoLiquidacao := aDTO.TpoLiquidacao;
    aModel.DtaLiquidacao := aDTO.DtaLiquidacao;
    aModel.ValLiquidacao := aDTO.ValLiquidacao;
    aModel.NomUsuario := aDTO.NomUsuario;
    aModel.TxtObservacao := aDTO.TxtObservacao;
    aModel.StaExpDoc := aDTO.StaExpDoc;
    aModel.ValReembCPMF := aDTO.ValReembCPMF;
    aModel.CodBeneficiario2 := aDTO.CodBeneficiario2;
    aModel.NomBenefExt2 := aDTO.NomBenefExt2;
    aModel.CPFCGCBenefExt2 := aDTO.CPFCGCBenefExt2;

  end;
end;

class procedure TAssemblerATDLiquidacao.ModelToDTO(
  const aModel: TModelATDLiquidacao; var aDTO: TDTOATDLiquidacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.SeqLiquidacao := aModel.SeqLiquidacao;
    aDTO.CodCarteira := aModel.CodCarteira;
    aDTO.CodCliente := aModel.CodCliente;
    aDTO.CodBeneficiario := aModel.CodBeneficiario;
    aDTO.NumPedido := aModel.NumPedido;
    aDTO.TpoLiquidacao := aModel.TpoLiquidacao;
    aDTO.DtaLiquidacao := aModel.DtaLiquidacao;
    aDTO.ValLiquidacao := aModel.ValLiquidacao;
    aDTO.NomUsuario := aModel.NomUsuario;
    aDTO.TxtObservacao := aModel.TxtObservacao;
    aDTO.StaExpDoc := aModel.StaExpDoc;
    aDTO.ValReembCPMF := aModel.ValReembCPMF;
    aDTO.CodBeneficiario2 := aModel.CodBeneficiario2;
    aDTO.NomBenefExt2 := aModel.NomBenefExt2;
    aDTO.CPFCGCBenefExt2 := aModel.CPFCGCBenefExt2;

  end;
end;

class procedure TAssemblerATDLiquidacao.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOATDLiquidacao;
  vModel: TModelATDLiquidacao;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelATDLiquidacao(aListModel[i]);
      vDTO := TDTOATDLiquidacao.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


