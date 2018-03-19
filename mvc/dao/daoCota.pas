unit daoCota;

interface

uses
  daoBase, Contnrs, modelCota, mvcTypes, DBTables;

type
  TDAOCota = class(TDAOBase)
  private
    function SQLSelectCotaDia(): String;
    function SQLSelectCotaAnterior(): String;
  public
    function GetCotaDia(const aCodCarteira: Integer; const aDtaCota: TDateTime): TModelCota;
    function GetCotaAnterior(const aCodCarteira: Integer; const aDtaCota: TDateTime): TModelCota;
  end;

implementation

uses SysUtils, mvcMiscelania, Variants;

{ TDAOCota }

function TDAOCota.GetCotaAnterior(const aCodCarteira: Integer;
  const aDtaCota: TDateTime): TModelCota;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 3);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'DtaCota';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaCota);
  vListParametros[2].Nome := 'CodRotina';
  vListParametros[2].Valor := '57000';

  Result := TModelCota(OpenQueryToModel( SQLSelectCotaAnterior, vListParametros, TModelCota ));
end;

function TDAOCota.GetCotaDia(const aCodCarteira: Integer;
  const aDtaCota: TDateTime): TModelCota;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 3);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'DtaCota';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaCota);
  vListParametros[2].Nome := 'CodRotina';
  vListParametros[2].Valor := '57000';

  Result := TModelCota(OpenQueryToModel( SQLSelectCotaDia, vListParametros, TModelCota ));
end;

function TDAOCota.SQLSelectCotaAnterior: String;
begin
  Result :=
    'SELECT TOP 1 * '+
    '  FROM FDO_Cota '+
    ' WHERE CodCarteira = :CodCarteira '+
    '   AND DtaCota < :DtaCota '+
    '   AND CodRotina = :CodRotina '+
    ' ORDER BY DtaCota DESC ';
end;

function TDAOCota.SQLSelectCotaDia: String;
begin
  Result :=
    'SELECT TOP 1 * '+
    '  FROM FDO_CotaInterface '+
    ' WHERE CodCarteira = :CodCarteira '+
    '   AND DtaCota = :DtaCota '+
    '   AND CodRotina = :CodRotina ';
end;

end.


