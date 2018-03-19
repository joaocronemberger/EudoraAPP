unit assemblerATDPedidos;

interface

uses
  dtoATDPedidos, modelATDPedidos, Contnrs;

type
  TAssemblerATDPedidos = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOATDPedidos; var aModel: TModelATDPedidos);
      class procedure ModelToDTO(const aModel: TModelATDPedidos; var aDTO: TDTOATDPedidos);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerATDPedidos }

class procedure TAssemblerATDPedidos.DTOToModel(
  const aDTO: TDTOATDPedidos; var aModel: TModelATDPedidos);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.NumPedido := aDTO.NumPedido;
    aModel.CodCliente := aDTO.CodCliente;
    aModel.DtaPedido := aDTO.DtaPedido;
    aModel.TpoOperacao := aDTO.TpoOperacao;
    aModel.ValPedido := aDTO.ValPedido;
    aModel.NomUsuario := aDTO.NomUsuario;
    aModel.StaIof := aDTO.StaIof;
    aModel.NumPedidoInterface := aDTO.NumPedidoInterface;
    aModel.DtaReembCPMF := aDTO.DtaReembCPMF;
    aModel.DesHistorico := aDTO.DesHistorico;
    aModel.TpoOrigem := aDTO.TpoOrigem;
    aModel.TpoMovtoOrigem := aDTO.TpoMovtoOrigem;
    aModel.StaCobraCPMF := aDTO.StaCobraCPMF;
    aModel.NumIntCCCliente := aDTO.NumIntCCCliente;
    aModel.NumIntCCFundo := aDTO.NumIntCCFundo;
    aModel.NumIntDOC := aDTO.NumIntDOC;
    aModel.TpoEstoque := aDTO.TpoEstoque;
    aModel.StaPedido := aDTO.StaPedido;
    aModel.CodFdoIncorporador := aDTO.CodFdoIncorporador;
    aModel.NumResgIncorporacao := aDTO.NumResgIncorporacao;
    aModel.DtaDistribuicao := aDTO.DtaDistribuicao;
    aModel.CodFinalidade := aDTO.CodFinalidade;
    aModel.NumIntTED := aDTO.NumIntTED;
    aModel.StaEnvioEmail := aDTO.StaEnvioEmail;
    aModel.StaExportaSMA := aDTO.StaExportaSMA;
    aModel.stawebservice := aDTO.stawebservice;
    aModel.NumAplMellon := aDTO.NumAplMellon;
    aModel.CodPropostaPedidosPrev := aDTO.CodPropostaPedidosPrev;
    aModel.StaContribuicao := aDTO.StaContribuicao;
    aModel.SiglaMovtoPrev := aDTO.SiglaMovtoPrev;
    aModel.StaExportaBTGDtaPedido := aDTO.StaExportaBTGDtaPedido;
    aModel.StaExportaBTGDtaCotizacao := aDTO.StaExportaBTGDtaCotizacao;
    aModel.cSitPdidoTrnsfIncpc := aDTO.cSitPdidoTrnsfIncpc;

  end;
end;

class procedure TAssemblerATDPedidos.ModelToDTO(
  const aModel: TModelATDPedidos; var aDTO: TDTOATDPedidos);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.NumPedido := aModel.NumPedido;
    aDTO.CodCliente := aModel.CodCliente;
    aDTO.DtaPedido := aModel.DtaPedido;
    aDTO.TpoOperacao := aModel.TpoOperacao;
    aDTO.ValPedido := aModel.ValPedido;
    aDTO.NomUsuario := aModel.NomUsuario;
    aDTO.StaIof := aModel.StaIof;
    aDTO.NumPedidoInterface := aModel.NumPedidoInterface;
    aDTO.DtaReembCPMF := aModel.DtaReembCPMF;
    aDTO.DesHistorico := aModel.DesHistorico;
    aDTO.TpoOrigem := aModel.TpoOrigem;
    aDTO.TpoMovtoOrigem := aModel.TpoMovtoOrigem;
    aDTO.StaCobraCPMF := aModel.StaCobraCPMF;
    aDTO.NumIntCCCliente := aModel.NumIntCCCliente;
    aDTO.NumIntCCFundo := aModel.NumIntCCFundo;
    aDTO.NumIntDOC := aModel.NumIntDOC;
    aDTO.TpoEstoque := aModel.TpoEstoque;
    aDTO.StaPedido := aModel.StaPedido;
    aDTO.CodFdoIncorporador := aModel.CodFdoIncorporador;
    aDTO.NumResgIncorporacao := aModel.NumResgIncorporacao;
    aDTO.DtaDistribuicao := aModel.DtaDistribuicao;
    aDTO.CodFinalidade := aModel.CodFinalidade;
    aDTO.NumIntTED := aModel.NumIntTED;
    aDTO.StaEnvioEmail := aModel.StaEnvioEmail;
    aDTO.StaExportaSMA := aModel.StaExportaSMA;
    aDTO.stawebservice := aModel.stawebservice;
    aDTO.NumAplMellon := aModel.NumAplMellon;
    aDTO.CodPropostaPedidosPrev := aModel.CodPropostaPedidosPrev;
    aDTO.StaContribuicao := aModel.StaContribuicao;
    aDTO.SiglaMovtoPrev := aModel.SiglaMovtoPrev;
    aDTO.StaExportaBTGDtaPedido := aModel.StaExportaBTGDtaPedido;
    aDTO.StaExportaBTGDtaCotizacao := aModel.StaExportaBTGDtaCotizacao;
    aDTO.cSitPdidoTrnsfIncpc := aModel.cSitPdidoTrnsfIncpc;

  end;
end;

class procedure TAssemblerATDPedidos.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOATDPedidos;
  vModel: TModelATDPedidos;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelATDPedidos(aListModel[i]);
      vDTO := TDTOATDPedidos.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


