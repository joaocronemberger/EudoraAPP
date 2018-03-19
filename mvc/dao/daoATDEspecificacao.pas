unit daoATDEspecificacao;

interface

uses
  daoBase, Contnrs, modelATDEspecificacao, mvcTypes, DBTables;

type
  TDAOATDEspecificacao = class(TDAOBase)
  private
    function SQLDeleteByNumPedido(): String;
  public
    procedure DoInsert(const aModel: TModelATDEspecificacao);
    procedure DoUpdate(const aModel: TModelATDEspecificacao);
    procedure DoDelete(const aModel: TModelATDEspecificacao);

    procedure DeleteByNumPedido(const aNumPedido: Integer);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOATDEspecificacao }

procedure TDAOATDEspecificacao.DoDelete(const aModel: TModelATDEspecificacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOATDEspecificacao.DoInsert(const aModel: TModelATDEspecificacao);
begin
  //aModel.SeqEspecificacao := Self.GetNextSequence(aModel, 'SeqEspecificacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOATDEspecificacao.DoUpdate(const aModel: TModelATDEspecificacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

procedure TDAOATDEspecificacao.DeleteByNumPedido(const aNumPedido: Integer);
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aNumPedido';
  vListParametros[0].Valor := aNumPedido;

  Self.ExecuteQuery(SQLDeleteByNumPedido, vListParametros);
end;


function TDAOATDEspecificacao.SQLDeleteByNumPedido: String;
begin
  Result :=
    'delete '+
    '  from ATD_Especificacao '+
    ' where NumPedido = :aNumPedido ';
end;

end.


