unit modelCodCotistaGestor;

interface

uses
  modelBase, mvcTypes;

type
  TModelCodCotistaGestor = class(TModelBase)
  private
    FCodCotista: Integer;
    FCodGestor: Integer;
    FCodCotistaGestor: Integer;
    FCodAdministrador: Integer;

  published
      property CodCotista: Integer read FCodCotista write FCodCotista;
      property CodGestor: Integer read FCodGestor write FCodGestor;
      property CodCotistaGestor: Integer read FCodCotistaGestor write FCodCotistaGestor;
      property CodAdministrador: Integer read FCodAdministrador write FCodAdministrador;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelCodCotistaGestor }

function TModelCodCotistaGestor.GetIdentity: String;
begin
  Result := '';
end;

function TModelCodCotistaGestor.GetPKFields: TArrayStrings;
begin
  SetLength(Result,3);
  Result[0] := 'CodCotista';
  Result[1] := 'CodGestor';
  Result[2] := 'CodAdministrador';

end;

function TModelCodCotistaGestor.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,4);
  Result[0] := 'CodCotista';
  Result[1] := 'CodGestor';
  Result[2] := 'CodCotistaGestor';
  Result[3] := 'CodAdministrador';

end;

function TModelCodCotistaGestor.GetTableName: String;
begin
  Result := 'FDO_CodCotistaGestor';
end;

end.


