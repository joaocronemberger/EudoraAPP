unit daoIntegracaoPedidoRest;

interface

uses
  daoBase, Contnrs, modelIntegracaoPedidoRest, mvcTypes, DBTables;

type
  TDAOIntegracaoPedidoRest = class(TDAOBase)
  private
    function SQLListaPendentes: String;
  public
    procedure DoInsertIfNotExists(const aModel: TModelIntegracaoPedidoRest);
    procedure DoDelete(const aModel: TModelIntegracaoPedidoRest);

    function GetListaPendentes(): TObjectList;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOIntegracaoPedidoRest }

procedure TDAOIntegracaoPedidoRest.DoDelete(const aModel: TModelIntegracaoPedidoRest);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOIntegracaoPedidoRest.DoInsertIfNotExists(
  const aModel: TModelIntegracaoPedidoRest);
begin
  Self.ExecuteQuery( aModel.GetSQLToInsertIfNotExists() );
end;

function TDAOIntegracaoPedidoRest.GetListaPendentes: TObjectList;
begin
  Result := Self.OpenQueryToList(SQLListaPendentes(), TModelIntegracaoPedidoRest);
end;

function TDAOIntegracaoPedidoRest.SQLListaPendentes: String;
begin
  Result :=
    'select * '+
    '  from FDO_IntegracaoPedidoRest '+
    ' where StaEnviado = ''P'' ';
end;

end.


