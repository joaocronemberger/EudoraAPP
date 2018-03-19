unit modelLogProcessamento;

interface

uses
  modelBase, mvcTypes;

type
  TModelLogProcessamento = class(TModelBase)
  private
    FCodCarteira: Integer;
    FDtaCalculoCota: TDateTime;
    FDtaHoraProcessamentoInicio: TDateTime;
    FDtaHoraProcessamentoFim: TDateTime;
    FLogProcessamento: String;
    FStaCalculo: String;
    FSeqUsuario: Integer;
    FCodLogProcessamento: Integer;

  published
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property DtaCalculoCota: TDateTime read FDtaCalculoCota write FDtaCalculoCota;
      property DtaHoraProcessamentoInicio: TDateTime read FDtaHoraProcessamentoInicio write FDtaHoraProcessamentoInicio;
      property DtaHoraProcessamentoFim: TDateTime read FDtaHoraProcessamentoFim write FDtaHoraProcessamentoFim;
      property LogProcessamento: String read FLogProcessamento write FLogProcessamento;
      property StaCalculo: String read FStaCalculo write FStaCalculo;
      property SeqUsuario: Integer read FSeqUsuario write FSeqUsuario;
      property CodLogProcessamento: Integer read FCodLogProcessamento write FCodLogProcessamento;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelLogProcessamento }

function TModelLogProcessamento.GetIdentity: String;
begin
  Result := 'CodLogProcessamento';
end;

function TModelLogProcessamento.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodLogProcessamento';

end;

function TModelLogProcessamento.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,8);
  Result[0] := 'CodCarteira';
  Result[1] := 'DtaCalculoCota';
  Result[2] := 'DtaHoraProcessamentoInicio';
  Result[3] := 'DtaHoraProcessamentoFim';
  Result[4] := 'LogProcessamento';
  Result[5] := 'StaCalculo';
  Result[6] := 'SeqUsuario';
  Result[7] := 'CodLogProcessamento';

end;

function TModelLogProcessamento.GetTableName: String;
begin
  Result := 'FDO_LogProcessamento';
end;

end.


