unit assemblerEspecificacaoOperacao;

interface

uses
  dtoEspecificacaoOperacao, modelEspecificacaoOperacao, Contnrs;

type
  TAssemblerEspecificacaoOperacao = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOEspecificacaoOperacao; var aModel: TModelEspecificacaoOperacao);
      class procedure ModelToDTO(const aModel: TModelEspecificacaoOperacao; var aDTO: TDTOEspecificacaoOperacao);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerEspecificacaoOperacao }

class procedure TAssemblerEspecificacaoOperacao.DTOToModel(
  const aDTO: TDTOEspecificacaoOperacao; var aModel: TModelEspecificacaoOperacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.NumOperacao := aDTO.NumOperacao;
    aModel.SeqEspecificacao := aDTO.SeqEspecificacao;

  end;
end;

class procedure TAssemblerEspecificacaoOperacao.ModelToDTO(
  const aModel: TModelEspecificacaoOperacao; var aDTO: TDTOEspecificacaoOperacao);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.NumOperacao := aModel.NumOperacao;
    aDTO.SeqEspecificacao := aModel.SeqEspecificacao;

  end;
end;

class procedure TAssemblerEspecificacaoOperacao.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOEspecificacaoOperacao;
  vModel: TModelEspecificacaoOperacao;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelEspecificacaoOperacao(aListModel[i]);
      vDTO := TDTOEspecificacaoOperacao.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


