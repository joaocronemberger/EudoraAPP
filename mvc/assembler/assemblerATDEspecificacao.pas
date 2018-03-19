unit assemblerATDEspecificacao;

interface

uses
  dtoATDEspecificacao, modelATDEspecificacao, Contnrs;

type
  TAssemblerATDEspecificacao = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOATDEspecificacao; var aModel: TModelATDEspecificacao);
      class procedure ModelToDTO(const aModel: TModelATDEspecificacao; var aDTO: TDTOATDEspecificacao);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerATDEspecificacao }

class procedure TAssemblerATDEspecificacao.DTOToModel(
  const aDTO: TDTOATDEspecificacao; var aModel: TModelATDEspecificacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.SeqEspecificacao := aDTO.SeqEspecificacao;
    aModel.NumPedido := aDTO.NumPedido;
    aModel.CodCarteira := aDTO.CodCarteira;
    aModel.TpoOperacao := aDTO.TpoOperacao;
    aModel.NumAplicacao := aDTO.NumAplicacao;
    aModel.ValOperacao := aDTO.ValOperacao;
    aModel.NomUsuario := aDTO.NomUsuario;
    aModel.StaRevisa := aDTO.StaRevisa;
    aModel.TpoTransferencia := aDTO.TpoTransferencia;
    aModel.CodCliDestino := aDTO.CodCliDestino;
    aModel.PercRateio := aDTO.PercRateio;
    aModel.DtaOperacao := aDTO.DtaOperacao;
    aModel.QtdCotaOperacao := aDTO.QtdCotaOperacao;
    aModel.DtaCotizacao := aDTO.DtaCotizacao;
    aModel.DtaLiquidacao := aDTO.DtaLiquidacao;
    aModel.StaOperacaoPenalty := aDTO.StaOperacaoPenalty;
    aModel.TpoCotizacao := aDTO.TpoCotizacao;
    aModel.NumPedidoPenalty := aDTO.NumPedidoPenalty;

  end;
end;

class procedure TAssemblerATDEspecificacao.ModelToDTO(
  const aModel: TModelATDEspecificacao; var aDTO: TDTOATDEspecificacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.SeqEspecificacao := aModel.SeqEspecificacao;
    aDTO.NumPedido := aModel.NumPedido;
    aDTO.CodCarteira := aModel.CodCarteira;
    aDTO.TpoOperacao := aModel.TpoOperacao;
    aDTO.NumAplicacao := aModel.NumAplicacao;
    aDTO.ValOperacao := aModel.ValOperacao;
    aDTO.NomUsuario := aModel.NomUsuario;
    aDTO.StaRevisa := aModel.StaRevisa;
    aDTO.TpoTransferencia := aModel.TpoTransferencia;
    aDTO.CodCliDestino := aModel.CodCliDestino;
    aDTO.PercRateio := aModel.PercRateio;
    aDTO.DtaOperacao := aModel.DtaOperacao;
    aDTO.QtdCotaOperacao := aModel.QtdCotaOperacao;
    aDTO.DtaCotizacao := aModel.DtaCotizacao;
    aDTO.DtaLiquidacao := aModel.DtaLiquidacao;
    aDTO.StaOperacaoPenalty := aModel.StaOperacaoPenalty;
    aDTO.TpoCotizacao := aModel.TpoCotizacao;
    aDTO.NumPedidoPenalty := aModel.NumPedidoPenalty;

  end;
end;

class procedure TAssemblerATDEspecificacao.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOATDEspecificacao;
  vModel: TModelATDEspecificacao;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelATDEspecificacao(aListModel[i]);
      vDTO := TDTOATDEspecificacao.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


