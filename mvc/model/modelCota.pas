unit modelCota;

interface

uses
  modelBase, mvcTypes;

type
  TModelCota = class(TModelBase)
  private
    FCodCarteira: Integer;
    FDtaCota: TDateTime;
    FTpoCota: String;
    FCodRotina: String;
    FValCota: Double;
    FStaCota: String;

  published
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property DtaCota: TDateTime read FDtaCota write FDtaCota;
      property TpoCota: String read FTpoCota write FTpoCota;
      property CodRotina: String read FCodRotina write FCodRotina;
      property ValCota: Double read FValCota write FValCota;
      property StaCota: String read FStaCota write FStaCota;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelCota }

function TModelCota.GetIdentity: String;
begin
  Result := '';
end;

function TModelCota.GetPKFields: TArrayStrings;
begin
  SetLength(Result,4);
  Result[0] := 'CodCarteira';
  Result[1] := 'DtaCota';
  Result[2] := 'TpoCota';
  Result[3] := 'CodRotina';

end;

function TModelCota.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,5);
  Result[0] := 'CodCarteira';
  Result[1] := 'DtaCota';
  Result[2] := 'TpoCota';
  Result[3] := 'CodRotina';
  Result[4] := 'ValCota';

end;

function TModelCota.GetTableName: String;
begin
  Result := 'FDO_Cota';
end;

end.


