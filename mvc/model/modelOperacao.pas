unit modelOperacao;

interface

uses
  modelBase, mvcTypes;

type
  TModelOperacao = class(TModelBase)
  private
    FNumOperacao: Integer;
    FSeqTransferencia: Integer;
    FCodCliente: Integer;
    FCodCarteira: Integer;
    FNumOperRetroativa: Integer;
    FDtaOperacao: TDateTime;
    FTpoOperacao: String;
    FDtaConvCota: TDateTime;
    FDtaLiquidacao: TDateTime;
    FValOperacao: Double;
    FQtdCotaOperacao: Double;
    FQtdCotaPagtoIR: Double;
    FStaoperacao: String;
    FNumOpeMellon: Integer;
    FStaExportaSMA: String;
    FStaIntSinacor: String;
    FNumIntCCCliente: Integer;
    FNumIntCCFundo: Integer;
    FNumIntDOC: Integer;
    FValLiqResgSinacor: Double;
    FTpoOrigem: String;
    FQtdCotaAI_AC: Double;
    FIR_AI_AC: Double;

  published
      property NumOperacao: Integer read FNumOperacao write FNumOperacao;
      property SeqTransferencia: Integer read FSeqTransferencia write FSeqTransferencia;
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property NumOperRetroativa: Integer read FNumOperRetroativa write FNumOperRetroativa;
      property DtaOperacao: TDateTime read FDtaOperacao write FDtaOperacao;
      property TpoOperacao: String read FTpoOperacao write FTpoOperacao;
      property DtaConvCota: TDateTime read FDtaConvCota write FDtaConvCota;
      property DtaLiquidacao: TDateTime read FDtaLiquidacao write FDtaLiquidacao;
      property ValOperacao: Double read FValOperacao write FValOperacao;
      property QtdCotaOperacao: Double read FQtdCotaOperacao write FQtdCotaOperacao;
      property QtdCotaPagtoIR: Double read FQtdCotaPagtoIR write FQtdCotaPagtoIR;
      property Staoperacao: String read FStaoperacao write FStaoperacao;
      property NumOpeMellon: Integer read FNumOpeMellon write FNumOpeMellon;
      property StaExportaSMA: String read FStaExportaSMA write FStaExportaSMA;
      property StaIntSinacor: String read FStaIntSinacor write FStaIntSinacor;
      property NumIntCCCliente: Integer read FNumIntCCCliente write FNumIntCCCliente;
      property NumIntCCFundo: Integer read FNumIntCCFundo write FNumIntCCFundo;
      property NumIntDOC: Integer read FNumIntDOC write FNumIntDOC;
      property ValLiqResgSinacor: Double read FValLiqResgSinacor write FValLiqResgSinacor;
      property TpoOrigem: String read FTpoOrigem write FTpoOrigem;
      property QtdCotaAI_AC: Double read FQtdCotaAI_AC write FQtdCotaAI_AC;
      property IR_AI_AC: Double read FIR_AI_AC write FIR_AI_AC;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelOperacao }

function TModelOperacao.GetIdentity: String;
begin
  Result := 'NumOperacao';
end;

function TModelOperacao.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NumOperacao';

end;

function TModelOperacao.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,7);
  Result[0] := 'NumOperacao';
  Result[1] := 'CodCliente';
  Result[2] := 'CodCarteira';
  Result[3] := 'DtaOperacao';
  Result[4] := 'TpoOperacao';
  Result[5] := 'ValOperacao';
  Result[6] := 'StaIntSinacor';

end;

function TModelOperacao.GetTableName: String;
begin
  Result := 'FDO_Operacao';
end;

end.


