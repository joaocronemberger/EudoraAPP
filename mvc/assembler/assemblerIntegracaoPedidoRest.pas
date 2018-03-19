unit assemblerIntegracaoPedidoRest;

interface

uses
  dtoIntegracaoPedidoRest, modelIntegracaoPedidoRest, Contnrs;

type
  TAssemblerIntegracaoPedidoRest = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOIntegracaoPedidoRest; var aModel: TModelIntegracaoPedidoRest);
      class procedure ModelToDTO(const aModel: TModelIntegracaoPedidoRest; var aDTO: TDTOIntegracaoPedidoRest);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerIntegracaoPedidoRest }

class procedure TAssemblerIntegracaoPedidoRest.DTOToModel(
  const aDTO: TDTOIntegracaoPedidoRest; var aModel: TModelIntegracaoPedidoRest);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.NumPedido := aDTO.NumPedido;
    aModel.ValCota := aDTO.ValCota;
    aModel.ValIR := aDTO.ValIR;
    aModel.ValIOF := aDTO.ValIOF;
    aModel.ValCotizado := aDTO.ValCotizado;
    aModel.StaEnviado := aDTO.StaEnviado;
    aModel.DesRetorno := aDTO.DesRetorno;

  end;
end;

class procedure TAssemblerIntegracaoPedidoRest.ModelToDTO(
  const aModel: TModelIntegracaoPedidoRest; var aDTO: TDTOIntegracaoPedidoRest);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.NumPedido := aModel.NumPedido;
    aDTO.ValCota := aModel.ValCota;
    aDTO.ValIR := aModel.ValIR;
    aDTO.ValIOF := aModel.ValIOF;
    aDTO.ValCotizado := aModel.ValCotizado;
    aDTO.StaEnviado := aModel.StaEnviado;
    aDTO.DesRetorno := aModel.DesRetorno;

  end;
end;

class procedure TAssemblerIntegracaoPedidoRest.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOIntegracaoPedidoRest;
  vModel: TModelIntegracaoPedidoRest;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelIntegracaoPedidoRest(aListModel[i]);
      vDTO := TDTOIntegracaoPedidoRest.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


