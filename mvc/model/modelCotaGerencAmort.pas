unit modelCotaGerencAmort;

interface

uses
  modelBase, mvcTypes;

type
  TModelCotaGerencAmort = class(TModelBase)
  private
    FCodCotaGerencAmort: Integer;
    FCodCarteira: Integer;
    FDtaCotaGerenc: TDateTime;
    FValCotaGerenc: Double;
    FRendtoAcum: Double;

  published
      property CodCotaGerencAmort: Integer read FCodCotaGerencAmort write FCodCotaGerencAmort;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property DtaCotaGerenc: TDateTime read FDtaCotaGerenc write FDtaCotaGerenc;
      property ValCotaGerenc: Double read FValCotaGerenc write FValCotaGerenc;
      property RendtoAcum: Double read FRendtoAcum write FRendtoAcum;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelCotaGerencAmort }

function TModelCotaGerencAmort.GetIdentity: String;
begin
  Result := 'CodCotaGerencAmort';
end;

function TModelCotaGerencAmort.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodCotaGerencAmort';

end;

function TModelCotaGerencAmort.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,3);
  Result[0] := 'CodCotaGerencAmort';
  Result[1] := 'CodCarteira';
  Result[2] := 'DtaCotaGerenc';

end;

function TModelCotaGerencAmort.GetTableName: String;
begin
  Result := 'FDO_CotaGerencAmort';
end;

end.


