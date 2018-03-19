unit modelFilaProcessoAutomatico;

interface

uses
  modelBase, mvcTypes;

type
  TModelFilaProcessoAutomatico = class(TModelBase)
  private
    FCodFilaProcessoAutomatico: Integer;
    FCodCarteira: Integer;
    FCodProtocoloOrdem: Integer;
    FDtaOrdemProcessamento: TDateTime;
    FDtaCotaProcessamento: TDateTime;
    FStaSolicitacao: String;
    FCodLogProcessamento: Integer;

  published
      property CodFilaProcessoAutomatico: Integer read FCodFilaProcessoAutomatico write FCodFilaProcessoAutomatico;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property CodProtocoloOrdem: Integer read FCodProtocoloOrdem write FCodProtocoloOrdem;
      property DtaOrdemProcessamento: TDateTime read FDtaOrdemProcessamento write FDtaOrdemProcessamento;
      property DtaCotaProcessamento: TDateTime read FDtaCotaProcessamento write FDtaCotaProcessamento;
      property StaSolicitacao: String read FStaSolicitacao write FStaSolicitacao;
      property CodLogProcessamento: Integer read FCodLogProcessamento write FCodLogProcessamento;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelFilaProcessoAutomatico }

function TModelFilaProcessoAutomatico.GetIdentity: String;
begin
  Result := 'CodFilaProcessoAutomatico';
end;

function TModelFilaProcessoAutomatico.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodFilaProcessoAutomatico';

end;

function TModelFilaProcessoAutomatico.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,6);
  Result[0] := 'CodFilaProcessoAutomatico';
  Result[1] := 'CodCarteira';
  Result[2] := 'CodProtocoloOrdem';
  Result[3] := 'DtaOrdemProcessamento';
  Result[4] := 'DtaCotaProcessamento';
  Result[5] := 'StaSolicitacao';

end;

function TModelFilaProcessoAutomatico.GetTableName: String;
begin
  Result := 'FDO_FilaProcessoAutomatico';
end;

end.


