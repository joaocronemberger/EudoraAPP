unit daoBase;

interface

uses
  DBTables, Forms, SysUtils, mvcTypes, modelBase, Contnrs, TypInfo,
  Classes, mvcMiscelania, DateUtils, Controls, Variants,
  ExtCtrls, ComObj, Messages, IdGlobal, SqlExpr,
  IdHash, IdHashMessageDigest, StrUtils, mvcReferenceManipulator, mvcSingletonConexao;

type
  TDAOBase = class
  private
    function GeTSQLQuery(const aSQL: string; const aParams: TArrayFields): TSQLQuery;
    procedure PrepareQuery(var aQuery: TSQLQuery; const aSQL: string; const aParams: TArrayFields);

  protected
    function GetNextSequence(const aModel: TModelBase; const aFieldName: String): Variant;
    procedure SetIdentity(const aModel: TModelBase);

  public
    { Methods Open }
    function OpenQuery(const aSQL: string): TSQLQuery; overload;
    function OpenQuery(const aSQL: string; const aParams: TArrayFields): TSQLQuery; overload;
    
    procedure OpenQuery(var aQuery: TSQLQuery; const aSQL: string); overload;
    procedure OpenQuery(var aQuery: TSQLQuery; const aSQL: string; const aParams: TArrayFields); overload;

    function OpenQueryReturnField(const aSQL: string; const aFieldName: String): Variant; overload;
    function OpenQueryReturnField(const aSQL: string; const aParams: TArrayFields; const aFieldName: String): Variant; overload;

    function OpenQueryToList(const aSQL: string; const aModelClass: TModelBaseClass): TObjectList; overload;
    function OpenQueryToList(const aSQL: string; const aParams: TArrayFields; const aModelClass: TModelBaseClass): TObjectList; overload;

    function OpenQueryToModel(const aSQL: string; const aModelClass: TModelBaseClass): TModelBase; overload;
    function OpenQueryToModel(const aSQL: string; const aParams: TArrayFields; const aModelClass: TModelBaseClass): TModelBase; overload;

    { Methods Execute }
    function ExecuteQuery(const aSQL: string): Boolean; overload;
    function ExecuteQuery(const aSQL: string; const aParams: TArrayFields): Boolean; overload;

    { Methods Connection }
    function InTransaction: Boolean;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
  end;

var
  ParametrosDefault: TArrayFields;

implementation

uses DB;

{ TDAOBase }

function TDAOBase.ExecuteQuery(const aSQL: string): Boolean;
begin
  Result := Self.ExecuteQuery(aSQL, ParametrosDefault);
end;

function TDAOBase.ExecuteQuery(const aSQL: string; const aParams: TArrayFields): Boolean;
begin
  Result := False;
  with Self.GeTSQLQuery(aSQL, aParams) do
  try
    try
      ExecSQL;
      Result := True;
    except
      raise;
    end;
  finally
    //Free;
  end;
end;

function TDAOBase.OpenQuery(const aSQL: string): TSQLQuery;
begin
  Result := Self.OpenQuery(aSQL, ParametrosDefault);
end;

function TDAOBase.GeTSQLQuery(const aSQL: string; const aParams: TArrayFields): TSQLQuery;
begin
  Result := TSingletonConexao.GetInstancia().GetMyQuery;
  PrepareQuery(Result, aSQL, aParams);
end;

function TDAOBase.OpenQuery(const aSQL: string; const aParams: TArrayFields): TSQLQuery;
begin
  Result := Self.GeTSQLQuery(aSQL, aParams);
  Result.Open;
end;

function TDAOBase.OpenQueryToList(const aSQL: string;
  const aModelClass: TModelBaseClass): TObjectList;
begin
  Result := Self.OpenQueryToList(aSQL, ParametrosDefault, aModelClass);
end;

function TDAOBase.OpenQueryToList(const aSQL: string;
  const aParams: TArrayFields; const aModelClass: TModelBaseClass): TObjectList;
