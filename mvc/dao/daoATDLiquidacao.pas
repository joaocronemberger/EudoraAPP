unit daoATDLiquidacao;

interface

uses
  daoBase, Contnrs, modelATDLiquidacao, mvcTypes, DBTables;

type
  TDAOATDLiquidacao = class(TDAOBase)
  private
    function SQLDeleteByNumPedido(): String;
  public
    procedure DoInsert(const aModel: TModelATDLiquidacao);
    procedure DoUpdate(const aModel: TModelATDLiquidacao);
    procedure DoDelete(const aModel: TModelATDLiquidacao);

    procedure DeleteByNumPedido(const aNumPedido: Integer);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOATDLiquidacao }

procedure TDAOATDLiquidacao.DeleteByNumPedido(const aNumPedido: Integer);
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aNumPedido';
  vListParametros[0].Valor := aNumPedido;

  Self.ExecuteQuery(SQLDeleteByNumPedido, vListParametros);
end;

procedure TDAOATDLiquidacao.DoDelete(const aModel: TModelATDLiquidacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOATDLiquidacao.DoInsert(const aModel: TModelATDLiquidacao);
begin
  //aModel.SeqLiquidacao := Self.GetNextSequence(aModel, 'SeqLiquidacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOATDLiquidacao.DoUpdate(const aModel: TModelATDLiquidacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOATDLiquidacao.SQLDeleteByNumPedido: String;
begin
  Result :=
    'delete '+
    '  from ATD_Liquidacao '+
    ' where NumPedido = :aNumPedido ';
end;

end.


