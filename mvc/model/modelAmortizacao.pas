unit modelAmortizacao;

interface

uses
  modelBase, mvcTypes;

type
  TModelAmortizacao = class(TModelBase)
  private
    FCodAmortizacao: Integer;
    FCodCarteira: Integer;
    FDtaAmortizacao: TDateTime;
    FTpoAmortizacao: SmallInt;
    FValAmortizacao: Double;
    FValCotaAmortizacao: Double;
    FTpoCotaAmortizacao: String;

  published
      property CodAmortizacao: Integer read FCodAmortizacao write FCodAmortizacao;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property DtaAmortizacao: TDateTime read FDtaAmortizacao write FDtaAmortizacao;
      property TpoAmortizacao: SmallInt read FTpoAmortizacao write FTpoAmortizacao;
      property ValAmortizacao: Double read FValAmortizacao write FValAmortizacao;
      property ValCotaAmortizacao: Double read FValCotaAmortizacao write FValCotaAmortizacao;
      property TpoCotaAmortizacao: String read FTpoCotaAmortizacao write FTpoCotaAmortizacao;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelAmortizacao }

function TModelAmortizacao.GetIdentity: String;
begin
  Result := '';
end;

function TModelAmortizacao.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodAmortizacao';

end;

function TModelAmortizacao.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,5);
  Result[0] := 'CodAmortizacao';
  Result[1] := 'CodCarteira';
  Result[2] := 'DtaAmortizacao';
  Result[3] := 'TpoCotaAmortizacao';
  Result[4] := 'TpoAmortizacao';

end;

function TModelAmortizacao.GetTableName: String;
begin
  Result := 'FDO_Amortizacao';
end;

end.


