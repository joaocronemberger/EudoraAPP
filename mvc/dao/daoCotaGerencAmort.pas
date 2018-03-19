unit daoCotaGerencAmort;

interface

uses
  daoBase, Contnrs, modelCotaGerencAmort, mvcTypes, DBTables;

type
  TDAOCotaGerencAmort = class(TDAOBase)
  private
    function SQLSelectPrimeiraCotaGerencial(): String;
    function SQLSelectCotaGerencialAnterior(): String;
    function SQLSelectCotaGerencialDoDia(): String;
  public
    function GetCotaGerencialDia(const aCodCarteira: Integer; const aDtaCota: TDateTime): TModelCotaGerencAmort;
    function GetCotaGerencialDiaAnterior(const aCodCarteira: Integer; const aDtaCota: TDateTime): TModelCotaGerencAmort;
    function GetPrimeiraCotaGerencial(const aCodCarteira: Integer): TModelCotaGerencAmort;

    procedure DoInsert(const aModel: TModelCotaGerencAmort);
    procedure DoUpdate(const aModel: TModelCotaGerencAmort);
    procedure DoDelete(const aModel: TModelCotaGerencAmort);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOCotaGerencAmort }

procedure TDAOCotaGerencAmort.DoDelete(const aModel: TModelCotaGerencAmort);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOCotaGerencAmort.DoInsert(const aModel: TModelCotaGerencAmort);
begin
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOCotaGerencAmort.DoUpdate(const aModel: TModelCotaGerencAmort);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOCotaGerencAmort.GetCotaGerencialDia(
  const aCodCarteira: Integer;
  const aDtaCota: TDateTime): TModelCotaGerencAmort;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'DtaCotaGerenc';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaCota);

  Result := TModelCotaGerencAmort(OpenQueryToModel( SQLSelectCotaGerencialDoDia, vListParametros, TModelCotaGerencAmort ));
end;

function TDAOCotaGerencAmort.GetCotaGerencialDiaAnterior(
  const aCodCarteira: Integer;
  const aDtaCota: TDateTime): TModelCotaGerencAmort;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'DtaCotaGerenc';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaCota);

  Result := TModelCotaGerencAmort(OpenQueryToModel( SQLSelectCotaGerencialAnterior, vListParametros, TModelCotaGerencAmort ));
end;

function TDAOCotaGerencAmort.GetPrimeiraCotaGerencial(
  const aCodCarteira: Integer): TModelCotaGerencAmort;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;

  Result := TModelCotaGerencAmort(OpenQueryToModel( SQLSelectPrimeiraCotaGerencial, vListParametros, TModelCotaGerencAmort ));
end;

function TDAOCotaGerencAmort.SQLSelectCotaGerencialAnterior: String;
begin
  Result :=
    'SELECT TOP 1 * '+
    '  FROM FDO_CotaGerencAmort '+
    ' WHERE CodCarteira = :CodCarteira '+
    '   AND DtaCotaGerenc < :DtaCotaGerenc '+
    ' ORDER BY DtaCotaGerenc DESC ';
end;

function TDAOCotaGerencAmort.SQLSelectCotaGerencialDoDia: String;
begin
  Result :=
    'SELECT TOP 1 * '+
    '  FROM FDO_CotaGerencAmort '+
    ' WHERE CodCarteira = :CodCarteira '+
    '   AND DtaCotaGerenc = :DtaCotaGerenc ';
end;

function TDAOCotaGerencAmort.SQLSelectPrimeiraCotaGerencial: String;
begin
  Result :=
    'SELECT TOP 1 * '+
    '  FROM FDO_CotaGerencAmort '+
    ' WHERE CodCarteira = :CodCarteira '+
    ' ORDER BY DtaCotaGerenc ASC ';
end;

end.


