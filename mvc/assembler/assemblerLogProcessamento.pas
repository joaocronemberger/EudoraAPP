unit assemblerLogProcessamento;

interface

uses
  dtoLogProcessamento, modelLogProcessamento, Contnrs, enumLogProcessamento;

type
  TAssemblerLogProcessamento = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTOLogProcessamento; var aModel: TModelLogProcessamento);
      class procedure ModelToDTO(const aModel: TModelLogProcessamento; var aDTO: TDTOLogProcessamento);

      class procedure DTOToDTO(const aDTO: TDTOLogProcessamento; var aDTOResult: TDTOLogProcessamento);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssemblerLogProcessamento }

class procedure TAssemblerLogProcessamento.DTOToModel(
  const aDTO: TDTOLogProcessamento; var aModel: TModelLogProcessamento);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aModel.CodCarteira := aDTO.CodCarteira;
    aModel.DtaCalculoCota := aDTO.DtaCalculoCota;
    aModel.DtaHoraProcessamentoInicio := aDTO.DtaHoraProcessamentoInicio;
    aModel.DtaHoraProcessamentoFim := aDTO.DtaHoraProcessamentoFim;
    aModel.LogProcessamento := aDTO.LogProcessamento.Text;
    aModel.StaCalculo := StaCalculoProcessamento[aDTO.StaCalculo];
    aModel.SeqUsuario := aDTO.SeqUsuario;
    aModel.CodLogProcessamento := aDTO.CodLogProcessamento;

  end;
end;

class procedure TAssemblerLogProcessamento.ModelToDTO(
  const aModel: TModelLogProcessamento; var aDTO: TDTOLogProcessamento);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
    aDTO.CodCarteira := aModel.CodCarteira;
    aDTO.DtaCalculoCota := aModel.DtaCalculoCota;
    aDTO.DtaHoraProcessamentoInicio := aModel.DtaHoraProcessamentoInicio;
    aDTO.DtaHoraProcessamentoFim := aModel.DtaHoraProcessamentoFim;
    aDTO.LogProcessamento.Text := aModel.LogProcessamento;
    aDTO.StaCalculo := LocateBySta(aModel.StaCalculo);
    aDTO.SeqUsuario := aModel.SeqUsuario;
    aDTO.CodLogProcessamento := aModel.CodLogProcessamento;

  end;
end;

class procedure TAssemblerLogProcessamento.ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTOLogProcessamento;
  vModel: TModelLogProcessamento;
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModelLogProcessamento(aListModel[i]);
      vDTO := TDTOLogProcessamento.Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

class procedure TAssemblerLogProcessamento.DTOToDTO(
  const aDTO: TDTOLogProcessamento; var aDTOResult: TDTOLogProcessamento);
begin
  if (Assigned(aDTOResult)) and (Assigned(aDTO)) then
  begin
    aDTOResult.CodCarteira := aDTO.CodCarteira;
    aDTOResult.DtaCalculoCota := aDTO.DtaCalculoCota;
    aDTOResult.DtaHoraProcessamentoInicio := aDTO.DtaHoraProcessamentoInicio;
    aDTOResult.DtaHoraProcessamentoFim := aDTO.DtaHoraProcessamentoFim;
    aDTOResult.LogProcessamento.Text := aDTO.LogProcessamento.Text;
    aDTOResult.StaCalculo := aDTO.StaCalculo;
    aDTOResult.SeqUsuario := aDTO.SeqUsuario;
    aDTOResult.CodLogProcessamento := aDTO.CodLogProcessamento;

  end;
end;

end.


