unit modelATDLiquidacao;

interface

uses
  modelBase, mvcTypes;

type
  TModelATDLiquidacao = class(TModelBase)
  private
    FSeqLiquidacao: Integer;
    FCodCarteira: Integer;
    FCodCliente: Integer;
    FCodBeneficiario: Integer;
    FNumPedido: Integer;
    FTpoLiquidacao: String;
    FDtaLiquidacao: TDateTime;
    FValLiquidacao: Double;
    FNomUsuario: String;
    FTxtObservacao: String;
    FStaExpDoc: String;
    FValReembCPMF: Double;
    FCodBeneficiario2: Integer;
    FNomBenefExt2: String;
    FCPFCGCBenefExt2: String;

  published
      property SeqLiquidacao: Integer read FSeqLiquidacao write FSeqLiquidacao;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property CodBeneficiario: Integer read FCodBeneficiario write FCodBeneficiario;
      property NumPedido: Integer read FNumPedido write FNumPedido;
      property TpoLiquidacao: String read FTpoLiquidacao write FTpoLiquidacao;
      property DtaLiquidacao: TDateTime read FDtaLiquidacao write FDtaLiquidacao;
      property ValLiquidacao: Double read FValLiquidacao write FValLiquidacao;
      property NomUsuario: String read FNomUsuario write FNomUsuario;
      property TxtObservacao: String read FTxtObservacao write FTxtObservacao;
      property StaExpDoc: String read FStaExpDoc write FStaExpDoc;
      property ValReembCPMF: Double read FValReembCPMF write FValReembCPMF;
      property CodBeneficiario2: Integer read FCodBeneficiario2 write FCodBeneficiario2;
      property NomBenefExt2: String read FNomBenefExt2 write FNomBenefExt2;
      property CPFCGCBenefExt2: String read FCPFCGCBenefExt2 write FCPFCGCBenefExt2;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelATDLiquidacao }

function TModelATDLiquidacao.GetIdentity: String;
begin
  Result := 'SeqLiquidacao';
end;

function TModelATDLiquidacao.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'SeqLiquidacao';

end;

function TModelATDLiquidacao.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,7);
  Result[0] := 'SeqLiquidacao';
  Result[1] := 'CodCarteira';
  Result[2] := 'NumPedido';
  Result[3] := 'TpoLiquidacao';
  Result[4] := 'DtaLiquidacao';
  Result[5] := 'ValLiquidacao';
  Result[6] := 'NomUsuario';

end;

function TModelATDLiquidacao.GetTableName: String;
begin
  Result := 'ATD_Liquidacao';
end;

end.


