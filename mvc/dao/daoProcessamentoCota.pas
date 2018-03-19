unit daoProcessamentoCota;

interface

uses
  daoBase, Contnrs, modelProcessamentoCota, mvcTypes, DBTables;

type
  TDAOProcessamentoCota = class(TDAOBase)
  private
    function GetSQLProcessamentoCota(): String;
  public
    procedure DoInsert(const aModel: TModelProcessamentoCota);
    procedure DoUpdate(const aModel: TModelProcessamentoCota);
    procedure DoDelete(const aModel: TModelProcessamentoCota);

    function GetProcessamentoCota(const aCodCarteira: Integer): TModelProcessamentoCota;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOProcessamentoCota }

procedure TDAOProcessamentoCota.DoDelete(const aModel: TModelProcessamentoCota);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOProcessamentoCota.DoInsert(const aModel: TModelProcessamentoCota);
begin
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOProcessamentoCota.DoUpdate(const aModel: TModelProcessamentoCota);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOProcessamentoCota.GetProcessamentoCota(const aCodCarteira: Integer): TModelProcessamentoCota;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aCodCarteira';
  vListParametros[0].Valor := aCodCarteira;

  Result := TModelProcessamentoCota(Self.OpenQueryToModel(GetSQLProcessamentoCota, vListParametros, TModelProcessamentoCota));
end;

function TDAOProcessamentoCota.GetSQLProcessamentoCota: String;
begin
  Result :=
    'select * '+
    '  from FDO_ProcessamentoCota with(nolock) '+
    ' where CodCarteira = :aCodCarteira ';
end;

end.


