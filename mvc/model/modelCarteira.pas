unit modelCarteira;

interface

uses
  modelBase, mvcTypes;

type
  TModelCarteira = class(TModelBase)
  private
    FCodCarteira: Integer;
    FValCotaInicial: Double;
    FNomFantasiaProduto: String;
    FTpoApurarCota: String;
    FDtaCriacao: TDateTime;

  published
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property ValCotaInicial: Double read FValCotaInicial write FValCotaInicial;
      property NomFantasiaProduto: String read FNomFantasiaProduto write FNomFantasiaProduto;
      property TpoApurarCota: String read FTpoApurarCota write FTpoApurarCota;
      property DtaCriacao: TDateTime read FDtaCriacao write FDtaCriacao;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelCarteira }

function TModelCarteira.GetIdentity: String;
begin
  Result := '';
end;

function TModelCarteira.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodCarteira';

end;

function TModelCarteira.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,28);
  Result[0] := 'CodCarteira';

end;

function TModelCarteira.GetTableName: String;
begin
  Result := 'FDO_Carteira';
end;

end.


