unit modelCliente;

interface

uses
  modelBase, mvcTypes;

type
  TModelCliente = class(TModelBase)
  private
    FCodCliente: Integer;
    FNomCliente: String;
    FNomCompCliente: String;

  published
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property NomCliente: String read FNomCliente write FNomCliente;
      property NomCompCliente: String read FNomCompCliente write FNomCompCliente;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelCliente }

function TModelCliente.GetIdentity: String;
begin
  Result := '';
end;

function TModelCliente.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodCliente';

end;

function TModelCliente.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,0);
end;

function TModelCliente.GetTableName: String;
begin
  Result := '';
end;

end.


