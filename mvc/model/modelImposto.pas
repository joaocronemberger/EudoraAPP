unit modelImposto;

interface

uses
  modelBase, mvcTypes;

type
  TModelImposto = class(TModelBase)
  private
    FNumOperacao: Integer;
    FAnoBase: String;
    FValBaseIrAno: Double;
    FValCompPrjAno: Double;
    FValIrAno: Double;

  published
      property NumOperacao: Integer read FNumOperacao write FNumOperacao;
      property AnoBase: String read FAnoBase write FAnoBase;
      property ValBaseIrAno: Double read FValBaseIrAno write FValBaseIrAno;
      property ValCompPrjAno: Double read FValCompPrjAno write FValCompPrjAno;
      property ValIrAno: Double read FValIrAno write FValIrAno;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelImposto }

function TModelImposto.GetIdentity: String;
begin
  Result := '';
end;

function TModelImposto.GetPKFields: TArrayStrings;
begin
  SetLength(Result,2);
  Result[0] := 'NumOperacao';
  Result[1] := 'AnoBase';

end;

function TModelImposto.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,5);
  Result[0] := 'NumOperacao';
  Result[1] := 'AnoBase';
  Result[2] := 'ValBaseIrAno';
  Result[3] := 'ValCompPrjAno';
  Result[4] := 'ValIrAno';

end;

function TModelImposto.GetTableName: String;
begin
  Result := 'FDO_Imposto';
end;

end.


