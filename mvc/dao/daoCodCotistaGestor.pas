unit daoCodCotistaGestor;

interface

uses
  daoBase, Contnrs, modelCodCotistaGestor, mvcTypes, DBTables;

type
  TDAOCodCotistaGestor = class(TDAOBase)
  private
    function SQLListaCodigoByCotista(): String;
  public
    procedure DoInsert(const aModel: TModelCodCotistaGestor);
    procedure DoUpdate(const aModel: TModelCodCotistaGestor);
    procedure DoDelete(const aModel: TModelCodCotistaGestor);

    function GetListaCodigoByCotista(const aCodCotista: Integer): TObjectList;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOCodCotistaGestor }

procedure TDAOCodCotistaGestor.DoDelete(const aModel: TModelCodCotistaGestor);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOCodCotistaGestor.DoInsert(const aModel: TModelCodCotistaGestor);
begin
  //aModel.CodCotista := Self.GetNextSequence(aModel, 'CodCotista');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOCodCotistaGestor.DoUpdate(const aModel: TModelCodCotistaGestor);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOCodCotistaGestor.GetListaCodigoByCotista(
  const aCodCotista: Integer): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aCodCotista';
  vListParametros[0].Valor := aCodCotista;

  Result := Self.OpenQueryToList(SQLListaCodigoByCotista(), vListParametros, TModelCodCotistaGestor);
end;

function TDAOCodCotistaGestor.SQLListaCodigoByCotista: String;
begin
  Result :=
    'SELECT * '+
    '  FROM FDO_CodCotistaGestor '+
    ' WHERE CodCotista = :aCodCotista ';
end;

end.