var
  vModel: TModelBase;
  vQuery: TSQLQuery;
begin
  Result := TObjectList.Create(True);

  vQuery := Self.OpenQuery(aSQL, aParams);
  try

    try
      vQuery.First;
      while not vQuery.Eof do
      begin
        vModel := aModelClass.Create;
        vModel.LoadByQuery(vQuery);
        Result.Add(vModel);

        vQuery.Next;
      end;
    except
      Raise;
    end;

  finally
    //SafeFree(vQuery);
  end;
end;

function TDAOBase.OpenQueryToModel(const aSQL: string;
  const aModelClass: TModelBaseClass): TModelBase;
begin
  Result := Self.OpenQueryToModel(aSQL, ParametrosDefault, aModelClass);
end;

function TDAOBase.OpenQueryToModel(const aSQL: string;
  const aParams: TArrayFields;
  const aModelClass: TModelBaseClass): TModelBase;
var
  vQuery: TSQLQuery;
begin
  // Inicializa variavel...
  Result := nil;
  
  vQuery := Self.OpenQuery(aSQL, aParams);
  try
    try
      if not vQuery.IsEmpty then
      begin
        vQuery.First;
        Result := aModelClass.Create;
        Result.LoadByQuery(vQuery);
      end;
    except
      Raise;
    end;
  finally
    //SafeFree(vQuery);
  end;
end;

function TDAOBase.OpenQueryReturnField(const aSQL,
  aFieldName: String): Variant;
begin
  Result := Self.OpenQueryReturnField(aSQL, ParametrosDefault, aFieldName);
end;

function TDAOBase.OpenQueryReturnField(const aSQL: string;
  const aParams: TArrayFields; const aFieldName: String): Variant;
begin
  with Self.OpenQuery(aSQL, aParams) do
  try
    if Assigned(FindField(aFieldName)) then
      Result := FieldByName(aFieldName).Value;
  finally
    //Free;
  end;
end;

function TDAOBase.GetNextSequence(const aModel: TModelBase;
  const aFieldName: String): Variant;
begin
  Result := Self.OpenQueryReturnField(' select coalesce(max('+aFieldName+'),0) +1 as '+aFieldName+' from '+ aModel.GetTableName, aFieldName);
end;

procedure TDAOBase.CommitTransaction;
begin
  TSingletonConexao.GetInstancia().CommitTransaction;
end;

function TDAOBase.InTransaction: Boolean;
begin
  Result := TSingletonConexao.GetInstancia().InTransaction;
end;

procedure TDAOBase.RollbackTransaction;
begin
  TSingletonConexao.GetInstancia().RollbackTransaction;
end;

procedure TDAOBase.StartTransaction;
begin
  TSingletonConexao.GetInstancia().StartTransaction;
end;

procedure TDAOBase.SetIdentity(const aModel: TModelBase);
begin
  aModel.SetID(Self.OpenQuery('select @@IDENTITY as ID'));
end;

procedure TDAOBase.OpenQuery(var aQuery: TSQLQuery; const aSQL: string);
begin
  Self.OpenQuery(aQuery, aSQL, ParametrosDefault);
end;

procedure TDAOBase.OpenQuery(var aQuery: TSQLQuery; const aSQL: string;
  const aParams: TArrayFields);
begin
  aQuery.SQLConnection := TSingletonConexao.GetInstancia().GetMyQuery.SQLConnection;
  PrepareQuery(aQuery, aSQL, aParams);
  aQuery.Open;
end;

procedure TDAOBase.PrepareQuery(var aQuery: TSQLQuery; const aSQL: string;
  const aParams: TArrayFields);
var
  i: integer;
begin
  aQuery.SQL.Text := aSQL;

  { Atribui os parâmetros }
  for i := low(aParams) to high(aParams) do
    aQuery.ParamByName(aParams[i].Nome).Value := aParams[i].Valor;

  aQuery.Prepared := True;
end;

end.
