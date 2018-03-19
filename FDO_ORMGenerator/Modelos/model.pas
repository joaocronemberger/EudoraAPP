unit model[TABLENAME];

interface

uses
  modelBase, mvcTypes;

type
  TModel[TABLENAME] = class(TModelBase)
  private
[LOOPPRIVATEFILEDS]
  published
[LOOPPROPERTIES]
  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModel[TABLENAME] }

function TModel[TABLENAME].GetIdentity: String;
begin
  Result := '[IDENTITYFIELD]';
end;

function TModel[TABLENAME].GetPKFields: TArrayStrings;
begin
  SetLength(Result,[COUNTPKFIELD]);
[LOOPPKFIELD]
end;

function TModel[TABLENAME].GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,[COUNTFIELDNOTNULL]);
[LOOPFIELDNOTNULL]
end;

function TModel[TABLENAME].GetTableName: String;
begin
  Result := '[FULLTABLENAME]';
end;

end.


