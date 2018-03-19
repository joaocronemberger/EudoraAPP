unit modelResgate;

interface

uses
  modelBase, mvcTypes;

type
  TModelResgate = class(TModelBase)
  private
    FNumOperacao: Integer;
    FNumAplicacao: Integer;
    FValPremioPerformance: Double;
    FValMultaSaida: Double;
    FValRendtoNominal: Double;
    FNumAplMellon: Integer;

  published
      property NumOperacao: Integer read FNumOperacao write FNumOperacao;
      property NumAplicacao: Integer read FNumAplicacao write FNumAplicacao;
      property ValPremioPerformance: Double read FValPremioPerformance write FValPremioPerformance;
      property ValMultaSaida: Double read FValMultaSaida write FValMultaSaida;
      property ValRendtoNominal: Double read FValRendtoNominal write FValRendtoNominal;
      property NumAplMellon: Integer read FNumAplMellon write FNumAplMellon;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelResgate }

function TModelResgate.GetIdentity: String;
begin
  Result := '';
end;

function TModelResgate.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NumOperacao';

end;

function TModelResgate.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,5);
  Result[0] := 'NumOperacao';
  Result[1] := 'NumAplicacao';
  Result[2] := 'ValPremioPerformance';
  Result[3] := 'ValMultaSaida';
  Result[4] := 'ValRendtoNominal';

end;

function TModelResgate.GetTableName: String;
begin
  Result := 'FDO_Resgate';
end;

end.


