unit modelAmortizacaoOperacao;

interface

uses
  modelBase, mvcTypes;

type
  TModelAmortizacaoOperacao = class(TModelBase)
  private
    FCodAmortizacaoOperacao: Integer;
    FNumOperacao: Integer;
    FValAplicDescontada: Double;
    FDtaAmortizacao: TDateTime;

  published
      property CodAmortizacaoOperacao: Integer read FCodAmortizacaoOperacao write FCodAmortizacaoOperacao;
      property NumOperacao: Integer read FNumOperacao write FNumOperacao;
      property ValAplicDescontada: Double read FValAplicDescontada write FValAplicDescontada;
      property DtaAmortizacao: TDateTime read FDtaAmortizacao write FDtaAmortizacao;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelAmortizacaoOperacao }

function TModelAmortizacaoOperacao.GetIdentity: String;
begin
  Result := 'CodAmortizacaoOperacao';
end;

function TModelAmortizacaoOperacao.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodAmortizacaoOperacao';

end;

function TModelAmortizacaoOperacao.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,3);
  Result[0] := 'CodAmortizacaoOperacao';
  Result[1] := 'NumOperacao';
  Result[2] := 'DtaAmortizacao';

end;

function TModelAmortizacaoOperacao.GetTableName: String;
begin
  Result := 'FDO_AmortizacaoOperacao';
end;

end.


