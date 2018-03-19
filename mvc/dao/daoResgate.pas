unit daoResgate;

interface

uses
  daoBase, Contnrs, modelResgate, mvcTypes, DBTables;

type
  TDAOResgate = class(TDAOBase)
  private
  public
    procedure DoInsert(const aModel: TModelResgate);
    procedure DoUpdate(const aModel: TModelResgate);
    procedure DoDelete(const aModel: TModelResgate);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOResgate }

procedure TDAOResgate.DoDelete(const aModel: TModelResgate);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOResgate.DoInsert(const aModel: TModelResgate);
begin
  //aModel.NumOperacao := Self.GetNextSequence(aModel, 'NumOperacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOResgate.DoUpdate(const aModel: TModelResgate);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

end.


