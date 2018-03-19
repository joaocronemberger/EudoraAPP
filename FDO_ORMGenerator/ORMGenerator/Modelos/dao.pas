unit dao[TABLENAME];

interface

uses
  daoBase, Contnrs, model[TABLENAME], mvcTypes, DBTables;

type
  TDAO[TABLENAME] = class(TDAOBase)
  private
  public
    procedure DoInsert(const aModel: TModel[TABLENAME]);
    procedure DoUpdate(const aModel: TModel[TABLENAME]);
    procedure DoDelete(const aModel: TModel[TABLENAME]);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAO[TABLENAME] }

procedure TDAO[TABLENAME].DoDelete(const aModel: TModel[TABLENAME]);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAO[TABLENAME].DoInsert(const aModel: TModel[TABLENAME]);
begin
  //aModel.[PKFIELD] := Self.GetNextSequence(aModel, '[PKFIELD]');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAO[TABLENAME].DoUpdate(const aModel: TModel[TABLENAME]);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

end.


